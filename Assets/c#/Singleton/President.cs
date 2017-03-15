using System;
using UnityEngine;

namespace AssemblyCSharp
{
	public class President<T> where T : class, new()
	{
		#region singleton
		protected President()
		{
			Debug.Log("President Constructor!");
		}

		protected class Nested
		{
			private Nested()
			{
				Debug.Log("Nested Constructor!");
			}

			internal static readonly T instance = new T();

		}

		public static T Instance()
		{
			return Nested.instance;
		}
		#endregion

		public virtual void Say()
		{
			Debug.Log("i am president");
		}
	}
}

