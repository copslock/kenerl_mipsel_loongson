Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Oct 2013 00:12:07 +0200 (CEST)
Received: from mail-ob0-f181.google.com ([209.85.214.181]:42989 "EHLO
        mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817043Ab3JQWMBi5lsd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Oct 2013 00:12:01 +0200
Received: by mail-ob0-f181.google.com with SMTP id va2so2437895obc.40
        for <multiple recipients>; Thu, 17 Oct 2013 15:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=2+ExaK+1byTcB064SKVtuxfmRVmc90PuX2hBk4UtC6s=;
        b=tvtLcrNovLZc6TvNeTeY9+JAUwPC6Flvcqm5ajqMeMB5EmkR2ChBlWXiNgH8iaz1/j
         xdVFGnzogGDuzF9PgAQNqYm25Ily876zflu5CkTkJdh1H/gi97ceso+5n3i5e6QGSL1u
         EEQCWYxbBzkK6kbG8otSgbYrkUrCNY+48LyBuGxaSFX3D/IyMja2w4wlTaiPTScKFsBL
         kN12oKJY4cEOuH8iptTPsRw7kh30qWS0Cy9VS4RUArW41XX9hbRwLVaFK0VovXk0Mw3v
         yF7xjE2ONakoehgFR1ZEkhz5obPSDonqx/M/Xh8A7T2y6P/f14ypaVitd/9KzNQW0kBy
         Ggvg==
X-Received: by 10.182.104.36 with SMTP id gb4mr16421944obb.43.1382047915265;
        Thu, 17 Oct 2013 15:11:55 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id nw5sm79161777obc.9.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 17 Oct 2013 15:11:54 -0700 (PDT)
Message-ID: <526060A8.40105@gmail.com>
Date:   Thu, 17 Oct 2013 15:11:52 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
CC:     "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH 2/6] MIPS: APRP: Add VPE loader support for CMP platforms.
References: <1381976070-8413-1-git-send-email-Steven.Hill@imgtec.com> <1381976070-8413-3-git-send-email-Steven.Hill@imgtec.com> <526020F6.80704@gmail.com> <52605E11.2060404@imgtec.com>
In-Reply-To: <52605E11.2060404@imgtec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38371
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

On 10/17/2013 03:00 PM, Deng-Cheng Zhu wrote:
> On 10/17/2013 10:40 AM, David Daney wrote:
>> On 10/16/2013 07:14 PM, Steven J. Hill wrote:
>>> From: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
>>>
>>> This patch adds VPE loader support for platforms having a CMP.
>>>
>>> Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
>>> Signed-off-by: Steven J. Hill <Steven.Hill@imgtec.com>
>>> Reviewed-by: Qais Yousef <Qais.Yousef@imgtec.com>
>>> ---
>>>   arch/mips/kernel/Makefile  |    2 +-
>>>   arch/mips/kernel/vpe-cmp.c |  184
>>> ++++++++++++++++++++++++++++++++++++++++++++
>>>   arch/mips/kernel/vpe-mt.c  |    4 +
>>>   3 files changed, 189 insertions(+), 1 deletion(-)
>>>   create mode 100644 arch/mips/kernel/vpe-cmp.c
>>>
>>> diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
>>> index 51f9117..912eb64 100644
>>> --- a/arch/mips/kernel/Makefile
>>> +++ b/arch/mips/kernel/Makefile
>>> @@ -54,7 +54,7 @@ obj-$(CONFIG_MIPS_MT_SMP)    += smp-mt.o
>>>   obj-$(CONFIG_MIPS_CMP)        += smp-cmp.o
>>>   obj-$(CONFIG_CPU_MIPSR2)    += spram.o
>>>
>>> -obj-$(CONFIG_MIPS_VPE_LOADER)    += vpe.o vpe-mt.o
>>> +obj-$(CONFIG_MIPS_VPE_LOADER)    += vpe.o vpe-cmp.o vpe-mt.o
>>>   obj-$(CONFIG_MIPS_VPE_APSP_API) += rtlx.o
>>>
>>>   obj-$(CONFIG_I8259)        += i8259.o
>>> diff --git a/arch/mips/kernel/vpe-cmp.c b/arch/mips/kernel/vpe-cmp.c
>>> new file mode 100644
>>> index 0000000..a5628ca
>>> --- /dev/null
>>> +++ b/arch/mips/kernel/vpe-cmp.c
>>> @@ -0,0 +1,184 @@
>>> +/*
>>> + * This file is subject to the terms and conditions of the GNU
>>> General Public
>>> + * License.  See the file "COPYING" in the main directory of this
>>> archive
>>> + * for more details.
>>> + *
>>> + * Copyright (C) 2004, 2005 MIPS Technologies, Inc.  All rights
>>> reserved.
>>> + * Copyright (C) 2013 Imagination Technologies Ltd.
>>> + */
>>> +#ifdef CONFIG_MIPS_CMP
>>> +
>>
>> Get rid of all these #ifdef.
>>
>> Use Kconfig symbols in the makefile instead.
>>
>>
>
> Right. Splitting stuff into -cmp/-mt files is an effort to remove such
> kind of #ifdef. The example can be found in Makefile in the v4 of this
> patch set: http://patchwork.linux-mips.org/patch/5059/
>
>

OK, that patch you point to seems a little better, but there are still 
ifdefs in the Makefile.  You can create synthetic Kconfig variables so 
the makefile is cleaner, but I don't know if it is worth it in this case.

Why did we get this new patch that regresses?

David Daney
