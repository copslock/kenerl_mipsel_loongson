Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Jan 2006 21:04:30 +0000 (GMT)
Received: from mail.ivivity.com ([64.238.111.98]:50 "EHLO thoth.ivivity.com")
	by ftp.linux-mips.org with ESMTP id S8134471AbWASVEB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 19 Jan 2006 21:04:01 +0000
Received: from 192.168.1.162 ([192.168.1.162]) by thoth.ivivity.com ([192.168.1.9]) with Microsoft Exchange Server HTTP-DAV ;
 Thu, 19 Jan 2006 21:07:25 +0000
Received: from MCK_Linux_NB by mail.ivivity.com; 19 Jan 2006 16:07:45 -0500
Subject: Re: how to emdedded ramdisk.gz in vmlinux for linux-2.6.14?
From:	Marc Karasek <marckarasek@ivivity.com>
To:	Kumba <kumba@gentoo.org>
Cc:	linux-mips <linux-mips@linux-mips.org>,
	zhuzhenhua <zzh.hust@gmail.com>
In-Reply-To: <43CD9568.1000707@gentoo.org>
References: <0F31272A2BCBBE4FA01344C6E69DBF501EAB1B@thoth.ivivity.com>
	 <43CC39A0.8080704@gentoo.org>
	 <1137515220.11738.2.camel@localhost.localdomain>
	 <43CD9568.1000707@gentoo.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Date:	Thu, 19 Jan 2006 16:07:45 -0500
Message-Id: <1137704865.22994.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Return-Path: <marck@ivivity.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10006
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marckarasek@ivivity.com
Precedence: bulk
X-list: linux-mips

Is the process still the same.  In that you create a ramdisk image that
can be mounted, just using initramfs instead?   

We will be moving to 2.6.x for our next chip and currently have scripts
to create a ramdisk with busybox embedded.  If these cannot be used
anymore, I may want to take over the patches for ramdisk from you and
maintain them.  Otherwise our sdk would have to change and the tools,
etc. and that is not a desireable option......

IMO: Fixing something that was not broken is not a very good idea. :-)

On Tue, 2006-01-17 at 20:10 -0500, Kumba wrote:
> Marc Karasek wrote:
> > Is this a better solution than having the ramdisk embedded? 
> 
> This is embedding the ramdisk.  Only in a different way.
> 
> 
> > It seems that most of the MIPS development is embedded designs and this
> > could be a problem if it is not :
> > 
> > 1) Easier 
> 
> Not exactly easier, initially.  I spent near a few weeks figuring initramfs out. 
>   The kernel is rather picky on certain things.  The main point is you need 
> /init, and if it's a script, then the very first line must be a hashbang 
> (!#/bin/blah).  Those two gave me headaches for awhile.  Other oddities can 
> occur that make initramfs a bit of a pain initially.
> 
> 
> > or
> > 2) Faster
> 
> Faster by what?  initramfs is unique because it resides on a level above the 
> arches, so it tends to be a sort of universal ramdisk.  SGI Origin system 
> couldn't use ramdisks originally because of their memory structure.  They can, 
> however, use initramfs.  I maintained patches for a time (up until ~2.6.13) that 
> added embedded ramdisk support back into the kernel, but now that I have 
> initramfs down pretty well (a tool does the grunt work for my needs, actually), 
> I'm not going to maintain those patches any longer.
> 
> 
> --Kumba
> 
-- 
Any content within this email is provided “AS IS” for informational purposes only.  No contract will be formed between the parties by virtue of this email. 
/***********************
Marc Karasek
System Lead Technical Engineer
iVivity Inc.
T 678-990-1550 x238
F 678-990-1551
***********************/
