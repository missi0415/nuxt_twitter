<template>
  <layout-main #layout-main><!--eslint-disable-line-->
    <v-card>
      <v-app-bar
        flat
        color="rgba(0, 0, 0, 0)"
      >
        <v-btn
          icon
          large
          class="mr-5"
          @click="pageBack"
        >
          <v-icon>mdi-arrow-left</v-icon>
        </v-btn>
        <v-toolbar-title>
          フォロー
        </v-toolbar-title>
      </v-app-bar>
      <v-divider />
      <v-tabs
        v-model="tab"
        color="primary accent-10"
        grow
      >
        <v-tab>フォロー</v-tab>
        <v-tab>フォロワー</v-tab>
      </v-tabs>
      <v-tabs-items v-model="tab">
        <v-tab-item>
          <user-follow-card
            v-for="user in following_user"
            :key="user.id"
            :user="user"
            :followingUsers="followingUsers"
          />
        </v-tab-item>
        <v-tab-item>
          <user-follow-card
            v-for="user in follower_user"
            :key="user.id"
            :user="user"
            :followingUsers="followingUsers"
          />
        </v-tab-item>
      </v-tabs-items>
    </v-card>
  </layout-main>
</template>
<script>
import { mapGetters, mapActions } from 'vuex'
import UserFollowCard from '../../../../components/user/userFollowCard.vue'
import LayoutMain from '~/components/layout/loggedIn/layoutMain.vue'
export default {
  components: {
    LayoutMain,
    UserFollowCard
  },
  data () {
    return {
      tab: null,
      user: { id: '', name: '', email: '', avatar: '', introduction: '', admin: '' },
      following_user: [],
      follower_user: [],
      followingUsers: [],
      follow: false,
      color: 'info white--text',
      message: 'フォロー中'
    }
  },
  computed: {
    ...mapGetters({
      currentUser: 'auth/data',
      currentUserId: 'auth/currentUserId',
      isAuthenticated: 'auth/isAuthenticated'
    })
  },
  mounted () {
    this.fetchFollow()
    this.changeTabs()
  },
  methods: {
    ...mapActions({
      flashMessage: 'flash/flashMessage'
    }),
    async fetchFollow () {
      const url = `/api/v1/users/${this.$route.params.id}`
      await this.$axios.get(url)
        .then((res) => {
          this.user.id = res.data.user.id
          this.user.name = res.data.user.name
          this.user.email = res.data.user.email
          this.user.introduction = res.data.user.introduction
          this.user.avatar = res.data.user.avatar.url
          this.user.admin = res.data.user.admin
          this.following_user = res.data.following_user
          this.followingUsers = res.data.following_users
          this.follower_user = res.data.follower_user
        })
        .catch((err) => {
          // eslint-disable-next-line no-console
          console.error(err)
        })
    },
    changeTabs () {
      if (this.$route.query.tab === '1') {
        this.tab = 1
      }
    },
    pluck (array, prop) {
      const obj = array.map((prev) => {
        return prev[prop]
      })
      return obj
    },
    pageBack () {
      this.$router.go(-1)
    }
  }
}

</script>
