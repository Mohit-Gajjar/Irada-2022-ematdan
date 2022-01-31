module.exports = {
  networks: {
    development: {
      host: "192.168.0.109",
      port: 7545,
      network_id: "*",
    },
    advanced: {
      websockets: true,
    },
  },
  contracts_build_directory: "./src/abis/",
  compilers: {
    solc: {
      optimiser: {
        enabled: true,
        runs: 200,
      },
    },
  },
};
