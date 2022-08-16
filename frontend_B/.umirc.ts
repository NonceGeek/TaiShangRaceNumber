import { defineConfig } from 'umi';

export default defineConfig({
  nodeModulesTransform: {
    type: 'none',
  },
  routes: [
    { path: '/', component: '@/pages/home' },
    { path: '/index', component: '@/pages/index' },
    { path: '/edit-page', component: '@/pages/edit-page' },
    { path: '/template-select', component: '@/pages/template-select' },
    { path: '/modify-page', component: '@/pages/modify-page' },
    { path: '/preview-page', component: '@/pages/preview-page' }
  ],
  fastRefresh: {},
  extraPostCSSPlugins: [require("tailwindcss"), require("autoprefixer")],
  base: process.env.NODE_ENV === 'production' ? '/hoster/' : '/',
  publicPath: process.env.NODE_ENV === 'production' ? '/hoster/' : '/',
});
