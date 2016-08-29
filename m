Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Aug 2016 00:39:49 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.136]:50054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992247AbcH2WjnCLr8H (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 30 Aug 2016 00:39:43 +0200
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id 8F50220219;
        Mon, 29 Aug 2016 22:39:39 +0000 (UTC)
Received: from mail-yw0-f178.google.com (mail-yw0-f178.google.com [209.85.161.178])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6975C201BB;
        Mon, 29 Aug 2016 22:39:36 +0000 (UTC)
Received: by mail-yw0-f178.google.com with SMTP id z8so1192503ywa.1;
        Mon, 29 Aug 2016 15:39:36 -0700 (PDT)
X-Gm-Message-State: AE9vXwMJISnb+IvcyeumLgUWI7pFWjgXZYPJh1msTL+c5rk4Z2fwq2jtk6moUhBm3/2nJlAWwutFNU1eZcbG1Q==
X-Received: by 10.129.53.197 with SMTP id c188mr412614ywa.70.1472510375680;
 Mon, 29 Aug 2016 15:39:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.129.162.2 with HTTP; Mon, 29 Aug 2016 15:39:15 -0700 (PDT)
In-Reply-To: <20160828122239.GA14316@raspberrypi.musicnaut.iki.fi>
References: <20160816150056.GD18731@ak-desktop.emea.nsn-net.net>
 <0336fae0-1717-2f90-c221-6ef69f7024ee@leemhuis.info> <20160828122239.GA14316@raspberrypi.musicnaut.iki.fi>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 29 Aug 2016 17:39:15 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+mmBH+HVLubj1_rQ0T60zfQj_Dbz41EVe7v_Mj_u2Vug@mail.gmail.com>
Message-ID: <CAL_Jsq+mmBH+HVLubj1_rQ0T60zfQj_Dbz41EVe7v_Mj_u2Vug@mail.gmail.com>
Subject: Re: [BISECTED REGRESSION] v4.8-rc: DT/OCTEON driver probing broken
To:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Michal Simek <monstr@monstr.eu>,
        Paul Burton <paul.burton@imgtec.com>
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Aaro Koskinen <aaro.koskinen@nokia.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <robh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54836
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

On Sun, Aug 28, 2016 at 7:22 AM, Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
> Hi,
>
> On Sun, Aug 28, 2016 at 12:34:06PM +0200, Thorsten Leemhuis wrote:
>> Lo! Kefeng, below report made it to the list of regression for 4.8, but
>> afaics nothing happened after the initial report. Is there maybe some
>> reason why it shouldn't be on the list of regressions at all? Or was the
>> problem discussed elsewhere? Or is it even fixed already? I noticed
>> https://git.kernel.org/torvalds/c/fc520f8b4f (of/platform: disable the
>> of_platform_default_populate_init() for all the ppc board), but that
>> change is PPC specific.
>
> There is a fix proposal here:
>
>         https://patchwork.linux-mips.org/patch/14041/
>
> There is still few other boards remaining that use of_platform_bus_probe()
> from device_initcall, but who knows, maybe they are not affected.
>
> arch/microblaze/kernel/platform.c

xlnx,compound is going to fail to probe. I'm adding this to the default.

> arch/mips/mti-malta/malta-dt.c

This should be fine. It does probe for "isa", but nothing in mainline
is using that. We can add it to the default when it does.

> arch/mips/netlogic/xlp/dt.c

Should be okay with default.

> arch/x86/platform/olpc/olpc_dt.c

This one needs fixing.

Rob
