import { defineConfig } from 'umi';

export default defineConfig({
  nodeModulesTransform: {
    type: 'none',
  },
  routes: [
    { path: '/', component: '@/pages/index' },
    { path: '/edit-page', component: '@/pages/edit-page' }
  ],
  fastRefresh: {},
  mfsu:{}
});
