Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 May 2003 23:15:28 +0100 (BST)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:14692 "EHLO
	trasno.mitica") by linux-mips.org with ESMTP id <S8225227AbTEGWPZ>;
	Wed, 7 May 2003 23:15:25 +0100
Received: by trasno.mitica (Postfix, from userid 1001)
	id C4CB67DC; Thu,  8 May 2003 00:14:56 +0200 (CEST)
To: Ladislav Michl <ladis@linux-mips.org>
Cc: linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] SGI Seeq cleanup
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
In-Reply-To: <20030507202851.GA668@kopretinka> (Ladislav Michl's message of
 "Wed, 7 May 2003 22:28:51 +0200")
References: <20030507202851.GA668@kopretinka>
Date: Thu, 08 May 2003 00:14:56 +0200
Message-ID: <86d6iul7z3.fsf@trasno.mitica>
User-Agent: Gnus/5.090015 (Oort Gnus v0.15) Emacs/21.2.93
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2286
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips

>>>>> "ladis" == Ladislav Michl <ladis@linux-mips.org> writes:

ladis> read eaddr using NVRAM access fuctions and make various cleanups so driver
ladis> can be build as module

You are my hero!

[ Removal of Space.c entry ] 

Hero++

ladis> @@ -96,8 +97,8 @@
ladis> struct sgiseeq_private {
ladis> volatile struct sgiseeq_init_block srings;
ladis> char *name;
ladis> -	volatile struct hpc3_ethregs *hregs;
ladis> -	volatile struct sgiseeq_regs *sregs;
ladis> +	struct hpc3_ethregs *hregs;
ladis> +	struct sgiseeq_regs *sregs;

I read through all the patch, and I didn't understand why volatile is
not needed anymore :(

Althought not that I did understand why it was needed in the first
place :)

ladis> @@ -435,7 +439,7 @@
ladis> /* Always check for received packets. */
ladis> sgiseeq_rx(dev, sp, hregs, sregs);
 
ladis> -	/* Only check for tx acks iff we have something queued. */
ladis> +	/* Only check for tx acks if we have something queued. */
ladis> if (sp->tx_old != sp->tx_new)
ladis> sgiseeq_tx(dev, sp, hregs, sregs);

iff == Math speak for if and only if.  Not sure if iff is needed in
that context at all.

Later, Juan. 

-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
