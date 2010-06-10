Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Jun 2010 21:24:20 +0200 (CEST)
Received: from mail-vw0-f49.google.com ([209.85.212.49]:55865 "EHLO
        mail-vw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492087Ab0FJTYQ convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 10 Jun 2010 21:24:16 +0200
Received: by vws7 with SMTP id 7so308359vws.36
        for <multiple recipients>; Thu, 10 Jun 2010 12:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=GfCibB/npYut1+/mFm9KkM6B9AQWt1GtlqxzinB1k4I=;
        b=ir+JK6QA/K1eFq13V3gL1+XG/Tfm137Sl72XjHNf9zqpIStfnfAZNCeM5Fbmzyoe3i
         rgW3hr/SRNJXSGGJJaia2AlaucMCFVHRnl6FV59wT3uRv9dyo1a+GQ8zyfIhmU1RYcZr
         n6h4lyalHOmGLLM88wHjAop/vQgrMwXgPwWgU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ZvCaC0URlV9mTeEoPGv3eoOVoycolmxy/4wBL3/JqoYQeK1cg6g0v9DMpcvGYzZQOo
         MU/N8WcgOJVWfFEOhIOsXO8V8kZ8TQADGuuT9JwoJ3ckiszgSa8FlMQh/UCpRBk6EOyl
         2ke52nYYAdpUSO7hMH3tFNy2J6KxN24nqYFIA=
MIME-Version: 1.0
Received: by 10.224.78.233 with SMTP id m41mr589788qak.342.1276197848380; Thu, 
        10 Jun 2010 12:24:08 -0700 (PDT)
Received: by 10.220.65.11 with HTTP; Thu, 10 Jun 2010 12:24:08 -0700 (PDT)
In-Reply-To: <0a4b5e5841e7842f7b80e368c1d103b5e98d3335.1275925108.git.siccegge@cs.fau.de>
References: <cover.1275925108.git.siccegge@cs.fau.de>
        <0a4b5e5841e7842f7b80e368c1d103b5e98d3335.1275925108.git.siccegge@cs.fau.de>
Date:   Thu, 10 Jun 2010 13:24:08 -0600
Message-ID: <AANLkTin3EsoPJPb9s7_nwSrWY9HihXMJHorAK96dKKIa@mail.gmail.com>
Subject: Re: [PATCH 7/9] Removing dead CONFIG_PMCTWILED
From:   Shane McDonald <mcdonald.shane@gmail.com>
To:     Christoph Egger <siccegge@cs.fau.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, vamos@i4.informatik.uni-erlangen.de
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 27117
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mcdonald.shane@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 7557

On Wed, Jun 9, 2010 at 5:22 AM, Christoph Egger <siccegge@cs.fau.de> wrote:
> CONFIG_PMCTWILED doesn't exist in Kconfig, therefore removing all
> references for it from the source code.
>
> Signed-off-by: Christoph Egger <siccegge@cs.fau.de>
> ---
>  arch/mips/pmc-sierra/msp71xx/msp_hwbutton.c |   11 -----------
>  1 files changed, 0 insertions(+), 11 deletions(-)
>
> diff --git a/arch/mips/pmc-sierra/msp71xx/msp_hwbutton.c b/arch/mips/pmc-sierra/msp71xx/msp_hwbutton.c
> index 11769b5..c841f08 100644
> --- a/arch/mips/pmc-sierra/msp71xx/msp_hwbutton.c
> +++ b/arch/mips/pmc-sierra/msp71xx/msp_hwbutton.c
> @@ -32,9 +32,6 @@
>  #include <msp_int.h>
>  #include <msp_regs.h>
>  #include <msp_regops.h>
> -#ifdef CONFIG_PMCTWILED
> -#include <msp_led_macros.h>
> -#endif
>
>  /* For hwbutton_interrupt->initial_state */
>  #define HWBUTTON_HI    0x1
> @@ -82,10 +79,6 @@ static void standby_on(void *data)
>        printk(KERN_WARNING "STANDBY switch was set to ON (not implemented)\n");
>
>        /* TODO: Put board in standby mode */
> -#ifdef CONFIG_PMCTWILED
> -       msp_led_turn_off(MSP_LED_PWRSTANDBY_GREEN);
> -       msp_led_turn_on(MSP_LED_PWRSTANDBY_RED);
> -#endif
>  }
>
>  static void standby_off(void *data)
> @@ -94,10 +87,6 @@ static void standby_off(void *data)
>                "STANDBY switch was set to OFF (not implemented)\n");
>
>        /* TODO: Take out of standby mode */
> -#ifdef CONFIG_PMCTWILED
> -       msp_led_turn_on(MSP_LED_PWRSTANDBY_GREEN);
> -       msp_led_turn_off(MSP_LED_PWRSTANDBY_RED);
> -#endif
>  }
>
>  static struct hwbutton_interrupt softreset_sw = {
> --
> 1.6.3.3

This constant was added in a patch that was never accepted:
http://www.linux-mips.org/archives/linux-mips/2007-03/msg00421.html.
Because this patch was submitted over 3 years ago, I think
it's reasonable to assume that work on the patch has stalled,
and so I think removing the CONFIG_PMCTWILED constant
makes sense.

I seem to be the only person semi-actively doing anything
with the MSP7120 code base, so if I ever try to clean up the
patch and re-submit, I'll re-submit the changes being
removed in this patch.

Acked-by: Shane McDonald <mcdonald.shane@gmail.com>
