Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Jan 2006 20:44:02 +0000 (GMT)
Received: from mail.ivivity.com ([64.238.111.98]:51014 "EHLO thoth.ivivity.com")
	by ftp.linux-mips.org with ESMTP id S3950158AbWATUnn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 20 Jan 2006 20:43:43 +0000
Received: from 192.168.1.162 ([192.168.1.162]) by thoth.ivivity.com ([192.168.1.9]) with Microsoft Exchange Server HTTP-DAV ;
 Fri, 20 Jan 2006 20:47:33 +0000
Received: from MCK_Linux_NB by mail.ivivity.com; 20 Jan 2006 15:47:33 -0500
Subject: Re: how to emdedded ramdisk.gz in vmlinux for linux-2.6.14?
From:	Marc Karasek <marckarasek@ivivity.com>
To:	"P. Christeas" <p_christ@hol.gr>
Cc:	Linux-Mips <linux-mips@linux-mips.org>
In-Reply-To: <200601202203.14325.p_christ@hol.gr>
References: <0F31272A2BCBBE4FA01344C6E69DBF501EAB1B@thoth.ivivity.com>
	 <200601202129.11398.p_christ@hol.gr>
	 <1137786593.22994.46.camel@localhost.localdomain>
	 <200601202203.14325.p_christ@hol.gr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Date:	Fri, 20 Jan 2006 15:47:33 -0500
Message-Id: <1137790053.22994.58.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Return-Path: <marck@ivivity.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10028
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marckarasek@ivivity.com
Precedence: bulk
X-list: linux-mips

Basically due to design issues and cost issues having a flash based
system is not possible.  Currently we have only 16MB total of flash and
the biggest contiguous block avail in this is only 12MB.  Our current
ramdisk (uncompressed) is running at 30MB.  Basically, memory is cheaper
than flash.  When you have designs that are very cost sensitive (to put
it lightly), for example adding a 50 cent part is a major event.  You
cannot just say we need more flash...  If we are to continue to support
the embedded market for Linux,  every decision we make as too what
feature gets put in, which ones get dropped have to be made with
everyone in mind.  What is good for the desktop market, may not be the
best solution for the embedded market.  BTW: When I mean embedded I do
not mean Ipaq or Palm.  These are small computers with a completely
different set of requirements than a 1U pizza box headless storage
controller/switch/etc.



On Fri, 2006-01-20 at 22:03 +0200, P. Christeas wrote:
> On Friday 20 January 2006 9:49 pm, you wrote:
> > Actually what we have currently done is seperate the ramdisk.gz image
> > from the kernel. By default the kernel would combine the two images.
> > This was done for a number of reasons,  being able to customize the
> > ramdisk apart from the kernel (different applications),  updating the
> > ramdisk/kernel seperate from one another, flash and memory constraints.
> >
> > In our process the embedded ramdisk is the filesystem.  It contains
> > busybox, all of our applications/kernel modules, glibc, etc.  And before
> > you ask, yes we have looked at uCLibc, but it does not fit our needs,
> > especially now that it is coupled with its own ramdisk creation tools.
> >
> > One other thing that bothers me is the ability for ramfs to grow/shrink
> > as needed.  This could be a major roadblock for us.  With an embedded
> > system, I would be hesitant to put in a filesystem that could gobble up
> > all of the memory.  At least with ramdisk, you would get a not enough
> > room message, with ramfs it just keeps growing until the kernel locks-
> > up.  (At least this is my impression.)  This is a very dangerous for an
> > embedded application.
> >
> 
> If you don't mind, you could post our conversation in public (if your layout 
> is not something secret). Tell me if I should cc to linux-mips.
> 
> One point is that nowadays, systems are *not* diskless. Since flash memory can 
> be used as a partition, there should be no reason to have a kernel with 
> embedded rootfs.
> Why not have sth like squashfs or jffs2 (rw) somewhere in the memory and use 
> it (which wouldn't require any RAM)?
> If you want, you could consider a "failsafe" ramdisk/fs that would load in 
> special cases (explicit load or a button press at boottime) where you need to 
> update the squashfs on the flash.
-- 
Any content within this email is provided “AS IS” for informational purposes only.  No contract will be formed between the parties by virtue of this email. 
/***********************
Marc Karasek
System Lead Technical Engineer
iVivity Inc.
T 678-990-1550 x238
F 678-990-1551
***********************/
