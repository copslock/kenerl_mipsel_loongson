Received:  by oss.sgi.com id <S554039AbQKFVzW>;
	Mon, 6 Nov 2000 13:55:22 -0800
Received: from woody.ichilton.co.uk ([216.29.174.40]:49164 "HELO
        woody.ichilton.co.uk") by oss.sgi.com with SMTP id <S554036AbQKFVzG>;
	Mon, 6 Nov 2000 13:55:06 -0800
Received: by woody.ichilton.co.uk (Postfix, from userid 0)
	id 6E2D77CD4; Mon,  6 Nov 2000 21:55:04 +0000 (GMT)
Date:   Mon, 6 Nov 2000 21:55:04 +0000
From:   Ian Chilton <mailinglist@ichilton.co.uk>
To:     linux-mips@oss.sgi.com
Subject: Findutils and Fileutils under Glibc 2.2
Message-ID: <20001106215504.A7157@woody.ichilton.co.uk>
Reply-To: Ian Chilton <ian@ichilton.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.11i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hello,

I am having more problems with packages that worked fine under glibc 2.2

File utils gives this error:

gcc -DLOCALEDIR=\"/usr/share/locale\" -DSHAREDIR=\"/usr/share\" -DHAVE_CONFIG_H -I.. -I. -I../lib -I../intl  -D_FILE_OFFSET_BITS=64  -g -O2 -c dircolors.c
dircolors.c:40:15: 1 arguments is not enough for macro "strndup"
make[2]: *** [dircolors.o] Error 1
make[2]: Leaving directory `/lfstmp/fileutils-4.0/src'
make[1]: *** [all-recursive] Error 1
make[1]: Leaving directory `/lfstmp/fileutils-4.0'
make: *** [all-recursive-am] Error 2


Findutils errors, but does not exit  :(
(I only noticed because find did not exist)..

during make install, gives:

making install in find
/bin/sh: invalid character 47 in exportstr for /root
make[1]: Entering directory `/lfstmp/findutils-4.1/find'
gcc -c -DHAVE_CONFIG_H -I.. -I../lib  -g -O fstype.c
fstype.c:34:15: 1 arguments is not enough for macro "strstr"
make[1]: *** [fstype.o] Error 1
make[1]: Leaving directory `/lfstmp/findutils-4.1/find'
making install in xargs
/bin/sh: invalid character 47 in exportstr for /root
make[1]: Entering directory `/lfstmp/findutils-4.1/xargs'
gcc -c -DHAVE_CONFIG_H -I.. -I../lib  -g -O ../find/version.c
gcc -o xargs xargs.o ../find/version.o ../lib/libfind.a  -lintl
gcc: ../find/version.o: No such file or directory
make[1]: *** [xargs] Error 1
make[1]: Leaving directory `/lfstmp/findutils-4.1/xargs'
making install in locate
/bin/sh: invalid character 47 in exportstr for /root
make[1]: Entering directory `/lfstmp/findutils-4.1/locate'
gcc -c -DHAVE_CONFIG_H -I.. -I../lib -DLOCATE_DB=\"/usr/var/locatedb\"  -g -O ../find/version.c
gcc -o locate locate.o ../find/version.o ../lib/libfind.a  -lintl
gcc: ../find/version.o: No such file or directory
make[1]: *** [locate] Error 1
make[1]: Leaving directory `/lfstmp/findutils-4.1/locate'


Thanks!


Bye for Now,

Ian


                     \|||/ 
                     (o o)
 /----------------ooO-(_)-Ooo----------------\
 |  Ian Chilton                              |
 |  E-Mail : ian@ichilton.co.uk              |
 \-------------------------------------------/
