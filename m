Received:  by oss.sgi.com id <S553777AbRAIKUO>;
	Tue, 9 Jan 2001 02:20:14 -0800
Received: from dorian.blic.net ([217.23.192.5]:58377 "EHLO dorian.blic.net")
	by oss.sgi.com with ESMTP id <S553763AbRAIKT6>;
	Tue, 9 Jan 2001 02:19:58 -0800
Received: from quake.blic.net (pmalic@quake.blic.net [217.23.192.7])
	by dorian.blic.net (8.9.3/8.9.3) with ESMTP id LAA08675;
	Tue, 9 Jan 2001 11:04:12 +0100
Date:   Tue, 9 Jan 2001 11:23:17 +0100 (CET)
From:   Predrag Malicevic <pmalic@blic.net>
To:     Ralf Baechle <ralf@oss.sgi.com>
cc:     <linux-mips@oss.sgi.com>
Subject: Re: O200 problem...
In-Reply-To: <20010109004138.A12181@bacchus.dhis.org>
Message-ID: <Pine.LNX.4.30.0101091053100.11171-100000@quake.blic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, 9 Jan 2001, Ralf Baechle wrote:

> > CPU 0 clock is 65535MHz.
>
> Something's fishy.  I guess ;-)

It is really strange... 65 GHz? ;)

> Thanks for sending the oops message; however without additional data
> provided I can't use it.  Can you please point please put the kernel image
> that resulted in the oops online?

Ok, I'll put it by Thursday (I can't come to the machines earlier).

P.S. I was first building kernels on an i386 system running RedHat 7.0,
but later on I switched to a faster machine running Slackware 7.0. In both
cases I used binutils-mips64-linux-2.9.5-3/egcs-mips64-linux-1.1.2-3 RPMs
from oss.sgi.com. Kernels from both machines behaved the same way.

--pm
