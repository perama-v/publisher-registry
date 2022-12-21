// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import "../src/PublisherRegistry.sol";

contract TestRegistry is Test {
    PublisherRegistry public publisher;

    function setUp() public {
        publisher = new PublisherRegistry();
        publisher.registerPublisher("data_topic_1", "ipns_alice");
        publisher.registerPublisher("data_topic_2", "ipns_bob");
        publisher.registerPublisher("data_topic_2", "ipns_charlie");
    }

    function testGetAllTopics() public {
        string[] memory topics = publisher.getAllTopics();
        assertEq(topics[0], "data_topic_1");
        assertEq(topics[1], "data_topic_2");
        assertEq(topics[2], "data_topic_2");
    }

    function testPublishersForTopic() public {
        PublisherRegistry.Publisher[] memory topics_1 =
            publisher.getPublishersForTopic("data_topic_1");
        assertEq(topics_1[0].ipns, "ipns_alice");

        PublisherRegistry.Publisher[] memory topics_2 =
            publisher.getPublishersForTopic("data_topic_2");
        assertEq(topics_2[0].ipns, "ipns_bob");
        assertEq(topics_2[1].ipns, "ipns_charlie");
    }

    function testIPNSForTopic() public {
        string[] memory topics_1 =
            publisher.getIPNSForTopic("data_topic_1");
        assertEq(topics_1[0], "ipns_alice");
        string[] memory topics_2 =
            publisher.getIPNSForTopic("data_topic_2");
        assertEq(topics_2[0], "ipns_bob");
        assertEq(topics_2[1], "ipns_charlie");
    }

}
