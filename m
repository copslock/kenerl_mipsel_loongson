Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Nov 2009 16:12:07 +0100 (CET)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:35593 "EHLO
	roarinelk.homelinux.net" rhost-flags-OK-OK-OK-OK)
	by eddie.linux-mips.org with ESMTP id S1492557AbZKXPMD (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 24 Nov 2009 16:12:03 +0100
Received: (qmail 13141 invoked by uid 1000); 24 Nov 2009 15:10:57 -0000
Date:	Tue, 24 Nov 2009 16:10:57 +0100
From:	mano@roarinelk.homelinux.net
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	Manuel Lauss <manuel.lauss@googlemail.com>,
	Linux-MIPS <linux-mips@linux-mips.org>,
	Manuel Lauss <manuel.lauss@gmail.com>
Subject: Re: [PATCH 3/3] MIPS: Alchemy: irq: use runtime CPU type detection
Message-ID: <20091124151057.GA13030@wormhole>
References: <1259005202-7771-1-git-send-email-manuel.lauss@gmail.com>
 <1259005202-7771-2-git-send-email-manuel.lauss@gmail.com>
 <1259005202-7771-3-git-send-email-manuel.lauss@gmail.com>
 <4B0BED46.2030809@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4B0BED46.2030809@ru.mvista.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25095
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

Hi Sergei!

On Tue, Nov 24, 2009 at 05:27:18PM +0300, Sergei Shtylyov wrote:
> > Use runtime CPU detection instead of relying on preprocessor symbols.
> 
> > Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
> 
> [...]
> 
> > @@ -547,36 +549,9 @@ handle:
> >  	do_IRQ(off);
> >  }
> >  
> > -/* setup edge/level and assign request 0/1 */
> > -static void __init setup_irqmap(struct au1xxx_irqmap *map, int count)
> > +static void __init au1000_init_irq(struct au1xxx_irqmap *map)
> >  {
> 
>     Perhaps au1xxx_inint_irq() would be a better name...

I wanted to express that this is for au1000 and its compatible brethren
since the Au1300 has a completely different IRQ and GPIO system which
requires new code.

	Manuel
