Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Sep 2016 14:34:29 +0200 (CEST)
Received: from basicbox7.server-home.net ([195.137.212.29]:49409 "EHLO
        basicbox7.server-home.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990522AbcIKMeWksya2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 11 Sep 2016 14:34:22 +0200
Received: from ankhmorpork.fritz.box (ip4d15e046.dynamic.kabel-deutschland.de [77.21.224.70])
        (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by basicbox7.server-home.net (Postfix) with ESMTPSA id 1FC085EEF2A;
        Sun, 11 Sep 2016 14:34:15 +0200 (CEST)
Subject: Re: [BISECTED REGRESSION] v4.8-rc: DT/OCTEON driver probing broken
To:     Rob Herring <robh@kernel.org>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Michal Simek <monstr@monstr.eu>,
        Paul Burton <paul.burton@imgtec.com>
References: <20160816150056.GD18731@ak-desktop.emea.nsn-net.net>
 <0336fae0-1717-2f90-c221-6ef69f7024ee@leemhuis.info>
 <20160828122239.GA14316@raspberrypi.musicnaut.iki.fi>
 <CAL_Jsq+mmBH+HVLubj1_rQ0T60zfQj_Dbz41EVe7v_Mj_u2Vug@mail.gmail.com>
Cc:     Aaro Koskinen <aaro.koskinen@nokia.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
Message-ID: <bb9ca373-2018-f795-59f0-00e34336e16e@leemhuis.info>
Date:   Sun, 11 Sep 2016 14:34:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+mmBH+HVLubj1_rQ0T60zfQj_Dbz41EVe7v_Mj_u2Vug@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <regressions@leemhuis.info>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55094
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: regressions@leemhuis.info
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

Hi! On 30.08.2016 00:39, Rob Herring wrote:
> On Sun, Aug 28, 2016 at 7:22 AM, Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
>> On Sun, Aug 28, 2016 at 12:34:06PM +0200, Thorsten Leemhuis wrote:
>> There is a fix proposal here:
>>         https://patchwork.linux-mips.org/patch/14041/
>> There is still few other boards remaining that use of_platform_bus_probe()
>> from device_initcall, but who knows, maybe they are not affected.
>> arch/microblaze/kernel/platform.c
> xlnx,compound is going to fail to probe. I'm adding this to the default.
> 
>> arch/mips/mti-malta/malta-dt.c
> This should be fine. It does probe for "isa", but nothing in mainline
> is using that. We can add it to the default when it does.
> 
>> arch/mips/netlogic/xlp/dt.c
> Should be okay with default.
> 
>> arch/x86/platform/olpc/olpc_dt.c
> This one needs fixing.

Rob, did anything happen on this front? This issue is still on the list
of regression for 4.8, and it seems to me nothing happened in the past
ten days -- or is this discussed somewhere else?.

Ciao, Thorsten
