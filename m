Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4V3MinC016323
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 30 May 2002 20:22:44 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4V3MiL7016322
	for linux-mips-outgoing; Thu, 30 May 2002 20:22:44 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from sccrmhc01.attbi.com (sccrmhc01.attbi.com [204.127.202.61])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4V3MbnC016319
	for <linux-mips@oss.sgi.com>; Thu, 30 May 2002 20:22:37 -0700
Received: from ocean.lucon.org ([12.234.143.38]) by sccrmhc01.attbi.com
          (InterMail vM.4.01.03.27 201-229-121-127-20010626) with ESMTP
          id <20020531032406.FQXQ29266.sccrmhc01.attbi.com@ocean.lucon.org>
          for <linux-mips@oss.sgi.com>; Fri, 31 May 2002 03:24:06 +0000
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id AEE2B125C3; Thu, 30 May 2002 20:24:04 -0700 (PDT)
Date: Thu, 30 May 2002 20:24:04 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: linux-mips@oss.sgi.com
Subject: Announce RedHat 7.3 for mips/mipsel
Message-ID: <20020530202404.A13170@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

My mini-port of RedHat 7.3 is at

ftp://oss.sgi.com/pub/linux/mips/redhat/7.3/

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
