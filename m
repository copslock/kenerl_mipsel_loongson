Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Dec 2002 18:42:14 +0100 (CET)
Received: from rwcrmhc52.attbi.com ([216.148.227.88]:52461 "EHLO
	rwcrmhc52.attbi.com") by linux-mips.org with ESMTP
	id <S8225205AbSLCRmO>; Tue, 3 Dec 2002 18:42:14 +0100
Received: from lucon.org (12-234-88-146.client.attbi.com[12.234.88.146])
          by rwcrmhc52.attbi.com (rwcrmhc52) with ESMTP
          id <20021203174200052002a3phe>; Tue, 3 Dec 2002 17:42:00 +0000
Received: by lucon.org (Postfix, from userid 1000)
	id 963B62C69E; Tue,  3 Dec 2002 09:42:00 -0800 (PST)
Date: Tue, 3 Dec 2002 09:42:00 -0800
From: "H. J. Lu" <hjl@lucon.org>
To: linux-mips@linux-mips.org
Subject: Updates for RedHat 7.3
Message-ID: <20021203094200.A959@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Return-Path: <hjl@lucon.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 727
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hjl@lucon.org
Precedence: bulk
X-list: linux-mips

I updated the following rpms in my RedHat 7.3 mips port:

toolchain-20021126-1.src.rpm
autofs-4.0.0pre10-0.6.src.rpm
automake-1.4p5-4.1.src.rpm
binutils-2.13.90.0.16-1.src.rpm
gcc-2.96-113.2.src.rpm
gdb-5.2.90-0.2.src.rpm
glibc-2.2.5-42.1.src.rpm
glibc-kernheaders-2.4.20pre6-1.src.rpm
hwdata-0.14.1-1.2.src.rpm
kudzu-0.99.52-1.4.src.rpm
libcap-1.10-12.1.src.rpm
libpng-1.0.14-0.7x.3.1.src.rpm
lvm-1.0.3-4.src.rpm
modutils-2.4.18-3.7x.1.src.rpm
nfs-utils-1.0.2-0.4.src.rpm
ntp-4.1.1-1.2.src.rpm
openssh-3.1p1-6.2.src.rpm
pam-0.75-32.2.src.rpm
parted-1.4.24-3.2.src.rpm
strace-4.4-8.1.src.rpm
tar-1.13.25-4.7.1.src.rpm
tcltk-8.3.3-67.2.src.rpm
tftp-0.30-0.1.src.rpm
XFree86-4.2.0-72.2.src.rpm
ypserv-2.5-2.7x.1.src.rpm
zsh-4.0.4-5.3.src.rpm


H.J.
----
My mini-port of RedHat 7.3 is at

ftp://ftp.linux-mips.org/pub/linux/mips/redhat/7.3/

It has both mips (big endian) and mipsel (little endian) binary rpms.
You should be able to put a small RedHat 7.3 on the mips/mipsel box and
compile the rest of RedHat 7.3 yourselves.

Here are something you should know:

1. The cross compiler hosted on RedHat 7.3/x86 is provided as the
toolchain rpm. The binary rpms for the mips and mipsel cross compilers
are included. This toolchain is a combination of gcc, binutils and
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

Thanks.


H.J.
