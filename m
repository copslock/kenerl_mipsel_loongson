Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g7BLMbRw023029
	for <linux-mips-outgoing@oss.sgi.com>; Sun, 11 Aug 2002 14:22:37 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g7BLMbRr023028
	for linux-mips-outgoing; Sun, 11 Aug 2002 14:22:37 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from rwcrmhc51.attbi.com (rwcrmhc51.attbi.com [204.127.198.38])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g7BLMSRw023018
	for <linux-mips@oss.sgi.com>; Sun, 11 Aug 2002 14:22:29 -0700
Received: from ocean.lucon.org ([12.234.143.38]) by rwcrmhc51.attbi.com
          (InterMail vM.4.01.03.27 201-229-121-127-20010626) with ESMTP
          id <20020811212444.GLGL19356.rwcrmhc51.attbi.com@ocean.lucon.org>
          for <linux-mips@oss.sgi.com>; Sun, 11 Aug 2002 21:24:44 +0000
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 566CE125DB; Sun, 11 Aug 2002 14:24:43 -0700 (PDT)
Date: Sun, 11 Aug 2002 14:24:43 -0700
From: "H. J. Lu" <hjl@lucon.org>
To: linux-mips@oss.sgi.com
Subject: Updates for RedHat 7.3
Message-ID: <20020811142443.A1692@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I updated the following rpms in RedHat 7.3:

binutils-2.13.90.0.3-1.src.rpm
freetype-2.1.2-0.1.src.rpm
gcc-2.96-112.1.src.rpm
gdb-5.2.1-0.2.src.rpm
glibc-2.2.5-37.1.src.rpm
libelf-0.7.0-6.1.src.rpm
modutils-2.4.14-3.2.src.rpm
openssl-0.9.6b-28.1.src.rpm
psmisc-20.2-3.73.1.src.rpm
util-linux-2.11n-12.7.3.1.src.rpm

Please note that its new home is at

ftp://ftp.linux-mips.org/pub/linux/mips/redhat/7.3/


H.J.
---
My mini-port of RedHat 7.3 is at

ftp://ftp.linux-mips.org/pub/linux/mips/redhat/7.3/

It has both mips (big endian) and mipsel (little endian) binary rpms.
You should be able to put a small RedHat 7.3 on the mips/mipsel box and
compile the rest of RedHat 7.3 yourselves.

Here are something you should know:

1. The cross compiler hosted on RedHat 7.3/x86 is provided as the
toolchain rpm. The binary rpms for the mips and mipsel cross compilers
are included. This toolchain is a combination of gcc, binutils, gdb and
glibc. It is packaged for the cross compiling. It allows you to cross
compile to RedHat 7.3/mips/mipsel from a RedHat 7.3/x86 host.
2. You have to find a way to put those rpms on your machine. I use
network boot and NFS root to do it.
3. baseline.tar.bz2 contains the cross build tree. You may need to
install i386 rpm binary included here to rebuild mips/mipsel rpms on
an x86 host. The "installer" directory has a simple installer, which
can be used to prepare NFS root and install RedHat 7.3/mips/mipsel on
a hard drive.
4. Since everything is cross compiled from x86, which is little endian,
many data files for mips, which is big endian, are either missing or
wrong. To get those data files for mips, you have to rebuild/install
the folowing rpms:

cracklib
glibc

natively on Linux/mips.
5. You should build/install perl rpm natively on your newly installed
mips/mipsel box.

Thanks.


H.J.
