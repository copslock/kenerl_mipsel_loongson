Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 20 Dec 2014 01:49:39 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:13090 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009080AbaLTAth13LeN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 20 Dec 2014 01:49:37 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id BE7C0AE0810A7;
        Sat, 20 Dec 2014 00:49:27 +0000 (GMT)
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Sat, 20 Dec
 2014 00:49:31 +0000
Received: from [192.168.65.146] (192.168.65.146) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Fri, 19 Dec
 2014 16:49:29 -0800
Message-ID: <5494C798.60706@imgtec.com>
Date:   Fri, 19 Dec 2014 16:49:28 -0800
From:   Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     David Daney <ddaney.cavm@gmail.com>, <linux-mips@linux-mips.org>,
        <ralf@linux-mips.org>
Subject: Re: [PATCH 0/2] Revert broken C0_Pagegrain[PG_IEC] support.
References: <1419035585-21671-1-git-send-email-ddaney.cavm@gmail.com> <5494C639.8050808@imgtec.com>
In-Reply-To: <5494C639.8050808@imgtec.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.65.146]
Return-Path: <Leonid.Yegoshin@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44854
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Leonid.Yegoshin@imgtec.com
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

On 12/19/2014 04:43 PM, Leonid Yegoshin wrote:
> On 12/19/2014 04:33 PM, David Daney wrote:
>> From: David Daney <david.daney@cavium.com>
>>
>> The two patches reverted here break eXecute-Inhibit (XI) memory
>> protection support.  Before the patches we get SIGSEGV when attempting
>> to execute in non-executable memory, after the patches we loop forever
>> in handle_tlbl.
>>
>> It is probably possible to make C0_Pagegrain[PG_IEC] work, but I think
>> the most prudent thing is to revert these patches, and then only reapply
>> something that works after it has been well tested.
>>
>> David Daney (2):
>>    Revert "MIPS: Use dedicated exception handler if CPU supports RI/XI
>>      exceptions"
>>    Revert "MIPS: kernel: cpu-probe: Detect unique RI/XI exceptions"
>>
>>   arch/mips/include/asm/mipsregs.h | 1 -
>>   arch/mips/kernel/cpu-probe.c     | 9 ---------
>>   arch/mips/kernel/traps.c         | 7 -------
>>   arch/mips/mm/tlbex.c             | 4 ++--
>>   4 files changed, 2 insertions(+), 19 deletions(-)
>>
> Well, it may be have sense just to fix tlb_init() instead.

diff --git a/arch/mips/mm/tlb-r4k.c b/arch/mips/mm/tlb-r4k.c
index aa6e4b3b2fe2..ed18efd9374b 100644
--- a/arch/mips/mm/tlb-r4k.c
+++ b/arch/mips/mm/tlb-r4k.c
@@ -602,7 +602,7 @@ void __cpuinit tlb_init(void)
  #ifdef CONFIG_64BIT
                 pg |= PG_ELPA;
  #endif
-               write_c0_pagegrain(pg);
+               write_c0_pagegrain(pg | read_c0_pagegrain());
         }
         mtc0_tlbw_hazard();
