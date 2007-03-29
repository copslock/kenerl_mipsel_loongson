Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Mar 2007 02:51:16 +0100 (BST)
Received: from rwcrmhc14.comcast.net ([216.148.227.154]:22267 "EHLO
	rwcrmhc14.comcast.net") by ftp.linux-mips.org with ESMTP
	id S20023217AbXC2BvO (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 29 Mar 2007 02:51:14 +0100
Received: from [192.168.1.4] (c-69-251-93-234.hsd1.md.comcast.net[69.251.93.234])
          by comcast.net (rwcrmhc14) with ESMTP
          id <20070329015029m140022c21e>; Thu, 29 Mar 2007 01:50:30 +0000
Message-ID: <460B1B64.1040401@gentoo.org>
Date:	Wed, 28 Mar 2007 21:50:28 -0400
From:	Kumba <kumba@gentoo.org>
User-Agent: Thunderbird 2.0b2 (Windows/20070116)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	linux-mips@linux-mips.org, ths@networkno.de, ralf@linux-mips.org
Subject: Re: [PATCH]: Remove CONFIG_BUILD_ELF64 entirely
References: <46086A90.7070402@gentoo.org>	<20070327.235310.128618679.anemo@mba.ocn.ne.jp>	<460A6CED.1070308@gentoo.org> <20070329.002453.18311528.anemo@mba.ocn.ne.jp>
In-Reply-To: <20070329.002453.18311528.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14766
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> Just an optimization.  For CKSEG0 symbol, a LUI instruction can fill
> high 32-bit by sign-extention.  Either code should work for CKSEG0
> kernel.

Hmm, strange then.  It's gotta be something those four extra commands do that 
IP32 likes.  IP22 boots fine with either form, though that has a separate 
problem where it looks like serial console on the zilog chip panics the system 
after booting into a netboot.

Doing some tests, I found out that by commenting out one or more of the 
daddui/dsll instructions for IP32 produced a kernel that still booted, but hung 
at running init/freeing kernel memory.  Using the single lui booted once, but I 
suspect that was my fault on not doing something proper, cause the next time 
around, it didn't boot at all.  I tested this all on a real console, versus 
serial, case there was an early panic or something.  But I see nothing to 
indicate why IP32 dislikes the lui->ld sequence versus the 
lui->daddui->dsll->etc->ld sequence.

There's no early printk on these systems either, so doing low-level debugging is 
difficult on them as well.


--Kumba

-- 
Gentoo/MIPS Team Lead

"Such is oft the course of deeds that move the wheels of the world: small hands 
do them because they must, while the eyes of the great are elsewhere."  --Elrond
