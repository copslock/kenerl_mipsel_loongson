Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Sep 2011 22:44:17 +0200 (CEST)
Received: from mail-gy0-f177.google.com ([209.85.160.177]:35214 "EHLO
        mail-gy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491847Ab1IXUoK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 24 Sep 2011 22:44:10 +0200
Received: by gyg13 with SMTP id 13so4022646gyg.36
        for <multiple recipients>; Sat, 24 Sep 2011 13:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=vW0ZMwUv0bT+TT0015h5EbxHhdfV6n1x05DRA6jV1ss=;
        b=SUA5ii+yuY81YPWDTeH9AsN5nRXu0OXV/xyqFCyu3fXRbBnu7nY96zfNc3glZLG8Mi
         5U+AuWaLQ0PDnahebO96135J9bk7c5q10Suwrz2pvbi7yhxNX2PKcCldi3a1YIKHfF0E
         9QkeJ3/+P/U8hG0NZONhM49iO/jOLTC4Yi/qI=
Received: by 10.68.29.138 with SMTP id k10mr18237756pbh.70.1316897043863;
        Sat, 24 Sep 2011 13:44:03 -0700 (PDT)
Received: from dd_xps.caveonetworks.com (adsl-68-122-40-123.dsl.pltn13.pacbell.net. [68.122.40.123])
        by mx.google.com with ESMTPS id 2sm37857039pbu.1.2011.09.24.13.44.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 24 Sep 2011 13:44:03 -0700 (PDT)
Message-ID: <4E7E4110.40603@gmail.com>
Date:   Sat, 24 Sep 2011 13:44:00 -0700
From:   David Daney <david.s.daney@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc13 Thunderbird/3.1.10
MIME-Version: 1.0
To:     Deng-Cheng Zhu <dengcheng.zhu@gmail.com>, ralf@linux-mips.org
CC:     David Daney <david.daney@cavium.com>, linux-mips@linux-mips.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@elte.hu>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Dezhong Diao <dediao@cisco.com>,
        Gabor Juhos <juhosg@openwrt.org>
Subject: Re: [PATCH v5 3/5] MIPS: perf: Reorganize contents of perf support
 files.
References: <1316712378-7282-1-git-send-email-david.daney@cavium.com>        <1316712378-7282-4-git-send-email-david.daney@cavium.com> <CAOfQC98+G6Ar8RAT8697GS3MMhEQH86WSyrGjPAo4ELMCWzJHw@mail.gmail.com>
In-Reply-To: <CAOfQC98+G6Ar8RAT8697GS3MMhEQH86WSyrGjPAo4ELMCWzJHw@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 31153
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.s.daney@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 13922

On 09/23/2011 07:50 PM, Deng-Cheng Zhu wrote:
> 2011/9/23 David Daney<david.daney@cavium.com>
>> The contents of arch/mips/kernel/perf_event.c and
>> arch/mips/kernel/perf_event_mipsxx.c were divided in a seemingly ad
>> hoc manner, with the first including the second.
>>
>> I moved all the hardware counter support code to perf_event_mipsxx.c
>> and removed the gating #ifdefs to the Kconfig and Makefile.
>>
>> Now perf_event.c contains only the callchain support, everything else
>> is in perf_event_mipsxx.c
>>
> Sorry for my late comment. I personally don't think it's a bad idea to
> use the original gating #ifdefs, because it allows sharing common code
> among different types of MIPS PMUs. Also, using CPU types as compiling
> conditions seems make sense. If you move the common hunk to
> perf_event_mipsxx.c, other CPUs like loognson series will have to duplicate
> these stuff.
>

I disagree, and here is why:

Almost all the the code is mipsxx specific.

If Loongson has a PMU that can reuse this code, it can just be added to 
perf_event_mipsxx.c along with all the other mips compatible PMUs

If this is not feasible, then it can have its own file and and common 
code can be removed to a common place at that time.

In any event, I have not seen any Loongson PMU patches, if someone has 
such patches I would be happy to consider changes that would make the 
kernel as a whole cleaner.  But preventing cleanup and removal of a ton 
of #ifdefery in hope that Loongson patches may someday want something 
different is not what I would call a good way forward.

David Daney




> Deng-Cheng
>
