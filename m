Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f56566R03342
	for linux-mips-outgoing; Tue, 5 Jun 2001 22:06:06 -0700
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f56565h03339
	for <linux-mips@oss.sgi.com>; Tue, 5 Jun 2001 22:06:05 -0700
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 524D6125BA; Tue,  5 Jun 2001 22:06:05 -0700 (PDT)
Date: Tue, 5 Jun 2001 22:06:05 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: linux-mips@oss.sgi.com
Subject: New toolchain for Linux/mips
Message-ID: <20010605220605.A10997@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I have a new toolchain for Linux/mips, which consists of gcc 2.96 and
glibc 2.2 from RedHat 7.1 as well as my current binutils. I have used
it to compile RedHat 7.1 to Linux/mipsel. I have built all RedHat 7.1
rpms necessary, except for X related, to boot up RedHat 7.1 on
Linux/mipsel:

# telnet xxxx
.....
Escape character is '^]'.

Red Hat Linux release 7.1 (Seawolf)
Kernel 2.4.3 on a mips
login: 

My toolchain should be as capable as the x86 version in RedHat 7.1.
But I do have 2 issues:

1. I got quite a few C++ exception execution failures from "make check"
in gcc 2.96. But I got more C++ exception execution failures on
IRIX 6.5. I guess the bugs are in gcc and/or binutils.
2. gdb in RedHat 7.1 has yet to be ported to mips. Without a working
gdb, it is very hard to fix 1.

I'd like to fold back my mips changes to gcc, glibc and binutils.
Before I submit my changes, I'd like to get them checked out by the
Linux/mips experts and users, especially on big endian mips. It will
also be nice to have a working gdb and reliable C++ exception.

Is there anyone interested in my new mips toolchain? Is there anyone
interested in fixing gdb and C++ exception?


H.J.
