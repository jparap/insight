package vaultutil

import (
	"fmt"

	vaultapi "github.com/hashicorp/vault/api"
	logging "github.com/sirupsen/logrus"
)

// NewClient retuns vault cli client conn
func NewClient(hostname string, port string, tlsConfig *vaultapi.TLSConfig) (*vaultapi.Client, error) {
	cfg := vaultapi.DefaultConfig()
	podURL := fmt.Sprintf("https://%s:%s", hostname, port)
	cfg.Address = podURL
	cfg.ConfigureTLS(tlsConfig)
	return vaultapi.NewClient(cfg)
}

//InitializeVault initilize vault for the first time.
func InitializeVault(vc *vaultapi.Client) *vaultapi.InitResponse {
	initOpts := &vaultapi.InitRequest{SecretShares: 1, SecretThreshold: 1}
	initResp, err := vc.Sys().Init(initOpts)
	if err != nil {
		logging.Errorf("failed to initialize vault: %v", err)
		return nil
	}
	return initResp
}

//UnsealVaultNode unseal a vault node in cluster
// TODO: support for multiple keys...
func UnsealVaultNode(unsealKey string, vc *vaultapi.Client) error {

	unsealResp, err := vc.Sys().Unseal(unsealKey)
	if err != nil {
		logging.Errorf("failed to unseal vault: %v", err)
		return err
	}
	if unsealResp.Sealed {
		return fmt.Errorf("failed to unseal vault: response still shows vault as sealed")
	}
	return nil

}

