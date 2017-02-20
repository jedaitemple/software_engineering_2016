exports.math = function (a,b,c)
{
	var output={};
	var root;
	var D=b*b-4*a*c;
	if(a==0)
	{	
		if(b==0 && c==0)
		{
		output = {x:"Any"};
		return output;		
		}
	root=-c/b;
	if(root%1!=0)
		{
		root=root.toFixed(2)/1;
		}	
	output={x:root};
	return output;
	}
	else if(D==0)
	{
	root=-b/2*a;
	if(root%1!=0)
		{
		root=root.toFixed(2)/1;
		}	
	output={x:root};	
	return output;	
	}
	else if(D>0)
	{	
	root_f=(-b+Math.sqrt(D))/2/a;
	root_s=(-b-Math.sqrt(D))/2/a;
	if(root_f%1!=0)
	{
		root_f=root_f.toFixed(2)/1;
	}	
	if(root_s%1!=0)
	{
		root_s=root_s.toFixed(2)/1;
	}	
	output={x1:root_f,x2:root_s};
	return output;	
	}
	else 
	{	
	output={x1:"NaN",x2:"NaN"};
	return output;	
	}
};
