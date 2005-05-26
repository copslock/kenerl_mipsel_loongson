Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 May 2005 17:33:23 +0100 (BST)
Received: from zproxy.gmail.com ([IPv6:::ffff:64.233.162.203]:38851 "EHLO
	zproxy.gmail.com") by linux-mips.org with ESMTP id <S8225973AbVEZQdH> convert rfc822-to-8bit;
	Thu, 26 May 2005 17:33:07 +0100
Received: by zproxy.gmail.com with SMTP id 13so985490nzp
        for <linux-mips@linux-mips.org>; Thu, 26 May 2005 09:33:00 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=PMEPd7e5R/hpq0jXhli9HjXLJ+fN3AEBqg8prqRQL/HFsnUcAbNlr/PSv6Luoc3ihi9f5c1gCFCDI2KBgTiQWxO2Hl6EkEXh6j68kbFL3A4LmlPpQeL34XWKjLD1sUNFI7adokq/Few6dQiFLJGTqIxdj21skEDmCd0GToAafM4=
Received: by 10.36.71.16 with SMTP id t16mr703149nza;
        Thu, 26 May 2005 09:32:59 -0700 (PDT)
Received: by 10.36.68.6 with HTTP; Thu, 26 May 2005 09:32:59 -0700 (PDT)
Message-ID: <6097c4905052609326a4c1232@mail.gmail.com>
Date:	Thu, 26 May 2005 20:32:59 +0400
From:	Maxim Osipov <maxim.osipov@gmail.com>
Reply-To: maxim@mox.ru
To:	linux-mips@linux-mips.org
Subject: glibc-2.3.4 mips64 compilation failure
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Return-Path: <maxim.osipov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7979
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: maxim.osipov@gmail.com
Precedence: bulk
X-list: linux-mips

Hello,

I am trying to build glibc-2.3.4 using binutils-2.15 and gcc-3.4.3
from ftp://ftp.linux-mips.org/pub/linux/mips/crossdev/i386-linux/mips64-linux.
Compilation fails with following messages:

clude/libc-symbols.h -DPIC -DASSEMBLER -x assembler-with-cpp -o
/home/maxim/temp/build-glibc/io/sendfile.o -
.././scripts/mkinstalldirs /home/maxim/temp/build-glibc/io
(echo '#include <sysdep.h>'; \
 echo 'PSEUDO (sendfile64, sendfile64, 4)'; \
 echo ' ret'; \
 echo 'PSEUDO_END(sendfile64)'; \
 echo 'libc_hidden_def (sendfile64)'; \
) | mips64-linux-gcc -mabi=64 -c -I../include -I.
-I/home/maxim/temp/build-glibc/io -I.. -I../libio
-I/home/maxim/temp/build-glibc -I../sysdeps/mips/elf
-I../linuxthreads/sysdeps/unix/sysv/linux/mips/mips64
-I../linuxthreads/sysdeps/unix/sysv/linux/mips
-I../linuxthreads/sysdeps/unix/sysv/linux
-I../linuxthreads/sysdeps/pthread -I../sysdeps/pthread
-I../linuxthreads/sysdeps/unix/sysv -I../linuxthreads/sysdeps/unix
-I../linuxthreads/sysdeps/mips
-I../sysdeps/unix/sysv/linux/mips/mips64/n64
-I../sysdeps/unix/sysv/linux/mips/mips64
-I../sysdeps/unix/sysv/linux/mips -I../sysdeps/unix/sysv/linux
-I../sysdeps/gnu -I../sysdeps/unix/common -I../sysdeps/unix/mman
-I../sysdeps/unix/inet -I../sysdeps/unix/sysv
-I../sysdeps/unix/mips/mips64/n64 -I../sysdeps/unix/mips/mips64
-I../sysdeps/unix/mips -I../sysdeps/unix -I../sysdeps/posix
-I../sysdeps/mips/mips64/n64 -I../sysdeps/ieee754/ldbl-128
-I../sysdeps/mips/mips64 -I../sysdeps/ieee754/flt-32
-I../sysdeps/ieee754/dbl-64 -I../sysdeps/mips -I../sysdeps/wordsize-64
-I../sysdeps/mips/fpu -I../sysdeps/ieee754 -I../sysdeps/generic/elf
-I../sysdeps/generic -nostdinc -isystem
/usr/lib/gcc/mips64-linux/3.4.3/include -isystem
/usr/local/tools/mips64-linux/mips64-linux/sys-root/usr/include
-D_LIBC_REENTRANT -include ../include/libc-symbols.h -DPIC -DASSEMBLER
-x assembler-with-cpp -o /home/maxim/temp/build-glibc/io/sendfile64.o
-
<stdin>: Assembler messages:
<stdin>:2: Error: absolute expression required `li'
make[2]: *** [/home/maxim/temp/build-glibc/io/sendfile64.o] Error 1
make[2]: Leaving directory `/home/maxim/temp/glibc-2.3.4/io'
make[1]: *** [io/subdir_lib] Error 2
make[1]: Leaving directory `/home/maxim/temp/glibc-2.3.4'

Has anyone seen it before? And one more thing - are there srpms for
the above mentioned tools available?

Best regards,
Maxim
