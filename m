Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5SHatnC012827
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 28 Jun 2002 10:36:55 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5SHatJD012826
	for linux-mips-outgoing; Fri, 28 Jun 2002 10:36:55 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from rwcrmhc51.attbi.com (rwcrmhc51.attbi.com [204.127.198.38])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5SHaknC012815
	for <linux-mips@oss.sgi.com>; Fri, 28 Jun 2002 10:36:47 -0700
Received: from ocean.lucon.org ([12.234.143.38]) by rwcrmhc51.attbi.com
          (InterMail vM.4.01.03.27 201-229-121-127-20010626) with ESMTP
          id <20020628174019.SJEO9178.rwcrmhc51.attbi.com@ocean.lucon.org>
          for <linux-mips@oss.sgi.com>; Fri, 28 Jun 2002 17:40:19 +0000
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 23637125D1; Fri, 28 Jun 2002 10:40:19 -0700 (PDT)
Date: Fri, 28 Jun 2002 10:40:18 -0700
From: "H. J. Lu" <hjl@lucon.org>
To: linux-mips@oss.sgi.com
Subject: RedHat 7.3 updates
Message-ID: <20020628104018.A19138@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I updated following rpms in RedHat 7.3:

binutils-2.12.90.0.14-1.src.rpm
db3-3.3.11-6.2.src.rpm
gdb-5.2-0.8.src.rpm
glibc-2.2.5-36.1.src.rpm
hotplug-2002_04_01-3.2.src.rpm
initscripts-6.67-1.3.src.rpm
openssh-3.1p1-6.1.src.rpm
postgresql-7.2.1-5.1.src.rpm
rpm-4.0.4-7x.18.3.src.rpm
tftp-0.28-2.1.src.rpm
toolchain-20020627-1.src.rpm
util-linux-2.11n-12.2.src.rpm


H.J.
----
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
