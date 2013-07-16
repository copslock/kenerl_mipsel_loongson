Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Jul 2013 15:07:25 +0200 (CEST)
Received: from mail-pa0-f51.google.com ([209.85.220.51]:63926 "EHLO
        mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6832024Ab3GPNHXasTeU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 16 Jul 2013 15:07:23 +0200
Received: by mail-pa0-f51.google.com with SMTP id lf11so766456pab.24
        for <multiple recipients>; Tue, 16 Jul 2013 06:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=Vizzfin9BU+lBpmsKAmcFvRjnQ4GTHc4XrqFJmU1tAE=;
        b=TNNNPxIyBWg3KJa7WZRzLBJHVFs8zLw7wJ/JV/aoOTf5b+E3ATQYnyyS5qRpnNYQg+
         ArX7+b8FyMFkQBwMFjHg7NBD1w9Tt4T+tJ9CRKgFgVuRFU7I8NdzJXtLx6crHwe9h0Vl
         WWdTtaLnQ0wh7vuSJMNwcKfe0lxEX2cPFyldcXRD1Z4aco2mivi39jbKWm4ecEIQryck
         qLLNH7NGw8XlmsoJbzRubXdLbUe37UvGEL0FRfrn064DZd/lc2DZiYVWjXdMi14XbjMW
         wLg3PdEnG/6021zPRqi5vWbFhtD0Rtk52LgoAGOiuVv4ANg4914/OdiCU0Qvn4WRnfZ3
         bfaA==
X-Received: by 10.66.222.226 with SMTP id qp2mr2601167pac.102.1373980036750;
 Tue, 16 Jul 2013 06:07:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.68.10.101 with HTTP; Tue, 16 Jul 2013 06:06:36 -0700 (PDT)
In-Reply-To: <1372537073-27370-1-git-send-email-jogo@openwrt.org>
References: <1372537073-27370-1-git-send-email-jogo@openwrt.org>
From:   Florian Fainelli <florian@openwrt.org>
Date:   Tue, 16 Jul 2013 14:06:36 +0100
X-Google-Sender-Auth: WWFFCS9_eR_sTrrGeCaTJFi8oic
Message-ID: <CAGVrzcbJ1N=Tr8jUpk1YHjMUZ1+psDRYj8edb3JKbb6EBkozWg@mail.gmail.com>
Subject: Re: [PATCH 00/10] MIPS: BCM63XX: improve BMIPS support
To:     Jonas Gorski <jogo@openwrt.org>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Kevin Cernekee <cernekee@gmail.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37299
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
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

Hello Jonas,

2013/6/29 Jonas Gorski <jogo@openwrt.org>:
> This patchset aims at unifying the different BMIPS support code to allow
> building a kernel that runs on multiple BCM63XX SoCs which might have
> different BMIPS flavours on them, regardless of SMP support enabled in
> the kernel.
>
> The first few patches clean up BMIPS itself and prepare it for multi-cpu
> support, while the latter add support to BCM63XX for running a SMP kernel
> with support for all SoCs, even those that do not have a SMP capable
> CPU.
>
> This patchset is runtime tested on BCM6348, BCM6328 and BCM6368, to
> verify that it actually does what it claims it does.
>
> Lacking hardware, it is only build tested for BMIPS4380 and BMIPS5000.
>
> Jonas Gorski (10):
>   MIPS: bmips: fix compilation for BMIPS5000
>   MIPS: allow asm/cpu.h to be included from assembly
>   MIPS: bmips: add macros for testing the current bmips CPU
>   MIPS: bmips: change compile time checks to runtime checks
>   MIPS: bmips: merge CPU options into one option
>   MIPS: BCM63XX: let the individual SoCs select the appropriate CPUs
>   MIPS: bmips: add a helper function for registering smp ops
>   MIPS: BCM63XX: always register bmips smp ops
>   MIPS: BCM63XX: change the guard to a BMIPS4350 check
>   MIPS: BCM63XX: disable SMP also on BCM3368

After fixing the typo on BMIPS4350 vs BMIPS4380 and fixing the
following (which I will submit just in a few minutes)

@@ -187,7 +187,7 @@ static void bmips_boot_secondary(int cpu, struct task_struct
        } else {
                if (cpu_is_bmips4350() || cpu_is_bmips4380()) {
                        /* Reset slave TP1 if booting from TP0 */
-                       if (cpu_logical_map(cpu) == 0)
+                       if (cpu_logical_map(cpu) == 1)
                                set_c0_brcm_cmt_ctrl(0x01);
                } else if (cpu_is_bmips5000()) {
                        if (cpu & 0x01)

it works just nicely on BMIPS4380. I plan on doing some testing on
BMIPS5000 later this week.

Thanks!
--
Florian
