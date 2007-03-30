Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Mar 2007 07:19:22 +0100 (BST)
Received: from sccrmhc13.comcast.net ([204.127.200.83]:9908 "EHLO
	sccrmhc13.comcast.net") by ftp.linux-mips.org with ESMTP
	id S20021417AbXC3GTU (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 30 Mar 2007 07:19:20 +0100
Received: from [192.168.1.4] (c-69-251-93-234.hsd1.md.comcast.net[69.251.93.234])
          by comcast.net (sccrmhc13) with ESMTP
          id <20070330061834013003egm4e>; Fri, 30 Mar 2007 06:18:35 +0000
Message-ID: <460CABBA.100@gentoo.org>
Date:	Fri, 30 Mar 2007 02:18:34 -0400
From:	Kumba <kumba@gentoo.org>
User-Agent: Thunderbird 2.0b2 (Windows/20070116)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	linux-mips@linux-mips.org, ths@networkno.de, ralf@linux-mips.org
Subject: Re: [PATCH]: Remove CONFIG_BUILD_ELF64 entirely
References: <460A6CED.1070308@gentoo.org>	<20070329.002453.18311528.anemo@mba.ocn.ne.jp>	<460B1B64.1040401@gentoo.org> <20070329.235333.25910277.anemo@mba.ocn.ne.jp>
In-Reply-To: <20070329.235333.25910277.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14779
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> Hmm... really strange.
> 
> This is OK:
> 		lui	k1, %highest(kernelsp)
> 		daddiu	k1, %higher(kernelsp)
> 		dsll	k1, k1, 16
> 		daddiu	k1, %hi(kernelsp)
> 		dsll	k1, k1, 16
> 
> This is NG:
> 		lui	k1, %hi(kernelsp)
> 
> So, could you try this one?
> 
> 		nop
> 		nop
> 		nop
> 		nop
> 		lui	k1, %hi(kernelsp)
> 
> If it booted, the problem should be in something irrelevant place.
> I.e. this optimization just triggers other bug by code/data movement.

Yup, it booted.  On further testing at iluxa's behest, it turns out it may be 
some quirk/cpu errata related to the RM5200 I use in my O2.  I swapped it out 
for a plain R5000 @ 200MHz, and removed the nop's -- boots fine.

This may also explain why the cobalt's were hitting something odd.  They also 
use a member of the RM52xx family (RM5231 iirc, O2 uses an RM5261).


--Kumba

-- 
Gentoo/MIPS Team Lead

"Such is oft the course of deeds that move the wheels of the world: small hands 
do them because they must, while the eyes of the great are elsewhere."  --Elrond
