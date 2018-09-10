Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Sep 2018 16:58:19 +0200 (CEST)
Received: from mail-wm0-x242.google.com ([IPv6:2a00:1450:400c:c09::242]:51481
        "EHLO mail-wm0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994571AbeIJO6MEMp2l (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 10 Sep 2018 16:58:12 +0200
Received: by mail-wm0-x242.google.com with SMTP id y2-v6so21899237wma.1
        for <linux-mips@linux-mips.org>; Mon, 10 Sep 2018 07:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=/ukGdzWBtmk9gFQRW/6WB5IqCbFh+0N+fAEU1vMF1NY=;
        b=USX3dUjf5QsXsBXI2uBd31nCaUmQdNs1dE/F3nPDWwYMUTLDJDrifKethzB1BBgLBR
         1g/Jo3AOQMLR4TLmCLUnh7b5FutI3Y6fmyM2+6d4OqZtvtDmV1lsRLgFB+i2/Db28R3q
         RT7h0hMuQNRoSb8CjV8WUvbeI3xsXdDFd5l3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=/ukGdzWBtmk9gFQRW/6WB5IqCbFh+0N+fAEU1vMF1NY=;
        b=Guh/mAlwI2ilHsZks/x5asRlUI+TtbEZNa/N82jVzkZSvYVyM+yfXtPigl7708u+CN
         63bVFc7MrHRUgK5TGoykd78Y9IqTARgddv48UUnVEtTc+ojTkXr2pBdCwOA/f6ihFKi9
         YDj69gUJHZ5CFPLkkwOZiHC+Oc5PUq4U96ixfhpeepGtJCibZt2d3W00Z6QVusalx5HL
         GWBMUbZ43FLSntrsCRTmNY8rexHkv+pkRty9fZ/Vvd/bmuqtUphi+fcg3+L+D9aRrunV
         g2VOOGmx5nLqolyYa5pDw9nVqPLD54QPRxZP5tnxWolJmibxR/hdRrIAMwhDkuhw3Q3m
         WJTA==
X-Gm-Message-State: APzg51C28+dM2bQkPN0NdBuRk2sPi1pQs3wjLIE8uCEz1SvTEbTGBXHb
        zaLYeD6jkVaJzX5LW0RVawapIw==
X-Google-Smtp-Source: ANB0VdYFjzw5WkrTJs+z6MQD/olrZZ/rGzuV4XFyqXiMb3WmeMGpdG6Rp2Xybtj0iJGCGp25gPVGFw==
X-Received: by 2002:a1c:c019:: with SMTP id q25-v6mr979592wmf.148.1536591486658;
        Mon, 10 Sep 2018 07:58:06 -0700 (PDT)
Received: from dell ([2.27.167.7])
        by smtp.gmail.com with ESMTPSA id t132-v6sm23582069wmf.24.2018.09.10.07.58.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 07:58:05 -0700 (PDT)
Date:   Mon, 10 Sep 2018 15:58:02 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Jonathan Corbet <corbet@lwn.net>, od@zcrc.me,
        Mathieu Malaterre <malat@debian.org>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-mips@linux-mips.org, linux-doc@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v7 01/24] mfd: Add ingenic-tcu.h header
Message-ID: <20180910145802.GV28860@dell>
References: <20180821171635.22740-1-paul@crapouillou.net>
 <20180821171635.22740-2-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180821171635.22740-2-paul@crapouillou.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Return-Path: <lee.jones@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66182
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lee.jones@linaro.org
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

On Tue, 21 Aug 2018, Paul Cercueil wrote:

> This header contains macros for the registers that are present in the
> regmap shared by all the drivers related to the TCU (Timer Counter Unit)
> of the Ingenic JZ47xx SoCs.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Acked-by: Lee Jones <lee.jones@linaro.org>
> ---
> 
> Notes:
>      v2: Use SPDX identifier for the license
>     
>      v3: - Use macros instead of enum
>          - Add 'TCU_' at the beginning of each macro
>     	 - Remove useless include <linux/regmap.h>
>     
>      v4: No change
>     
>      v5: No change
>     
>      v6: Rename barrier macro from __LINUX_CLK_INGENIC_TCU_H__ to
>          __LINUX_MFD_INGENIC_TCU_H__
>     
>      v7: No change
> 
>  include/linux/mfd/ingenic-tcu.h | 56 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 56 insertions(+)
>  create mode 100644 include/linux/mfd/ingenic-tcu.h

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
