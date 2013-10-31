Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Oct 2013 20:07:55 +0100 (CET)
Received: from avon.wwwdotorg.org ([70.85.31.133]:41716 "EHLO
        avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6822133Ab3JaTHthtiO3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 31 Oct 2013 20:07:49 +0100
Received: from severn.wwwdotorg.org (unknown [192.168.65.5])
        (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by avon.wwwdotorg.org (Postfix) with ESMTPS id 282532200C;
        Thu, 31 Oct 2013 13:07:48 -0600 (MDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by severn.wwwdotorg.org (Postfix) with ESMTPSA id 1F10AE40F8;
        Thu, 31 Oct 2013 13:07:44 -0600 (MDT)
Message-ID: <5272AA80.1030804@wwwdotorg.org>
Date:   Thu, 31 Oct 2013 13:07:44 -0600
From:   Stephen Warren <swarren@wwwdotorg.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.0
MIME-Version: 1.0
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
CC:     mturquette@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux@arm.linux.org.uk, jiada_wang@mentor.com,
        kyungmin.park@samsung.com, laurent.pinchart@ideasonboard.com,
        linux-kernel@vger.kernel.org,
        uclinux-dist-devel@blackfin.uclinux.org, linux-mips@linux-mips.org,
        linux-sh@vger.kernel.org,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>
Subject: Re: [PATCH v7 5/5] clk: Implement clk_unregister()
References: <1383076268-8984-1-git-send-email-s.nawrocki@samsung.com> <1383076268-8984-6-git-send-email-s.nawrocki@samsung.com> <5272A24A.30800@wwwdotorg.org> <5272A7A0.7020800@samsung.com>
In-Reply-To: <5272A7A0.7020800@samsung.com>
X-Enigmail-Version: 1.5.2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.97.8 at avon.wwwdotorg.org
X-Virus-Status: Clean
Return-Path: <swarren@wwwdotorg.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38432
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: swarren@wwwdotorg.org
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

On 10/31/2013 12:55 PM, Sylwester Nawrocki wrote:
> On 31/10/13 19:32, Stephen Warren wrote:
>> On 10/29/2013 01:51 PM, Sylwester Nawrocki wrote:
>>>> clk_unregister() is currently not implemented and it is required when
>>>> a clock provider module needs to be unloaded.
>>>>
>>>> Normally the clock supplier module is prevented to be unloaded by
>>>> taking reference on the module in clk_get().
>>>>
>>>> For cases when the clock supplier module deinitializes despite the
>>>> consumers of its clocks holding a reference on the module, e.g. when
>>>> the driver is unbound through "unbind" sysfs attribute, there are
>>>> empty clock ops added. These ops are assigned temporarily to struct
>>>> clk and used until all consumers release the clock, to avoid invoking
>>>> callbacks from the module which just got removed.
>>
>> This patch is now in Mike's clk-next and hence next-20131031, and causes
>> both a WARN and an OOPS when booting the Tegra Dalmore board. (See log
>> below)
>>
>> If I do the following to fix some other issues:
>>
>> 1) Apply:
>> http://www.spinics.net/lists/arm-kernel/msg283619.html
>> clk: fix boot panic with non-dev-associated clocks
>>
>> 2) Merge some Tegra-specific bug-fixes:
>> https://lkml.org/lkml/2013/10/29/771
>> Re: pull request for Tegra clock rework and Tegra124 clock support
>>
>> ... then revert this patch a336ed7 "clk: Implement clk_unregister()",
>> everything works again.
> 
> Does it still crash when you apply this patch
> http://www.spinics.net/lists/arm-kernel/msg283550.html ?

Yes, that seems to work, thanks.
