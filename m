Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6AGZMr30671
	for linux-mips-outgoing; Tue, 10 Jul 2001 09:35:22 -0700
Received: from tennyson.netexpress.net (IDENT:root@tennyson.netexpress.net [64.22.192.12])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6AGZLV30667
	for <linux-mips@oss.sgi.com>; Tue, 10 Jul 2001 09:35:21 -0700
Received: from localhost (vorlon@localhost)
	by tennyson.netexpress.net (8.9.3/8.9.3) with ESMTP id LAA25591
	for <linux-mips@oss.sgi.com>; Tue, 10 Jul 2001 11:35:20 -0500
X-Authentication-Warning: tennyson.netexpress.net: vorlon owned process doing -bs
Date: Tue, 10 Jul 2001 11:35:20 -0500 (CDT)
From: Steve Langasek <vorlon@netexpress.net>
To: "'linux-mips@oss.sgi.com'" <linux-mips@oss.sgi.com>
Subject: Re: MIPS Cross Compiler Tools
In-Reply-To: <25369470B6F0D41194820002B328BDD27D22@ATLOPS>
Message-ID: <Pine.LNX.4.30.0107101132510.25158-100000@tennyson.netexpress.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi Marc,

On Tue, 10 Jul 2001, Marc Karasek wrote:

> I had a question about the cross compiler tools for MIPS, specifically
> glibc.  I d/l the rpms from oss.sgi.com,  but they are only binutils, and
> the compiler (C, C++).

> Are most people building glibc against these or are you building the tools
> completely from scratch?  As glibc is needed to compile anything else other
> than the kernel.

You don't need a special 'cross-compiler' glibc in order to set up a
cross-build environment for MIPS; simply grab a glibc package that's
precompiled for MIPS and install it into your cross-build root directory.

I don't know who (if anyone) would have rpms for a recent mips glibc; I use
Debian, where I have the packages available as part of the distro.

Regards,
Steve Langasek
postmodern programmer
