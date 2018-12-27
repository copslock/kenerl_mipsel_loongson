Return-Path: <SRS0=uIlq=PE=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB2CC43387
	for <linux-mips@archiver.kernel.org>; Thu, 27 Dec 2018 12:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 904C2214AE
	for <linux-mips@archiver.kernel.org>; Thu, 27 Dec 2018 12:39:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727204AbeL0Mja (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Thu, 27 Dec 2018 07:39:30 -0500
Received: from mx1.mailbox.org ([80.241.60.212]:41300 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727093AbeL0Mj3 (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Thu, 27 Dec 2018 07:39:29 -0500
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id BD1F34C3BB;
        Thu, 27 Dec 2018 13:39:26 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter01.heinlein-hosting.de (spamfilter01.heinlein-hosting.de [80.241.56.115]) (amavisd-new, port 10030)
        with ESMTP id fXC9RiQMfaIe; Thu, 27 Dec 2018 13:39:25 +0100 (CET)
Subject: Re: [PATCH] MIPS: Add CPU option reporting to /proc/cpuinfo
To:     Kevin 'ldir' Darbyshire-Bryant <ldir@darbyshire-bryant.me.uk>
Cc:     "paul.burton@mips.com" <paul.burton@mips.com>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "jonas.gorski@gmail.com" <jonas.gorski@gmail.com>
References: <20181223225224.23042-1-hauke@hauke-m.de>
 <81623E5E-FAB2-4C91-B7F9-8C5BB8422D5C@darbyshire-bryant.me.uk>
 <89c9e62d-850c-2c78-3d09-269ce0c619a1@hauke-m.de>
 <4088FEE6-B2A4-49CE-8816-1A33D5443E21@darbyshire-bryant.me.uk>
 <FA3C385D-0FE2-4462-A7CA-89D984BBB234@darbyshire-bryant.me.uk>
From:   Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <23a09eea-2836-a07d-4a10-c87f170a94fb@hauke-m.de>
Date:   Thu, 27 Dec 2018 13:39:09 +0100
MIME-Version: 1.0
In-Reply-To: <FA3C385D-0FE2-4462-A7CA-89D984BBB234@darbyshire-bryant.me.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On 12/25/18 10:35 PM, Kevin 'ldir' Darbyshire-Bryant wrote:
> 
> 
>> On 24 Dec 2018, at 14:43, Kevin 'ldir' Darbyshire-Bryant <ldir@darbyshire-bryant.me.uk> wrote:
>>
>>
>>
>>> On 24 Dec 2018, at 13:42, Hauke Mehrtens <hauke@hauke-m.de> wrote:
>>>
>> <snip>
>>> Hi Kevin,
>>>
>>> Normally you should not deactivate any features in cpu-feature-overrides.h which are supported by the CPU, when you do not define any thing the kernel will use auto detection.
>>>
>>> I think we should use the cpu_has_foo features as these are the features which could be used by user space applications, if it is only accidentally deactivated by the kernel, which should not happen, it could be that this feature is not fully set up by the kernel and will not work.
>>>
>>> Hauke
>>
>> Fair enough.
> 
> Tried your patch and discovered you need to wrap the cpu_has_mipsmt_pertccounters:
> 
> +#ifdef CONFIG_MIPS_PERF_SHARED_TC_COUNTERS
> +      if (cpu_has_mipsmt_pertccounters)
> +              seq_printf(m, "%s", " mipsmt_pertccounters");
> +#endif
> 
> otherwise when building for archer c7 v2 (74kc) in openwrt this happens:
> 
> arch/mips/kernel/proc.c: In function 'show_cpuinfo':
> arch/mips/kernel/proc.c:245:6: error: 'cpu_has_mipsmt_pertccounters' undeclared (first use in this function); did you mean 'can_use_mips_counter'?
>    if (cpu_has_mipsmt_pertccounters)
>        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>        can_use_mips_counter
> 
> 
> Cheers,
> 
> Kevin D-B
> 
> 012C ACB2 28C6 C53E 9775  9123 B3A2 389B 9DE2 334A
> 
Hi Kevin,

I do not see any condition based on CONFIG_MIPS_PERF_SHARED_TC_COUNTERS 
in arch/mips/include/asm/cpu-features.h, which kernel version did you 
use to test this patch? cpu_has_mipsmt_pertccounters was introduced 
between kernel 4.14 and 4.19, so it is not available in older kernel 
versions.

Hauke
