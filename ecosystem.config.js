module.exports = {
  apps: [
    {
      name: 'node-app',
      script: 'dist/src/http/server.js',
      env: {
        NODE_ENV: 'production',
        // Outras variáveis de ambiente
      },
      env_production: {
        NODE_ENV: 'production',
      },
      // Definir o caminho para o arquivo .env
      env_file: '/usr/src/app/.env', // Caminho para o arquivo .env
    },
  ],
};