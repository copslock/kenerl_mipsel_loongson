Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Jan 2004 18:37:27 +0000 (GMT)
Received: from mx5.Informatik.Uni-Tuebingen.De ([IPv6:::ffff:134.2.12.32]:7371
	"EHLO mx5.informatik.uni-tuebingen.de") by linux-mips.org with ESMTP
	id <S8225349AbUAMShY>; Tue, 13 Jan 2004 18:37:24 +0000
Received: from localhost (loopback [127.0.0.1])
	by mx5.informatik.uni-tuebingen.de (Postfix) with ESMTP
	id 0A0E0132; Tue, 13 Jan 2004 19:37:18 +0100 (NFT)
Received: from mx5.informatik.uni-tuebingen.de ([127.0.0.1])
 by localhost (mx5 [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 30756-01; Tue, 13 Jan 2004 19:37:16 +0100 (NFT)
Received: from dual (semeai.Informatik.Uni-Tuebingen.De [134.2.15.66])
	by mx5.informatik.uni-tuebingen.de (Postfix) with ESMTP
	id 89084121; Tue, 13 Jan 2004 19:37:15 +0100 (NFT)
Received: from mrvn by dual with local (Exim 3.36 #1 (Debian))
	id 1AgTPY-0006UX-00; Tue, 13 Jan 2004 19:37:08 +0100
To: Pete Popov <ppopov@mvista.com>
Cc: Goswin von Brederlow <brederlo@informatik.uni-tuebingen.de>,
	Linux MIPS mailing list <linux-mips@linux-mips.org>
Subject: Re: Kernel oops on XXS1500 in au1000eth.c
References: <87lloblo27.fsf@mrvn.homelinux.org>
	<1074018143.21864.13.camel@zeus.mvista.com>
From: Goswin von Brederlow <brederlo@informatik.uni-tuebingen.de>
Date: 13 Jan 2004 19:37:08 +0100
In-Reply-To: <1074018143.21864.13.camel@zeus.mvista.com>
Message-ID: <87d69nlmp7.fsf@mrvn.homelinux.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Reasonable Discussion)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Virus-Scanned: by amavisd-new (McAfee AntiVirus) at informatik.uni-tuebingen.de
Return-Path: <brederlo@informatik.uni-tuebingen.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3925
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: brederlo@informatik.uni-tuebingen.de
Precedence: bulk
X-list: linux-mips

Pete Popov <ppopov@mvista.com> writes:

> On Tue, 2004-01-13 at 10:07, Goswin von Brederlow wrote:
> > Hi,
> > 
> > when compiling a kernel for my XXS1500 I allways ended up with a
> > kernel oops in the network driver (au1000eth.c).
> > 
> > Finaly I checked the actual kernel source the running kernel was build
> > from and found "CONFIG_BCM5222_DUAL_PHY" was set. Setting that solves
> > the oops.
> > 
> > Maybe that could be caught in some way and prevented.
> 
> Well, the kernel shouldn't be crashing but as far as the BCM dual phy
> thing -- I'm not sure how to detect it at run time without knowing ahead
> of time that we've got one.  I admittedly haven't spent too much time
> thinking about this problem but I didn't see an easy way to handle it.
> 
> Pete

Maybe some

if (mach == MACH_XXS1500) ...

construct? The MACH_XXS1500 must be good for something.

Hopefully MyCable will change the name when they design a new board
with a different network thing.

MfG
        Goswin
