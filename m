Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 31 May 2009 02:30:43 +0100 (BST)
Received: from rhun.apana.org.au ([64.62.148.172]:54016 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org
	with ESMTP id S20024850AbZEaBaf (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 31 May 2009 02:30:35 +0100
Received: from gondolin.me.apana.org.au ([192.168.0.6])
	by arnor.apana.org.au with esmtp (Exim 4.63 #1 (Debian))
	id 1MAZsZ-0005Ky-Hy; Sun, 31 May 2009 11:30:27 +1000
Received: from herbert by gondolin.me.apana.org.au with local (Exim 4.69)
	(envelope-from <herbert@gondor.apana.org.au>)
	id 1MAZsU-0007Gt-Q3; Sun, 31 May 2009 11:30:22 +1000
Date:	Sun, 31 May 2009 11:30:22 +1000
From:	Herbert Xu <herbert@gondor.apana.org.au>
To:	Andrew Morton <akpm@linux-foundation.org>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org,
	ralf@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwrng: Add TX4939 RNG driver
Message-ID: <20090531013022.GA27930@gondor.apana.org.au>
References: <1243350141-883-1-git-send-email-anemo@mba.ocn.ne.jp> <20090529162907.9cb1bba2.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090529162907.9cb1bba2.akpm@linux-foundation.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <herbert@gondor.apana.org.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23078
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: herbert@gondor.apana.org.au
Precedence: bulk
X-list: linux-mips

On Fri, May 29, 2009 at 04:29:07PM -0700, Andrew Morton wrote:
>
> > +static u64 read_rng(void __iomem *base, unsigned int offset)
> > +{
> > +	/* Caller must disable interrupts */
> > +	return ____raw_readq(base + offset);
> > +}
> 
> What is the reasoning behind the local_irq_disable() requirement?
> 
> Because I'm wondering whether this is safe on SMP?

Yes I'd like to see this fixed before adding this patch.

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
