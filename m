Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7FLxAc13847
	for linux-mips-outgoing; Wed, 15 Aug 2001 14:59:10 -0700
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7FLx9j13840
	for <linux-mips@oss.sgi.com>; Wed, 15 Aug 2001 14:59:09 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id OAA24667;
	Wed, 15 Aug 2001 14:59:02 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id OAA05223;
	Wed, 15 Aug 2001 14:59:01 -0700 (PDT)
Received: from copsun17.mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id f7FLvfa17185;
	Wed, 15 Aug 2001 23:57:41 +0200 (MEST)
From: Hartvig Ekner <hartvige@mips.com>
Received: (from hartvige@localhost)
	by copsun17.mips.com (8.9.1/8.9.0) id XAA29536;
	Wed, 15 Aug 2001 23:57:41 +0200 (MET DST)
Message-Id: <200108152157.XAA29536@copsun17.mips.com>
Subject: Re: About booting malta board.
To: swang@mmc.atmel.com
Date: Wed, 15 Aug 2001 23:57:41 +0200 (MET DST)
Cc: linux-mips@oss.sgi.com
In-Reply-To: <3B7AFD6B.C0891B97@mmc.atmel.com> from "Shuanglin Wang" at Aug 15, 2001 05:53:31 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

You would need to be a little more specific if you want help - e.g. what
kernel did you boot, did you get the binary from the MIPS Malta CDROM or
website, did you compile yourself, what "go" command parameters did you
use to launch the kernel, what CPU are you running on, etc.

Only idea I can come up with unless you are more specific is that you
accidentally booted the wrong kernel, e.g. Atlas board kernel 
instead of Malta - this kernel will startup and then hang quickly.

/Hartvig

Shuanglin Wang writes:
> 
> I try to install the Linux on the Malta board. In the big-endian mode, it
> works fine. But in the little-endian mode, the kernel just displayed
> "LINUX started..." and then deadlock.  Does anybody can help  me solve the
> problem ?
> 
> I guess the system maybe failed to create an initial console for displaying
> messages to me?
> 
> Thanks,
> 
> --Shuanglin
