Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Jul 2008 11:30:21 +0100 (BST)
Received: from gate.msc-ge.com ([212.86.197.209]:46725 "EHLO gate.msc-ge.com")
	by ftp.linux-mips.org with ESMTP id S20033284AbYG3KaN (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 30 Jul 2008 11:30:13 +0100
Received: from localhost ([127.0.0.1]:34228)
	by msc-mail01.stu.msc-ge.com with esmtp (Exim 4.34 #5 (Debian))
	id 1KO8wa-0002Qx-C9; Wed, 30 Jul 2008 12:30:08 +0200
Received: from msc-mail01.stu.msc-ge.com ([127.0.0.1])
 by localhost (msc-mail01 [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 09060-04; Wed, 30 Jul 2008 12:30:07 +0200 (CEST)
Received: from msc-ex03.msc-ge.mscnet ([10.100.1.38]:23312)
	by msc-mail01.stu.msc-ge.com with esmtp (Exim 4.34 #5 (Debian))
	id 1KO8wZ-0002Ql-N3; Wed, 30 Jul 2008 12:30:07 +0200
Received: from [192.168.44.99] ([192.168.44.99]) by msc-ex03.msc-ge.mscnet with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 30 Jul 2008 12:30:17 +0200
Message-ID: <48904264.8040600@msc-ge.com>
Date:	Wed, 30 Jul 2008 12:28:52 +0200
From:	Manuel Lauss <mlau@msc-ge.com>
Organization: MSC Vertriebsges.m.b.H.
User-Agent: Thunderbird 2.0.0.16 (X11/20080725)
MIME-Version: 1.0
To:	Kevin Hickey <khickey@rmicorp.com>
CC:	Manuel Lauss <mano@roarinelk.homelinux.net>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH v4 0/10] Alchemy updates.
References: <20080729165853.GB8784@roarinelk.homelinux.net> <1217367234.13597.11.camel@kh-ubuntu.razamicroelectronics.com>
In-Reply-To: <1217367234.13597.11.camel@kh-ubuntu.razamicroelectronics.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Jul 2008 10:30:17.0964 (UTC) FILETIME=[42E35AC0:01C8F22F]
X-Virus-Scanned: by amavisd-new
Return-Path: <mlau@msc-ge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20050
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlau@msc-ge.com
Precedence: bulk
X-list: linux-mips

Hi Kevin,

> 1.  I like the interface you added in patch #10.  Much better than the
> old /proc one and flexible enough for a lot of different boards.  I
> agree with your own comment that maybe it should be in the
> board-specific directories so that people can name the nodes better, but
> for now I think this is great.

Thinking about my board here in particular: I need to save/restore a
few bytes in an FPGA (in the ->enter() callback) and call a few other
pm related callbacks; the gpio nodes are set internally by or'ing together
other wake sources (think carddetects, Wake on lan, GSM modem irq, ...).

So if we want to keep it the way it is now, we should give boards a means
to disable exposure of each of the "standard" wakesources of the Au1000 chip,
to provide their own nodes and suspend_ops_t callbacks.


> 2.  If I use the db1200_defconfig and enable Power Management
> (CONFIG_PM), the build fails on the Au1xxx IDE and fb drivers.  Are you
> seeing this too?  I see no reason to reject this patch if they don't
> build with CONFIG_PM, I just want to make sure I'm not doing something
> wrong.

The au1200fb failure, yes. I also have a patch to fix it, but it needs
a bit more love: X for example does not always survive the framebuffer
suspend/resume cycle (it complains about changed parameters after resume).

IDE I can't use so didn't test.


> 3.  In my preliminary testing, the system was able to suspend and resume
> correctly on a DB1200 board.  I will do some stress testing in the next
> couple of days to make sure that it is stable in the long term. 

Very much appreciated!

Thanks Kevin,
	Manuel Lauss
