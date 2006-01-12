Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Jan 2006 10:15:14 +0000 (GMT)
Received: from nproxy.gmail.com ([64.233.182.203]:13551 "EHLO nproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8126506AbWALKOt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 12 Jan 2006 10:14:49 +0000
Received: by nproxy.gmail.com with SMTP id y38so265768nfb
        for <linux-mips@linux-mips.org>; Thu, 12 Jan 2006 02:18:03 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=gPxCBSUvwNgh9bxaqBqCk9Re1QztVkkArI9NFZTo2BGzOT3FopmT04N4xXdhs82ca7aPfEYoTeIQzuwy1DpLXhLFIsJoEl6jzDv5jZ/9TrxMVpvNHo2KsEou0vx278d1LRaPIOhBAVwWe1lmW0t6gXMEXiT6Xqd5k/D0SrZwwys=
Received: by 10.48.238.3 with SMTP id l3mr114893nfh;
        Thu, 12 Jan 2006 02:18:03 -0800 (PST)
Received: by 10.48.225.20 with HTTP; Thu, 12 Jan 2006 02:18:03 -0800 (PST)
Message-ID: <c58a7a270601120218r77ec0d8drf2d14663138a13c2@mail.gmail.com>
Date:	Thu, 12 Jan 2006 10:18:03 +0000
From:	Alex Gonzalez <langabe@gmail.com>
To:	linux-mips <linux-mips@linux-mips.org>
Subject: Compiling a non-pic glibc
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Return-Path: <langabe@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9866
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: langabe@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

What is the correct way of cross-compiling a non-pic static glibc?

I thought something like,

env CC="mips64-linux-gnu-gcc -mabi=n32 -mno-abicalls -fno-pic -mips4"
../glibc-src/configure --host=mips64-linux-gnu
--build=i686-pc-linux-gnulibc2.2 --prefix=/usr
--with-headers=/mips64-linux-gnu/sys-root/usr/include/
--enable-add-ons=linuxthreads --without-cvs --with-fp --disable-shared

and 'make' will do it, but it fails with,

make[2]: Entering directory `/home/alex/projects/glibc-src/iconv'
/opt/redhat/mips64linux-031001/H-i686-pc-linux-gnulibc2.2/bin/mips64-linux-gnu-gcc
-mabi=n32 -mno-abicalls -fno-pic -mips4 -nostdlib -nostartfiles -o
/home/alex/projects/glibc-build/iconv/iconvconfig     
/home/alex/projects/glibc-build/csu/crt1.o
/home/alex/projects/glibc-build/csu/crti.o
`/opt/redhat/mips64linux-031001/H-i686-pc-linux-gnulibc2.2/bin/mips64-linux-gnu-gcc
-mabi=n32 -mno-abicalls -fno-pic -mips4 --print-file-name=crtbegin.o`
/home/alex/projects/glibc-build/iconv/iconvconfig.o
/home/alex/projects/glibc-build/iconv/strtab.o
/home/alex/projects/glibc-build/iconv/xmalloc.o 
/home/alex/projects/glibc-build/libc.a  -lgcc
/home/alex/projects/glibc-build/libc.a -lgcc
`/opt/redhat/mips64linux-031001/H-i686-pc-linux-gnulibc2.2/bin/mips64-linux-gnu-gcc
-mabi=n32 -mno-abicalls -fno-pic -mips4 --print-file-name=crtend.o`
/home/alex/projects/glibc-build/csu/crtn.o
/opt/redhat/mips64linux-031001/H-i686-pc-linux-gnulibc2.2/lib/gcc-lib/mips64-linux-gnu/3.3-mips64linux-031001/../../../../mips64-linux-gnu/bin/ld:
/opt/redhat/mips64linux-031001/H-i686-pc-linux-gnulibc2.2/lib/gcc-lib/mips64-linux-gnu/3.3-mips64linux-031001/32/crtbegin.o:
warning: linking PIC files with non-PIC files
/opt/redhat/mips64linux-031001/H-i686-pc-linux-gnulibc2.2/lib/gcc-lib/mips64-linux-gnu/3.3-mips64linux-031001/../../../../mips64-linux-gnu/bin/ld:
/home/alex/projects/glibc-build/iconv/iconvconfig.o: warning: linking
PIC files with non-PIC files

Just in case, I am trying to build glibc-2.3.1 with a gcc 3.3 based toolchain.

Thanks,
Alex
