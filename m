Received:  by oss.sgi.com id <S553849AbQKCOhj>;
	Fri, 3 Nov 2000 06:37:39 -0800
Received: from woody.ichilton.co.uk ([216.29.174.40]:46347 "HELO
        woody.ichilton.co.uk") by oss.sgi.com with SMTP id <S553845AbQKCOh1>;
	Fri, 3 Nov 2000 06:37:27 -0800
Received: by woody.ichilton.co.uk (Postfix, from userid 0)
	id F06687CF1; Fri,  3 Nov 2000 14:37:25 +0000 (GMT)
Date:   Fri, 3 Nov 2000 14:37:25 +0000
From:   Ian Chilton <mailinglist@ichilton.co.uk>
To:     linux-mips@oss.sgi.com
Subject: Re: More GCC problems
Message-ID: <20001103143725.A2123@woody.ichilton.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.11i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hello,

> /tmp/cca08866.s: Assembler messages:
> /tmp/cca08866.s:27593: Error: Branch out of range
> /tmp/cca08866.s:27632: Error: Branch out of range
> /tmp/cca08866.s:27637: Error: Branch out of range

I get this same thing, when doing this:

- use make-cross.sh to build a cross compiling envronment using the current cvs stuff - 001103
- cross compile gcc-001017 using this:

CC="mips-linux-gcc -I/scratch/crossdev/mips-linux/mips-linux/include" CC_FOR_BUILD=cc GCC_FOR_TARGET="mips-linux-gcc -I/s/crossdev/mips-linux/include" AR=mips-linux-ar RANLIB=mips-linux-ranlib LD=mips-linux-ld ../configure --prefix=/usr --enable-threads --enable-languages=c --host=mips-linux --target=mips-linux --build=`../config.guess` && make


PLEASE someone help me out here.... I have spent the last 2 days trying to compile GCC. I have tried every version I can find, from 07072000 to 1707200 which suposidly work, to the lastest CVS version. I have tried native and cross compiling....

The only gcc builds I have had work is egcs-1.0.3a, and a 2.97 cross compile. 


I need a 2.97 native build, static, to compile glibc 2.2, then build a 2.97 dynamic.


HEEEELLLP!
 

Thanks!


Bye for Now,

Ian


                     \|||/ 
                     (o o)
 /----------------ooO-(_)-Ooo----------------\
 |  Ian Chilton                              |
 |  E-Mail : ian@ichilton.co.uk              |
 \-------------------------------------------/
