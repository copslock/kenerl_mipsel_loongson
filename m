Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 May 2003 07:05:55 +0100 (BST)
Received: from vopmail.sfo.interquest.net ([IPv6:::ffff:66.135.128.69]:34574
	"EHLO micaiah.rwc.iqcicom.com") by linux-mips.org with ESMTP
	id <S8225278AbTEJGFx>; Sat, 10 May 2003 07:05:53 +0100
Received: from Muruga.localdomain (unverified [66.135.134.124]) by micaiah.rwc.iqcicom.com
 (Vircom SMTPRS 2.0.244) with ESMTP id <B0006366709@micaiah.rwc.iqcicom.com>;
 Fri, 9 May 2003 23:05:48 -0700
Received: from localhost (muthu@localhost)
	by Muruga.localdomain (8.11.6/8.11.2) with ESMTP id h4A5iEY12859;
	Fri, 9 May 2003 22:44:14 -0700
Date: Fri, 9 May 2003 22:44:13 -0700 (PDT)
From: Muthukumar Ratty <muthu@iqmail.net>
To: Michael Anburaj <michaelanburaj@hotmail.com>
cc: <linux-mips@linux-mips.org>
Subject: Re: Linux for MIPS Atlas 4Kc board
In-Reply-To: <BAY1-F45jlKqwWil63h0000a6fd@hotmail.com>
Message-ID: <Pine.LNX.4.33.0305092241080.12630-100000@Muruga.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <muthu@iqmail.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2334
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: muthu@iqmail.net
Precedence: bulk
X-list: linux-mips

> Warning: unable to open an initial console.
> Kernel panic: No init found.  Try passing init= option to kernel.
>


do you have init in /export/.../sbin Probably exporting wrong
directory?

>
> in src/linux/init/main.c
>
> open("/dev/console", O_RDWR, 0) is returning a negative value. I don't have
> a video device on board., required? Will /dev/console open a UART port
> (/dev/ttyS0 or /dev/tty0)? Why am I getting this error?
>
> 1. Is the kernel not build properly (did not include console driver)?
> 2. Should I pass init=blablabla as a parameter? <but nothing like that is
> specified in the doc.>.
>
> Advice me please...
>
> Thanks,
>
> -Mike.
>
> _________________________________________________________________
> MSN 8 with e-mail virus protection service: 2 months FREE*
> http://join.msn.com/?page=features/virus
>
>
