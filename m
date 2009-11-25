Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Nov 2009 12:34:59 +0100 (CET)
Received: from vitalin.sorra.shikadi.net ([64.71.152.201]:3673 "EHLO
        vitalin.sorra.shikadi.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492472AbZKYLez (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Nov 2009 12:34:55 +0100
Received: from berkeloid.vlook.shikadi.net ([172.16.255.5])
        by vitalin.sorra.shikadi.net with esmtp (Exim 4.62)
        (envelope-from <a.nielsen@shikadi.net>)
        id 1NDG95-00048i-MT; Wed, 25 Nov 2009 21:34:51 +1000
Received: from korath.teln.shikadi.net ([192.168.0.14])
        by berkeloid.teln.shikadi.net with esmtp (Exim 4.68)
        (envelope-from <a.nielsen@shikadi.net>)
        id 1NDG94-0006MO-Sw; Wed, 25 Nov 2009 21:34:50 +1000
Message-ID: <4B0D165A.5030500@shikadi.net>
Date:   Wed, 25 Nov 2009 21:34:50 +1000
From:   Adam Nielsen <a.nielsen@shikadi.net>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-GB; rv:1.8.1.22) Gecko/20090809 Thunderbird/2.0.0.22 Mnenhy/0.7.5.0
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     linux-mips@linux-mips.org
Subject: Re: Can you add a signature to the kernel ELF image?
References: <4B0C625B.5070408@shikadi.net> <20091124234406.GB20316@linux-mips.org>
In-Reply-To: <20091124234406.GB20316@linux-mips.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <a.nielsen@shikadi.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25120
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: a.nielsen@shikadi.net
Precedence: bulk
X-list: linux-mips

> Take a look at arch/mips/kernel/head.S.  This file will be the first on
> the final linker call's command line, that is head.S's .text section will
> end at the lowest address.

Ah excellent, that combined with the linker script (to twiddle load addresses) 
is just what I'm after.

> #ifdef CONFIG_NCD_HMX
> 	b	1f
> 	nop
> 	nop
> 	.word	0x20
> 	.asciz	"XncdHMX"
> 	.word	0, 0, 0
> #endif

Perfect, thanks for the example, that makes it much easier.

>> [1] http://www.linux-mips.org/wiki/HMX
>
> The wiki page says something about a CRC but just poking a 0x20 into a
> constant address is not exactly a CRC calculation.  Not sure how this
> really is meant.

As far as I'm aware 0x20 means "ignore the CRC", I think the CRC itself is 
covered by one of the zero words.

Cheers,
Adam.
