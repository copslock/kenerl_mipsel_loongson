Received:  by oss.sgi.com id <S553812AbQJNALQ>;
	Fri, 13 Oct 2000 17:11:16 -0700
Received: from woody.ichilton.co.uk ([216.29.174.40]:32006 "HELO
        woody.ichilton.co.uk") by oss.sgi.com with SMTP id <S553700AbQJNAK5>;
	Fri, 13 Oct 2000 17:10:57 -0700
Received: by woody.ichilton.co.uk (Postfix, from userid 0)
	id 2762E7C75; Sat, 14 Oct 2000 01:10:56 +0100 (BST)
Date:   Sat, 14 Oct 2000 01:10:56 +0100
From:   Ian Chilton <mailinglist@ichilton.co.uk>
To:     linux-mips@oss.sgi.com
Subject: ld problem
Message-ID: <20001014011056.A27588@woody.ichilton.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.9i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hello,

I am running a system with glibc 2.0.6 (-5lm), binutils 2.8.1 and egcs 1.0.3a, oh, and linux-2.2.14-mips

Everything compiled fine, including X4.0.1, except when I try to run startx, I get:

bash-2.04# startx
xinit: error in loading shared libraries
libXmu.so.6: cannot open shared object file: No such file or directory


That's when I found the ldconfig problem:

bash-2.04# /sbin/ldconfig 
Bus error


Any ideas??


Is this useful -->

bash-2.04# file /sbin/ldconfig 
/sbin/ldconfig: ELF 32-bit MSB mips-1 executable, MIPS R3000_BE, version 1, statically linked, not stripped
bash-2.04# 


Thanks!


Bye for Now,

Ian


                     \|||/ 
                     (o o)
 /----------------ooO-(_)-Ooo----------------\
 |  Ian Chilton                              |
 |  E-Mail : ian@ichilton.co.uk              |
 \-------------------------------------------/
