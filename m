Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Aug 2017 20:52:58 +0200 (CEST)
Received: from mail.eperm.de ([89.247.134.16]:41502 "EHLO mail.eperm.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994885AbdHQSwvVcIS7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 17 Aug 2017 20:52:51 +0200
Received: from tauon.chronox.de (mail.eperm.de [89.247.134.16])
        by mail.eperm.de (Postfix) with ESMTPSA id B23D9181607A;
        Thu, 17 Aug 2017 20:52:49 +0200 (CEST)
From:   Stephan Mueller <smueller@chronox.de>
To:     PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Cc:     herbert@gondor.apana.org.au, robh+dt@kernel.org,
        mark.rutland@arm.com, ralf@linux-mips.org, mturquette@baylibre.com,
        sboyd@codeaurora.org, davem@davemloft.net, paul@crapouillou.net,
        linux-crypto@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 3/6] crypto: jz4780-rng: Add Ingenic JZ4780 hardware PRNG driver
Date:   Thu, 17 Aug 2017 20:52:49 +0200
Message-ID: <20325029.4QLNKKN8OS@tauon.chronox.de>
In-Reply-To: <20170817182520.20102-4-prasannatsmkumar@gmail.com>
References: <20170817182520.20102-1-prasannatsmkumar@gmail.com> <20170817182520.20102-4-prasannatsmkumar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Return-Path: <smueller@chronox.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59635
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: smueller@chronox.de
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

Am Donnerstag, 17. August 2017, 20:25:17 CEST schrieb PrasannaKumar 
Muralidharan:

Hi PrasannaKumar,

> +
> +static int jz4780_rng_generate(struct crypto_rng *tfm,
> +			       const u8 *src, unsigned int slen,
> +			       u8 *dst, unsigned int dlen)
> +{
> +	struct jz4780_rng_ctx *ctx = crypto_rng_ctx(tfm);
> +	struct jz4780_rng *rng = ctx->rng;
> +	u32 data;
> +
> +	/*
> +	 * JZ4780 Programmers manual says the RNG should not run continuously
> +	 * for more than 1s. So enable RNG, read data and disable it.
> +	 * NOTE: No issue was observed with MIPS creator CI20 board even when
> +	 * RNG ran continuously for longer periods. This is just a precaution.
> +	 *
> +	 * A delay is required so that the current RNG data is not bit shifted
> +	 * version of previous RNG data which could happen if random data is
> +	 * read continuously from this device.
> +	 */
> +	jz4780_rng_writel(rng, 1, REG_RNG_CTRL);
> +	do {
> +		data = jz4780_rng_readl(rng, REG_RNG_DATA);
> +		memcpy((void *)dst, (void *)&data, 4);

How do you know that dst is a multiple of 4 bytes? When dlen is only 3, you 
overflow the buffer.

> +		dlen -= 4;
> +		dst += 4;
> +		udelay(20);
> +	} while (dlen >= 4);
> +
> +	if (dlen > 0) {
> +		data = jz4780_rng_readl(rng, REG_RNG_DATA);
> +		memcpy((void *)dst, (void *)&data, dlen);
> +	}
> +	jz4780_rng_writel(rng, 0, REG_RNG_CTRL);
> +
> +	return 0;
> +}

Ciao
Stephan
