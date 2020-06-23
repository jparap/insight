// Copyright 2018 The vault-operator Authors
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

package vaultutil

import (
	"bytes"
	"fmt"
	"path/filepath"
)

const (
	// VaultTLSAssetDir is the dir where vault's server TLS and etcd TLS assets sits
	VaultTLSAssetDir = "/run/vault/tls/"
	// ServerTLSCertName is the filename of the vault server cert
	ServerTLSCertName = "server.crt"
	// ServerTLSKeyName is the filename of the vault server key
	ServerTLSKeyName = "server.key"
	// ClientTLSCertName is the filename of the vault client cert
	ClientTLSCertName = "vault-client-ca.crt"
)

var listenerFmt = `
listener "tcp" {
  address     = "0.0.0.0:8200"
  cluster_address = "0.0.0.0:8201"
  tls_cert_file = "%s"
  tls_key_file  = "%s"
  tls_client_ca_file  = "%s"
}
`

var etcdStorageFmt = `
storage "etcd" {
  address = "%s"
  etcd_api = "v3"
  ha_enabled = "true"
  tls_ca_file = "%s"
  tls_cert_file = "%s"
  tls_key_file = "%s"
  sync = "false"
}
`

// NewConfigWithDefaultParams appends to given config data some default params:
// - telemetry setting
// - tcp listener
func NewConfigWithDefaultParams(data string) string {
	buf := bytes.NewBufferString(data)
	buf.WriteString(`
disable_mlock = "true"
ui = "true"
telemetry {
	statsd_address = "localhost:9125"	
}
`)

	listenerSection := fmt.Sprintf(listenerFmt,
		filepath.Join(VaultTLSAssetDir, ServerTLSCertName),
		filepath.Join(VaultTLSAssetDir, ServerTLSKeyName),
		filepath.Join(VaultTLSAssetDir, ClientTLSCertName))
	buf.WriteString(listenerSection)

	return buf.String()
}

// NewConfigWithEtcd returns the new config data combining
// original config and new etcd storage section.
func NewConfigWithEtcd(data, etcdURL string) string {
	storageSection := fmt.Sprintf(etcdStorageFmt, etcdURL, filepath.Join(VaultTLSAssetDir, "etcd-client-ca.crt"),
		filepath.Join(VaultTLSAssetDir, "etcd-client.crt"), filepath.Join(VaultTLSAssetDir, "etcd-client.key"))
	data = fmt.Sprintf("%s%s", data, storageSection)
	return data
}

//  Moving to client.go
// NewClient retuns vault cli client conn
// func NewClient(hostname string, port string, tlsConfig *vaultapi.TLSConfig) (*vaultapi.Client, error) {
// 	cfg := vaultapi.DefaultConfig()
// 	podURL := fmt.Sprintf("https://%s:%s", hostname, port)
// 	cfg.Address = podURL
// 	cfg.ConfigureTLS(tlsConfig)
// 	return vaultapi.NewClient(cfg)
// }
