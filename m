Received:  by oss.sgi.com id <S553760AbRAaGP1>;
	Tue, 30 Jan 2001 22:15:27 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:41566 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S553721AbRAaGPK>; Tue, 30 Jan 2001 22:15:10 -0800
Received: from sgisgp.singapore.sgi.com (sgisgp.singapore.sgi.com [134.14.84.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via SMTP id WAA06303
	for <linux-mips@oss.sgi.com>; Tue, 30 Jan 2001 22:24:13 -0800 (PST)
	mail_from (calvine@sgi.com)
Received: from sgp-apsa001e--n.singapore.sgi.com by sgisgp.singapore.sgi.com via ESMTP (950413.SGI.8.6.12/930416.SGI)
	for <linux-mips@oss.sgi.com> id OAA16222; Wed, 31 Jan 2001 14:25:06 +0800
Received: by sgp-apsa001e--n.singapore.sgi.com with Internet Mail Service (5.5.2650.21)
	id <1AC4R9MV>; Wed, 31 Jan 2001 14:20:18 +0800
Message-ID: <43FECA7CDC4CD411A4A3009027999112267E3E@sgp-apsa001e--n.singapore.sgi.com>
From:   Calvine Chew <calvine@sgi.com>
To:     "'linux-mips'" <linux-mips@oss.sgi.com>
Subject: Building XFree86 4.0.2?
Date:   Wed, 31 Jan 2001 14:20:17 +0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hello all!

I'm trying to build XFree86 4.0.2 on HardHat 5.1 (unpatched) and I'm looking
at the Mips.cf, which mentions a bootstrapcflag, but the relnotes say
supported configs don't need bootstrapcflag="-DMips" passed to make. If I
pass bootstrap I get a conflict on stdio.h early on (conflicting type
sys_errlist), whereas if I don't pass bootstrapcflag, I get an error around
after 5000 lines of output (undefined references to __libc_accept, etc, from
libpthread.so when trying to make makekeys.c).

Seems to be an incompatible glibc library. Is XFree86 4.0.2 only for glibc
2.1 and above (I believe the raw Hardhat install comes with glibc2.0?)?
Anyone know where I can either grab the 402 binaries or the glibc2.1/2.2
binaries for Hardhat? Thanks!

Regards...

--
Calvine Chew, Technical Consultant
Technology & Industry Consulting Group (Asia South), SGI.
***************************************************************
Inter spem curamque, timores inter et iras, omnem crede diem tibi
diluxisse supremum: grata superveniet quae sperabitur hora.
http://calvine
***************************************************************
