Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Apr 2004 21:49:57 +0100 (BST)
Received: from modemcable166.48-200-24.mc.videotron.ca ([IPv6:::ffff:24.200.48.166]:33737
	"EHLO xanadu.home") by linux-mips.org with ESMTP
	id <S8225760AbUD2Ut4>; Thu, 29 Apr 2004 21:49:56 +0100
Received: from localhost (nico@localhost)
	by xanadu.home (8.11.6/8.11.6) with ESMTP id i3TKnj801327;
	Thu, 29 Apr 2004 16:49:45 -0400
X-Authentication-Warning: xanadu.home: nico owned process doing -bs
Date: Thu, 29 Apr 2004 16:49:45 -0400 (EDT)
From: Nicolas Pitre <nico@cam.org>
X-X-Sender: nico@xanadu.home
To: Tim Bird <tim.bird@am.sony.com>
cc: linux kernel <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.arm.linux.org.uk>,
	<linux-mips@linux-mips.org>, <linux-sh-ctl@m17n.org>,
	CE Linux Developers List <celinux-dev@tree.celinuxforum.org>
Subject: Re: CONFIG_XIP_ROM vs. CONFIG_XIP_KERNEL
In-Reply-To: <40915265.2050906@am.sony.com>
Message-ID: <Pine.LNX.4.44.0404291644170.30657-100000@xanadu.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <nico@cam.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4927
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nico@cam.org
Precedence: bulk
X-list: linux-mips

On Thu, 29 Apr 2004, Tim Bird wrote:

> I'm looking at some sources for kernel Execute-in-place (XIP).
> 
> I see references to CONFIG_XIP_ROM and CONFIG_XIP_KERNEL,
> in different architecture branches of the same kernel
> source tree.
> 
> Is this difference merely the result of inconsistent
> usage, or is there a functional difference between
> these two options?

It's the result of me deciding CONFIG_XIP_ROM wasn't totally appropriate ...  

> I can imagine that CONFIG_XIP_ROM is intended only to
> handle XIP in ROM, and that CONFIG_XIP_KERNEL possibly
> handles additional cases like XIP in flash.  However,
> before jumping to that conclusion I thought I would
> ask if there is some intention behind the different
> config names.

... so I renamed it to CONFIG_XIP_KERNEL.  Especially since there is also 
XIPable user space which also can be stored in ROM (or flash).  So please 
disregard CONFIG_XIP_ROM and use CONFIG_XIP_KERNEL.  Whether ROM or Flash is 
used is rather irrelevant to the code this option is linked to.


Nicolas
