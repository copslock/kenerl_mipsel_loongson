Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g7F2hlRw022338
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 14 Aug 2002 19:43:47 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g7F2hlYF022337
	for linux-mips-outgoing; Wed, 14 Aug 2002 19:43:47 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from real.realitydiluted.com (real.realitydiluted.com [208.242.241.164])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g7F2hgRw022328
	for <linux-mips@oss.sgi.com>; Wed, 14 Aug 2002 19:43:43 -0700
Received: from localhost.localdomain ([127.0.0.1] helo=realitydiluted.com)
	by real.realitydiluted.com with esmtp (Exim 3.22 #1 (Red Hat Linux))
	id 17f5xz-0004PZ-00; Wed, 14 Aug 2002 16:46:11 -0500
Message-ID: <3D5B15DE.7000007@realitydiluted.com>
Date: Wed, 14 Aug 2002 21:45:50 -0500
From: "Steven J. Hill" <sjhill@realitydiluted.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020615 Debian/1.0.0-3
MIME-Version: 1.0
To: uclibc@uclibc.org, linux-mips@oss.sgi.com
Subject: New MIPS native uClibc toolchain RPMS...
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Greetings.

I am pleased to announce the availability of the first uClibc
native toolchain RPMS for both little and big endian MIPS.
These toolchains allow you to compile C and C++ applications
for uClibc. They use the last stable 0.9.12 code which was
available on 20020807. These RPMS use the following sources:

    binutils-2.12.1
    gcc-3.1
    uClibc-0.9.12
    linux-2.4.18-headers

These were tested exhaustively on both endians of MIPS
processors. I would appreciate any feedback. These toolchains
can also compile Linux kernels. They are available here:

    ftp://ftp.realitydiluted.com/MIPS/uclibc

Cheers.

-Steve
