Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Oct 2017 16:30:57 +0200 (CEST)
Received: from orcrist.hmeau.com ([104.223.48.154]:59164 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992544AbdJLOatp4gTk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 12 Oct 2017 16:30:49 +0200
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.84_2 #2 (Debian))
        id 1e2eV9-0003oq-3h; Thu, 12 Oct 2017 22:30:19 +0800
Received: from herbert by gondobar with local (Exim 4.84_2)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1e2eV1-0007u3-V9; Thu, 12 Oct 2017 22:30:11 +0800
Date:   Thu, 12 Oct 2017 22:30:11 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Cc:     robh+dt@kernel.org, ralf@linux-mips.org, davem@davemloft.net,
        paul@crapouillou.net, linux-crypto@vger.kernel.org,
        linux-mips@linux-mips.org, malat@debian.org, noloader@gmail.com
Subject: Re: [PATCH v3 0/4] crypto: Add driver for JZ4780 PRNG
Message-ID: <20171012143011.GA30173@gondor.apana.org.au>
References: <20170918140241.24003-1-prasannatsmkumar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170918140241.24003-1-prasannatsmkumar@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <herbert@gondor.apana.org.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60380
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

On Mon, Sep 18, 2017 at 07:32:37PM +0530, PrasannaKumar Muralidharan wrote:
> This patch series adds support of pseudo random number generator found
> in Ingenic's JZ4780 and X1000 SoC.
> 
> Create cgublock node which has CGU and RNG node as its children. The
> cgublock node uses "simple-bus" compatible which helps in exposing CGU
> and RNG nodes without changing CGU driver. Add 'syscon' compatible in
> CGU node in jz4780.dtsi. The jz4780-rng driver uses regmap exposed via
> syscon interface to access the RNG registers. CGU driver is not
> modified in this patch set as registers used by CGU driver and this
> driver are different.
> 
> PrasannaKumar Muralidharan (4):
>   crypto: jz4780-rng: Add JZ4780 PRNG devicetree binding documentation
>   crypto: jz4780-rng: Add Ingenic JZ4780 hardware PRNG driver
>   crypto: jz4780-rng: Add RNG node to jz4780.dtsi
>   crypto: jz4780-rng: Enable PRNG support in CI20 defconfig

Please indicate which patches are intended to go through the crypto
trees.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
