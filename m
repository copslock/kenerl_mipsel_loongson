Received:  by oss.sgi.com id <S42324AbQIZWiR>;
	Tue, 26 Sep 2000 15:38:17 -0700
Received: from woody.ichilton.co.uk ([216.29.174.40]:52487 "HELO
        woody.ichilton.co.uk") by oss.sgi.com with SMTP id <S42310AbQIZWh4>;
	Tue, 26 Sep 2000 15:37:56 -0700
Received: by woody.ichilton.co.uk (Postfix, from userid 0)
	id 9B1D27EC3; Tue, 26 Sep 2000 23:37:24 +0100 (BST)
Date:   Tue, 26 Sep 2000 23:37:24 +0100
From:   Ian Chilton <mailinglist@ichilton.co.uk>
To:     linux-mips@oss.sgi.com
Subject: egcs problem
Message-ID: <20000926233724.A15790@woody.ichilton.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.9i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hello,

I am building a Linux system with egcs 1.0.3a, binutils 2.8.1 and glibc 2.0.6 (before I try the latest CVS stuff).

I sucsssfully built the esentials statically, and used that to build everything dynamically...the only 2 things I could not compile were groff and egcs (dynamically, although it worked statically).

make[4]: Leaving directory `/lfstmp/egcs-1.0.3a/gcc-build/libraries/el/libio'
/lfstmp/egcs-1.0.3a/gcc-build/gcc/xgcc -B/lfstmp/egcs-1.0.3a/gcc-build/gcc/ -g -O2 -fno-implicit-templates  -EL -Wl,-soname,libstdc++.so.`echo 2.8.0 | sed 's/\([0-9][.][0-9]\).*/\1/'` -shared -o libstdc++.so.2.8.0 `cat piclist` -lm
/usr/lib/libm.so: could not read symbols: Invalid operation
collect2: ld returned 1 exit status
make[3]: *** [libstdc++.so.2.8.0] Error 1
make[3]: Leaving directory `/lfstmp/egcs-1.0.3a/gcc-build/libraries/el/libstdc++'
make[2]: *** [multi-do] Error 1
make[2]: Leaving directory `/lfstmp/egcs-1.0.3a/gcc-build/libraries/libstdc++'
make[1]: *** [multi-all] Error 2
make[1]: Leaving directory `/lfstmp/egcs-1.0.3a/gcc-build/libraries/libstdc++'
make: *** [all-target-libstdc++] Error 2
bash-2.04#    


bash-2.04# ls /usr/lib/libstdc*
/usr/lib/libstdc++.a
bash-2.04# ls /usr/lib/libm*   
/usr/lib/libm.a  /usr/lib/libm.so  /usr/lib/libm_p.a  /usr/lib/libmcheck.a
bash-2.04# 


Any ideas?
 

Thanks!


Bye for Now,

Ian


                     \|||/ 
                     (o o)
 /----------------ooO-(_)-Ooo----------------\
 |  Ian Chilton                              |
 |  E-Mail : ian@ichilton.co.uk              |
 \-------------------------------------------/
