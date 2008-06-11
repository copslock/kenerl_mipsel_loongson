Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jun 2008 01:57:25 +0100 (BST)
Received: from rs25s3.datacenter.cha.cantv.net ([200.44.33.34]:60091 "EHLO
	rs25s3.datacenter.cha.cantv.net") by ftp.linux-mips.org with ESMTP
	id S29039479AbYFKA5W (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 11 Jun 2008 01:57:22 +0100
X-DNSBL-MILTER:	Passed
Received: from [192.168.0.3] (dc9d0839d.dslam-172-17-49-239-0232-299.dsl.cantv.net [201.208.131.157] (may be forged))
	by rs25s3.datacenter.cha.cantv.net (8.13.8/8.13.0/3.0) with ESMTP id m5B0vCpk007472;
	Tue, 10 Jun 2008 20:27:13 -0430
X-Matched-Lists: []
Message-ID: <484F22EE.5090601@gentoo.org>
Date:	Tue, 10 Jun 2008 20:27:18 -0430
From:	Ricardo Mendoza <ricmm@gentoo.org>
User-Agent: Thunderbird 2.0.0.6 (X11/20071112)
MIME-Version: 1.0
To:	Clem Taylor <clem.taylor@gmail.com>
CC:	linux-mips@linux-mips.org
Subject: Re: early hang in 2.6.24 on au1550 (MIPSLE)
References: <ecb4efd10806101430o426a2b51r3895871e31ceec89@mail.gmail.com>
In-Reply-To: <ecb4efd10806101430o426a2b51r3895871e31ceec89@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV version 0.93.1, clamav-milter version 0.93.1 on 10.128.1.151
X-Virus-Status:	Clean
Return-Path: <ricmm@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19469
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ricmm@gentoo.org
Precedence: bulk
X-list: linux-mips

Clem Taylor wrote:

> A few months ago I switched from 2.6.16.16 to 2.6.24 on an AU1550
> (MIPSLE) system. I started rolling this out to more systems, getting
> ready for a new software release and discovered that on fresh powerup,
> the 2.6.24 kernel sometimes (1 in 10-25 power cycles) fails to start.
> The bootloader (uboot) decompresses the kernel from a jffs2 filesystem
> and then jumps to it, but I don't get any serial messages from the
> kernel.
> 
> If I switch back to the 2.6.16.16 kernel, everything is happy. The
> annoying thing is that I have been unable to catch the problem with
> the JTAG debugger connected, so I'm not sure where it is hanging.
> 
> I've been looking at diffs in the arch/mips tree and nothing has
> jumped out at me.   I don't think this is a hardware problem, this
> hardware platform has been fairly stable and it works just fine with
> the older kernel. I was wondering if anyone has any suggestions where
> I might look? Also, is anyone using 2.6.24 with a Au1550?

Nothing? What about time layer switch to make use of cevt and csrc
devices for example. Gotta keep in mind that  2.6.16 is archaic; you
should write an early printk implementation for au1550 and see where it
dies. With another board once I experienced something similar and it
happened to be timer interrupts getting skipped at times, so, you might
be dying in calibration if your problem is similar.


     Ricardo
