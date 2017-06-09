Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Jun 2017 16:23:02 +0200 (CEST)
Received: from mail-ot0-f194.google.com ([74.125.82.194]:36756 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993967AbdFIOWxJOOEA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 9 Jun 2017 16:22:53 +0200
Received: by mail-ot0-f194.google.com with SMTP id i31so5983042ota.3;
        Fri, 09 Jun 2017 07:22:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=g9gY9EG9Y9hTNfqS9xfg7FIggiLrGfDWMCmwSBlR/xs=;
        b=b4S59AEZcsCV4jU2AFGmwP8GxUzmWpQLr/YoEYztrhwLIn8m726dO0GKureWZosnAW
         u0Gonqwv63J+QL7AUx01Tz3CpJuDcD4m5Xqs4Rux2G/82PVs2MOfZBs8l1wC4Muxflc1
         oFHFNDj6jjY6P30AowL9J/ioazYKbtsX4982VBXVllGVEkm7Gx3IOjeuV5w/Wcq58ESl
         ZoU0vSvgDu2r/VgfsjASwSdmTHm1iBjDBRw/D0QskRCVzcK4Xe06rhWN0N6ltoA+I7XD
         K72K1BDPmL1kswBIgQgHgEv4dySgkdF7u62Rr4TzwPj0eq++YGOdz0ZRvwQtvPwbnFfH
         tVuw==
X-Gm-Message-State: AODbwcAa3E3TLBWPiR97SYstqTcifbjfpqQikcm0vrQNKfn//0rHuFwC
        mXKml85IiuOmvA==
X-Received: by 10.157.23.22 with SMTP id i22mr24681451ota.165.1497018164826;
        Fri, 09 Jun 2017 07:22:44 -0700 (PDT)
Received: from localhost (66-90-148-125.dyn.grandenetworks.net. [66.90.148.125])
        by smtp.gmail.com with ESMTPSA id p44sm539757otg.33.2017.06.09.07.22.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Jun 2017 07:22:44 -0700 (PDT)
Date:   Fri, 9 Jun 2017 09:22:43 -0500
From:   Rob Herring <robh@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Maarten ter Huurne <maarten@treewalker.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH 05/15] serial: 8250_ingenic: Add support for the JZ4770
 SoC
Message-ID: <20170609142243.wbt6gngfl3pmdnzr@rob-hp-laptop>
References: <20170607200439.24450-1-paul@crapouillou.net>
 <20170607200439.24450-6-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170607200439.24450-6-paul@crapouillou.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58383
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

On Wed, Jun 07, 2017 at 10:04:29PM +0200, Paul Cercueil wrote:
> The JZ4770 SoC's UART is no different from the other JZ SoCs, so this
> commit simply adds the ingenic,jz4770-uart compatible string.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  Documentation/devicetree/bindings/serial/ingenic,uart.txt | 3 ++-
>  drivers/tty/serial/8250/8250_ingenic.c                    | 5 +++++
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/serial/ingenic,uart.txt b/Documentation/devicetree/bindings/serial/ingenic,uart.txt
> index 02cb7fe59cb7..75fd8b314af9 100644
> --- a/Documentation/devicetree/bindings/serial/ingenic,uart.txt
> +++ b/Documentation/devicetree/bindings/serial/ingenic,uart.txt
> @@ -2,7 +2,8 @@
>  
>  Required properties:
>  - compatible : "ingenic,jz4740-uart", "ingenic,jz4760-uart",
> -	"ingenic,jz4775-uart" or "ingenic,jz4780-uart"
> +	"ingenic,jz4770-uart", "ingenic,jz4775-uart" or
> +	"ingenic,jz4780-uart"

If you respin, please reformat to 1 per line.

Acked-by: Rob Herring <robh@kernel.org>
