package main

import (
    "log"
    "industrial-data-1766743492/internal/api"
    "industrial-data-1766743492/internal/blockchain"
    "industrial-data-1766743492/internal/config"
)

func main() {
    cfg := config.Load()

    ethClient, err := blockchain.NewSepoliaClient(cfg.Blockchain)
    if err != nil {
        log.Fatalf("Failed to connect to Sepolia: %v", err)
    }

    contract, err := blockchain.NewIndustrialDataStorage(
        ethClient,
        cfg.ContractAddress,
    )
    if err != nil {
        log.Fatalf("Failed to initialize contract: %v", err)
    }

    server := api.NewServer(contract, cfg)

    log.Printf("Industrial Data Storage API starting on :8080")
    if err := server.Start(); err != nil {
        log.Fatalf("Server failed: %v", err)
    }
}