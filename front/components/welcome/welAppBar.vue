<template>
  <v-app-bar
    app
    :dark="!isScrollPoint"
    :height="appBarHeight"
    :color="toolbarStyle.color"
    :elevation="toolbarStyle.elevation"
  >
    <app-logo
      @click.native="goTo('scroll-top')"
    />
    <app-title
      class="hidden-mobile-and-down"
    />
    <v-spacer />
    <v-toolbar-items class="ml-2 hidden-ipad-and-down">
      <v-btn
        v-for="(menu,i) in menus"
        :key="`menu-btn-${i}`"
        text
        :class="{ 'hidden-sm-and-down': (menu.title === 'about') }"
        @click="goTo(menu.title)"
      >
        {{ $t(`menus.${menu.title}`) }}
      </v-btn>
    </v-toolbar-items>
    <gest-login-link />
    <signup-link />
    <login-link />
    <v-menu
      bottom
      nudge-left="110"
      nudge-width="100"
    >
      <template v-slot:activator="{ on }">
        <v-app-bar-nav-icon
          class="hidden-ipad-and-up"
          v-on="on"
        />
      </template>
      <v-list
        dense
        class="hidden-ipad-and-up"
      >
        <v-list-item
          v-for="(menu, i) in menus"
          :key="`menu-list-${i}`"
          exact
          @click="goTo(menu.title)"
        >
          <v-list-item-title>
            {{ $t(`menus.${menu.title}`) }}
          </v-list-item-title>
        </v-list-item>
      </v-list>

    </v-menu>
  </v-app-bar>
</template>

<script>
import gestLoginLink from '../beforeLogin/gestLoginLink.vue'
import loginLink from '~/components/beforeLogin/loginLink.vue'
import signupLink from '~/components/beforeLogin/signupLink.vue'
import appLogo from '~/components/ui/appLogo.vue'
import appTitle from '~/components/ui/appTitle.vue'
export default {
  components: { appLogo, signupLink, loginLink, appTitle, gestLoginLink },
  // 親コンポーネントのwelcom.vueから渡されてきたmenusをpropsに入れて受け取る
  props: {
    menus: {
      type: Array,
      default: () => []
    },
    imgHeight: {
      type: Number,
      default: 0
    }
  },
  data ({ $store }) {
    return {
      scrollY: 0,
      appBarHeight: $store.state.styles.beforeLogin.appBarHeight
    }
  },
  computed: {
    isScrollPoint () {
      return this.scrollY > (this.imgHeight - this.appBarHeight)
    },
    toolbarStyle () {
      const color = this.isScrollPoint ? 'white' : 'transparent'
      const elevation = this.isScrollPoint ? 4 : 0
      return { color, elevation }
    }
  },
  mounted () {
    window.addEventListener('scroll', this.onScroll)
  },
  beforeDestroy () {
    window.removeEventListener('scroll', this.onScroll)
  },
  methods: {
    onScroll () {
      this.scrollY = window.scrollY
    },
    goTo (id) {
      this.$vuetify.goTo(`#${id}`)
    }
  }
}
</script>
