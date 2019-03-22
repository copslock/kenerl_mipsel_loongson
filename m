Return-Path: <SRS0=ULQD=RZ=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 712EEC43381
	for <linux-mips@archiver.kernel.org>; Fri, 22 Mar 2019 05:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38FF02075D
	for <linux-mips@archiver.kernel.org>; Fri, 22 Mar 2019 05:22:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbfCVFWu (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 22 Mar 2019 01:22:50 -0400
Received: from mx.sdf.org ([205.166.94.20]:50673 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725938AbfCVFWt (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Fri, 22 Mar 2019 01:22:49 -0400
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id x2M5Mjw1029828
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits) verified NO);
        Fri, 22 Mar 2019 05:22:46 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id x2M5MjTm026260;
        Fri, 22 Mar 2019 05:22:45 GMT
Date:   Fri, 22 Mar 2019 05:22:45 GMT
From:   George Spelvin <lkml@sdf.org>
Message-Id: <201903220522.x2M5MjTm026260@sdf.org>
To:     lkml@sdf.org, paul.burton@mips.com
Subject: Re: [PATCH] arch/mips/kvm/emulate.c: Don't waste /dev/random emulating TLBWR
Cc:     jhogan@kernel.org, linux-mips@vger.kernel.org
In-Reply-To: <20190322000043.krzxo7coqibbxi6c@pburton-laptop>
References: <201903210604.x2L64Ord018045@sdf.org>,
    <20190322000043.krzxo7coqibbxi6c@pburton-laptop>
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On Fri, 22 Mar 2019 at 00:00:45 +0000, Paul Burton wrote:
> On Thu, Mar 21, 2019 at 06:04:24AM +0000, George Spelvin wrote:
>> KVM_MIPS_GUEST_TLB_SIZE is 64, so we only need one random byte,
>> not 4.
>> 
>> A more complex question is whether we need crypto-grade random
>> numbers at all.  If safe, we could use prandom_u32().  If not,
>> we could seed a private PRNG and use prandom_u32_state().
>> 
>> Or could we just use asm("mfc0 %0, Random" : "=r" (index))?

> Thanks for the patch. I expect we should be fine with:
> 
>   index = prandom_u32_max(KVM_MIPS_GUEST_TLB_SIZE);
> 
> We certainly don't need crypto-grade randomness here. Using the cp0
> Random register would be an option for configurations prior to MIPSr6,
> where the Random register was deprecated & we shouldn't rely on its
> presence. So we could do:
> 
>   if (MIPS_ISA_REV < 6)
>     index = read_c0_random() % KVM_MIPS_GUEST_TLB_SIZE;
>   else
>     index = prandom_u32_max(KVM_MIPS_GUEST_TLB_SIZE);
> 
> Though whether that micro-optimization is worth the extra code is
> questionable.

I'm also not sure if you *want* to use the random register, because
that's a source of /dev/random entropy (arch/mips/include/asm/timex.h),
and maybe exposing it to VM guests would be a bad thing.

There's no need to get too fancy; prandom_u32_max is fine.  (And
gcc optimizes it to a shift if the argument is a compie-time power
of 2.)

Anyway, thank you for the response, and I'm assuming there's no need
for revised patch from me; as it's less work for you to write your own.
