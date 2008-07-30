Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Jul 2008 22:37:07 +0100 (BST)
Received: from mx1.razamicroelectronics.com ([63.111.213.197]:26984 "EHLO
	hq-ex-mb01.razamicroelectronics.com") by ftp.linux-mips.org with ESMTP
	id S20022716AbYG3VhA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 30 Jul 2008 22:37:00 +0100
Received: from 10.8.0.25 ([10.8.0.25]) by hq-ex-mb01.razamicroelectronics.com ([10.1.1.40]) via Exchange Front-End Server webmail.razamicroelectronics.com ([10.1.1.41]) with Microsoft Exchange Server HTTP-DAV ;
 Wed, 30 Jul 2008 21:36:50 +0000
Received: from kh-ubuntu by webmail.razamicroelectronics.com; 30 Jul 2008 21:36:59 +0000
Subject: Re: [PATCH v4 0/10] Alchemy updates.
From:	Kevin Hickey <khickey@rmicorp.com>
To:	Manuel Lauss <mlau@msc-ge.com>
Cc:	Manuel Lauss <mano@roarinelk.homelinux.net>,
	linux-mips@linux-mips.org
In-Reply-To: <48904264.8040600@msc-ge.com>
References: <20080729165853.GB8784@roarinelk.homelinux.net>
	 <1217367234.13597.11.camel@kh-ubuntu.razamicroelectronics.com>
	 <48904264.8040600@msc-ge.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Date:	Wed, 30 Jul 2008 21:36:59 +0000
Message-Id: <1217453819.13597.29.camel@kh-ubuntu.razamicroelectronics.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.22.3.1 
Return-Path: <khickey@rmicorp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20056
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: khickey@rmicorp.com
Precedence: bulk
X-list: linux-mips

On Wed, 2008-07-30 at 12:28 +0200, Manuel Lauss wrote:
> Hi Kevin,
> 
> > 1.  I like the interface you added in patch #10.  Much better than the
> > old /proc one and flexible enough for a lot of different boards.  I
> > agree with your own comment that maybe it should be in the
> > board-specific directories so that people can name the nodes better, but
> > for now I think this is great.
> 
> Thinking about my board here in particular: I need to save/restore a
> few bytes in an FPGA (in the ->enter() callback) and call a few other
> pm related callbacks; the gpio nodes are set internally by or'ing together
> other wake sources (think carddetects, Wake on lan, GSM modem irq, ...).
> 
> So if we want to keep it the way it is now, we should give boards a means
> to disable exposure of each of the "standard" wakesources of the Au1000 chip,
> to provide their own nodes and suspend_ops_t callbacks.
> 
I agree - what I should have said is that the current method is good for
this patch set.  It should be enhanced but that should not block the
acceptance of these patches.
> 
> > 2.  If I use the db1200_defconfig and enable Power Management
> > (CONFIG_PM), the build fails on the Au1xxx IDE and fb drivers.  Are you
> > seeing this too?  I see no reason to reject this patch if they don't
> > build with CONFIG_PM, I just want to make sure I'm not doing something
> > wrong.
> 
> The au1200fb failure, yes. I also have a patch to fix it, but it needs
> a bit more love: X for example does not always survive the framebuffer
> suspend/resume cycle (it complains about changed parameters after resume).
> 
Sounds good.  Looking forward to it.

> IDE I can't use so didn't test.
We have it on our board so I'll take care of it.  I have a partial
solution working already.

> 
> 
> > 3.  In my preliminary testing, the system was able to suspend and resume
> > correctly on a DB1200 board.  I will do some stress testing in the next
> > couple of days to make sure that it is stable in the long term. 
> 
> Very much appreciated!
> 
> Thanks Kevin,
> 	Manuel Lauss
> 
-- 
Kevin Hickey
﻿Alchemy Solutions
RMI Corporation
khickey@RMICorp.com
P: 512.691.8044
