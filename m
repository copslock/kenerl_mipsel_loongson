Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Mar 2018 13:49:36 +0100 (CET)
Received: from mail-pl0-f67.google.com ([209.85.160.67]:36054 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990423AbeCRMtZOc9Wn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 18 Mar 2018 13:49:25 +0100
Received: by mail-pl0-f67.google.com with SMTP id 61-v6so8626939plf.3
        for <linux-mips@linux-mips.org>; Sun, 18 Mar 2018 05:49:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GSaO4nYWmci8jnr2+5ldi+pv++NeCdWznoOHrOCXt3Q=;
        b=s0JH//pFxyQ8LWLpihHFU8SzqdBBNjbceMfLraxSLZY93QXvYiwzfrMj588xMEETWx
         gMMmCyetAWbGmMwcBeeJ9tGywyRb2qDpEdGAqu1gAGN/7pXP2sL13ZzNQ9kES8v6WWmF
         Eiiqq3CSJDHfwwZt0ITgnVEe2ClSmqPj49AmivYM/nayCWd6he07W80sOX76WmAcDNBW
         y8SeH2PARG3kk+8BZUPo3rFGRlySOjWBZzK6AnuGMgDBNPe6Rsr8rREMIrOyGYHviDbC
         OcJgDjAGUDzO7rmeLUD2Pv5yGipCxd0tB9Yu/Mgm62aubbIE/Z8rygZYCQqEDyxEpF6m
         iMuQ==
X-Gm-Message-State: AElRT7GYRst07RofBhS/tuyM73v+QWs4dDrgTU/j1rmcNVTgwikdnyIi
        xRaBkpyVXLA2tBqeuJHXMw==
X-Google-Smtp-Source: AG47ELsvOKcDsVuxvY3ADT2Uu7RSzTBWWESxjnkBrYIycAHc9nMCtNPCx45LC6zHAlKimoNMa7ZCWg==
X-Received: by 2002:a17:902:9009:: with SMTP id a9-v6mr8675930plp.272.1521377359061;
        Sun, 18 Mar 2018 05:49:19 -0700 (PDT)
Received: from localhost (165084180235.ctinets.com. [165.84.180.235])
        by smtp.gmail.com with ESMTPSA id 14sm25049538pfi.164.2018.03.18.05.49.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 18 Mar 2018 05:49:18 -0700 (PDT)
Date:   Sun, 18 Mar 2018 07:49:17 -0500
From:   Rob Herring <robh@kernel.org>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-mmc@vger.kernel.org, linux-mips@linux-mips.org,
        James Hogan <jhogan@kernel.org>,
        Ezequiel Garcia <ezequiel@collabora.co.uk>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 07/14] mmc: dt-bindings: add MMC support to JZ4740 SoC
Message-ID: <20180318124917.sfptnnnqsmsxewdj@rob-hp-laptop>
References: <20180312215554.20770-1-ezequiel@vanguardiasur.com.ar>
 <20180312215554.20770-8-ezequiel@vanguardiasur.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180312215554.20770-8-ezequiel@vanguardiasur.com.ar>
User-Agent: NeoMutt/20170609 (1.8.3)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63026
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

On Mon, Mar 12, 2018 at 06:55:47PM -0300, Ezequiel Garcia wrote:
> From: Ezequiel Garcia <ezequiel@collabora.co.uk>
> 
> Add the devicetree binding for JZ4740/JZ4780 SoC.

... SoC MMC/SD controller.

> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Ezequiel Garcia <ezequiel@collabora.co.uk>
> ---
>  Documentation/devicetree/bindings/mmc/jz4740.txt | 38 ++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/jz4740.txt

Otherwise,

Reviewed-by: Rob Herring <robh@kernel.org>
