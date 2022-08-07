import { defineConfig } from 'umi';

export default defineConfig({
  nodeModulesTransform: {
    type: 'none',
  },
  routes: [
    { path: '/sign', component: '@/pages/sign' },
    { path: '/choose', component: '@/pages/choose' },
    { path: '/edit', component: '@/pages/edit' },
  ],
  fastRefresh: {},
  mfsu:{}
});
