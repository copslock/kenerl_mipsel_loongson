Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Aug 2017 23:57:48 +0200 (CEST)
Received: from mail-oi0-f68.google.com ([209.85.218.68]:36491 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994821AbdHYV5lgU2QA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 25 Aug 2017 23:57:41 +0200
Received: by mail-oi0-f68.google.com with SMTP id d66so611207oib.3;
        Fri, 25 Aug 2017 14:57:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QsxYmqUlrgZULAZSYYcAG4QJ0S4RFdFvdAU2R+J77vQ=;
        b=RhI1WSQ7BuRwbWUlNRENp6tDEAfw35XbLKDgbQd2YMlvbLfOvS9SDUD6R7HwAoaPGx
         soXB3+E4rCHOHCPbu5C8U/qgNqU1BLdRpZB0dlAQl5UiQQbsbImys3mKnMUIgxgswofc
         o5ljLIs3sgdYoXkbfIORXeQKxtPp+dtSlNr04B6FAuyHKce+sDQJ/3shbS6Vc6KmMwpa
         1DafalUV66Dq0ifozkyzrocw08Ih+rGFO41STA8d05/wOogcnP2Wjeq/n5RjmFxjamME
         OfPnuVG9RK/W3jjFGf00sCRcr4Y1xsT5TS81qhCTBGDLL+92Gzapcih8CudmCCw2XENv
         kZ5Q==
X-Gm-Message-State: AHYfb5hlzKQtDm2MypShfWuEq4A0OVaxD4JgTAanCZvN47dmEq/o5Zc5
        fRRzPRJx0EbXRg==
X-Received: by 10.202.67.7 with SMTP id q7mr14511394oia.62.1503698255726;
        Fri, 25 Aug 2017 14:57:35 -0700 (PDT)
Received: from localhost (216-188-254-6.dyn.grandenetworks.net. [216.188.254.6])
        by smtp.gmail.com with ESMTPSA id n72sm7832457oig.13.2017.08.25.14.57.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Aug 2017 14:57:35 -0700 (PDT)
Date:   Fri, 25 Aug 2017 16:57:34 -0500
From:   Rob Herring <robh@kernel.org>
To:     PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        mark.rutland@arm.com, ralf@linux-mips.org, paul@crapouillou.net,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@linux-mips.org, malat@debian.org, noloader@gmail.com
Subject: Re: [PATCH v2 1/4] crypto: jz4780-rng: Add JZ4780 PRNG devicetree
 binding documentation
Message-ID: <20170825215734.f5rc7fzxpl3ynnwl@rob-hp-laptop>
References: <20170823025707.27888-1-prasannatsmkumar@gmail.com>
 <20170823025707.27888-2-prasannatsmkumar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170823025707.27888-2-prasannatsmkumar@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59804
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robh@kernel.org
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

On Wed, Aug 23, 2017 at 08:27:04AM +0530, PrasannaKumar Muralidharan wrote:
> Add devicetree bindings for hardware pseudo random number generator
> present in Ingenic JZ4780 SoC.
> 
> Signed-off-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
> ---
> Changes in v2:
> * Add "syscon" in CGU node's compatible section
> * Make RNG child node of CGU.
> 
>  .../bindings/crypto/ingenic,jz4780-rng.txt           | 20 ++++++++++++++++++++

bindings/rng/ for RNG h/w.

>  1 file changed, 20 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/crypto/ingenic,jz4780-rng.txt
> 
> diff --git a/Documentation/devicetree/bindings/crypto/ingenic,jz4780-rng.txt b/Documentation/devicetree/bindings/crypto/ingenic,jz4780-rng.txt
> new file mode 100644
> index 0000000..a0c18e5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/crypto/ingenic,jz4780-rng.txt
> @@ -0,0 +1,20 @@
> +Ingenic jz4780 RNG driver
> +
> +Required properties:
> +- compatible : Should be "ingenic,jz4780-rng"
> +
> +Example:
> +
> +cgu: jz4780-cgu@10000000 {
> +	compatible = "ingenic,jz4780-cgu", "syscon";
> +	reg = <0x10000000 0x100>;
> +
> +	clocks = <&ext>, <&rtc>;
> +	clock-names = "ext", "rtc";
> +
> +	#clock-cells = <1>;
> +
> +	rng: rng@d8 {

unit-address requires reg property.

> +		compatible = "ingenic,jz480-rng";
> +	};
> +};
> -- 
> 2.10.0
> 
