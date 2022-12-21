# publisher-registry
A [PublisherRegistry.sol](./src/PublisherRegistry.sol) contract
for associating (IPNS, topic) pairs.

This is an implementation of the Generic Attributable Manifest Broadcaster
([GAMB](https://github.com/perama-v/GAMB)). Specifically, it is the IPNS-based
version described in [this issue](https://github.com/perama-v/GAMB/issues/1)
that makes it free to publish after the initial registration transaction.

The publisher posts their IPNS and the name of the data type they are publishing.
Then whenever they create a new manifest, they update their IPNS locally. If they
lose their keys to the IPNS, they can generate new keys and then
submit a new transaction to register that new IPNS.

Malicious actors cannot prevent an honest actor from publishing. Users can navigate
spam IPNS by automating the check of the manifest at each IPNS and ignoring it
if necessary.

The ultimate purpose of this contract is to provide a natural coordination point for
publishers and users of [TODD](https://github.com/perama-v/TODD)-compliant data.