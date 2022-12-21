// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import "../src/PublisherRegistry.sol";

contract TestRegistry is Test {
    PublisherRegistry public publisher;

    function setUp() public {
        publisher = new PublisherRegistry();
    }

    function testPublishHash() public {
        publisher.registerPublisher("database_1", "abcde");
        string[] memory topics = publisher.getAllTopics();
        assertEq(topics[0], "database_1");
    }

}
