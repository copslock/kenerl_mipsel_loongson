Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Jun 2005 12:44:58 +0100 (BST)
Received: from alg145.algor.co.uk ([IPv6:::ffff:62.254.210.145]:27400 "EHLO
	dmz.algor.co.uk") by linux-mips.org with ESMTP id <S8225762AbVFMLok>;
	Mon, 13 Jun 2005 12:44:40 +0100
Received: from alg158.algor.co.uk ([62.254.210.158] helo=olympia.mips.com)
	by dmz.algor.co.uk with esmtp (Exim 3.35 #1 (Debian))
	id 1Dhnem-0007Mc-00; Mon, 13 Jun 2005 13:03:08 +0100
Received: from gladsmuir.algor.co.uk ([172.20.192.66] helo=gladsmuir)
	by olympia.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1DhnML-0003ng-00; Mon, 13 Jun 2005 12:44:05 +0100
From:	Dominic Sweetman <dom@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17069.29065.124810.728626@gargle.gargle.HOWL>
Date:	Mon, 13 Jun 2005 12:44:09 +0100
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	qemu-devel@nongnu.org, linux-mips@linux-mips.org,
	Jocelyn Mayer <l_indien@magic.fr>,
	Fabrice Bellard <fabrice@bellard.org>
Subject: Re: Qemu for MIPS
In-Reply-To: <20050613105944.GA19704@linux-mips.org>
References: <20050613105944.GA19704@linux-mips.org>
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
X-MTUK-Scanner:	Found to be clean
X-MTUK-SpamCheck: not spam (whitelisted), SpamAssassin (score=-4.834,
	required 4, AWL, BAYES_00)
Return-Path: <dom@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8073
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dom@mips.com
Precedence: bulk
X-list: linux-mips


Ralf Baechle (ralf@linux-mips.org) writes:

> I've posted updated Qemu patches on
> 
>   ftp://ftp.linux-mips.org/pub/linux/mips/qemu
>   http://www.linux-mips.org/wiki/index.php/Qemu
> 
> Enhancements over last week's patches:
> 
>  o The count/compare interrupt will now properly be delivered.
>  o mfc0 will now return the proper value for the EXL and ERL flags
>  o eret will now consider the value of ERL and EXL.
>  o i8259 PIC is now properly cascaded to a CPU interrupt.
>  o An ISA NE2000 card will now be emulated.
>  o The CPU's random register now considers the value of the wired register

Great stuff...

> Known bugs:
> 
>  o ll/sc don't use a ll_bit like the real hardware thus right now any atomic
>    functions aren't really atomic.

I suppose you know that the CPUs all implement "break link on
exception" by zeroing the link bit on an 'eret'?  That doesn't sound
too hard...

>  o ll/sc really should be watching a physical not a virtual address or they
>    won't do much useful on any kind of shared memory structure.
>  o MIPS documentation documents the lladdr register to contain the virtual
>    address of the location being watched but about every implementation
>    since the R4000 actually keeps the physical address there - and documents
>    that as an erratum even though it actually the sensible thing to do.  We
>    should do the same.  Fortunately nothing that I know of actually relies
>    on the content of the lladdr register, so this one is cosmetic.

Arguably, an emulator should not provide the LLaddr register at all.
It's optional and "only available for debug" - and probably such
debugging is possible another way in an emulator.  Robust software
shouldn't depend on assuming the contents make sense.

> ...
> Kernel panic - not syncing: No init found.  Try passing init= option to kernel.
> 
> Which is a bug - there is a valid root filesystem.  Something for tomorrow.

Not quite there yet... but well done, again.

--
Dominic
