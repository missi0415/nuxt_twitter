<template>
  <div>
    <v-tooltip bottom>
      <template #activator="{ on, attrs }">
        <v-btn
          icon
          class="btn-delete"
          v-bind="attrs"
          v-on="on"
          @click.prevent.stop="dialog = true"
        >
          <v-icon v-text="'mdi-delete-empty'" />
        </v-btn>
      </template>
      <span>削除</span>
    </v-tooltip>
    <v-dialog
      v-model="dialog"
      width="500"
    >
      <v-card>
        <v-card-title>
          削除します。よろしいですか？
        </v-card-title>
        <v-card-text>
          この操作は取り消せません。
        </v-card-text>
        <v-divider />
        <v-card-actions>
          <v-spacer />
          <v-btn
            rounded
            color="info"
            @click="dialog = false"
          >
            キャンセル
          </v-btn>
          <v-btn
            rounded
            color="error"
            @click="clickOK"
          >
            削除する
          </v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </div>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'
export default {
  props: {
    post: {
      type: Object,
      required: true
    },
    isIndex: {
      type: Boolean,
      required: true
    }
  },
  data () {
    return {
      dialog: false
    }
  },
  computed: {
    ...mapGetters({
      btnColor: 'btn/color'
    })
  },
  methods: {
    ...mapActions({
      flashMessage: 'flash/flashMessage'
    }),
    async clickOK () {
      await this.$axios.$delete(`/api/v1/posts/${this.post.id}`)
        .then(() => {
          if (this.$route.name === 'users-id') {
            this.hidePost()
          } else if (this.$route.name === 'posts') {
            this.hidePost()
          } else if (this.isIndex) {
            this.fetchPost()
          } else {
            this.$router.replace('/posts')
          }
          this.dialog = false
          this.flashMessage({ message: '削除しました', type: 'primary', status: true })
        })
        .catch((err) => {
          // eslint-disable-next-line no-console
          console.log('投稿の削除に失敗', err)
        })
    },
    fetchPost () {
      this.$emit('fetchPost')
    },
    hidePost () {
      this.$emit('hidePost')
    },
    fetchUser () {
      this.$emit('fetchUser')
    }
  }
}
</script>
<style scoped>
  .btn-delete:hover {
    color: #ff5656;
  }
</style>
