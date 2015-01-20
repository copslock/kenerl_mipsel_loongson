Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Jan 2015 03:44:16 +0100 (CET)
Received: from mail-qc0-f171.google.com ([209.85.216.171]:48140 "EHLO
        mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011181AbbATCoPc0A0k (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Jan 2015 03:44:15 +0100
Received: by mail-qc0-f171.google.com with SMTP id s11so10070799qcv.2;
        Mon, 19 Jan 2015 18:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=b4oHcoVAqOtUTdXnwbVJBRm06cw7faWsHAFm0izyy4I=;
        b=Zw5DqicO6qugGXWRj6nmvaB+C4u4OqjeYw/bYcHRxPNcBoxeUb/AXvWe/sPNuLLG+l
         HnZMK9mzhjPpxtIhk/yRthC/phzxB118dxiz/QIi+GRbFIm+gShutZukERMNJuq+33ed
         f4NnZj8ci+93N2ItJOjX1N4KIFEFew8JCL/vre5VkX8+pk5GPDJ7YN38C/Xdb1/5+Cqq
         ofKyMTcslAZtXwG6Kf/vv37RlaHc5Zu7UrCLvjSW+5LVEvPThO5xj5OLI7Htknln+AbT
         GE/WLFfYIBmwcVnx2nNyCoPjL9J+O3fIryIGnVeJ0igt8I76DiSMLO9OgyNfXI25L8YF
         3i/w==
X-Received: by 10.140.89.177 with SMTP id v46mr23079926qgd.58.1421721849840;
 Mon, 19 Jan 2015 18:44:09 -0800 (PST)
MIME-Version: 1.0
Received: by 10.229.188.138 with HTTP; Mon, 19 Jan 2015 18:43:49 -0800 (PST)
In-Reply-To: <54BDA7A6.1040506@gentoo.org>
References: <54BC5E43.8060606@gentoo.org> <CAEdQ38H=bHCYm21LrA=EoENRj8jwKU2jk3u36s+hqfzU0VYQSQ@mail.gmail.com>
 <54BDA7A6.1040506@gentoo.org>
From:   Matt Turner <mattst88@gmail.com>
Date:   Mon, 19 Jan 2015 18:43:49 -0800
Message-ID: <CAEdQ38HrwAWmPEFd6V+yxL5pMV-0Wa24Ly_bDPM6qbQD=i5jOQ@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Add R16000 detection
To:     Joshua Kinard <kumba@gentoo.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <mattst88@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45347
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mattst88@gmail.com
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

On Mon, Jan 19, 2015 at 4:56 PM, Joshua Kinard <kumba@gentoo.org> wrote:
> On 01/19/2015 14:34, Matt Turner wrote:
>> On Sun, Jan 18, 2015 at 5:30 PM, Joshua Kinard <kumba@gentoo.org> wrote:
>>> diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
>>> index 5342674..3f334a8 100644
>>> --- a/arch/mips/kernel/cpu-probe.c
>>> +++ b/arch/mips/kernel/cpu-probe.c
>>> @@ -833,8 +833,13 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
>>>                 c->tlbsize = 64;
>>>                 break;
>>>         case PRID_IMP_R14000:
>>> -               c->cputype = CPU_R14000;
>>> -               __cpu_name[cpu] = "R14000";
>>> +               if (((c->processor_id >> 4) & 0x0f) > 2) {
>>> +                       c->cputype = CPU_R16000;
>>> +                       __cpu_name[cpu] = "R16000";
>>> +               } else {
>>> +                       c->cputype = CPU_R14000;
>>> +                       __cpu_name[cpu] = "R14000";
>>> +               }
>>
>> It looks like this is the only hunk that has a functional change, and
>> that is simply setting __cpu_name[cpu] to "R16000"
>>
>> You can do that without adding CPU_R16000 to the enumeration. I don't
>> see that adding it accomplishes anything.
>>
>
> It mirrors what CPU_R14000 and CPU_R12000 do.  I won't rule out that, down the
> road, something about the R16K might be different enough from the R14K to
> require one of these other spots later on, so adding it now isn't going to
> adversely affect things.

That's justification for removing CPU_R14000 as well, not adding CPU_R16000.

Otherwise it's just adding useless code.
