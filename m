Received: from oss.sgi.com (localhost.localdomain [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3I47s8d012142
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 17 Apr 2002 21:07:54 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3I47s0U012141
	for linux-mips-outgoing; Wed, 17 Apr 2002 21:07:54 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from rwcrmhc52.attbi.com (rwcrmhc52.attbi.com [216.148.227.88])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g3I47m8d012133
	for <linux-mips@oss.sgi.com>; Wed, 17 Apr 2002 21:07:48 -0700
Received: from ocean.lucon.org ([12.234.143.38]) by rwcrmhc52.attbi.com
          (InterMail vM.4.01.03.27 201-229-121-127-20010626) with ESMTP
          id <20020418040844.MBDE1901.rwcrmhc52.attbi.com@ocean.lucon.org>
          for <linux-mips@oss.sgi.com>; Thu, 18 Apr 2002 04:08:44 +0000
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 7ACFF125C2; Wed, 17 Apr 2002 21:08:43 -0700 (PDT)
Date: Wed, 17 Apr 2002 21:08:43 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: linux-mips@oss.sgi.com
Subject: Update of RedHat 7.1/mips
Message-ID: <20020417210843.A10182@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

FYI, I updated a few packages in RedHat 7.1/mips. It has new gcc,
glibc, binutils and gdb.

H.J.
---
My mini-port of RedHat 7.1 is at

ftp://oss.sgi.com/pub/linux/mips/redhat/7.1/

you should be able to put a small RedHat 7.1 on the mips/mipsel box and
compile the rest of RedHat 7.1 yourselves.

Here are something you should know:

1. The cross compiler hosted on RedHat 7.[12]/x86 is provided as a
toolchain rpm. The binary rpms for the mips and mipsel cross compilers
are included. This toolchain is a combination of gcc, binutils, gdb and
glibc. It is packaged for the cross compiling. It allows you to cross
compile to RedHat 7.1/mips from a RedHat 7.[12]/x86 host.
2. You have to find a way to put those rpms on your machine. I use
network boot and NFS root to do it.
3. install.tar.bz2 has some scripts to prepare NFS root and install
RedHat 7.1 on a hard drive.
4. baseline.tar.bz2 contains the cross build tree.
5. Since everything is cross compiled from x86, which is little endian,
many data files for mips, which is big endian, are either missing or
wrong. To get those data files for mips, you have to rebuild/install
the folowing rpms:

cracklib
glibc

natively on Linux/mips.

Thanks.


H.J.
