Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Sep 2016 13:03:40 +0200 (CEST)
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34685 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991960AbcIPLDdjOGgk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Sep 2016 13:03:33 +0200
Received: by mail-wm0-f67.google.com with SMTP id l132so1995928wmf.1
        for <linux-mips@linux-mips.org>; Fri, 16 Sep 2016 04:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Utt3TJsMyDftsCO6den8y44mFNSnwBEg0pl3U/0gDJg=;
        b=c+gxrK7q/MeSl/GUul1+FKjbGHJhOw1n4F3x/5bqDZhtnWSP1FU4hhOTOB28umq+JQ
         iaIoDRR4DjiIE51SSpAJjQJgAPpid8J9V2x3TvLRjxTj/42W+V1ifTz3PL+cSGUUlEKa
         jAP7yoAWUSjZZflabq9VUnw7oIwcPctYeC2zXvTuDi1HXNhuxbnJcKlj8DSzXXbLRTDn
         bIvPp8AMD47xGxsxD9JoCr5UV7eRz5qRdjdfP/VFg3C7mhwmjD/Dbvids+tyWLf8kxty
         84JWfH5WwtCpY7GeCVSQ6ewitnygQlEuIuLtBwFozuUctN4fR1h0TogEeerbEgi5l2WS
         7GJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Utt3TJsMyDftsCO6den8y44mFNSnwBEg0pl3U/0gDJg=;
        b=S61xYBp1ha+FcdF75UzgDUGDbmubm7suc7JlFI6J8pWGbg95lEAqADvCrOmw7G9SFR
         AK7YMHEQE3YlrP4Pd3g0r3ISazxfMKDemh1jCImrw0lUIjDMDILM4TNtNocIoprKW87L
         4SXvrj0iiPpBJWVUqYtwvTuwYNAetvhYYkPYmabeIc6EaqY8MvBQ7Fy15+V38gbBObMs
         oDzmgycjMJfedfeklppet7bHBtZVNcTbvjLcNRH7Oo/0QmRBBz5WOAlsbOHGVOEXg5Ft
         K4HKcja1hlsSIiNEM8vph9/eaQARKSfzX5OVXeiweH9DYrwhrRiqORdiEixZH4XxG0UQ
         tATA==
X-Gm-Message-State: AE9vXwPXxydke1yfSpFNGnCo78HQ4NhEz/mMAkVsXlcn0En97eY9bhrm/BxhSQsqbxu7yw==
X-Received: by 10.28.43.129 with SMTP id r123mr7485307wmr.1.1474023808157;
        Fri, 16 Sep 2016 04:03:28 -0700 (PDT)
Received: from [192.168.1.82] (ARouen-653-1-214-191.w90-22.abo.wanadoo.fr. [90.22.23.191])
        by smtp.gmail.com with ESMTPSA id bc5sm7838543wjb.37.2016.09.16.04.03.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Sep 2016 04:03:27 -0700 (PDT)
Message-ID: <1474023805.17258.10.camel@gmail.com>
Subject: Re: genirq: Setting trigger mode 0 for irq 11 failed
 (txx9_irq_set_type+0x0/0xb8)
From:   Alban Browaeys <alban.browaeys@gmail.com>
To:     Marc Zyngier <marc.zyngier@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:     Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jon Hunter <jonathanh@nvidia.com>
Date:   Fri, 16 Sep 2016 13:03:25 +0200
In-Reply-To: <57DBA464.9010506@arm.com>
References: <CAMuHMdVW1eTn20=EtYcJ8hkVwohaSuH_yQXrY2MGBEvZ8fpFOg@mail.gmail.com>
         <1473980577.17787.21.camel@gmail.com> <57DBA464.9010506@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-Path: <alban.browaeys@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55149
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alban.browaeys@gmail.com
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

Le vendredi 16 septembre 2016 à 08:51 +0100, Marc Zyngier a écrit :
> Hi Alban,
> 
> On 16/09/16 00:02, Alban Browaeys wrote:
> > I am seeing this on arm odroid u2 devicetree :
> > genirq: Setting trigger mode 0 for irq 16 failed
> > (gic_set_type+0x0/0x64)
> 
> Passing IRQ_TYPE_NONE to a cascading interrupt is risky at best...
> Can you point me to the various DTs and their failing interrupts?

mine is:
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/exynos4412-odroidu3.dts

I got a report of this issue to another odroid :
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/exynos4412-odroidx2.dts



they both get their settings from :
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/exynos4412.dtsi

relevant in the chain are:
- combiner modified:
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/exynos4x12.dtsi#n460
- gic:
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/exynos4x12-pinctrl.dtsi#n576
- gic and combiner initial settings:
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/exynos4.dtsi#n134



> Also, can you please give the following patch a go and let me know
> if that fixes the issue (I'm interested in the potential warning
> here).

1st batch of warnings is :

