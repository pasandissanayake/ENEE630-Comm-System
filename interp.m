function x = interp(ya,yb,yd,ye,xc)
x=((2 + 3 * xc) * ya - 2 * yb - 2 * yd + 2 * ye - 3 * xc * (2 * yb - 2 * yd + ye) + sqrt(7 * ya^2 + 52 * yb^2 + 52 * yd^2 - 38 * yd * ye + 7 * ye^2 + 22 * yb * (-4 * yd + ye) + 2 * ya * (-19 * yb + 11 * yd + ye)))/(3 * (ya - 2 * yb + 2 * yd - ye));
end