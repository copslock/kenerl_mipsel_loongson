Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Oct 2018 12:56:41 +0100 (CET)
Received: from mail-wr1-x443.google.com ([IPv6:2a00:1450:4864:20::443]:34322
        "EHLO mail-wr1-x443.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992280AbeJ3L4h5owyU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 30 Oct 2018 12:56:37 +0100
Received: by mail-wr1-x443.google.com with SMTP id l6-v6so12275709wrt.1
        for <linux-mips@linux-mips.org>; Tue, 30 Oct 2018 04:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NDvJHuJEHcXrFbYGamseXrE+75OV340d/Bj4qXMmHmA=;
        b=IvqKv2phANn9ENDJoFpYpJnTnIt78SMmotjGy22aZB6VLJnn8qGyYGCtEBpZshx13H
         +6N0OREHQV7oJVEU7Gg1vvsTl6DwEFCO/IXnxLSPzn4jlsuLJfhBoykqF2at2ijT7PWg
         LrBIAA+5tRvzbUFrtPwbsOQDgHUNcuJcP5HjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NDvJHuJEHcXrFbYGamseXrE+75OV340d/Bj4qXMmHmA=;
        b=TvzWbQy2IYx5f80G9yZPFuDf2HsI9g11ABA4x5jdwZXIvyMKSq2CkRMHH53dVEC5Jn
         ZSm/86m0ZXY4xqgJazg9lN1pi+aA0XvX5HgFceKcbABnP8chqDBDakVTAgz+wzO/hcFm
         4LN4lSIFG7AqNbs7UV+nJhMKppMOJB/m1+KsFDDeNdPm6VJfzd+PcNMbGfk+loaiHEyl
         /LSNampa7lLMA8TWm6B2rtZE4gT2/XC7dz1w3G20bWfIzzwUpMNsMykMovsRSjO0e3BC
         2tOa2PClan6CYdIe41C03v5mIo2b0q8OrGXTwcMtHcm/NW0zusqwRknkVxJb5TYiWFaE
         LklA==
X-Gm-Message-State: AGRZ1gJdjZUGYegOPucKXo6i3aFG+5qLm6k0gx5/OuYvjeC5pEtoyStv
        UsYznhnp9VoXnf2xYrWKGwPMaA==
X-Google-Smtp-Source: AJdET5eZGsFu6G3mFMPCtbUyW6CvZgH0WXTK/3MFbGDeVoSlI0PsDmfsp/3V8yZAA19Dc83enfz3yg==
X-Received: by 2002:a5d:558b:: with SMTP id i11-v6mr16965334wrv.38.1540900592403;
        Tue, 30 Oct 2018 04:56:32 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id 82-v6sm29949173wms.17.2018.10.30.04.56.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Oct 2018 04:56:31 -0700 (PDT)
Date:   Tue, 30 Oct 2018 11:56:28 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>, tglx@linutronix.de,
        mingo@kernel.org, gregkh@linuxfoundation.org,
        linux-arm-msm@vger.kernel.org,
        kgdb-bugreport@lists.sourceforge.net, nm@ti.com,
        linux-mips@linux-mips.org, dalias@libc.org,
        catalin.marinas@arm.com, vigneshr@ti.com,
        linux-aspeed@lists.ozlabs.org, linux-sh@vger.kernel.org,
        peterz@infradead.org, will.deacon@arm.com, mhocko@suse.com,
        paulus@samba.org, hpa@zytor.com, sparclinux@vger.kernel.org,
        marex@denx.de, sfr@canb.auug.org.au, ysato@users.sourceforge.jp,
        linux-hexagon@vger.kernel.org, x86@kernel.org,
        linux@armlinux.org.uk, pombredanne@nexb.com, tony@atomide.com,
        mingo@redhat.com, joel@jms.id.au, linux-serial@vger.kernel.org,
        rolf.evers.fischer@aptiv.com, jhogan@kernel.org,
        asierra@xes-inc.com, linux-snps-arc@lists.infradead.org,
        dan.carpenter@oracle.com, ying.huang@intel.com, riel@surriel.com,
        frederic@kernel.org, jslaby@suse.com, paul.burton@mips.com,
        rppt@linux.vnet.ibm.com, bp@alien8.de, luto@kernel.org,
        andriy.shevchenko@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, christophe.leroy@c-s.fr,
        andrew@aj.id.au, linux-kernel@vger.kernel.org, ralf@linux-mips.org,
        rkuo@codeaurora.org, Jisheng.Zhang@synaptics.com,
        vgupta@synopsys.com, benh@kernel.crashing.org, jk@ozlabs.org,
        mpe@ellerman.id.au, akpm@linux-foundation.org,
        linuxppc-dev@lists.ozlabs.org, davem@davemloft.net,
        kstewart@linuxfoundation.org
Subject: Re: [PATCH 0/7] serial: Finish kgdb on qcom_geni; fix many lockdep
 splats w/ kgdb
Message-ID: <20181030115628.eqtyqdugkpkxvyr2@holly.lan>
References: <20181029180707.207546-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181029180707.207546-1-dianders@chromium.org>
User-Agent: NeoMutt/20180716
Return-Path: <daniel.thompson@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66984
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel.thompson@linaro.org
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

On Mon, Oct 29, 2018 at 11:07:00AM -0700, Douglas Anderson wrote:
> Looking back, this is pretty much two series squashed that could be
> treated indepdently.  The first is a serial series and the second is a
> kgdb series.

Indeed.

I couldn't work out the link between the first 5 patches and the last 2
until I read this...

Is anything in the 01->05 patch set even related to kgdb? From the stack
traces it looks to me like the lock dep warning would trigger for any
sysrq. I think separating into two threads for v2 would be sensible.


Daniel.


> 
> For all serial patches I'd expect them to go through the tty tree once
> they've been reviewed.
> 
> If folks are OK w/ the 'smp' patch it probably should go in some core
> kernel tree.  The kgdb patch won't work without it, though, so to land
> that we'd need coordination between the folks landing that and the
> folks landing the 'smp' patch.
> 
> 
> Douglas Anderson (7):
>   serial: qcom_geni_serial: Finish supporting sysrq
>   serial: core: Allow processing sysrq at port unlock time
>   serial: qcom_geni_serial: Process sysrq at port unlock time
>   serial: core: Include console.h from serial_core.h
>   serial: 8250: Process sysrq at port unlock time
>   smp: Don't yell about IRQs disabled in kgdb_roundup_cpus()
>   kgdb: Remove irq flags and local_irq_enable/disable from roundup
> 
>  arch/arc/kernel/kgdb.c                      |  4 +--
>  arch/arm/kernel/kgdb.c                      |  4 +--
>  arch/arm64/kernel/kgdb.c                    |  4 +--
>  arch/hexagon/kernel/kgdb.c                  | 11 ++----
>  arch/mips/kernel/kgdb.c                     |  4 +--
>  arch/powerpc/kernel/kgdb.c                  |  2 +-
>  arch/sh/kernel/kgdb.c                       |  4 +--
>  arch/sparc/kernel/smp_64.c                  |  2 +-
>  arch/x86/kernel/kgdb.c                      |  9 ++---
>  drivers/tty/serial/8250/8250_aspeed_vuart.c |  6 +++-
>  drivers/tty/serial/8250/8250_fsl.c          |  6 +++-
>  drivers/tty/serial/8250/8250_omap.c         |  6 +++-
>  drivers/tty/serial/8250/8250_port.c         |  8 ++---
>  drivers/tty/serial/qcom_geni_serial.c       | 10 ++++--
>  include/linux/kgdb.h                        |  9 ++---
>  include/linux/serial_core.h                 | 38 ++++++++++++++++++++-
>  kernel/debug/debug_core.c                   |  2 +-
>  kernel/smp.c                                |  4 ++-
>  18 files changed, 80 insertions(+), 53 deletions(-)
> 
> -- 
> 2.19.1.568.g152ad8e336-goog
> 
