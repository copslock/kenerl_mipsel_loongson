Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Jun 2006 07:41:02 +0100 (BST)
Received: from ug-out-1314.google.com ([66.249.92.169]:65340 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S8133399AbWFSGkw (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 19 Jun 2006 07:40:52 +0100
Received: by ug-out-1314.google.com with SMTP id k3so2580073ugf
        for <linux-mips@linux-mips.org>; Sun, 18 Jun 2006 23:40:51 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=P46qv7SYrefw/mflQuBrfiymFQ0f01B4SYHLlQTE9PPqImhzvuriW/iJh6QYFb11MPwm4XzGWtEZPbEViEyp5AmYflv2vKzlEfuOvcy0pt+BrqTGDaubEYsPbjuKhrHzNXZYo00t+uuPVbLWG96iBduAE+YtoYSGmrRvPyG3mCg=
Received: by 10.78.31.18 with SMTP id e18mr1866185hue;
        Sun, 18 Jun 2006 23:40:51 -0700 (PDT)
Received: by 10.78.128.10 with HTTP; Sun, 18 Jun 2006 23:40:51 -0700 (PDT)
Message-ID: <f69849430606182340t72ed5a68l95a724ea933faf12@mail.gmail.com>
Date:	Mon, 19 Jun 2006 11:40:51 +0500
From:	"kernel coder" <lhrkernelcoder@gmail.com>
To:	"James E Wilson" <wilson@specifix.com>
Subject: Re: gcc-4.1.0 cross-compile for MIPS
Cc:	linux-mips@linux-mips.org
In-Reply-To: <1150497195.17820.4.camel@aretha.corp.specifix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <f69849430606160522i12050d00n9a4a39810f13b8a0@mail.gmail.com>
	 <1150497195.17820.4.camel@aretha.corp.specifix.com>
Return-Path: <lhrkernelcoder@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11761
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lhrkernelcoder@gmail.com
Precedence: bulk
X-list: linux-mips

yes you were right.When i did
make all-gcc

It just compiled smoothly.

Now to compile glibc-2.3.6 ,I issued following sequence of commands

../glibc-2.3.6/configure --host=mipsel-linux --prefix="/usr"
--enable-add-ons --with-headers=/home/shahzad/install/mipsel/include

 make cross-compiling=yes
install_root=/home/shahzad/install/mipsel/include  prefix=""
install-headers

But following error was generated

make[1]: Entering directory `/home/shahzad/glibc-2.3.6' { echo
'#include "posix/bits/posix1_lim.h"';            \   echo '#define
_LIBC 1';                                       \   echo '#include
"misc/sys/uio.h"'; } |                 \ gcc -mabi=32 -E -dM -MD -MP
-MF /home/shahzad/build-glibc-headers/bits/stdio_lim.dT -MT
'/home/shahzad/build-glibc-headers/bits/stdio_lim.h
/home/shahzad/build-glibc-headers/bits/stdio_lim.d'      \
      -Iinclude -I. -I/home/shahzad/build-glibc-headers  -Ilibio
-Inptl -I/home/shahzad/build-glibc-headers -Isysdeps/mips/elf
-Inptl/sysdeps/unix/sysv/linux -Inptl/sysdeps/pthread
-Isysdeps/pthread -Inptl/sysdeps/unix/sysv -Inptl/sysdeps/unix
-Isysdeps/unix/sysv/linux/mips/mips32 -Isysdeps/unix/sysv/linux/mips
-Isysdeps/unix/sysv/linux -Isysdeps/gnu -Isysdeps/unix/common
-Isysdeps/unix/mman -Isysdeps/unix/inet -Isysdeps/unix/sysv
-Isysdeps/unix/mips/mips32 -Isysdeps/unix/mips -Isysdeps/unix
-Isysdeps/posix -Isysdeps/mips/mips32 -Isysdeps/mips
-Isysdeps/ieee754/flt-32 -Isysdeps/ieee754/dbl-64
-Isysdeps/wordsize-32 -Isysdeps/mips/fpu -Isysdeps/ieee754
-Isysdeps/generic/elf -Isysdeps/generic -nostdinc -isystem
/usr/lib/gcc/i386-redhat-linux/4.1.0/include -isystem
/home/shahzad/install/mipsel/include -xc - -o
/home/shahzad/build-glibc-headers/bits/stdio_lim.hT
cc1: error: unrecognized command line option "-mabi=32"



I did some search on google,but on most of links "-mabi=32" option was
being used with cross-compiler for mips.
Would you please tell me what is causing the problem.




On 6/17/06, James E Wilson <wilson@specifix.com> wrote:
> On Fri, 2006-06-16 at 05:22, kernel coder wrote:
> > /home/shahzad/install//mipsel/sys-include -DHAVE_CONFIG_H -I.
> > -I../../../gcc-4.1.0/libssp -I. -Wall -O2 -g -O2 -MT ssp.lo -MD -MP
> > -MF .deps/ssp.Tpo -c ../../../gcc-4.1.0/libssp/ssp.c -o ssp.o
> > ../../../gcc-4.1.0/libssp/ssp.c:46:20: error: fcntl.h: No such file or directory
>
> You can't build target libraries like libssp in a --without-headers
> build.  It was luck that this happened to work with earlier gcc
> releases, because previously we didn't have C language target libraries
> in gcc.  The solution is to do
>   make all-gcc
>   make install-gcc
> instead of just
>   make all
>   make install
>
> Please see Dan Kegel's crosstools package, which already knows how to do
> this.
> --
> Jim Wilson, GNU Tools Support, http://www.specifix.com
>
>
