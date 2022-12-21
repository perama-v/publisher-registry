// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

/// @notice Lets anyone announce or find up a publisher for any topic.
/// @dev Associates an IPNS with a topic string, allowing a publisher IPNS to be easily found.
contract PublisherRegistry {
    struct Publisher {
        // The msg.sender of the transaction to register an IPNS.
        address submitted_by;
        // The IPNS being stored for a particular topic.
        string ipns;
    }

    // Mapping of a Topic to an array of Publishers.
    mapping(string => Publisher[]) public publisherHashMap;
    // An array with every Topic string ever submitted.
    string[] public topics;

    constructor() {}

    /// @notice Record the IPNS of a publisher who will publish for a topic.
    /// @dev Maps the given IPNS to the specified topic, appending to existing submissions.
    function registerPublisher(string memory topic, string memory ipns_of_publisher) public {
        topics.push(topic);
        publisherHashMap[topic].push(Publisher({submitted_by: msg.sender, ipns: ipns_of_publisher}));
        emit NewPublisher(msg.sender, topic, ipns_of_publisher);
    }
    /// @notice Gets all publishers for a topic.
    /// @dev Gets the Publishers that are mapped to the given topic string.
    /// @return Returns an array of Publishers.
    function getPublishersForTopic(string memory topic) public view returns (Publisher[] memory) {
        return publisherHashMap[topic];
    }

    /// @notice Gets all IPNS for a topic.
    /// @dev A convenience functionn that gets the IPNS values that are mapped to the given topic string.
    /// @return Returns an array of IPNS strings.
    function getIPNSForTopic(string memory topic) public view returns (string[] memory) {
        Publisher[] memory publishers = publisherHashMap[topic];
        string[] memory ipns_strings = new string[](publishers.length);
        for (uint i = 0; i < publishers.length; i++) {
            ipns_strings[i] = publishers[i].ipns;
        }
        return ipns_strings;
    }

    /// @notice Gets all topics ever submitted.
    /// @dev Every topic string submitted.
    /// @return Returns an array of topic strings.
    function getAllTopics() public view returns (string[] memory) {
        return topics;
    }

    // Event for whenever a new (topic, ipns) pair is registered.
    event NewPublisher(address submitted_by, string topic, string ipns);
}

