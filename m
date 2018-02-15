Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Feb 2018 23:22:30 +0100 (CET)
Received: from mail-io0-x241.google.com ([IPv6:2607:f8b0:4001:c06::241]:40420
        "EHLO mail-io0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990656AbeBOWWXt87DO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 15 Feb 2018 23:22:23 +0100
Received: by mail-io0-x241.google.com with SMTP id t22so2318775ioa.7;
        Thu, 15 Feb 2018 14:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QM4zQzddQgm0hnhU2S/uIX9gvte8+DkRHkQqhtfH/8E=;
        b=C5IwBXPvtxGbZLqk6koJm8GKLZLzp1pZv0h9HoqeTnPMeflqz2K8W8ixU6lFN6yZIz
         +xrUup6a6eLEGqNyq7Bsc46FzaYAJENBWWN5nrAqpdsDv0US1v++JcWQeN323gAPHiee
         eHHbmCNOp6hszLYVq1hhFvXYe6iP5IP4otFk+PXyUz4IRYb6vnW068Qdbnqprs+gnThJ
         a+DEbic3q4CBFm4BglnzIuxMxZyO4WLSQWsAKSQE/LeD9dWjxr01X0YHVXMsfWP/8sIt
         6m1ZtA0evTDPzTvSG6za8v1pI7XxVx5nXfPDGgHM5F5fepuOJten36mak8CDTZXCURqv
         hlGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QM4zQzddQgm0hnhU2S/uIX9gvte8+DkRHkQqhtfH/8E=;
        b=Xm76g9lf25RBBsvn7Z5rZkjuvYszUwVnNzsRas920uXOtb5WXYVKWcQC0p7XLDvLpw
         8XvEr/XAqlp5/8B+M5EL1bIVLEJ4yH8NCkheMcXs62va9U7avq+45ZdDplRfb1FYnrcV
         1k1bROcX9Pegrvb6hn46jU3X1dzqSitDjxvsEMbaEwj39w/ugTy+kKR6MnrPnRs2UT2R
         OS/DXAaHBBuNqhef16OIRIAOxqmyP71gTGTVgFjT13+2+AievhPQbJirx/5sTMilV4c/
         w/+nVqIjz26ZJgTsM4LM+Ht8g+EXdRGh1cpxXrQMEV16ntksTrhtCOCOuWvS44S9kH7h
         unrQ==
X-Gm-Message-State: APf1xPBUWy3y84CdPHWZ85639sfKr0VCmLgnhxKpxd9iHXu0x94ThQSQ
        Xi3fi2qJ77YCUN9Xa3owJDw=
X-Google-Smtp-Source: AH8x226648HhUj+YcJ1ZRBQeZCjnKKKxHbslaCyhRVjsOBEIHGnSqWawWykvhKa8slKwEn0tVvJadg==
X-Received: by 10.107.78.5 with SMTP id c5mr5799457iob.120.1518733337365;
        Thu, 15 Feb 2018 14:22:17 -0800 (PST)
Received: from gmail.com ([2620:15c:17:3:dc28:5c82:b905:e8a8])
        by smtp.gmail.com with ESMTPSA id l17sm1217994iog.67.2018.02.15.14.22.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Feb 2018 14:22:16 -0800 (PST)
Date:   Thu, 15 Feb 2018 14:22:14 -0800
From:   Eric Biggers <ebiggers3@gmail.com>
To:     James Hogan <jhogan@kernel.org>
Cc:     linux-mips@linux-mips.org,
        Marcin Nowakowski <marcin.nowakowski@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org
Subject: Re: [PATCH v3 2/3] MIPS: crypto: Add crc32 and crc32c hw accelerated
 module
Message-ID: <20180215222214.GB49445@gmail.com>
References: <cover.a1aaa0593f5afd4b00e8131611adda3a02c060d1.1518214143.git-series.jhogan@kernel.org>
 <77eab2cb46e52be3639610a7ad574bac7bf78d73.1518214143.git-series.jhogan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77eab2cb46e52be3639610a7ad574bac7bf78d73.1518214143.git-series.jhogan@kernel.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Return-Path: <ebiggers3@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62569
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ebiggers3@gmail.com
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

On Fri, Feb 09, 2018 at 10:11:06PM +0000, James Hogan wrote:
> +static struct shash_alg crc32_alg = {
> +	.digestsize		=	CHKSUM_DIGEST_SIZE,
> +	.setkey			=	chksum_setkey,
> +	.init			=	chksum_init,
> +	.update			=	chksum_update,
> +	.final			=	chksum_final,
> +	.finup			=	chksum_finup,
> +	.digest			=	chksum_digest,
> +	.descsize		=	sizeof(struct chksum_desc_ctx),
> +	.base			=	{
> +		.cra_name		=	"crc32",
> +		.cra_driver_name	=	"crc32-mips-hw",
> +		.cra_priority		=	300,
> +		.cra_blocksize		=	CHKSUM_BLOCK_SIZE,
> +		.cra_alignmask		=	0,
> +		.cra_ctxsize		=	sizeof(struct chksum_ctx),
> +		.cra_module		=	THIS_MODULE,
> +		.cra_init		=	chksum_cra_init,
> +	}
> +};
> +
> +
> +static struct shash_alg crc32c_alg = {
> +       .digestsize             =       CHKSUM_DIGEST_SIZE,
> +       .setkey                 =       chksum_setkey,
> +       .init                   =       chksum_init,
> +       .update                 =       chksumc_update,
> +       .final                  =       chksumc_final,
> +       .finup                  =       chksumc_finup,
> +       .digest                 =       chksumc_digest,
> +       .descsize               =       sizeof(struct chksum_desc_ctx),
> +       .base                   =       {
> +               .cra_name               =       "crc32c",
> +               .cra_driver_name        =       "crc32c-mips-hw",
> +               .cra_priority           =       300,
> +               .cra_blocksize          =       CHKSUM_BLOCK_SIZE,
> +               .cra_alignmask          =       0,
> +               .cra_ctxsize            =       sizeof(struct chksum_ctx),
> +               .cra_module             =       THIS_MODULE,
> +               .cra_init               =       chksum_cra_init,
> +       }
> +};

Does this actually work on the latest kernel?  Now hash algorithms must have
CRYPTO_ALG_OPTIONAL_KEY in .cra_flags if they have a .setkey method but don't
require it to be called, otherwise the crypto API will think it's a keyed hash
and not allow it to be used without a key.  I had to add this flag to the other
CRC32 and CRC32C algorithms (commit a208fa8f33031).  One of the CRC32C test
vectors even doesn't set a key so it should be causing the self-tests to fail
for "crc32c-mips-hw".  (We should add such a test vector for CRC32 too, though.)

Eric
