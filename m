Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 May 2003 08:45:53 +0100 (BST)
Received: from p0241.as-l042.contactel.cz ([IPv6:::ffff:194.108.237.241]:3332
	"EHLO kopretinka") by linux-mips.org with ESMTP id <S8225230AbTEHHpv>;
	Thu, 8 May 2003 08:45:51 +0100
Received: from ladis by kopretinka with local (Exim 3.35 #1 (Debian))
	id 19Dg3Z-0000Gs-00; Thu, 08 May 2003 09:43:09 +0200
Date: Thu, 8 May 2003 09:43:09 +0200
To: Juan Quintela <quintela@mandrakesoft.com>
Cc: Ladislav Michl <ladis@linux-mips.org>, linux-mips@linux-mips.org,
	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] SGI Seeq cleanup
Message-ID: <20030508074308.GB837@kopretinka>
References: <20030507202851.GA668@kopretinka> <86d6iul7z3.fsf@trasno.mitica>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86d6iul7z3.fsf@trasno.mitica>
User-Agent: Mutt/1.3.28i
From: Ladislav Michl <ladis@linux-mips.org>
Return-Path: <ladis@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2291
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ladis@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, May 08, 2003 at 12:14:56AM +0200, Juan Quintela wrote:
> >>>>> "ladis" == Ladislav Michl <ladis@linux-mips.org> writes:
> 
> ladis> read eaddr using NVRAM access fuctions and make various cleanups so driver
> ladis> can be build as module
> 
> You are my hero!
> 
> [ Removal of Space.c entry ] 

Question comes in mind: It's possible to have ISA eth card installed in
Indigo2. How to ensure that onboard Seeq will be always eth0 without
using Space.c? (and don't advice me to build driver for ISA card as
module :))

> Hero++
> 
> ladis> @@ -96,8 +97,8 @@
> ladis> struct sgiseeq_private {
> ladis> volatile struct sgiseeq_init_block srings;
> ladis> char *name;
> ladis> -	volatile struct hpc3_ethregs *hregs;
> ladis> -	volatile struct sgiseeq_regs *sregs;
> ladis> +	struct hpc3_ethregs *hregs;
> ladis> +	struct sgiseeq_regs *sregs;
> 
> I read through all the patch, and I didn't understand why volatile is
> not needed anymore :(
> 
> Althought not that I did understand why it was needed in the first
> place :)

I think struct members have to be volatile, not struct itself.

> ladis> @@ -435,7 +439,7 @@
> ladis> /* Always check for received packets. */
> ladis> sgiseeq_rx(dev, sp, hregs, sregs);
>  
> ladis> -	/* Only check for tx acks iff we have something queued. */
> ladis> +	/* Only check for tx acks if we have something queued. */
> ladis> if (sp->tx_old != sp->tx_new)
> ladis> sgiseeq_tx(dev, sp, hregs, sregs);
> 
> iff == Math speak for if and only if.  Not sure if iff is needed in
> that context at all.

Ah, didn't know it. But i'd say simple if is enough in this case :)

	ladis
