Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Jun 2009 10:26:33 +0100 (WEST)
Received: from rhun.apana.org.au ([64.62.148.172]:35159 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org
	with ESMTP id S20022575AbZFCJ00 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 3 Jun 2009 10:26:26 +0100
Received: from gondolin.me.apana.org.au ([192.168.0.6])
	by arnor.apana.org.au with esmtp (Exim 4.63 #1 (Debian))
	id 1MBmjg-0007Ub-PX; Wed, 03 Jun 2009 19:26:17 +1000
Received: from herbert by gondolin.me.apana.org.au with local (Exim 4.69)
	(envelope-from <herbert@gondor.apana.org.au>)
	id 1MBmja-0002vr-Pq; Wed, 03 Jun 2009 19:26:10 +1000
Date:	Wed, 3 Jun 2009 19:26:10 +1000
From:	Herbert Xu <herbert@gondor.apana.org.au>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Matt Mackall <mpm@selenic.com>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwrng: Add TX4939 RNG driver (v2)
Message-ID: <20090603092610.GA11258@gondor.apana.org.au>
References: <1243954462-18149-1-git-send-email-anemo@mba.ocn.ne.jp> <1243973584.22069.182.camel@calx> <20090603090238.GH23561@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090603090238.GH23561@linux-mips.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <herbert@gondor.apana.org.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23197
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: herbert@gondor.apana.org.au
Precedence: bulk
X-list: linux-mips

On Wed, Jun 03, 2009 at 10:02:38AM +0100, Ralf Baechle wrote:
> On Tue, Jun 02, 2009 at 03:13:04PM -0500, Matt Mackall wrote:
> 
> > On Tue, 2009-06-02 at 23:54 +0900, Atsushi Nemoto wrote:
> > > This patch adds support for the integrated RNG of the TX4939 SoC.
> > > 
> > > Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> > 
> > Acked-by: Matt Mackall <mpm@selenic.com>
> 
> Ok, I'll send this to Linus for 2.6.31 then.

Actually I've already added it to my tree since I'm looking after
the hwrng drivers.

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
