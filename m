Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Nov 2017 15:03:20 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:56786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990593AbdKGODMx1si2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 7 Nov 2017 15:03:12 +0100
Received: from mail-qk0-f175.google.com (mail-qk0-f175.google.com [209.85.220.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D9FB21921;
        Tue,  7 Nov 2017 14:03:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D9FB21921
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh@kernel.org
Received: by mail-qk0-f175.google.com with SMTP id p7so1333297qkd.7;
        Tue, 07 Nov 2017 06:03:09 -0800 (PST)
X-Gm-Message-State: AMCzsaVExWJP9qW66vrbHxNsT4nib4WZ5pHoBsRkZEqH//tfMU+0578R
        hW6XaHeYe445YNRvW2aBlSFUApqHU+N/q+6dOA==
X-Google-Smtp-Source: ABhQp+TViaRTaSzUWoXZf9/ifyxKc4ad2O50myuiJCQzxtOxhlgml8UP4Orgjb87mXxqFm4m8NsIGNIkpPjPpYrO8EI=
X-Received: by 10.55.128.66 with SMTP id b63mr27257928qkd.67.1510063388520;
 Tue, 07 Nov 2017 06:03:08 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.130.134 with HTTP; Tue, 7 Nov 2017 06:02:47 -0800 (PST)
In-Reply-To: <CAK8P3a3QKkGv6eSjX7wH6LpOY0-1XUPFoX0ntog5-ZSHPab6iA@mail.gmail.com>
References: <5a0159b6.08bc500a.ebe4b.25c6@mx.google.com> <CAK8P3a3QKkGv6eSjX7wH6LpOY0-1XUPFoX0ntog5-ZSHPab6iA@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 7 Nov 2017 08:02:47 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJsXzgUvQrBXGQxuOrb-QUjOOiSyqhpF-V9NeaKG4TyrA@mail.gmail.com>
Message-ID: <CAL_JsqJsXzgUvQrBXGQxuOrb-QUjOOiSyqhpF-V9NeaKG4TyrA@mail.gmail.com>
Subject: Re: next/master build: 214 builds: 26 failed, 188 passed, 28 errors,
 6333 warnings (next-20171107)
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "kernelci.org bot" <bot@kernelci.org>,
        Kernel Build Reports Mailman List 
        <kernel-build-reports@lists.linaro.org>,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <robh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60741
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

On Tue, Nov 7, 2017 at 6:15 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tue, Nov 7, 2017 at 7:59 AM, kernelci.org bot <bot@kernelci.org> wrote:

>> 12 arch/arm/boot/dts/spear1340-evb.dtb: Warning (dmas_property): Property 'dmas', cell 4 is not a phandle reference in /ahb/apb/serial@b4100000
>> 12 arch/arm/boot/dts/spear1340-evb.dtb: Warning (dmas_property): Missing property '#dma-cells' in node /interrupt-controller@ec801000 or bad phandle (referred from /ahb/apb/serial@b4100000:dmas[4])
>> 12 arch/arm/boot/dts/spear1310-evb.dtb: Warning (gpios_property): Property 'cs-gpios', cell 6 is not a phandle reference in /ahb/apb/spi@e0100000
>> 12 arch/arm/boot/dts/spear1310-evb.dtb: Warning (gpios_property): Missing property '#gpio-cells' in node /interrupt-controller@ec801000 or bad phandle (referred from /ahb/apb/spi@e0100000:cs-gpios[6])
> ...
>
> endless stream of new dtc warnings, mostly valid. I have started
> fixing them but at some point
> gave up. Looking for help here.

Sorry, I intended to have these show up early in the cycle to give
time to fix, but between -next being sporadic and kernelci needing a
change to report dtc warnings it all landed late. It's really only
50-100 unique errors. Things just explode since everything is an
include file.

Rob
