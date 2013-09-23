Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Sep 2013 14:41:52 +0200 (CEST)
Received: from 0.mx.nanl.de ([217.115.11.12]:49206 "EHLO mail.nanl.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6818702Ab3IWMlqIIAum (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 23 Sep 2013 14:41:46 +0200
Received: from mail-vb0-x22e.google.com (mail-vb0-x22e.google.com [IPv6:2607:f8b0:400c:c02::22e])
        by mail.nanl.de (Postfix) with ESMTPSA id C614540041;
        Mon, 23 Sep 2013 12:41:31 +0000 (UTC)
Received: by mail-vb0-f46.google.com with SMTP id p13so2150620vbe.33
        for <multiple recipients>; Mon, 23 Sep 2013 05:41:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=PBEqZrXJ7dhhTRglcVe9q9Km/DqSQIhlksnGiPcRXdA=;
        b=bHcFPOONncvkxuurzORUBhd1u0sWWww3BCOtx4VwyNKnlP6dJqIYrAzyVY7bM8h1r7
         rraIE40UC/NiT3n0oAsn4w7otPrdfZ8xRekq7dv4HmIRa/kaDgqpK/7UrhiSTFIPnTLn
         /vUoGuQS0gSjzJdZfn88mw0sWkTYUmNb/vbR09sWs9mYdkAOB2ADGuLGOsmKhyaX6zwd
         BO+Ae+HzIJyLc3Nslv3QU7GxsAU12l6lt9AKx4Efx22+8Etdr4Ykm5iCasV8LA1lDpr1
         z38qeGvUJCtoANuTmWAllgDktb7cC/JaCHhz8c/88ZHPJqSMrhAPtOixPRq7yNHhkv/h
         W8rA==
X-Received: by 10.220.105.199 with SMTP id u7mr21540923vco.1.1379940099381;
 Mon, 23 Sep 2013 05:41:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.221.42.10 with HTTP; Mon, 23 Sep 2013 05:41:19 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.03.1309231332500.16797@linux-mips.org>
References: <alpine.LFD.2.03.1309222307440.16797@linux-mips.org>
 <CAOiHx==GRTP3FpSfPG9yUc50mZBvrzjnXnGMXA6A5WSBRXbp3g@mail.gmail.com> <alpine.LFD.2.03.1309231332500.16797@linux-mips.org>
From:   Jonas Gorski <jogo@openwrt.org>
Date:   Mon, 23 Sep 2013 14:41:19 +0200
Message-ID: <CAOiHx==su=eew_rXG_EJcub71vpqJgOS7XL05OcgjVDyZ8-1_Q@mail.gmail.com>
Subject: Re: [PATCH v2] MIPS: Tell R4k SC and MC variations apart
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37929
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jogo@openwrt.org
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

On Mon, Sep 23, 2013 at 2:35 PM, Maciej W. Rozycki <macro@linux-mips.org> wrote:
(snip)

> linux-mips-r4k-mc.patch
> Index: linux/arch/mips/kernel/cpu-probe.c
> ===================================================================
> --- linux.orig/arch/mips/kernel/cpu-probe.c
> +++ linux/arch/mips/kernel/cpu-probe.c
> @@ -362,13 +362,33 @@ static inline void cpu_probe_legacy(stru
>                                 __cpu_name[cpu] = "R4000PC";
>                         }
>                 } else {
> +                       int cca = read_c0_config() & CONF_CM_CMASK;
> +                       int mc;
> +
> +                       /*
> +                        * SC and MC versions can't be reliably told apart,
> +                        * but only the latter support coherent caching
> +                        * modes so assume the firmware has set the KSEG0
> +                        * coherency attribute reasonably (if uncached, we
> +                        * assume SC).
> +                        */
> +                       switch (cca) {
> +                       case CONF_CM_CACHABLE_CE:
> +                       case CONF_CM_CACHABLE_COW:
> +                       case CONF_CM_CACHABLE_CUW:
> +                               mc = 1;
> +                               break;
> +                       default:
> +                               mc = 0;
> +                               break;
> +                       }
>                         if ((c->processor_id & PRID_REV_MASK) >=
>                             PRID_REV_R4400) {
> -                               c->cputype = CPU_R4400SC;
> -                               __cpu_name[cpu] = "R4400SC";
> +                               c->cputype = mc ? CPU_R4400MC : CPU_R4400SC;
> +                               __cpu_name[cpu] = mc ? "R4400MC" : "R4400SC";
>                         } else {
> -                               c->cputype = CPU_R4000SC;
> -                               __cpu_name[cpu] = "R4000SC";
> +                               c->cputype = mc ? CPU_R4000MC : CPU_R4000SC;
> +                               __cpu_name[cpu] = mc ? "R4400MC" : "R4000SC";

You are still calling it "R4400", not "R4000" as expected.


Jonas
