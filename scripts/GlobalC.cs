using Godot;
using System;
using System.Runtime.InteropServices;

public partial class GlobalC : Node
{
	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		Console.WriteLine("Hello from C#");
	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{
		
	}
	
	public static void Test()
	{
		Console.WriteLine("Test C# stuff.");
	}
}
