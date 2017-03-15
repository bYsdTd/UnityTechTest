using System;
using UnityEngine;

namespace AssemblyCSharp
{
	public class ChinaPresident : President<ChinaPresident>
	{
		public void Say ()
		{
			Debug.Log("i am china president");
		}
	}
}

