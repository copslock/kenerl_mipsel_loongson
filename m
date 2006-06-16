Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jun 2006 13:38:43 +0100 (BST)
Received: from moutng.kundenserver.de ([212.227.126.177]:24315 "EHLO
	moutng.kundenserver.de") by ftp.linux-mips.org with ESMTP
	id S8133593AbWFPMie (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 16 Jun 2006 13:38:34 +0100
Received: from [217.81.185.199] (helo=[192.168.178.44])
	by mrelayeu.kundenserver.de (node=mrelayeu3) with ESMTP (Nemesis),
	id 0MKxQS-1FrDal2JmW-0000bp; Fri, 16 Jun 2006 14:38:28 +0200
Message-ID: <4492A642.6080808@cantastic.de>
Date:	Fri, 16 Jun 2006 14:38:26 +0200
From:	Ralf Roesch <linux@cantastic.de>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To:	kernel coder <lhrkernelcoder@gmail.com>
CC:	linux-mips@linux-mips.org
Subject: Re: gcc-4.1.0 cross-compile for MIPS
References: <f69849430606160522i12050d00n9a4a39810f13b8a0@mail.gmail.com>
In-Reply-To: <f69849430606160522i12050d00n9a4a39810f13b8a0@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:fe0074b40cafaf3a4e4a4699a3836908
Return-Path: <linux@cantastic.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11744
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@cantastic.de
Precedence: bulk
X-list: linux-mips

I have successfully build a newlib based crosscompiler but it's gcc 4.0.3.

Anyway  I have some notes on your configuration:

--without-headres (is it a typo?)

Instead I have:
--with-headers=<path_to_newlib>/src/newlib/libc/include \

May be this helps.

Regards
Ralf

kernel coder schrieb:
> hi,
>   I'm trying to cross compile gcc-4.1.0 for mipsel platform.Following
> is the sequence of commands which i'm using.My host system is i686.
>
> ../gcc-4.1.0/configure --target=mipsel --without-headres
> --prefix=/home/shahzad/install/ --with-newlib --enable-languages=c
>
> make
>
> But following error is generated
>
> /home/shahzad/mips_gcc/./gcc/xgcc -B/home/shahzad/mips_gcc/./gcc/
> -B/home/shahzad/install//mipsel/bin/
> -B/home/shahzad/install//mipsel/lib/ -isystem
> /home/shahzad/install//mipsel/include -isystem
> /home/shahzad/install//mipsel/sys-include -DHAVE_CONFIG_H -I.
> -I../../../gcc-4.1.0/libssp -I. -Wall -O2 -g -O2 -MT ssp.lo -MD -MP
> -MF .deps/ssp.Tpo -c ../../../gcc-4.1.0/libssp/ssp.c -o ssp.o
> ../../../gcc-4.1.0/libssp/ssp.c:46:20: error: fcntl.h: No such file or 
> directory
> ../../../gcc-4.1.0/libssp/ssp.c: In function '__guard_setup':
> ../../../gcc-4.1.0/libssp/ssp.c:70: warning: implicit declaration of
> function 'open'
> ../../../gcc-4.1.0/libssp/ssp.c:70: error: 'O_RDONLY' undeclared
> (first use in this function)
> ../../../gcc-4.1.0/libssp/ssp.c:70: error: (Each undeclared identifier
> is reported only once
> ../../../gcc-4.1.0/libssp/ssp.c:70: error: for each function it 
> appears in.)
> ../../../gcc-4.1.0/libssp/ssp.c:73: error: 'ssize_t' undeclared (first
> use in this function)
> ../../../gcc-4.1.0/libssp/ssp.c:73: error: expected ';' before 'size'
> .........................................
> ........................................
>
> I'm using fedora 5 as development platform and version of gcc
> installed on system is 4.1.0
>
> thanks,
> shahzad
>
