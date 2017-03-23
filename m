Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Mar 2017 09:49:47 +0100 (CET)
Received: from mail-it0-x230.google.com ([IPv6:2607:f8b0:4001:c0b::230]:35504
        "EHLO mail-it0-x230.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990644AbdCWItju9iUE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 Mar 2017 09:49:39 +0100
Received: by mail-it0-x230.google.com with SMTP id y18so36318201itc.0
        for <linux-mips@linux-mips.org>; Thu, 23 Mar 2017 01:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=CAMB+nHSxzhxU94engUOr27YRtdUPO3Aw6O5YCRVAI8=;
        b=PEYcag7F90QvtyUHD0SdkvDSElLDvLYh34tixGkOZEFN0dnarAyzbRwS4kTbePSoB/
         eoU+vm59+ijnSNsAgX0jEWLpOBdjjg5icUYZIbuM8Jhzz4/R6gDVhCpR4rg9IZfLUZAU
         8CjtYSFHS1R8G6hj/f1J90NEIul6letwrC4r8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=CAMB+nHSxzhxU94engUOr27YRtdUPO3Aw6O5YCRVAI8=;
        b=uBP3a/7t+m2TaYGsb696tTeKi5c36WScA9V2p5CFF9HCrzFVPinhPKNz2GX6bKMSbm
         BsIovkbDp0qDhTuj1BtRY/qETZmm3FKrRgmSJwmmgusuefHEN8s6Sy/7kTvFlL8m78Eu
         c1GvdQ9MD8vBtFoElUZzd/nfqCB8irXGk+sUyk0AIkINUyjgHD2oFV7ahSMQ9CfgKDFI
         6pCz6qaMbzVLIPX61Hn6QOsofEB4ssiPrPFBGicaY1GFUiusCUXT6H5Eplkr+tyc1JMI
         GuqWuJkX7zc8xdsUY8WFFgFcXaSRbxyWb/OVRS+vO0n+h2fBLA/zC6UCaNVqFYz93TsE
         Vyig==
X-Gm-Message-State: AFeK/H1Gd++juEoR3CTkFCyf8svmVerZlTEvjmIhHx7CedgNJqHgZtw2v9g/K1UXZCiafp4zu7WPyeVXWWq1k/Vt
X-Received: by 10.36.228.13 with SMTP id o13mr12314703ith.56.1490258974087;
 Thu, 23 Mar 2017 01:49:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.134.193 with HTTP; Thu, 23 Mar 2017 01:49:33 -0700 (PDT)
In-Reply-To: <1489508003-25288-2-git-send-email-nathan.sullivan@ni.com>
References: <1489508003-25288-1-git-send-email-nathan.sullivan@ni.com> <1489508003-25288-2-git-send-email-nathan.sullivan@ni.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 23 Mar 2017 09:49:33 +0100
Message-ID: <CACRpkdb-Q=NcxL2qiqbgg-w+R_fq5eVojFn=1AzWZkPn0VdB1Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] gpio: mmio: add support for NI 169445 NAND GPIO
To:     Nathan Sullivan <nathan.sullivan@ni.com>
Cc:     Alexandre Courbot <gnurou@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Linux MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57421
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linus.walleij@linaro.org
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

On Tue, Mar 14, 2017 at 5:13 PM, Nathan Sullivan <nathan.sullivan@ni.com> wrote:

> The GPIO-based NAND controller on National Instruments 169445 hardware
> exposes a set of simple lines for the control signals.
>
> Signed-off-by: Nathan Sullivan <nathan.sullivan@ni.com>

Patch applied.

Yours,
Linus Walleij
