Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2PAmDe10731
	for linux-mips-outgoing; Mon, 25 Mar 2002 02:48:13 -0800
Received: from mail-gw.sonicblue.com (mail-gw.sonicblue.com [209.10.223.218])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2PAm7q10728
	for <linux-mips@oss.sgi.com>; Mon, 25 Mar 2002 02:48:07 -0800
Received: from relay.sonicblue.com (timbale [10.6.1.10])
	by mail-gw.sonicblue.com (8.11.6/8.11.6) with ESMTP id g2PAoP908502
	for <linux-mips@oss.sgi.com>; Mon, 25 Mar 2002 03:50:25 -0700 (MST)
Received: from corpvirus1.sc.sonicblue.com (corpvirus1.sonicblue.com [10.6.2.49])
	by relay.sonicblue.com (8.11.5/8.11.5) with SMTP id g2PAoP603072
	for <linux-mips@oss.sgi.com>; Mon, 25 Mar 2002 02:50:25 -0800 (PST)
Received: FROM corpmailmx.sonicblue.com BY corpvirus1.sc.sonicblue.com ; Mon Mar 25 02:57:40 2002 -0800
Received: by CORPMAILMX with Internet Mail Service (5.5.2653.19)
	id <D4ZWC022>; Mon, 25 Mar 2002 02:51:06 -0800
Message-ID: <37D1208A1C9BD511855B00D0B772242C011C7F13@corpmail1.sc.sonicblue.com>
From: Peter Hartley <PDHartley@sonicblue.com>
To: "'H . J . Lu'" <hjl@lucon.org>, Andrew Morton <akpm@zip.com.au>
Cc: tytso@thunk.org, linux-mips@oss.sgi.com,
   linux kernel
	 <linux-kernel@vger.kernel.org>,
   GNU C Library
	 <libc-alpha@sources.redhat.com>
Subject: RE: Does e2fsprogs-1.26 work on mips?
Date: Mon, 25 Mar 2002 02:52:24 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

H J Lu wrote:
> I look at the glibc code. It uses a constant RLIM_INFINITY for a given
> arch. The user always passes (~0UL) to glibc on x86. glibc will check
> if the kernel supports the new getrlimit at the run time. If it
> doesn't, glibc will adjust the RLIM_INFINITY for setrlimit. I 
> don't see
> how glibc 2.2.5 compiled under kernel 2.2 will fail under 2.4 due to
> this unless glibc is misconfigureed or miscompiled.

It's not a question of which kernel glibc is compiled under, it's a question
of which version of the kernel headers (/usr/include/{linux,asm}) glibc is
compiled against.

A glibc, even the newest glibc, *compiled against 2.2 headers* cannot know
about the new getrlimit, so the run-time test cannot be compiled and is not
used. Such a glibc subsequently breaks fsck if run under a 2.4 kernel.

Recompile your glibc against 2.4 headers and you should get a glibc and fsck
that work if run under either a 2.2 or 2.4 kernel.

The necessary kernel patch to fix this mess is in the latest -pre-ac (thanks
Alan).

	Peter
