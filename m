Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Apr 2003 17:23:46 +0100 (BST)
Received: from smtp-out.comcast.net ([IPv6:::ffff:24.153.64.115]:48140 "EHLO
	smtp-out.comcast.net") by linux-mips.org with ESMTP
	id <S8225240AbTDNQXq>; Mon, 14 Apr 2003 17:23:46 +0100
Received: from gentoo.org
 (pcp02545003pcs.waldrf01.md.comcast.net [68.48.92.102])
 by mtaout09.icomcast.net
 (iPlanet Messaging Server 5.2 HotFix 1.14 (built Mar 18 2003))
 with ESMTP id <0HDC003IYDI5KQ@mtaout09.icomcast.net> for
 linux-mips@linux-mips.org; Mon, 14 Apr 2003 12:22:53 -0400 (EDT)
Date: Mon, 14 Apr 2003 12:24:54 -0400
From: Kumba <kumba@gentoo.org>
Subject: Re: Oddities with CVS Kernels, Memory on Indigo2
In-reply-to: <wrpbrz9vzkl.fsf@hina.wild-wind.fr.eu.org>
To: linux-mips@linux-mips.org
Reply-to: kumba@gentoo.org
Message-id: <3E9AE0D6.5060401@gentoo.org>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.3)
 Gecko/20030312
References: <3E98F206.5050206@gentoo.org> <20030414140717.GA805@simek>
 <3E9AD98B.90808@gentoo.org> <wrpbrz9vzkl.fsf@hina.wild-wind.fr.eu.org>
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2029
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips


	Also, forgot to mention on this topic, but while messing with ISA/EISA 
cards in the I2, I've run across some strange "hack" regarding Local IRQ 
3 on the machine.  There's a construct inside 
arch/mips/sgi-ip22/ip22-int.c in the enable_local3_irq() function that 
purposely panics the kernel if LIRQ3 is probed or used.  Any one got any 
idea why this is?  There aren't any comments in the code to explain this 
odd little construct, and removing it generates some amusing messages at 
bootup, long the lines of "Whee: Got an LIO3 irq, winging it...".  Quite 
odd if you ask me.

--Kumba


Marc Zyngier wrote:
>>>>>>"kumba" == kumba  <kumba@gentoo.org> writes:
> 
> 
> kumba> Mind you, that's an ISA Parallel Port card I dropped in.  I
> kumba> noticed the SGI's parallel port never worked, so I dug up a
> kumba> spare and tried it.
> 
> So you're the first to try an ISA card on the I2. I must say I'm
> quite pleased it worked ! :-)
> 
>         M.
