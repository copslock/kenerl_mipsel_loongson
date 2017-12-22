Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Dec 2017 09:23:12 +0100 (CET)
Received: from [128.1.224.119] ([128.1.224.119]:50302 "EHLO ringil.hmeau.com"
        rhost-flags-FAIL-FAIL-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990491AbdLVIXDknvzt (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 22 Dec 2017 09:23:03 +0100
Received: from gondolin.me.apana.org.au ([192.168.0.6] helo=gondolin.hengli.com.au)
        by norbury.hmeau.com with esmtp (Exim 4.80 #3 (Debian))
        id 1eSIbX-0002RF-5f; Fri, 22 Dec 2017 19:22:55 +1100
Received: from herbert by gondolin.hengli.com.au with local (Exim 4.80)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1eSIbR-0007ju-BF; Fri, 22 Dec 2017 19:22:49 +1100
Date:   Fri, 22 Dec 2017 19:22:48 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     James Hogan <james.hogan@mips.com>,
        "David S. Miller" <davem@davemloft.net>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        linux-crypto@vger.kernel.org
Subject: Re: [PATCH] lib/mpi: Fix umul_ppmm() for MIPS64r6
Message-ID: <20171222082248.GA29663@gondor.apana.org.au>
References: <20171205233135.1763-1-james.hogan@mips.com>
 <20171222070808.GB27149@gondor.apana.org.au>
 <20171222075921.GJ28538@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171222075921.GJ28538@linux-mips.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <herbert@gondor.apana.org.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61551
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

On Fri, Dec 22, 2017 at 08:59:21AM +0100, Ralf Baechle wrote:
> On Fri, Dec 22, 2017 at 06:08:08PM +1100, Herbert Xu wrote:
> 
> > I can take this but I'd like to see an ack from someone on the
> > MIPS side.
> 
> Sure:
> 
> Acked-by: Ralf Baechle <ralf@linux-mips.org>

Thanks Ralf!
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
