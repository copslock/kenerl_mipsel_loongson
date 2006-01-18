Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Jan 2006 01:06:47 +0000 (GMT)
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:41702 "EHLO
	rwcrmhc12.comcast.net") by ftp.linux-mips.org with ESMTP
	id S8133560AbWARBG3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 18 Jan 2006 01:06:29 +0000
Received: from [192.168.1.4] (pcp04414054pcs.nrockv01.md.comcast.net[69.140.185.48])
          by comcast.net (rwcrmhc13) with ESMTP
          id <2006011801100201500afot6e>; Wed, 18 Jan 2006 01:10:03 +0000
Message-ID: <43CD9568.1000707@gentoo.org>
Date:	Tue, 17 Jan 2006 20:10:00 -0500
From:	Kumba <kumba@gentoo.org>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To:	linux-mips <linux-mips@linux-mips.org>
CC:	zhuzhenhua <zzh.hust@gmail.com>
Subject: Re: how to emdedded ramdisk.gz in vmlinux for linux-2.6.14?
References: <0F31272A2BCBBE4FA01344C6E69DBF501EAB1B@thoth.ivivity.com>	 <43CC39A0.8080704@gentoo.org> <1137515220.11738.2.camel@localhost.localdomain>
In-Reply-To: <1137515220.11738.2.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9958
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Marc Karasek wrote:
> Is this a better solution than having the ramdisk embedded? 

This is embedding the ramdisk.  Only in a different way.


> It seems that most of the MIPS development is embedded designs and this
> could be a problem if it is not :
> 
> 1) Easier 

Not exactly easier, initially.  I spent near a few weeks figuring initramfs out. 
  The kernel is rather picky on certain things.  The main point is you need 
/init, and if it's a script, then the very first line must be a hashbang 
(!#/bin/blah).  Those two gave me headaches for awhile.  Other oddities can 
occur that make initramfs a bit of a pain initially.


> or
> 2) Faster

Faster by what?  initramfs is unique because it resides on a level above the 
arches, so it tends to be a sort of universal ramdisk.  SGI Origin system 
couldn't use ramdisks originally because of their memory structure.  They can, 
however, use initramfs.  I maintained patches for a time (up until ~2.6.13) that 
added embedded ramdisk support back into the kernel, but now that I have 
initramfs down pretty well (a tool does the grunt work for my needs, actually), 
I'm not going to maintain those patches any longer.


--Kumba

-- 
Gentoo/MIPS Team Lead
Gentoo Foundation Board of Trustees

"Such is oft the course of deeds that move the wheels of the world: small hands 
do them because they must, while the eyes of the great are elsewhere."  --Elrond
