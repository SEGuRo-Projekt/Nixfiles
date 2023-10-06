{ config, ... }:

{
  users.users.stv0g = {
    isNormalUser = true;

    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC9kuBu/eYcN1hNNIWEVfswO/rOoE1JVQPK+92Y6r856xrdaCpGOtHv5MBmO70fmGEFZ86e2QC0Ij5zqlwqTTNwWAHxT6H9d3CytThx54UronOCeQxQBYcJpLDSdY5MuseZjm0RlW+7aSNvnUttDByGBoCl+VWaaNF+dN2MWzrGIw0rvKJ24OVhPmm91VwOIoCJkKJ9AL1OEIpCH7n7jcaJYVBP2j+RVYfq47W4e9SfE/QlL+QVk360w+kFSeTybaMnsWALZNwk/kywzPq1dpw+4ToD6qBF6leY7ivD/ZsFppbndyzjW93PO3IWlTXmFd/UK/3xzihuZE9KWl0D1O5hny3o0DXkWK96xSFA4hhMqkVw0bNS9+jVq3fuaGNAtOUEg0rfCPPf0fwnPYq9pOyDUViGHDhMY/yWBSqlN+L3Rt9b8hwh0bhsAQiWF5ujIo3mivFD6BQQAyK52Qz778VRPK39k0gpYxqltcJEfjJ832arvNO9XseUKUQAi50gVyXfxD3yQK++0U1E9isF+VyLd1m5MgrtPlP20Ab2PJD6UUaMpr1rEldP9jVsGpVowntC/Hp4/ljCeppize4CRgZjWDHE+Yj+TWmVeuUTObniVWpE/eiQoDIe+FBWPeStq3UMPW5viUafzf2sCUxMyc/ZTUqy8wzDZEyfJ7OGaoxPrQ== cardno:15_419_315"
      "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBERI62l9pAbMxi6QYd3xnEMJhOY9NxcUOvgzNrJsDqSSRs5UgRjHCTDbw+7+yqr+ibcwDAcQgnzJEdRqsdhdTdc= cardno:15_419_315"
    ];
  };

  users.users.root.openssh.authorizedKeys.keys =
    config.users.users.stv0g.openssh.authorizedKeys.keys;
}