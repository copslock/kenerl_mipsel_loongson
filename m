Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Sep 2013 13:37:37 +0200 (CEST)
Received: from 0.mx.nanl.de ([217.115.11.12]:49204 "EHLO mail.nanl.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6818702Ab3IWLhbOcTh7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 23 Sep 2013 13:37:31 +0200
Received: from mail-ve0-x233.google.com (mail-ve0-x233.google.com [IPv6:2607:f8b0:400c:c01::233])
        by mail.nanl.de (Postfix) with ESMTPSA id C2D2546060;
        Mon, 23 Sep 2013 11:37:12 +0000 (UTC)
Received: by mail-ve0-f179.google.com with SMTP id c14so2101612vea.24
        for <multiple recipients>; Mon, 23 Sep 2013 04:37:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=f1GkHBbxDSnIXNdPoAdB5ZmbHs1MCeLoQ1L3sAyrXqg=;
        b=jBS8Zd+r4dJLTgvt4z9/dL4JCOBWRXdbl7R+Ijg5RkSskzE2nSPAGegfVtDLzz4k9s
         iulm1PYLOCjkrqWApGfi6ZSvBY3jHkgsGnT5ipLB5fxjNZZEgJfXw8qZxdXoZpnGaW/w
         KrOLlyVM2NNcAsNgmBKGi7d01hYJL5IKebJKwzDJ57EQxehN09rb4O6Nky+ySuHNrRmr
         1LAlmiMd8tvf2WErq5SmRP3mpVlQLwqzjhU4Ge9QHB0wt73WhABh8wJuxdPWhdfcTxmA
         TauE7hchjjfS63hT/fguRgGZeQNUTO7mhAbiJAs05Xg033T47GFs8BAlztB7TI1iIyZu
         NWSQ==
X-Received: by 10.58.208.130 with SMTP id me2mr21854169vec.13.1379936240459;
 Mon, 23 Sep 2013 04:37:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.221.42.10 with HTTP; Mon, 23 Sep 2013 04:37:00 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.03.1309222307440.16797@linux-mips.org>
References: <alpine.LFD.2.03.1309222307440.16797@linux-mips.org>
From:   Jonas Gorski <jogo@openwrt.org>
Date:   Mon, 23 Sep 2013 13:37:00 +0200
Message-ID: <CAOiHx==GRTP3FpSfPG9yUc50mZBvrzjnXnGMXA6A5WSBRXbp3g@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Tell R4k SC and MC variations apart
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37927
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

On Mon, Sep 23, 2013 at 12:30 AM, Maciej W. Rozycki
<macro@linux-mips.org> wrote:
> There is no reliable way to tell R4000/R4400 SC and MC variations apart,
> however simple heuristic should give good results.  Only the MC version
> supports coherent caching so we can rely on such a mode having been set
> for KSEG0 by the power-on firmware to reliably indicate an MC processor.
> SC processors reportedly hang on coherent cached memory accesses and Linux
> is linked to a cached load address so the firmware has to use the correct
> caching mode to download the kernel image in a cached mode successfully.
>
> OTOH if the firmware chooses to use either the non-coherent cached or the
> uncached mode for KSEG0 on an MC processor, then the SC variant will be
> reported, just as we currently do, so no regression here.
>
> Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
> ---
> Ralf,
>
>  I believe we discussed this once long ago and you had some concerns about
> such an approach although I don't recall exactly what they were.  I
> maintain that this heuristic is reasonable, has no drawbacks and has a
> potential to make some optimisations or errata workarounds easier.  Also
> we can collect data about systems affected to see what their firmware does
> -- R4000SC/R4400SC DECstations definitely get CP0.Config.K0 right.
>
>   Maciej
>
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
> +                               __cpu_name[cpu] = mc ? "R4400SC" : "R4000SC";

I guess the first one should be "R4000MC", not "R4400SC".

Regards
Jonas
