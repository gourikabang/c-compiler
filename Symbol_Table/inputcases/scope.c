int main()
{
	int z;
	z=8;
	{
		int z;
		z = 2;
		z = z + 4;
	}
	z = z - 3;
	return z;
}