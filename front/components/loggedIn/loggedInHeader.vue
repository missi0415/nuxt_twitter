<template>
  <div>
    <logged-in-nav-drawer
    />
    <!-- eslint-disable-next-line -->
    <logged-in-app-bar #nav-icon>
      <v-app-bar-nav-icon
        @click="drawer = !drawer"
      />
    </logged-in-app-bar>
  </div>
</template>

<script>
import loggedInAppBar from './header/loggedInAppBar.vue'
import loggedInNavDrawer from './header/loggedInNavDrawer.vue'
export default {
  components: {
    loggedInNavDrawer,
    loggedInAppBar
  },
  data () {
    return {
      drawer: null
    }
  }
}
</script>