------------[ cut here ]------------
WARNING: CPU: 0 PID: 0 at kernel/irq/chip.c:833 __irq_do_set_handler+0x1c0/0x1c4
Modules linked in:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.8.0-rc6-debug+ #30
Hardware name: ODROID-U2/U3
[<c010fc74>] (unwind_backtrace) from [<c010c9a0>] (show_stack+0x10/0x14)
[<c010c9a0>] (show_stack) from [<c035cafc>] (dump_stack+0xa8/0xd4)
[<c035cafc>] (dump_stack) from [<c01214dc>] (__warn+0xe8/0x100)
[<c01214dc>] (__warn) from [<c01215a4>] (warn_slowpath_null+0x20/0x28)
[<c01215a4>] (warn_slowpath_null) from [<c017d394>] (__irq_do_set_handler+0x1c0/0x1c4)
[<c017d394>] (__irq_do_set_handler) from [<c017d450>] (irq_set_chained_handler_and_data+0x38/0x54)
[<c017d450>] (irq_set_chained_handler_and_data) from [<c0a15878>] (combiner_of_init+0x1a0/0x1c4)
[<c0a15878>] (combiner_of_init) from [<c0a1ead4>] (of_irq_init+0x194/0x2e8)
[<c0a1ead4>] (of_irq_init) from [<c0a07450>] (exynos_init_irq+0x8/0x3c)
[<c0a07450>] (exynos_init_irq) from [<c0a0190c>] (init_IRQ+0x2c/0x88)
[<c0a0190c>] (init_IRQ) from [<c0a00b78>] (start_kernel+0x284/0x388)
[<c0a00b78>] (start_kernel) from [<40008078>] (0x40008078)
---[ end trace f68728a0d3053b52 ]---

2nd batch is :

------------[ cut here ]------------
WARNING: CPU: 1 PID: 1 at kernel/irq/chip.c:833 __irq_do_set_handler+0x1c0/0x1c4
Modules linked in:
CPU: 1 PID: 1 Comm: swapper/0 Tainted: G        W       4.8.0-rc6-debug+ #30
Hardware name: ODROID-U2/U3
[<c010fc74>] (unwind_backtrace) from [<c010c9a0>] (show_stack+0x10/0x14)
[<c010c9a0>] (show_stack) from [<c035cafc>] (dump_stack+0xa8/0xd4)
[<c035cafc>] (dump_stack) from [<c01214dc>] (__warn+0xe8/0x100)
[<c01214dc>] (__warn) from [<c01215a4>] (warn_slowpath_null+0x20/0x28)
[<c01215a4>] (warn_slowpath_null) from [<c017d394>] (__irq_do_set_handler+0x1c0/0x1c4)
[<c017d394>] (__irq_do_set_handler) from [<c017d450>] (irq_set_chained_handler_and_data+0x38/0x54)
[<c017d450>] (irq_set_chained_handler_and_data) from [<c038e340>] (exynos_eint_wkup_init+0x188/0x2dc)
[<c038e340>] (exynos_eint_wkup_init) from [<c038d668>] (samsung_pinctrl_probe+0x874/0xa18)
[<c038d668>] (samsung_pinctrl_probe) from [<c04342c8>] (platform_drv_probe+0x4c/0xb0)
[<c04342c8>] (platform_drv_probe) from [<c043267c>] (driver_probe_device+0x24c/0x440)
[<c043267c>] (driver_probe_device) from [<c0430658>] (bus_for_each_drv+0x64/0x98)
[<c0430658>] (bus_for_each_drv) from [<c04322e8>] (__device_attach+0xb4/0x144)
[<c04322e8>] (__device_attach) from [<c04316f4>] (bus_probe_device+0x88/0x90)
[<c04316f4>] (bus_probe_device) from [<c042f850>] (device_add+0x428/0x5c8)
[<c042f850>] (device_add) from [<c054c3f8>] (of_platform_device_create_pdata+0x84/0xb8)
[<c054c3f8>] (of_platform_device_create_pdata) from [<c054c59c>] (of_platform_bus_create+0x164/0x440)
[<c054c59c>] (of_platform_bus_create) from [<c054ca20>] (of_platform_populate+0x80/0x114)
[<c054ca20>] (of_platform_populate) from [<c0a1d458>] (of_platform_default_populate_init+0x6c/0x80)
[<c0a1d458>] (of_platform_default_populate_init) from [<c01018d4>] (do_one_initcall+0x50/0x198)
[<c01018d4>] (do_one_initcall) from [<c0a00ecc>] (kernel_init_freeable+0x250/0x2f0)
[<c0a00ecc>] (kernel_init_freeable) from [<c06c1064>] (kernel_init+0x8/0x114)
[<c06c1064>] (kernel_init) from [<c0108710>] (ret_from_fork+0x14/0x24)
---[ end trace f68728a0d3053b66 ]---



Best regards,
Alban
