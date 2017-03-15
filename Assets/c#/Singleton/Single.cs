using System;
using UnityEngine;

namespace AssemblyCSharp
{
	public class Single<T> where T : class, new()
	{
		protected Single()
		{
			Debug.Log("Single Constructor!");
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
			
	}
}

