Received:  by oss.sgi.com id <S42351AbQI0UsO>;
	Wed, 27 Sep 2000 13:48:14 -0700
Received: from woody.ichilton.co.uk ([216.29.174.40]:18185 "HELO
        woody.ichilton.co.uk") by oss.sgi.com with SMTP id <S42278AbQI0Ur4>;
	Wed, 27 Sep 2000 13:47:56 -0700
Received: by woody.ichilton.co.uk (Postfix, from userid 0)
	id 10AA27C5D; Wed, 27 Sep 2000 21:47:55 +0100 (BST)
Date:   Wed, 27 Sep 2000 21:47:54 +0100
From:   Ian Chilton <mailinglist@ichilton.co.uk>
To:     linux-mips@oss.sgi.com
Subject: Problem with the new glibc-2.0.6
Message-ID: <20000927214754.A20741@woody.ichilton.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.9i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hello,

I built the older glibc 2.0.6 fine, but had problems with egcs when I built dynamically, and ldconfig would not work...so, I started again...

However, the new glibc that was released the other day, does not work :(

I am using binutils 2.8.1 and egcs 1.0.3a

Any ideas?

LD_LIBRARY_PATH=/mnt/hd2/lfstmp/glibc-2.0.6/glibc-build:/mnt/hd2/lfstmp/glibc-2.0.6/glibc-build/elf:/mnt/hd2/lfstmp/glibc-2.0.6/glibc-build/nss /mnt/hd2/lfstmp/glibc-2.0.6/glibc-build/elf/ld.so.1 /mnt/hd2/lfstmp/glibc-2.0.6/glibc-build/sunrpc/rpcgen -c rpcsvc/bootparam.x -o /mnt/hd2/lfstmp/glibc-2.0.6/glibc-build/sunrpc/xbootparam.T
make[2]: *** [/mnt/hd2/lfstmp/glibc-2.0.6/glibc-build/sunrpc/xbootparam.stmp] Segmentation fault (core dumped)
make[2]: Leaving directory `/mnt/hd2/lfstmp/glibc-2.0.6/sunrpc'
make[1]: *** [sunrpc/others] Error 2
make[1]: Leaving directory `/mnt/hd2/lfstmp/glibc-2.0.6'
make: *** [all] Error 2
 

Thanks!


Bye for Now,

Ian


                     \|||/ 
                     (o o)
 /----------------ooO-(_)-Ooo----------------\
 |  Ian Chilton                              |
 |  E-Mail : ian@ichilton.co.uk              |
 \-------------------------------------------/
