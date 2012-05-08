Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 May 2012 06:01:28 +0200 (CEST)
Received: from relmlor2.renesas.com ([210.160.252.172]:37448 "EHLO
        relmlor2.renesas.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903617Ab2EHEBK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 May 2012 06:01:10 +0200
Received: from relmlir1.idc.renesas.com ([10.200.68.151])
 by relmlor2.idc.renesas.com ( SJSMS)
 with ESMTP id <0M3O0019MR5T5MA0@relmlor2.idc.renesas.com>; Tue,
 08 May 2012 13:01:05 +0900 (JST)
Received: from relmlac1.idc.renesas.com ([10.200.69.21])
 by relmlir1.idc.renesas.com (SJSMS)
 with ESMTP id <0M3O00KM7R5TOW60@relmlir1.idc.renesas.com>; Tue,
 08 May 2012 13:01:05 +0900 (JST)
Received: by relmlac1.idc.renesas.com (Postfix, from userid 0)
        id 7FDD78015D; Tue, 08 May 2012 13:01:05 +0900 (JST)
Received: from relmlac1.idc.renesas.com (localhost [127.0.0.1])
        by relmlac1.idc.renesas.com (Postfix) with ESMTP id 4408680193; Tue,
 08 May 2012 13:01:05 +0900 (JST)
Received: from relmlii2.idc.renesas.com [10.200.68.66]  by
 relmlac1.idc.renesas.com with ESMTP id PAB29899; Tue,
 08 May 2012 13:01:05 +0900
X-IronPort-AV: E=Sophos;i="4.75,547,1330873200";   d="scan'208";a="80159051"
Received: from unknown (HELO [10.161.69.127]) ([10.161.69.127])
 by relmlii2.idc.renesas.com with ESMTP; Tue, 08 May 2012 13:01:05 +0900
Message-id: <4FA89A80.6060407@renesas.com>
Date:   Tue, 08 May 2012 13:01:04 +0900
From:   Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:12.0) Gecko/20120428
 Thunderbird/12.0.1
MIME-version: 1.0
To:     sjhill@mips.com
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org, douglas@mips.com,
        chris@mips.com
Subject: Re: [PATCH 01/10] MIPS: Add core files for MIPS SEAD-3 development
 platform.
References: <1333817315-30091-1-git-send-email-sjhill@mips.com>
 <1333817315-30091-2-git-send-email-sjhill@mips.com>
 <4F8386C8.9020401@renesas.com>
 <31E06A9FC96CEC488B43B19E2957C1B8011469208F@exchdb03.mips.com>
In-reply-to: <31E06A9FC96CEC488B43B19E2957C1B8011469208F@exchdb03.mips.com>
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-archive-position: 33184
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: shinya.kuribayashi.px@renesas.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Hi Steven-san,

On 5/8/2012 5:16 AM, Hill, Steven wrote:
> I will certainly remove CONFIG_CPU_HAS_LLSC, thank you. I attempted to
> enable 'cpu_has_clo_clz' for SEAD-3, but it breaks my microMIPS-only
> kernel builds. Specifically, since microMIPS LL/SC instructions do
> not have 16-bit address offsets, in the '__cmpxchg_asm' macro function
> I get constraint errors because then the assembler has to use the %LO
> register in order to calculate the offset address. I am going to hold
> off on enabling the option until after the 3.5 release and then
> revisit for a solution. Thank you.

Got it, find no problems with your plan.  It seems there must be other
issues with optimization on microMIPS-only kernels :-)
-- 
Shinya Kuribayashi
Renesas Electronics
