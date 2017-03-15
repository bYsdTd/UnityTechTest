using UnityEngine;
using System.Collections;

public class reverseList : MonoBehaviour {

	public class ListNode 
	{
		public int val;
		public ListNode next;
		public ListNode(int x) { val = x; }
	}

	public class Solution {
		public ListNode ReverseList(ListNode head) {

			if(head == null)
			{
				return null;
			}

			ListNode cur = head;
			ListNode next = head.next;


			while(next != null)
			{
				ListNode tmp = next.next;
				next.next = cur;
				cur = next;
				next = tmp;
			}

			return cur;
		}
	}

	// Use this for initialization
	void Start () {

		Solution so = new Solution();

		ListNode head = new ListNode(1);
		head.next = new ListNode(2);

		ListNode result = so.ReverseList(head);

	}
	
	// Update is called once per frame
	void Update () {
	
	}
}
