Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Oct 2003 00:16:40 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:61687 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8225391AbTJ1AQi>;
	Tue, 28 Oct 2003 00:16:38 +0000
Received: from zeus.mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id QAA03382;
	Mon, 27 Oct 2003 16:16:30 -0800
Subject: Re: Pb1500 and PCMCIA booting?
From: Pete Popov <ppopov@mvista.com>
To: Greg Herlein <gherlein@herlein.com>
Cc: Linux MIPS mailing list <linux-mips@linux-mips.org>
In-Reply-To: <Pine.LNX.4.44.0310271113460.604-100000@io.herlein.com>
References: <Pine.LNX.4.44.0310271113460.604-100000@io.herlein.com>
Content-Type: text/plain
Organization: MontaVista Software
Message-Id: <1067300192.22671.254.camel@zeus.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 27 Oct 2003 16:16:32 -0800
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3527
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@mvista.com
Precedence: bulk
X-list: linux-mips

Greg,

On Mon, 2003-10-27 at 11:15, Greg Herlein wrote:
> Does anyone have advice/experience in what's the best way to get 
> linux booting from the Pb1500 development board directly off 
> PCMCIA?  I'm susepcting that getting a bootable filesystem rigged 
> up on a CF card and using my handy CF <-> PCMCIA adapter card to 
> get it onto the bus.  
> 
> Any advice/gotchas/hints as I start down this path?

If you want to boot Linux off pcmcia, you need to add that support to
yamon or whatever boot code you're using.

If you're talking about using a pcmcia for a root file system, then what
you can do is:

- build your root fs and dump it on the pcmcia card
- create a small ramdisk which you'll statically link into your kernel.
Your ramdisk will be your temporary root FS and should contain on it
things like the pcmcia modules and socket driver, a script that loads
them, cardmgr, insmod, mount, and ... I don't remember what else but
that's pretty much it. The kernel mounts the ramdisk root fs, executes
your script which does its magic, then control is passed to the kernel
which mounts the real root fs on the pcmcia card.

Pete
