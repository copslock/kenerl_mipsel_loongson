Return-Path: <SRS0=lXGt=PL=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6154FC43387
	for <linux-mips@archiver.kernel.org>; Thu,  3 Jan 2019 21:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3476520815
	for <linux-mips@archiver.kernel.org>; Thu,  3 Jan 2019 21:49:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfACVtw (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Thu, 3 Jan 2019 16:49:52 -0500
Received: from mx1.mailbox.org ([80.241.60.212]:27996 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726760AbfACVtw (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Thu, 3 Jan 2019 16:49:52 -0500
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id 1F2514AB01;
        Thu,  3 Jan 2019 22:49:50 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter02.heinlein-hosting.de (spamfilter02.heinlein-hosting.de [80.241.56.116]) (amavisd-new, port 10030)
        with ESMTP id tcxL-ECyg5lm; Thu,  3 Jan 2019 22:49:49 +0100 (CET)
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
 <23a09eea-2836-a07d-4a10-c87f170a94fb@hauke-m.de>
 <5B483FB8-8081-45E9-A082-FCA7F77EE06F@darbyshire-bryant.me.uk>
From:   Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <57008009-6432-7c83-b15b-aa9a9ae567c3@hauke-m.de>
Date:   Thu, 3 Jan 2019 22:49:47 +0100
MIME-Version: 1.0
In-Reply-To: <5B483FB8-8081-45E9-A082-FCA7F77EE06F@darbyshire-bryant.me.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On 12/27/18 2:08 PM, Kevin 'ldir' Darbyshire-Bryant wrote:
> 
> 
>> On 27 Dec 2018, at 12:39, Hauke Mehrtens <hauke@hauke-m.de> wrote:
>>
>>>
>> Hi Kevin,
>>
>> I do not see any condition based on CONFIG_MIPS_PERF_SHARED_TC_COUNTERS in arch/mips/include/asm/cpu-features.h, which kernel version did you use to test this patch? cpu_has_mipsmt_pertccounters was introduced between kernel 4.14 and 4.19, so it is not available in older kernel versions.
>>
>> Hauke
> 
> 
> This is 4.14.90 on openwrt…and I don’t think there are any sneaky backports involved in this area.
> 
> Take a look around line 131 of arch/mips/kernel/perf_event_mipsxx.c

Hi Kevin,

I assume you are talking about this:
https://elixir.bootlin.com/linux/v4.19.13/source/arch/mips/kernel/perf_event_mipsxx.c#L131

I still do not get why this is a problem.

If code wants to check if a feature is supported it includes 
"asm/cpu-features.h", this file then includes "cpu-feature-overrides.h".
For cpu-feature-overrides.h either the generic and empty version is 
provided or the SoC code has its own version with some SoC specific 
settings.

The asm/cpu-features.h file checks if the SoC code provided a special 
settings and if not it will add the code which will detect this feature 
dynamically, see here:
https://elixir.bootlin.com/linux/v4.19.13/source/arch/mips/include/asm/cpu-features.h#L577

This code should provide some settings independently of any Kconfig 
setting, for some Kconfig settings it is known that it is not active.

Hauke
