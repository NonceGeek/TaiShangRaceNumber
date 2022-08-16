import { defineConfig } from 'umi';

export default defineConfig({
  nodeModulesTransform: {
    type: 'none',
  },
  routes: [
    { path: '/', component: '@/pages/home' },
    { path: '/index', component: '@/pages/index' },
    { path: '/sign', component: '@/pages/sign' },
    { path: '/choose', component: '@/pages/choose' },
    { path: '/edit', component: '@/pages/edit' },
    { path: '/buy', component: '@/pages/buy' },
    { path: '/deal', component: '@/pages/deal' }
  ],
  fastRefresh: {},
  extraPostCSSPlugins: [require("tailwindcss"), require("autoprefixer")],
  base: process.env.NODE_ENV === 'production' ? '/runner/' : '/',
  publicPath: process.env.NODE_ENV === 'production' ? '/runner/' : '/',
});
