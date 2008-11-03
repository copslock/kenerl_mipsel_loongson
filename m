Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Nov 2008 14:28:32 +0000 (GMT)
Received: from orbit.nwl.cc ([81.169.176.177]:40331 "EHLO
	mail.ifyouseekate.net") by ftp.linux-mips.org with ESMTP
	id S23053428AbYKCO2a (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 3 Nov 2008 14:28:30 +0000
Received: from nuty (localhost [127.0.0.1])
	by mail.ifyouseekate.net (Postfix) with ESMTP id 101CD386DBBE;
	Mon,  3 Nov 2008 15:28:23 +0100 (CET)
Date:	Mon, 3 Nov 2008 15:29:42 +0100
From:	Phil Sutter <n0-1@freewrt.org>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] provide functions for gpio configuration
Message-ID: <20081103142942.GA13461@nuty>
Mail-Followup-To: Sergei Shtylyov <sshtylyov@ru.mvista.com>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
References: <1225412757-17894-1-git-send-email-n0-1@freewrt.org> <1225465088-29365-1-git-send-email-n0-1@freewrt.org> <490E2200.1070201@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <490E2200.1070201@ru.mvista.com>
User-Agent: Mutt/1.5.11
Return-Path: <n0-1@freewrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21168
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: n0-1@freewrt.org
Precedence: bulk
X-list: linux-mips

Hi,

On Mon, Nov 03, 2008 at 12:56:16AM +0300, Sergei Shtylyov wrote:
> >+	val &= ~( ~bitval << offset );   /* unset bit if bitval == 0 */
> >  
> 
>   If bitval == 0, ~bitval evaluates to all ones, and the final AND mask 
> ~(0xffffffff << offset) clears 32-offset MSBs. What you want is simply 
> ~(1 << offset).

Right, I messed up boolean and bitwise inverting. The correct line is:

| val &= ~(!bitval << offset);   /* unset bit if bitval == 0 */

That's the same as ~(1 << offset) when bitval is zero, but turns into a
no op when it's one. That's what I want here, successfully removing the
need for the if-else case.

> >@@ -176,117 +184,60 @@ static int rb532_gpio_direction_input(struct 
> >gpio_chip *chip, unsigned offset)
> > static int rb532_gpio_direction_output(struct gpio_chip *chip,
> > 					unsigned offset, int value)
> > {
> >-	unsigned long		flags;
> >-	u32			mask = 1 << offset;
> >-	u32			tmp;
> > 	struct rb532_gpio_chip	*gpch;
> >-	void __iomem		*gpdr;
> > 
> > 	gpch = container_of(chip, struct rb532_gpio_chip, chip);
> >-	writel(mask, gpch->regbase + GPIOD);
> >  
> 
>   Hm, the old code seems really borked here...

It's not as bad as this may look like. In fact I could just simplify
lots of the functions by having them call rb532_set_bit().

A patch fixing the above mentioned issue follows, thanks for your help!

Greetings, Phil
