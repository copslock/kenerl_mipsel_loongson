Received:  by oss.sgi.com id <S553848AbRBITA2>;
	Fri, 9 Feb 2001 11:00:28 -0800
Received: from pobox.sibyte.com ([208.12.96.20]:19472 "HELO pobox.sibyte.com")
	by oss.sgi.com with SMTP id <S553845AbRBITAV>;
	Fri, 9 Feb 2001 11:00:21 -0800
Received: from postal.sibyte.com (moat.sibyte.com [208.12.96.21])
	by pobox.sibyte.com (Postfix) with SMTP
	id 02982205FE; Fri,  9 Feb 2001 11:00:15 -0800 (PST)
Received: from SMTP agent by mail gateway 
 Fri, 09 Feb 2001 10:54:10 -0800
Received: from plugh.sibyte.com (plugh.sibyte.com [10.21.64.158])
	by postal.sibyte.com (Postfix) with ESMTP
	id 1ECEE1595F; Fri,  9 Feb 2001 11:00:15 -0800 (PST)
Received: by plugh.sibyte.com (Postfix, from userid 61017)
	id 47824686D; Fri,  9 Feb 2001 11:01:19 -0800 (PST)
From:   Justin Carlson <carlson@sibyte.com>
Reply-To: carlson@sibyte.com
Organization: Sibyte
To:     Pete Popov <ppopov@mvista.com>,
        "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: irq.c
Date:   Fri, 9 Feb 2001 10:56:50 -0800
X-Mailer: KMail [version 1.0.29]
Content-Type: text/plain
References: <3A843C2D.525643E7@mvista.com>
In-Reply-To: <3A843C2D.525643E7@mvista.com>
MIME-Version: 1.0
Message-Id: <0102091101190P.01909@plugh.sibyte.com>
Content-Transfer-Encoding: 8bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, 09 Feb 2001, Pete Popov wrote:
> There's a dozen copies of "irq.c", and a few more files that do the same
> thing but are named differently. The irq.c in arch/mips/kernel doesn't
> seem to be used by any system.  The PowerPC also has lots of variants
> also, but I believe they have a single irq.c file that all systems use. 
> So I guess my question is, is anyone using arch/mips/kernel/irq.c, and
> does everyone plan on moving to that file (which seems like the right
> thing to do).  
> 

I've noticed that arch/i386/kernel/irq.c has this note on it:

/*
 * (mostly architecture independent, will move to kernel/irq.c in 2.5.)
 *
 * IRQs are in fact implemented a bit like signal handlers for the kernel.
 * Naturally it's not a 1:1 relation, but there are similarities.
 */

My internal code uses this as a template, in anticipation of this move;
assuming this will happen in 2.5, does it make sense to do an intermediate move
to a common mips/kernel/irq.c?

If it does, I'd like to see mips/kernel/irq.c updated to more closely match the
i386 version, but I'm curious what other people think.

-Justin
