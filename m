Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Jun 2009 10:45:06 +0100 (WEST)
Received: from rhun.apana.org.au ([64.62.148.172]:50820 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org
	with ESMTP id S20022000AbZFCJo7 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 3 Jun 2009 10:44:59 +0100
Received: from gondolin.me.apana.org.au ([192.168.0.6])
	by arnor.apana.org.au with esmtp (Exim 4.63 #1 (Debian))
	id 1MBn1l-0007zJ-1D; Wed, 03 Jun 2009 19:44:57 +1000
Received: from herbert by gondolin.me.apana.org.au with local (Exim 4.69)
	(envelope-from <herbert@gondor.apana.org.au>)
	id 1MBn1i-00031X-LR; Wed, 03 Jun 2009 19:44:54 +1000
Date:	Wed, 3 Jun 2009 19:44:54 +1000
From:	Herbert Xu <herbert@gondor.apana.org.au>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org, mpm@selenic.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] TXx9: Add TX4939 RNG support (v2)
Message-ID: <20090603094454.GB11356@gondor.apana.org.au>
References: <1243954462-18149-2-git-send-email-anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1243954462-18149-2-git-send-email-anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <herbert@gondor.apana.org.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23199
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: herbert@gondor.apana.org.au
Precedence: bulk
X-list: linux-mips

On Tue, Jun 02, 2009 at 11:54:22PM +0900, Atsushi Nemoto wrote:
> Add platform support for RNG of TX4939 SoC.
> 
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

Aha, I knew I should have left Ralf take the patch, and this is
the reason :)

Rather than having the patches split between the two of us, I'll
back out the RNG patch from my tree so both of them can go through
Ralf's MIPS tree.

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
