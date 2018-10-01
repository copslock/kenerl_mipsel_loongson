Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Oct 2018 11:25:14 +0200 (CEST)
Received: from mail-wr1-x444.google.com ([IPv6:2a00:1450:4864:20::444]:43072
        "EHLO mail-wr1-x444.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992925AbeJAJZHNH1-d (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 1 Oct 2018 11:25:07 +0200
Received: by mail-wr1-x444.google.com with SMTP id n1-v6so2908618wrt.10;
        Mon, 01 Oct 2018 02:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=OhEgUOB92QopJxDtkpB/kyOIyuMWKtWWsN3PGIRlWBw=;
        b=kLnPe+dkYCEOCvcI7eAaPv/TjTybwXi9/8+YLm/CFZ4J8ecACyJLfgrkw1sGtAmgQJ
         OLqvFLXSsSpDxsyAGipT6gACLv4YleuKMnFWP9pA+7PibUfSTCDBwbJewzNXjFRTTGWw
         kIYwRopI/VRvQYwx+9meWsnaUkKxkpUUpTFMQHNq+7p54HceFFCWA7jz2wgJTgPRzk2A
         mpQUK4FL8EKE6N0T6yi3Hl+AMZqyIwN1uKEE8Mm91OYKmaB/qE19QOlAE15l1aCTBaS2
         +kXAanjp/l+q0m9PJAeIU6C4zCuVavNz57EBDpLCDlc50MDTa6xCyQUep4pI2/5IL8/Z
         xwMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=OhEgUOB92QopJxDtkpB/kyOIyuMWKtWWsN3PGIRlWBw=;
        b=K20+Te0Of9yOLTTi0glj5oayJ34uOFRu1vmDip1MASqgBQE1Db3uk8F3w9k27nNx+V
         uIOL8SnpiQv/vxWAFFv3bByAx28WxVTf+c8mqTEIN2h8DvVTVXuJWzUt2cajgCTfCznP
         ialBlVSns+Q3kI85ySLPSE9xUa/8qdgp+dABVnJxyGgzErg+pqavPy6PPQH8wgo5J2ES
         FfaS674SrcVmH4QBy2nRilWqIbBPu7HXbtK/jchGa3cuEs5vDZ73idKKD0a2nWGLlTUk
         ihqfOH5A4R9KIk3/xymzMQ5qdaY0huTRx4EeiucJiLYNqyds3AmBOZ6pzwkh/IlqWZbE
         TUnA==
X-Gm-Message-State: ABuFfoiPXjSMfLTqsqMR8aNdxzNAV5Nai/L19GhufYLetaJN5t/QtuVx
        1GRyqQoWRk3Bqxt/S8+FT6o=
X-Google-Smtp-Source: ACcGV62G299+enXKRwlsf4p88HeqDdbJR0LYyf/+Y8gYw+MoknJFdSzaw+D4LNcD70JKOXXrECR6ew==
X-Received: by 2002:adf:ec11:: with SMTP id x17-v6mr6381768wrn.266.1538385901779;
        Mon, 01 Oct 2018 02:25:01 -0700 (PDT)
Received: from laptop ([37.122.159.87])
        by smtp.gmail.com with ESMTPSA id k25-v6sm10742636wre.18.2018.10.01.02.24.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Oct 2018 02:25:01 -0700 (PDT)
Message-ID: <a7854b26769c0baec6ad03cc1eee03b78f89b194.camel@gmail.com>
Subject: Re: [RFC 5/5] MIPS: Add Realtek RTL8186 SoC support
From:   Yasha Cherikovsky <yasha.che3@gmail.com>
To:     Marc Zyngier <marc.zyngier@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 01 Oct 2018 12:24:58 +0300
In-Reply-To: <351da67a-b1e6-7972-5c91-0f204690080f@arm.com>
References: <20180930141510.2690-1-yasha.che3@gmail.com>
         <20180930141510.2690-6-yasha.che3@gmail.com>
         <a7bba9bd-dab3-4f92-465f-e05beee2b9e3@arm.com>
         <ceced0d550bc30d4f3e66d2c7f569c39ca890ce4.camel@gmail.com>
         <351da67a-b1e6-7972-5c91-0f204690080f@arm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <yasha.che3@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66635
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yasha.che3@gmail.com
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

On Mon, 2018-10-01 at 10:15 +0100, Marc Zyngier wrote:
> On 01/10/18 09:48, Yasha Cherikovsky wrote:
> > Hi Marc,
> > 
> > On Mon, 2018-10-01 at 09:19 +0100, Marc Zyngier wrote:
> > > Hi Yasha,
> > > 
> > > On 30/09/18 15:15, Yasha Cherikovsky wrote:
> > > > The Realtek RTL8186 SoC is a MIPS based SoC
> > > > used in some home routers [1][2].
> > > > 
> > > > The hardware includes Lexra LX5280 CPU with a TLB,
> > > > two Ethernet controllers, a WLAN controller and more.
> > > > 
> > > > With this patch, it is possible to successfully boot
> > > > the kernel and load userspace on the Edimax BR-6204Wg
> > > > router.
> > > > Network drivers support will come in future patches.
> > > > 
> > > > This patch includes:
> > > > - New MIPS rtl8186 platform
> > > >       - Core platform setup code (mostly DT based)
> > > >       - New Kconfig option
> > > >       - defconfig file
> > > >       - MIPS zboot UART support
> > > > - RTL8186 interrupt controller driver
> > > > - RTL8186 timer driver
> > > > - Device tree files for the RTL8186 SoC and Edimax BR-6204Wg
> > > >     router
> > > > 
> > > > [1] https://www.linux-mips.org/wiki/Realtek_SOC#Realtek_RTL8186
> > > > [2] https://wikidevi.com/wiki/Realtek_RTL8186
> > > > 
> > > > Signed-off-by: Yasha Cherikovsky <yasha.che3@gmail.com>
> > > > Cc: Ralf Baechle <ralf@linux-mips.org>
> > > > Cc: Paul Burton <paul.burton@mips.com>
> > > > Cc: James Hogan <jhogan@kernel.org>
> > > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > > Cc: Jason Cooper <jason@lakedaemon.net>
> > > > Cc: Marc Zyngier <marc.zyngier@arm.com>
> > > > Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> > > > Cc: Rob Herring <robh+dt@kernel.org>
> > > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > > Cc: linux-mips@linux-mips.org
> > > > Cc: devicetree@vger.kernel.org
> > > > Cc: linux-kernel@vger.kernel.org
> > > > ---
> > > >    arch/mips/Kbuild.platforms                    |   1 +
> > > >    arch/mips/Kconfig                             |  17 ++
> > > >    arch/mips/boot/compressed/uart-16550.c        |   5 +
> > > >    arch/mips/boot/dts/Makefile                   |   1 +
> > > >    arch/mips/boot/dts/realtek/Makefile           |   4 +
> > > >    arch/mips/boot/dts/realtek/rtl8186.dtsi       |  86 +++++++
> > > >    .../dts/realtek/rtl8186_edimax_br_6204wg.dts  |  45 ++++
> > > >    arch/mips/configs/rtl8186_defconfig           | 112 +++++++++
> > > >    arch/mips/include/asm/mach-rtl8186/rtl8186.h  |  37 +++
> > > >    arch/mips/rtl8186/Makefile                    |   2 +
> > > >    arch/mips/rtl8186/Platform                    |   7 +
> > > >    arch/mips/rtl8186/irq.c                       |   8 +
> > > >    arch/mips/rtl8186/prom.c                      |  15 ++
> > > >    arch/mips/rtl8186/setup.c                     |  80 +++++++
> > > >    arch/mips/rtl8186/time.c                      |  10 +
> > > >    drivers/clocksource/Kconfig                   |   9 +
> > > >    drivers/clocksource/Makefile                  |   1 +
> > > >    drivers/clocksource/timer-rtl8186.c           | 220
> > > > ++++++++++++++++++
> > > >    drivers/irqchip/Kconfig                       |   5 +
> > > >    drivers/irqchip/Makefile                      |   1 +
> > > >    drivers/irqchip/irq-rtl8186.c                 | 107 +++++++++
> > > 
> > > Could you please split this into at least three patches (arch code,
> > > clocksource, irqchip) to ease the review?
> > > 
> > > Thanks,
> > > 
> > > 	M.
> > 
> > Currently the RTL8186_IRQ and the RTL8186_TIMER Kconfig entries depend
> > on
> > MACH_RTL8186 (which is added in the MIPS portion of the same patch).
> > Also, MACH_RTL8186 in MIPS selects these two options.
> > 
> > What is the best way to split that?
> 
> It is absolutely fine to have something depending on a non-selectable 
> config option, which would allow you to split things up as finely as you 
> want. Just have the patch enabling the config option last.
> 
> Thanks,
> 
> 	M.

Good to know, thanks.
I'll send a v2 soon.

Yasha
