Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jun 2006 15:22:17 +0100 (BST)
Received: from ug-out-1314.google.com ([66.249.92.172]:38221 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S8133774AbWFPOWI (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 16 Jun 2006 15:22:08 +0100
Received: by ug-out-1314.google.com with SMTP id k3so1683895ugf
        for <linux-mips@linux-mips.org>; Fri, 16 Jun 2006 07:22:05 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WT54bM/yW6KTWpXPEcx4cnpi3a04pEP/tru3PY7L6s0J6cxX5P+En8LEid436w1ePQ8ysIFb4HWpSlSFK+LcfyTj2teTz7Bcuk7DNPp+6HPemc3oL7lyVfoPKZ1ndEA4h4k+fTydOD+krYFjxFT8IZtZ4cws6ERwTLlQqSA2iXk=
Received: by 10.67.89.6 with SMTP id r6mr2793831ugl;
        Fri, 16 Jun 2006 07:22:05 -0700 (PDT)
Received: by 10.67.86.14 with HTTP; Fri, 16 Jun 2006 07:22:05 -0700 (PDT)
Message-ID: <f69849430606160722g7a737553i735cad92023db5a0@mail.gmail.com>
Date:	Fri, 16 Jun 2006 19:22:05 +0500
From:	"kernel coder" <lhrkernelcoder@gmail.com>
To:	"Ralf Roesch" <linux@cantastic.de>
Subject: Re: gcc-4.1.0 cross-compile for MIPS
Cc:	linux-mips@linux-mips.org
In-Reply-To: <4492A642.6080808@cantastic.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <f69849430606160522i12050d00n9a4a39810f13b8a0@mail.gmail.com>
	 <4492A642.6080808@cantastic.de>
Return-Path: <lhrkernelcoder@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11745
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lhrkernelcoder@gmail.com
Precedence: bulk
X-list: linux-mips

thanks ,i did a grep in gcc source directory for fcntl.h but there was
no such file in source code.
I think i should explicitly include path for fcntl.h file.

For gcc-3.4.2 i used following sequence of commands.

binutils
------------
../binutils-2.16.1/configure --prefix=/home/shahzad/install --target=mipsel
make
make install

 gcc-3.4.2
----------------------------
../gcc-3.4.2/configure --prefix=/home/shahzad/install --target=mipsel
--without-headers --with-newlib --enable-languages=c
make
make install

glibc
-----------
../glibc-2.3.1/configure --host=mipsel --prefix="/usr"
--enable-add-ons     -with-headers=/home/shahzad/install/include

make cross-compiling=yes  --prefix="" install-headers

gcc-3.4.2
--------------
../gcc-3.4.2/configure --target=mipsel --prefix=/home/shahzad/install
--disable-shared --with-headers=/home/shahzad/install/include
--with-newlib --enable-languages=c

make
make install

Should i change this sequence for gcc-4.1.0.Can someone give his
sequence of commands for his successfull gcc build for mips.

thanks,
shahzad


On 6/16/06, Ralf Roesch <linux@cantastic.de> wrote:
> I have successfully build a newlib based crosscompiler but it's gcc 4.0.3.
>
> Anyway  I have some notes on your configuration:
>
> --without-headres (is it a typo?)
>
> Instead I have:
> --with-headers=<path_to_newlib>/src/newlib/libc/include \
>
> May be this helps.
>
> Regards
> Ralf
>
> kernel coder schrieb:
> > hi,
> >   I'm trying to cross compile gcc-4.1.0 for mipsel platform.Following
> > is the sequence of commands which i'm using.My host system is i686.
> >
> > ../gcc-4.1.0/configure --target=mipsel --without-headres
> > --prefix=/home/shahzad/install/ --with-newlib --enable-languages=c
> >
> > make
> >
> > But following error is generated
> >
> > /home/shahzad/mips_gcc/./gcc/xgcc -B/home/shahzad/mips_gcc/./gcc/
> > -B/home/shahzad/install//mipsel/bin/
> > -B/home/shahzad/install//mipsel/lib/ -isystem
> > /home/shahzad/install//mipsel/include -isystem
> > /home/shahzad/install//mipsel/sys-include -DHAVE_CONFIG_H -I.
> > -I../../../gcc-4.1.0/libssp -I. -Wall -O2 -g -O2 -MT ssp.lo -MD -MP
> > -MF .deps/ssp.Tpo -c ../../../gcc-4.1.0/libssp/ssp.c -o ssp.o
> > ../../../gcc-4.1.0/libssp/ssp.c:46:20: error: fcntl.h: No such file or
> > directory
> > ../../../gcc-4.1.0/libssp/ssp.c: In function '__guard_setup':
> > ../../../gcc-4.1.0/libssp/ssp.c:70: warning: implicit declaration of
> > function 'open'
> > ../../../gcc-4.1.0/libssp/ssp.c:70: error: 'O_RDONLY' undeclared
> > (first use in this function)
> > ../../../gcc-4.1.0/libssp/ssp.c:70: error: (Each undeclared identifier
> > is reported only once
> > ../../../gcc-4.1.0/libssp/ssp.c:70: error: for each function it
> > appears in.)
> > ../../../gcc-4.1.0/libssp/ssp.c:73: error: 'ssize_t' undeclared (first
> > use in this function)
> > ../../../gcc-4.1.0/libssp/ssp.c:73: error: expected ';' before 'size'
> > .........................................
> > ........................................
> >
> > I'm using fedora 5 as development platform and version of gcc
> > installed on system is 4.1.0
> >
> > thanks,
> > shahzad
> >
>
