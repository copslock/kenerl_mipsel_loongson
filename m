Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 10 May 2009 19:58:28 +0100 (BST)
Received: from qmta04.westchester.pa.mail.comcast.net ([76.96.62.40]:41059
	"EHLO QMTA04.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20023165AbZEJS6W (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 10 May 2009 19:58:22 +0100
Received: from OMTA10.westchester.pa.mail.comcast.net ([76.96.62.28])
	by QMTA04.westchester.pa.mail.comcast.net with comcast
	id puXt1b0090cZkys54uyGD7; Sun, 10 May 2009 18:58:16 +0000
Received: from [192.168.1.13] ([69.140.18.238])
	by OMTA10.westchester.pa.mail.comcast.net with comcast
	id puyG1b00858Be2l3WuyGnK; Sun, 10 May 2009 18:58:17 +0000
Message-ID: <4A072383.3010109@gentoo.org>
Date:	Sun, 10 May 2009 14:57:07 -0400
From:	Kumba <kumba@gentoo.org>
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
MIME-Version: 1.0
To:	Johannes Dickgreber <tanzy@gmx.de>
CC:	Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: Help getting IP30/Octane fixed?
References: <4A06100F.7020105@gentoo.org> <4A0717AA.8060603@gmx.de>
In-Reply-To: <4A0717AA.8060603@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22679
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Johannes Dickgreber wrote:

> This is whats wrong with SMP: from file include/asm/mach-ip30/heart.h
> 
> #define HEART_IMR(x)		((volatile ulong *)0x900000000ff10000 + (8 * (x)))
> 
> I schould be
> 
> #define HEART_IMR(x)		((volatile ulong *)0x900000000ff10000 + (x))
> 
> or it schould be
> 
> #define HEART_IMR(x)		((volatile ulong *) (0x900000000ff10000 + (8 * (x))))
> 
> The IRQ MASK Register for the different CPUs are side by side.
> In your version the factor 8 is used twice. First explicit inside the braces
> and second, because of the pointer to ulong implicit done by the
> compiler.
> I checked it by dissambling the code and my smp-kernel is working if i start
> only with one cpu. With 2 cpus the smp-kernel is booting, but the init process
> hangs then.

I'll have to test this when I get a new SMP module in.  Found a cheap R10K 
(yuck) on eBay for real cheap that'll suffice.  My R12000-300MHz refused to post 
at all (LED didn't even change to red, but the PROM would process NMI resets, 
oddly enough).

Ricardo (ricmm on IRC) explained it as this:

<ricmm> the baseline problem is that the secondary CPU's ipi irq is not 
triggering, the first one works
<ricmm> and smp_call_function() is calling an init function on both CPUs with a 
wait_for_completion flag set
<ricmm> but the second CPU will never run the function as the irq is not 
happening, therefore the flag will remain set
<ricmm> and smp_call_function() will spin waiting for the completion


> the revert is not needed anymore, because of code in arch/mips/pci/ops-bridge.c
> look for the function emulate_ioc3_cfg

Awesome, that's great to know!


> i have done some more work on the older patches and have a working kernel.
> if someone wants this patch, i can send it.

I'll take a look at it and see if I can integrate it into what I already have. 
Do you have it broken out into separate changes for the IOC3 metadriver and for 
the core IP30 code?


Thanks!

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org

"The past tempts us, the present confuses us, the future frightens us.  And our 
lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
