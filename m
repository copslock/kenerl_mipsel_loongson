Received:  by oss.sgi.com id <S553857AbQJ3LuW>;
	Mon, 30 Oct 2000 03:50:22 -0800
Received: from woody.ichilton.co.uk ([216.29.174.40]:12552 "HELO
        woody.ichilton.co.uk") by oss.sgi.com with SMTP id <S553854AbQJ3LuM>;
	Mon, 30 Oct 2000 03:50:12 -0800
Received: by woody.ichilton.co.uk (Postfix, from userid 0)
	id EF7427CEC; Mon, 30 Oct 2000 11:50:10 +0000 (GMT)
Date:   Mon, 30 Oct 2000 11:50:10 +0000
From:   Ian Chilton <mailinglist@ichilton.co.uk>
To:     linux-mips@oss.sgi.com
Subject: GCC Problem
Message-ID: <20001030115010.A18728@woody.ichilton.co.uk>
Reply-To: ian@ichilton.co.uk
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.9i
Fcc:    /var/mail/sent-mail-oct2000
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hello,

I had a problem compiling egcs 1.0.3a nativly. I had it a few weeks ago, and fixed it, and it worked. Now, I am having exactly the same problem again, and I can't seem to fix it...annoying..

The system has glibc-2.0.6-7lm and binutils-2.8.1. I am using the egcs-1.0.3a-3 patch
Last time I did it, I was using -5lm and the egcs -2 patch..

Here is the problem:

/lfstmp/egcs-1.0.3a/gcc-build/gcc/xgcc -B/lfstmp/egcs-1.0.3a/gcc-build/gcc/ -g -O2 -fno-implicit-templates  -EL -Wl,-soname,libstdc++.so.`echo 2.8.0 | sed 's/\([0-9][.][0-9]\).*/\1/'` -shared -o libstdc++.so.2.8.0 `cat piclist` -lm
/usr/lib/libm.so: could not read symbols: Invalid operation
collect2: ld returned 1 exit status
make[4]: *** [libstdc++.so.2.8.0] Error 1
make[4]: Leaving directory `/lfstmp/egcs-1.0.3a/gcc-build/libraries/el/libstdc++'
make[3]: *** [multi-do] Error 1
make[3]: Leaving directory `/lfstmp/egcs-1.0.3a/gcc-build/libraries/libstdc++'
make[2]: *** [multi-all] Error 2
make[2]: Leaving directory `/lfstmp/egcs-1.0.3a/gcc-build/libraries/libstdc++'
make[1]: *** [all-target-libstdc++] Error 2
make[1]: Leaving directory `/lfstmp/egcs-1.0.3a/gcc-build'
make: *** [bootstrap] Error 2


I seem to remember the fix was something like creating symlinks. In /usr/lib, I only had libstdc++.a, so I copied libstdc++.so.2.8.0 from my working /usr/lib dir and made some symlinks as below:

bash-2.04# ls -l /usr/lib/libstdc*
-rw-r--r--   1 root     root      1852098 Oct 28 20:28 /usr/lib/libstdc++.a
lrwxrwxrwx   1 root     root           18 Oct 29 15:40 /usr/lib/libstdc++.so -> libstdc++.so.2.8.0
lrwxrwxrwx   1 root     root           18 Oct 29 15:40 /usr/lib/libstdc++.so.2.8 -> libstdc++.so.2.8.0
-r-xr-xr-x   1 root     root       510594 Oct 29 12:53 /usr/lib/libstdc++.so.2.8.0


I also seem to have all of these OK:

bash-2.04# ls -l /usr/lib/libm*
-rw-r--r--   1 root     root      1240434 Oct 29 15:29 /usr/lib/libm.a
lrwxrwxrwx   1 root     root           19 Oct 29 15:29 /usr/lib/libm.so -> ../../lib/libm.so.6
-rw-r--r--   1 root     root      1255528 Oct 29 15:29 /usr/lib/libm_p.a
-rw-r--r--   1 root     root         3764 Oct 29 15:29 /usr/lib/libmcheck.a
bash-2.04# 

bash-2.04# /sbin/ldconfig
bash-2.04# 
 

Can someone help me out here, bcause I have had it working, and know it works, but it is frustrating  :)


Just to let you know what I am working on....I hope to have a glibc-2.0.6/egcs 1.0.3a/2.2.14 system AND a glibc-2.2/new gcc/2.4pre9 system available for download in the next week or 2....


Thanks!


Bye for Now,

Ian


                     \|||/ 
                     (o o)
 /----------------ooO-(_)-Ooo----------------\
 |  Ian Chilton                              |
 |  E-Mail : ian@ichilton.co.uk              |
 \-------------------------------------------/
