Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Jun 2009 04:53:24 +0100 (WEST)
Received: from rhun.apana.org.au ([64.62.148.172]:54673 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org
	with ESMTP id S20021356AbZFBDxT (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 2 Jun 2009 04:53:19 +0100
Received: from gondolin.me.apana.org.au ([192.168.0.6])
	by arnor.apana.org.au with esmtp (Exim 4.63 #1 (Debian))
	id 1MBL3m-0001dN-2L; Tue, 02 Jun 2009 13:53:10 +1000
Received: from herbert by gondolin.me.apana.org.au with local (Exim 4.69)
	(envelope-from <herbert@gondor.apana.org.au>)
	id 1MBL3f-000605-Du; Tue, 02 Jun 2009 13:53:03 +1000
Date:	Tue, 2 Jun 2009 13:53:03 +1000
From:	Herbert Xu <herbert@gondor.apana.org.au>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	akpm@linux-foundation.org, linux-mips@linux-mips.org,
	ralf@linux-mips.org, linux-kernel@vger.kernel.org, mpm@selenic.com
Subject: Re: [PATCH] hwrng: Add TX4939 RNG driver
Message-ID: <20090602035303.GC22831@gondor.apana.org.au>
References: <1243350141-883-1-git-send-email-anemo@mba.ocn.ne.jp> <20090529162907.9cb1bba2.akpm@linux-foundation.org> <20090601.014517.169682203.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090601.014517.169682203.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <herbert@gondor.apana.org.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23161
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: herbert@gondor.apana.org.au
Precedence: bulk
X-list: linux-mips

On Mon, Jun 01, 2009 at 01:45:17AM +0900, Atsushi Nemoto wrote:
>
> >From the datasheet:
> 
> 	The quality of the random numbers generated immediately after
> 	reset can be insufficient.  Therefore, do not use random
> 	numbers obtained from the first and second generations; use
> 	the ones from the third or subsequent generation.
> 
> I will put this comment in the driver.

OK, I think you've resolved all my concerns.  Please cc me when
you resubmit.

Thanks!
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
