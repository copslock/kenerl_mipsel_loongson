Received:  by oss.sgi.com id <S553902AbQJ3X0M>;
	Mon, 30 Oct 2000 15:26:12 -0800
Received: from NS.CenSoft.COM ([208.219.23.2]:779 "EHLO ns.centurysoftware.com")
	by oss.sgi.com with ESMTP id <S553821AbQJ3X0B>;
	Mon, 30 Oct 2000 15:26:01 -0800
Received: from censoft.com (IDENT:jordanc@cen94.censoft.com [208.219.23.94])
	by ns.centurysoftware.com (8.9.3/8.9.3) with ESMTP id RAA19582;
	Mon, 30 Oct 2000 17:36:51 -0700 (MST)
Message-ID: <39FE0338.AAB08D9A@censoft.com>
Date:   Mon, 30 Oct 2000 16:24:40 -0700
From:   Jordan Crouse <jordanc@Censoft.com>
Organization: Century Software
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     linux-mips@oss.sgi.com
CC:     jasonk@censoft.com, markl@censoft.com
Subject: Compiling libc
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

This is one for all the libc folks out there..

I am running into some big problems trying to compile libc-001023 as
downloaded from the ftp site just the other day. 

Basically, after compiling everything, I start to verify my build and I
get the following whilst in the /iconv directory (actually, I get it all
over the place):

mips_41xx_le-gcc -nostdlib -nostartfiles -o iconv_prog
-Wl,-dynamic-linker=/opt/hardhat/devkit/mips/41xx_le/mipsel-hardhat-linux/lib/ld.so.1  
../csu/crt1.o ../csu/crti.o `mips_41xx_le-gcc
--print-file-name=crtbegin.o` iconv_prog.o 
-Wl,-rpath-link=..:../math:../elf:../dlfcn:../nss:../nis:../rt:../resolv:../crypt:../linuxthreads
../libc.so.6 ../libc_nonshared.a -lgcc `mips_41xx_le-gcc
--print-file-name=crtend.o` ../csu/crtn.o
../libc.so.6: undefined reference to `__pthread_initialize_minimal'

This is driving me up the wall and down the other side since it is
obvious that the linuxthreads directory is part of the rpath, and I know
that all of the pthreads libraries are compiled, so I can't find a
single reason why it doesn't work.  

A little background for you...  mips_41xx_le is actually the
mipsel-linux compiler under a different name (from the MontaVista CDK). 
I invoked my configure script as such:

./configure --enable-add-ons=linuxthreads
--prefix=/opt/hardhat/devkit/mips/41xx_le/mipsel-hardhat-linux
mipsel-hardhat-linux

I would really appreciate any patches, advice or therapy.

Jordan crouse
