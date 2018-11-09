pragma solidity ^0.4.18;

contract Voting {

  mapping (bytes32 => uint8) public votesReceived;        //存储每一个候选人对应的得票数，注意：Solidity中没有*.keys这样的方法来获取键值
  bytes32[] public candidateList;                         //全部候选人的名称

  function Voting(bytes32[] candidateNames) public {
    candidateList = candidateNames;
  }

  function totalVotesFor(bytes32 candidate) view public returns (uint8) {
    require(validCandidate(candidate));
    return votesReceived[candidate];
  }

  function voteForCandidate(bytes32 candidate) public {
    require(validCandidate(candidate));
    votesReceived[candidate]  += 1;                     //定义mapping类型时，value默认值为0
  }

  //验证某个人是否在候选人名单中
  function validCandidate(bytes32 candidate) view public returns (bool) {
    for(uint i = 0; i < candidateList.length; i++) {
      if (candidateList[i] == candidate) {
        return true;
      }
    }
    return false;
   }
}
