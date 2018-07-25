Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jul 2018 17:22:16 +0200 (CEST)
Received: from mail-it0-f66.google.com ([209.85.214.66]:53052 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992960AbeGYPWMkr4r- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Jul 2018 17:22:12 +0200
Received: by mail-it0-f66.google.com with SMTP id p4-v6so9237296itf.2;
        Wed, 25 Jul 2018 08:22:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wUGZ8yQvdACe2ZxrMtgWCtHxkP603WoiUzJ1qHIXpvY=;
        b=gtZ711FwxKmDRBYYHf2V40t8GLvFEnWL711JrWUYXgR9LKgTc/9lwKYFT8xOv1vBOZ
         g/Tx1t8hnz6SJ0C718Fpy1x//j/7nmsjQlLo6STEZRGe3Am7oBoSMrEDl36XatROsCE7
         TE1ys6F4prSOtjdSU8fcMHZcqSrg/PAIE/x3QqlMWEsb6nF6s+G1FStPZlwBPOpQWAP+
         kA97kbbQOf1TWCmNtxKbIMfTJ+cicAS8Loy2PP8YHVaWlPXEh3g8b97xcoo7p9hMIexq
         G45y54p2TCKRexaAnKeSd1on5jgH5L8r9nkzJahn2g4Epj14sLlJWWob/D8u3l0X8HsE
         5vpA==
X-Gm-Message-State: AOUpUlGeV67q7RyO3vp2yejPSzggGdzYlaFPS4xeGs5Fn5oT2i1fGPOI
        L/oS/VAO970wKutZArRItA==
X-Google-Smtp-Source: AAOMgpfBERNduaebSHhGkU6RDd/OglPPwcFWY+zzqYRU/xkD3PrLTJ5XAwxdVAPAPadsFNNwidgHRA==
X-Received: by 2002:a24:7941:: with SMTP id z62-v6mr6323443itc.20.1532532126594;
        Wed, 25 Jul 2018 08:22:06 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id f195-v6sm2635184itf.41.2018.07.25.08.22.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Jul 2018 08:22:06 -0700 (PDT)
Date:   Wed, 25 Jul 2018 09:22:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-mips@linux-mips.org,
        linux-doc@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v5 14/21] clk: jz4740: Add TCU clock
Message-ID: <20180725152205.GA6941@rob-hp-laptop>
References: <20180724231958.20659-1-paul@crapouillou.net>
 <20180724231958.20659-15-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180724231958.20659-15-paul@crapouillou.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65141
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

On Wed, Jul 25, 2018 at 01:19:51AM +0200, Paul Cercueil wrote:
> Add the missing TCU clock to the list of clocks supplied by the CGU for
> the JZ4740 SoC.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  drivers/clk/ingenic/jz4740-cgu.c       | 6 ++++++
>  include/dt-bindings/clock/jz4740-cgu.h | 1 +
>  2 files changed, 7 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
