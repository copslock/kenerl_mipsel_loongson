Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2PItjU25078
	for linux-mips-outgoing; Mon, 25 Mar 2002 10:55:45 -0800
Received: from mail-gw.sonicblue.com (mail-gw.sonicblue.com [209.10.223.218])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2PIthq25075
	for <linux-mips@oss.sgi.com>; Mon, 25 Mar 2002 10:55:43 -0800
Received: from relay.sonicblue.com (timbale [10.6.1.10])
	by mail-gw.sonicblue.com (8.11.6/8.11.6) with ESMTP id g2PIw1904316
	for <linux-mips@oss.sgi.com>; Mon, 25 Mar 2002 11:58:01 -0700 (MST)
Received: from corpvirus1.sc.sonicblue.com (corpvirus1.sonicblue.com [10.6.2.49])
	by relay.sonicblue.com (8.11.5/8.11.5) with SMTP id g2PIw1600910
	for <linux-mips@oss.sgi.com>; Mon, 25 Mar 2002 10:58:01 -0800 (PST)
Received: FROM corpmailmx.sonicblue.com BY corpvirus1.sc.sonicblue.com ; Mon Mar 25 11:05:20 2002 -0800
Received: by CORPMAILMX with Internet Mail Service (5.5.2653.19)
	id <D4ZWDFWD>; Mon, 25 Mar 2002 10:58:46 -0800
Message-ID: <37D1208A1C9BD511855B00D0B772242C011C7F15@corpmail1.sc.sonicblue.com>
From: Peter Hartley <PDHartley@sonicblue.com>
To: linux-mips@oss.sgi.com, linux kernel <linux-kernel@vger.kernel.org>,
   GNU C Library <libc-alpha@sources.redhat.com>
Subject: RE: Does e2fsprogs-1.26 work on mips?
Date: Mon, 25 Mar 2002 11:00:05 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

H J Lu wrote:
> What are you talking about? It doesn't matter which kernel header
> is used. glibc doesn't even use /usr/include/asm/resource.h nor
> should any user space applications.

It's not about /usr/include/asm/resource.h, it's about
/usr/include/asm/unistd.h, where the syscall numbers are defined.

This is presumably what the "#ifdef __NR_ugetrlimit" in
sysdeps/unix/sysv/linux/i386/getrlimit.c is meant to be testing against --
nothing in the glibc-2.2.5 distribution itself defines that symbol. Surely a
Linux glibc doesn't compile without the target system's linux/* and asm/*
headers?

2.4's /usr/include/asm/unistd.h defines __NR_ugetrlimit but 2.2's doesn't.

	Peter
