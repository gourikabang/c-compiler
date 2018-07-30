int main(){
	int a[5][5],b,c;
	int x,y;
	for(x=0;x<5;x=x+1){
		for(y=0;y<5;y=y+1){
			if(x==y){
				a[x][y] = 17;
			}else{
				a[x][y] = 15;
			}
			c=a[x][y];
		}
		b=a[0][0];
	}
	
}