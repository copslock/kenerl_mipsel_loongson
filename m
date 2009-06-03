Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Jun 2009 11:04:34 +0100 (WEST)
Received: from rhun.apana.org.au ([64.62.148.172]:50958 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org
	with ESMTP id S20022575AbZFCKEU (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 3 Jun 2009 11:04:20 +0100
Received: from gondolin.me.apana.org.au ([192.168.0.6])
	by arnor.apana.org.au with esmtp (Exim 4.63 #1 (Debian))
	id 1MBnKP-0008Hx-ID; Wed, 03 Jun 2009 20:04:13 +1000
Received: from herbert by gondolin.me.apana.org.au with local (Exim 4.69)
	(envelope-from <herbert@gondor.apana.org.au>)
	id 1MBnKL-00037l-Ux; Wed, 03 Jun 2009 20:04:10 +1000
Date:	Wed, 3 Jun 2009 20:04:09 +1000
From:	Herbert Xu <herbert@gondor.apana.org.au>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Matt Mackall <mpm@selenic.com>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwrng: Add TX4939 RNG driver (v2)
Message-ID: <20090603100409.GA11989@gondor.apana.org.au>
References: <1243954462-18149-1-git-send-email-anemo@mba.ocn.ne.jp> <1243973584.22069.182.camel@calx> <20090603090238.GH23561@linux-mips.org> <20090603092610.GA11258@gondor.apana.org.au> <20090603092927.GA11369@gondor.apana.org.au> <20090603100215.GA13250@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090603100215.GA13250@linux-mips.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <herbert@gondor.apana.org.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23202
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: herbert@gondor.apana.org.au
Precedence: bulk
X-list: linux-mips

On Wed, Jun 03, 2009 at 11:02:15AM +0100, Ralf Baechle wrote:
>
> There is no conflict on the drivers/char/hw_random/ part, so I'll drop
> that one.  The platform part in arch/mips/ has to go through the MIPS
> tree as it depends on another patch.

OK we can certainly do that.

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
