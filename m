Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 14 Nov 2004 17:23:02 +0000 (GMT)
Received: from rwcrmhc12.comcast.net ([IPv6:::ffff:216.148.227.85]:38301 "EHLO
	rwcrmhc12.comcast.net") by linux-mips.org with ESMTP
	id <S8225221AbUKNRW5>; Sun, 14 Nov 2004 17:22:57 +0000
Received: from [192.168.1.4] (pcp05077810pcs.waldrf01.md.comcast.net[68.54.246.193])
          by comcast.net (rwcrmhc12) with ESMTP
          id <2004111417224801400pkanhe>
          (Authid: kumba12345);
          Sun, 14 Nov 2004 17:22:48 +0000
Message-ID: <419794FB.6020104@gentoo.org>
Date: Sun, 14 Nov 2004 12:25:15 -0500
From: Kumba <kumba@gentoo.org>
User-Agent: Mozilla Thunderbird 0.9 (Windows/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: Re: [PATCH]: Rewrite of arch/mips/ramdisk/
References: <4196FE7C.9040309@gentoo.org> <20041114085202.GA30480@lst.de>
In-Reply-To: <20041114085202.GA30480@lst.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6327
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Christoph Hellwig wrote:
> 
> So why do you keep it instead of using initramfs as you should - which
> is the portable method useable on all ports.

Not sure I'm following what you're asking/referring to.  This is for an 
embedded filesystem initrd, like for a small busybox-based initrd, useful for 
netboot images and the like.  From looking at the initramfs stuff in usr/, 
that looks to be specific for linking config.gz into the kernel, and not 
configurable to link in a filesystem-based initrd.

I basically mimiced the method in usr/ for arch/mips/ramdisk/.  If there's 
some more global mechanism for utilizing this and tying in an initrd, then I 
didn't see it.  The current code in arch/mips/ramdisk/ is virtually the same 
as the stuff in arch/sh/ramdisk/, so it doesn't look like any kind of code 
sharing is going on between the various ports that have an optional embedded 
ramdisk.


--Kumba

-- 
"Such is oft the course of deeds that move the wheels of the world: small 
hands do them because they must, while the eyes of the great are elsewhere." 
--Elrond
