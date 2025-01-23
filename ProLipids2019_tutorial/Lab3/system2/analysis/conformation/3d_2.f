      dimension x(10000000),y(10000000)
      open(1,file='3d-input.dat',status='old')
      open(2,file='3d-output.dat',status='unknown')

      coun=0
      do i=1,1000
            read(1,*)x(i),y(i)
            coun=coun+1
      enddo
C      print *, coun

      kount = 0

300   FORMAT(f4.1, 2x, f4.1, 2x, i15)
      do i=0,42,1
            a=0.2d0
            b=0.2d0


            do j=0,42,1
               
               do k = 1, 1000

                  if(x(k).ge.(5.9+a*i).and.x(k).le.(5.9+a*(i+1)))then      
                   if(y(k).ge.(9.9+b*j).and.y(k).le.(9.9+b*(j+1)))then
                              kount=kount+1
                        endif
                  endif

               enddo
               xavrg=(5.9+(a*i)+5.9+a*(i+1))/2.0
               yavrg=(9.9+(b*j)+9.9+b*(j+1))/2.0
               zaveg=(kount/coun)*100
               write(2,300) xavrg, yavrg, kount
               kount = 0
            enddo

         enddo

      stop

      end
