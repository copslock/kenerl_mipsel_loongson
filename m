Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Aug 2016 20:42:10 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.136]:54420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992211AbcH2SmCZLl-7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 29 Aug 2016 20:42:02 +0200
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id 933BC20212;
        Mon, 29 Aug 2016 18:41:56 +0000 (UTC)
Received: from mail-yb0-f179.google.com (mail-yb0-f179.google.com [209.85.213.179])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B9AA201BB;
        Mon, 29 Aug 2016 18:41:55 +0000 (UTC)
Received: by mail-yb0-f179.google.com with SMTP id a7so50215587ybi.0;
        Mon, 29 Aug 2016 11:41:55 -0700 (PDT)
X-Gm-Message-State: AE9vXwOutJXgLhdEqEL5as5n2fwB4O4Ls5Z3xaGtq1SUCaO0rH3uOWMvccN3is6KZoNn8d6uC/9HBRIy4Lqvyg==
X-Received: by 10.37.11.22 with SMTP id 22mr8125728ybl.167.1472496114426; Mon,
 29 Aug 2016 11:41:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.129.162.2 with HTTP; Mon, 29 Aug 2016 11:41:34 -0700 (PDT)
In-Reply-To: <CAL_JsqK-+MOw1VCb57DXdEBwaVZP+KypapXJb7Mw3unD4A0-GQ@mail.gmail.com>
References: <20160816150056.GD18731@ak-desktop.emea.nsn-net.net> <CAL_JsqK-+MOw1VCb57DXdEBwaVZP+KypapXJb7Mw3unD4A0-GQ@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 29 Aug 2016 13:41:34 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKXzBmDF164HMjdXEFRAsVWL=U6qpJhsHeiqmrFRbeVdA@mail.gmail.com>
Message-ID: <CAL_JsqKXzBmDF164HMjdXEFRAsVWL=U6qpJhsHeiqmrFRbeVdA@mail.gmail.com>
Subject: Re: [BISECTED REGRESSION] v4.8-rc: DT/OCTEON driver probing broken
To:     Aaro Koskinen <aaro.koskinen@nokia.com>
Cc:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <robh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54835
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

On Mon, Aug 29, 2016 at 12:36 PM, Rob Herring <robh@kernel.org> wrote:
> On Tue, Aug 16, 2016 at 10:00 AM, Aaro Koskinen <aaro.koskinen@nokia.com> wrote:
>> Hi,
>>
>> Commit 44a7185c2ae6 ("of/platform: Add common method to populate default
>> bus") added new arch_initcall of_platform_default_populate_init() that
>> will be called before device_initcall octeon_publish_devices(). Now the
>> of_platform_bus_probe() called in octeon_publish_devices() is apparently
>> doing nothing:
>>
>> [   52.331353] calling  octeon_publish_devices+0x0/0x14 @ 1
>> [   52.331358] OF: of_platform_bus_probe()
>> [   52.331362] OF:  starting at: /
>> [   52.331378] OF: of_platform_bus_create() - skipping /soc@0, already populated
>> [   52.331394] initcall octeon_publish_devices+0x0/0x14 returned 0 after 29 usecs
>>
>> This also means that USB etc. won't get probed.
>>
>> Any ideas what would be the proper fix for this? Changing
>> octeon_publish_devices() to arch_initcall seems to work but that may be
>> a bit hackish... Also, there might be also other MIPS boards affected
>> (arch/mips/netlogic/xlp/dt.c, arch/mips/mti-malta/malta-dt.c).
>
> Can you try reverting this hunk. I don't think it should be needed and
> it is preventing /soc@0 children from being probed. If things still
> don't work, then it should purely be a probe ordering problem. I have
> some better fixes in mind, but not for 4.8. So if this doesn't work,
> then the same fix as PPC is fine.

Nevermind, reverting this hunk is not enough.

Rob
