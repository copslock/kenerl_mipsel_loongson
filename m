Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Oct 2013 00:01:06 +0200 (CEST)
Received: from multi.imgtec.com ([194.200.65.239]:17780 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6817043Ab3JQWBAtmr6O (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 18 Oct 2013 00:01:00 +0200
Message-ID: <52605E11.2060404@imgtec.com>
Date:   Thu, 17 Oct 2013 15:00:49 -0700
From:   Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.0
MIME-Version: 1.0
To:     David Daney <ddaney.cavm@gmail.com>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>
CC:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>
Subject: Re: [PATCH 2/6] MIPS: APRP: Add VPE loader support for CMP platforms.
References: <1381976070-8413-1-git-send-email-Steven.Hill@imgtec.com> <1381976070-8413-3-git-send-email-Steven.Hill@imgtec.com> <526020F6.80704@gmail.com>
In-Reply-To: <526020F6.80704@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.136.61]
X-SEF-Processed: 7_3_0_01192__2013_10_17_23_00_55
Return-Path: <DengCheng.Zhu@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38370
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@imgtec.com
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

On 10/17/2013 10:40 AM, David Daney wrote:
> On 10/16/2013 07:14 PM, Steven J. Hill wrote:
>> From: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
>>
>> This patch adds VPE loader support for platforms having a CMP.
>>
>> Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
>> Signed-off-by: Steven J. Hill <Steven.Hill@imgtec.com>
>> Reviewed-by: Qais Yousef <Qais.Yousef@imgtec.com>
>> ---
>>   arch/mips/kernel/Makefile  |    2 +-
>>   arch/mips/kernel/vpe-cmp.c |  184 
>> ++++++++++++++++++++++++++++++++++++++++++++
>>   arch/mips/kernel/vpe-mt.c  |    4 +
>>   3 files changed, 189 insertions(+), 1 deletion(-)
>>   create mode 100644 arch/mips/kernel/vpe-cmp.c
>>
>> diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
>> index 51f9117..912eb64 100644
>> --- a/arch/mips/kernel/Makefile
>> +++ b/arch/mips/kernel/Makefile
>> @@ -54,7 +54,7 @@ obj-$(CONFIG_MIPS_MT_SMP)    += smp-mt.o
>>   obj-$(CONFIG_MIPS_CMP)        += smp-cmp.o
>>   obj-$(CONFIG_CPU_MIPSR2)    += spram.o
>>
>> -obj-$(CONFIG_MIPS_VPE_LOADER)    += vpe.o vpe-mt.o
>> +obj-$(CONFIG_MIPS_VPE_LOADER)    += vpe.o vpe-cmp.o vpe-mt.o
>>   obj-$(CONFIG_MIPS_VPE_APSP_API) += rtlx.o
>>
>>   obj-$(CONFIG_I8259)        += i8259.o
>> diff --git a/arch/mips/kernel/vpe-cmp.c b/arch/mips/kernel/vpe-cmp.c
>> new file mode 100644
>> index 0000000..a5628ca
>> --- /dev/null
>> +++ b/arch/mips/kernel/vpe-cmp.c
>> @@ -0,0 +1,184 @@
>> +/*
>> + * This file is subject to the terms and conditions of the GNU General 
>> Public
>> + * License.  See the file "COPYING" in the main directory of this archive
>> + * for more details.
>> + *
>> + * Copyright (C) 2004, 2005 MIPS Technologies, Inc.  All rights reserved.
>> + * Copyright (C) 2013 Imagination Technologies Ltd.
>> + */
>> +#ifdef CONFIG_MIPS_CMP
>> +
>
> Get rid of all these #ifdef.
>
> Use Kconfig symbols in the makefile instead.
>
>

Right. Splitting stuff into -cmp/-mt files is an effort to remove such kind 
of #ifdef. The example can be found in Makefile in the v4 of this patch 
set: http://patchwork.linux-mips.org/patch/5059/


Deng-Cheng
