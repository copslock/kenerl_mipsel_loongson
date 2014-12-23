Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Dec 2014 22:15:35 +0100 (CET)
Received: from helcar.apana.org.au ([209.40.204.226]:54231 "EHLO
        helcar.apana.org.au" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009710AbaLWVPdXBtdX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 Dec 2014 22:15:33 +0100
Received: from gondolin.me.apana.org.au ([192.168.0.6])
        by fornost.hengli.com.au with esmtp (Exim 4.80 #3 (Debian))
        id 1Y3Wnc-0002f6-Kh; Wed, 24 Dec 2014 08:15:24 +1100
Received: from herbert by gondolin.me.apana.org.au with local (Exim 4.80)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1Y3WnX-0000ng-JH; Wed, 24 Dec 2014 08:15:19 +1100
Date:   Wed, 24 Dec 2014 08:15:19 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        linux-crypto@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] MIPS/crypto: MD5 for OCTEON
Message-ID: <20141223211519.GA3051@gondor.apana.org.au>
References: <1419195242-546-1-git-send-email-aaro.koskinen@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1419195242-546-1-git-send-email-aaro.koskinen@iki.fi>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <herbert@gondor.apana.org.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44905
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: herbert@gondor.apana.org.au
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Sun, Dec 21, 2014 at 10:53:57PM +0200, Aaro Koskinen wrote:
> Hi,
> 
> This adds accelerated MD5 cryptoapi module for OCTEON.
> 
> Tested with 3.19-rc1 on EdgeRouter Lite (OCTEON+) and EdgeRouter Pro
> (OCTEON2) by running selftest, tcrypt and also by sending TCP MD5SIG
> traffic between OCTEON <-> X86 box.
> 
> Below figures show the improvement on ER Lite compared to md5-generic
> (calculated from output of tcrypt mode=402).

All applied.  Thanks!
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
