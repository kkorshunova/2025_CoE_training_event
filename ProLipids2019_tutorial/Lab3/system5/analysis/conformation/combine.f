      dimension x11(10000000),y11(10000000)
      dimension y12(10000000),y13(10000000)
      dimension y14(10000000)
      dimension x21(10000000),y21(10000000)
      dimension y22(10000000),y23(10000000)
      dimension y24(10000000)
      open(1,file='second_set_cut.xvg',status='old')
      open(2,file='first_set_cut.xvg',status='old')
      open(3,file='ca_207_113_ca_131_286.dat',status='unknown')
      open(4,file='3d-input.dat',status='unknown')

      do i=1,1000
          read(1,*)x11(i),y11(i)
          read(2,*)x21(i),y21(i)
      enddo

      do i=1,1000
      y21(i)=y21(i)*10
      y11(i)=y11(i)*10
      write(3,*)x11(i),y21(i),y11(i)
      write(4,*)y21(i),y11(i)
      enddo
      
      stop
      end
    
