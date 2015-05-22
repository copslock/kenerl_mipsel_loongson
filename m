Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 May 2015 18:50:21 +0200 (CEST)
Received: from mail-qk0-f174.google.com ([209.85.220.174]:33233 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006627AbbEVQuTvTN5s (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 May 2015 18:50:19 +0200
Received: by qkgv12 with SMTP id v12so16080533qkg.0
        for <linux-mips@linux-mips.org>; Fri, 22 May 2015 09:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=FY6270XEkFLFKdTZcboIqRL6dqKsNtBCB6FnyYHRk/k=;
        b=NbbNwnw2jnhhWCIumH8RmLUbfv+vvb85X94BYDosSkoRnZwR3rqHirnoNd5iPMhj8k
         ltKDAEjwlSuADtCOvBv9935Z5AC+Ib0Km28L/FuOpWunuW3sYccKmNeWMk3O0qjSkpmW
         +/rc1x14S9N1+e4yUIDMjBrh22I+jeQzglT5TbsIdMCrXe8/9WmTCfmLNHNGifPNZ48S
         EuOZkPEv/6gOKyBu2XJswVV1w8b8HXajCe4vhuhxH995vRX2sZzlyPGxPOhg3+fpIwue
         FrptLJjI27TotbVzFZqf3Snm2Hg3y5vsQGg2n8MACQOdcZWyuzHR7XoBUbfzAtubAZtM
         xctw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=FY6270XEkFLFKdTZcboIqRL6dqKsNtBCB6FnyYHRk/k=;
        b=nz6lFzqCryJ60bwKP5g/PG17WK5c9PpxkWAvFXRihzIfQJ/x3msNlXNE+KKwp1Ub4C
         W9LpTUu25/z4LMraBm6ZLcahkR87+tfs+Sga28f0n617PkxtPIjlKdJKvnWRDKnkWhZi
         mB8fgUWnEoMGngDd7XZmu0jnXhbXnTAdcSgWQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=FY6270XEkFLFKdTZcboIqRL6dqKsNtBCB6FnyYHRk/k=;
        b=Bs6I2a/VrGmvI8UQ4xX2/219bBmeUOxRo5NYd7nlhgCMB1nbOyNAc0V5uW7Bk48eMJ
         QJDOroQCvE/4S9+cw2VE6pkisPd4AYLHTXGslKicu+VXBhgUGGn++0u+DFBB3RkIs6FI
         eHVrcTfqC+xCrqIThI8iaurd24XiGiw1F+J9HBN3VGYLipsUXXL2uRLintikBZJG97cP
         8/db6eSEgZmroRo7L1ii6qSAJP99XPaBLOxdpOEOArkynSsDPIrT2926m0qHUq+Xjh4R
         ikdnTXHMu2y+TioSAcADTH0u+2Y56btapWCUdpPKCDtsKH/BPbc3XoixKZa3OK54Ks7A
         50zw==
X-Gm-Message-State: ALoCoQlK7Bnlq9NHfHceJEsefvA348FcrWfXjSJwv35hzZ4ope7HdsMnGAqhmqGCKVDmEcXmlOD+
MIME-Version: 1.0
X-Received: by 10.55.41.17 with SMTP id p17mr19825489qkh.86.1432313416484;
 Fri, 22 May 2015 09:50:16 -0700 (PDT)
Received: by 10.140.23.72 with HTTP; Fri, 22 May 2015 09:50:16 -0700 (PDT)
In-Reply-To: <1432244618-15548-1-git-send-email-ezequiel.garcia@imgtec.com>
References: <1432244260-14908-1-git-send-email-ezequiel.garcia@imgtec.com>
        <1432244618-15548-1-git-send-email-ezequiel.garcia@imgtec.com>
Date:   Fri, 22 May 2015 09:50:16 -0700
X-Google-Sender-Auth: _LfDCZENfbqQiNG-ZcdzjolHRdU
Message-ID: <CAL1qeaG=LeQtSS_0w_=hXMNfG2dqTomL5hgifFXV-x1Jy9P1rw@mail.gmail.com>
Subject: Re: [PATCH 7/7] mips: pistachio: Allow to enable the external timer
 based clocksource
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        James Hartley <james.hartley@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Damien Horsley <Damien.Horsley@imgtec.com>,
        Govindraj Raja <Govindraj.Raja@imgtec.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47572
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: abrestic@chromium.org
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

On Thu, May 21, 2015 at 2:43 PM, Ezequiel Garcia
<ezequiel.garcia@imgtec.com> wrote:
> This commit introduces a new config, so the user can choose to enable
> the General Purpose Timer based clocksource. This option is required
> to have CPUFreq support.
>
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
> ---
>  arch/mips/Kconfig           |  1 +
>  arch/mips/pistachio/Kconfig | 13 +++++++++++++
>  2 files changed, 14 insertions(+)
>  create mode 100644 arch/mips/pistachio/Kconfig
>
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index f501665..91f6ca0 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -934,6 +934,7 @@ source "arch/mips/jazz/Kconfig"
>  source "arch/mips/jz4740/Kconfig"
>  source "arch/mips/lantiq/Kconfig"
>  source "arch/mips/lasat/Kconfig"
> +source "arch/mips/pistachio/Kconfig"
>  source "arch/mips/pmcs-msp71xx/Kconfig"
>  source "arch/mips/ralink/Kconfig"
>  source "arch/mips/sgi-ip27/Kconfig"
> diff --git a/arch/mips/pistachio/Kconfig b/arch/mips/pistachio/Kconfig
> new file mode 100644
> index 0000000..97731ea
> --- /dev/null
> +++ b/arch/mips/pistachio/Kconfig
> @@ -0,0 +1,13 @@
> +config PISTACHIO_GPTIMER_CLKSRC
> +       bool "Enable General Purpose Timer based clocksource"
> +       depends on MACH_PISTACHIO
> +       select CLKSRC_PISTACHIO
> +       select MIPS_EXTERNAL_TIMER

Why not just select these in the MACH_PISTACHIO Kconfig entry?  Is
there any harm in always having the Pistachio GPT enabled?
