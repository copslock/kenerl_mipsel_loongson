Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Oct 2013 00:55:12 +0200 (CEST)
Received: from mail-oa0-f53.google.com ([209.85.219.53]:47795 "EHLO
        mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823123Ab3JQWzHWGmS8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Oct 2013 00:55:07 +0200
Received: by mail-oa0-f53.google.com with SMTP id n12so794417oag.12
        for <multiple recipients>; Thu, 17 Oct 2013 15:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=GNaW7s8DipPhM3KFMKJ05IyI200a0wSq+t7nSFNrjzk=;
        b=Sc/gGyfUGRaTsdwXL67CiYSvkJUbBMbFyD8rQbwvHL59ZA0T+T/nW12n+lsGl0Q+ci
         +za2dIigFCT7/LBmuYN9KW4poVp9fOSbLNB2OiUdOro4gVJgpQoM2trmpbcfaeI7x6Xa
         dGrxWAjOEdFfYDBLfVSsPPMUNYXz8XJrfbyd3iP7gRNOWwkzR81S9NfS5RJ6XPMdfGRk
         7VLuTnxqXwSugpheKW+gN7718+1yNr9U7HtW5E0fUkKeKocncHCQ7ENoS5TrzxXfBtDF
         HWGxVARJYB8NXxwAo9YV7M+8ZQVr0FAAGmp87qKthOSUsEI2+4H7zqncRCSFv2bEY4Sy
         bcog==
X-Received: by 10.182.84.132 with SMTP id z4mr15930535oby.49.1382050500428;
        Thu, 17 Oct 2013 15:55:00 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id nw5sm79544554obc.9.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 17 Oct 2013 15:54:59 -0700 (PDT)
Message-ID: <52606AC1.10403@gmail.com>
Date:   Thu, 17 Oct 2013 15:54:57 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
CC:     "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH 2/6] MIPS: APRP: Add VPE loader support for CMP platforms.
References: <1381976070-8413-1-git-send-email-Steven.Hill@imgtec.com> <1381976070-8413-3-git-send-email-Steven.Hill@imgtec.com> <526020F6.80704@gmail.com> <52605E11.2060404@imgtec.com> <526060A8.40105@gmail.com> <526066F0.9090405@imgtec.com>
In-Reply-To: <526066F0.9090405@imgtec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38373
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 10/17/2013 03:38 PM, Deng-Cheng Zhu wrote:
> On 10/17/2013 03:11 PM, David Daney wrote:
>> On 10/17/2013 03:00 PM, Deng-Cheng Zhu wrote:
>>> On 10/17/2013 10:40 AM, David Daney wrote:
>>>> On 10/16/2013 07:14 PM, Steven J. Hill wrote:
>>>>> From: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
>>>>>
>>>>> This patch adds VPE loader support for platforms having a CMP.
>>>>>
>>>>> Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
>>>>> Signed-off-by: Steven J. Hill <Steven.Hill@imgtec.com>
>>>>> Reviewed-by: Qais Yousef <Qais.Yousef@imgtec.com>
>>>>> ---
>>>>>   arch/mips/kernel/Makefile  |    2 +-
>>>>>   arch/mips/kernel/vpe-cmp.c |  184
>>>>> ++++++++++++++++++++++++++++++++++++++++++++
>>>>>   arch/mips/kernel/vpe-mt.c  |    4 +
>>>>>   3 files changed, 189 insertions(+), 1 deletion(-)
>>>>>   create mode 100644 arch/mips/kernel/vpe-cmp.c
>>>>>
>>>>> diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
>>>>> index 51f9117..912eb64 100644
>>>>> --- a/arch/mips/kernel/Makefile
>>>>> +++ b/arch/mips/kernel/Makefile
>>>>> @@ -54,7 +54,7 @@ obj-$(CONFIG_MIPS_MT_SMP)    += smp-mt.o
>>>>>   obj-$(CONFIG_MIPS_CMP)        += smp-cmp.o
>>>>>   obj-$(CONFIG_CPU_MIPSR2)    += spram.o
>>>>>
>>>>> -obj-$(CONFIG_MIPS_VPE_LOADER)    += vpe.o vpe-mt.o
>>>>> +obj-$(CONFIG_MIPS_VPE_LOADER)    += vpe.o vpe-cmp.o vpe-mt.o
>>>>>   obj-$(CONFIG_MIPS_VPE_APSP_API) += rtlx.o
>>>>>
>>>>>   obj-$(CONFIG_I8259)        += i8259.o
>>>>> diff --git a/arch/mips/kernel/vpe-cmp.c b/arch/mips/kernel/vpe-cmp.c
>>>>> new file mode 100644
>>>>> index 0000000..a5628ca
>>>>> --- /dev/null
>>>>> +++ b/arch/mips/kernel/vpe-cmp.c
>>>>> @@ -0,0 +1,184 @@
>>>>> +/*
>>>>> + * This file is subject to the terms and conditions of the GNU
>>>>> General Public
>>>>> + * License.  See the file "COPYING" in the main directory of this
>>>>> archive
>>>>> + * for more details.
>>>>> + *
>>>>> + * Copyright (C) 2004, 2005 MIPS Technologies, Inc.  All rights
>>>>> reserved.
>>>>> + * Copyright (C) 2013 Imagination Technologies Ltd.
>>>>> + */
>>>>> +#ifdef CONFIG_MIPS_CMP
>>>>> +
>>>>
>>>> Get rid of all these #ifdef.
>>>>
>>>> Use Kconfig symbols in the makefile instead.
>>>>
>>>>
>>>
>>> Right. Splitting stuff into -cmp/-mt files is an effort to remove such
>>> kind of #ifdef. The example can be found in Makefile in the v4 of this
>>> patch set: http://patchwork.linux-mips.org/patch/5059/
>>>
>>>
>>
>> OK, that patch you point to seems a little better, but there are still
>> ifdefs in the Makefile.  You can create synthetic Kconfig variables so
>> the makefile is cleaner, but I don't know if it is worth it in this case.
>
> Hmm. That has pros and cons, IMO. So the Makefile will look like:
>
> obj-$(CONFIG_MIPS_VPE_LOADER_CMP)  += vpe.o vpe-cmp.o
> obj-$(CONFIG_MIPS_VPE_APSP_API_CMP) += rtlx.o rtlx-cmp.o
> obj-$(CONFIG_MIPS_VPE_LOADER_MT)  += vpe.o vpe-mt.o
> obj-$(CONFIG_MIPS_VPE_APSP_API_MT) += rtlx.o rtlx-mt.o
>
> It removes ifdef, but doesn't look straightforward to me: CMP and MT
> APRP are mutually exclusive.

It is not necessarily cleaner but you could have something like:
---------------------
config MIPS_VPE_LOADER_CMP
	bool
	default "y"
	depends on MIPS_VPE_LOADER && MIPS_CMP

config MIPS_VPE_LOADER_MT
	bool
	default "y"
	depends on MIPS_VPE_LOADER && !MIPS_CMP

----------
obj-$(CONFIG_MIPS_VPE_LOADER)	+= vpe.o
obj-$(CONFIG_MIPS_VPE_LOADER_CMP)	+= vpe-cmt.o
obj-$(CONFIG_MIPS_VPE_LOADER_MT)	+= vpe-mt.o


I would do either that, or what you have in 
http://patchwork.linux-mips.org/patch/5059/  either is acceptable I think.

My main objection was the thing about putting the #ifdefs around the 
entire body of the C files.

David Daney
