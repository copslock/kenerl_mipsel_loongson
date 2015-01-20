Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Jan 2015 06:33:03 +0100 (CET)
Received: from resqmta-po-07v.sys.comcast.net ([96.114.154.166]:34067 "EHLO
        resqmta-po-07v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006566AbbATFdCJ0Y-q (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Jan 2015 06:33:02 +0100
Received: from resomta-po-17v.sys.comcast.net ([96.114.154.241])
        by resqmta-po-07v.sys.comcast.net with comcast
        id i5YX1p0015Clt1L015Yvln; Tue, 20 Jan 2015 05:32:55 +0000
Received: from [192.168.1.13] ([73.212.71.42])
        by resomta-po-17v.sys.comcast.net with comcast
        id i5Yu1p00A0uk1nt015Yu6G; Tue, 20 Jan 2015 05:32:55 +0000
Message-ID: <54BDE881.3090907@gentoo.org>
Date:   Tue, 20 Jan 2015 00:32:49 -0500
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
MIME-Version: 1.0
To:     Matt Turner <mattst88@gmail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: Add R16000 detection
References: <54BC5E43.8060606@gentoo.org> <CAEdQ38H=bHCYm21LrA=EoENRj8jwKU2jk3u36s+hqfzU0VYQSQ@mail.gmail.com> <54BDA7A6.1040506@gentoo.org> <CAEdQ38HrwAWmPEFd6V+yxL5pMV-0Wa24Ly_bDPM6qbQD=i5jOQ@mail.gmail.com> <54BDD5DA.6070405@gentoo.org> <CAEdQ38GHvbbSF0k0mQTAjMd8hn0D0Bg0hE2LHptxpkQV_gohGQ@mail.gmail.com>
In-Reply-To: <CAEdQ38GHvbbSF0k0mQTAjMd8hn0D0Bg0hE2LHptxpkQV_gohGQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1421731975;
        bh=37nqaYUuPbIQEYrRsSndvF3YiF4d44x27PViohg+qLw=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=ieQj6wlYF94e6cVXCFq2hbzfsHRgEhWYtwyh38e8GHG+dmjy8SkB7VURJqtxCIbzu
         cnsXx9b6nKIu5hXfwyFH0H3Z/IF9AhymzhxPNEzt9tAXncRZEN187e93zbMUuGFBd1
         v93as8N7oRL36iGi5H8WLd0Oph6vLaphrVe5RHi0nN4QZu41moas43ZBEt+iURjVBW
         uh0nCk9zKpnAx6yn/6wMuCR9E8ElVgxhNMShUw8dNRhxjbBTSqlvUUz1ZG2rWbW2OY
         3EHqM1pC0qluMoMRm0lpqQnm1G1iuXgMgrRkia7KPyjD9lAm/igAKMzVz/yevGiaJF
         Th0rPUANZ/OYQ==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45351
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
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

On 01/20/2015 00:11, Matt Turner wrote:
> On Mon, Jan 19, 2015 at 8:13 PM, Joshua Kinard <kumba@gentoo.org> wrote:
>> On 01/19/2015 21:43, Matt Turner wrote:
>>> On Mon, Jan 19, 2015 at 4:56 PM, Joshua Kinard <kumba@gentoo.org> wrote:
>>>> On 01/19/2015 14:34, Matt Turner wrote:
>>>>> On Sun, Jan 18, 2015 at 5:30 PM, Joshua Kinard <kumba@gentoo.org> wrote:
>>>>>> diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
>>>>>> index 5342674..3f334a8 100644
>>>>>> --- a/arch/mips/kernel/cpu-probe.c
>>>>>> +++ b/arch/mips/kernel/cpu-probe.c
>>>>>> @@ -833,8 +833,13 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
>>>>>>                 c->tlbsize = 64;
>>>>>>                 break;
>>>>>>         case PRID_IMP_R14000:
>>>>>> -               c->cputype = CPU_R14000;
>>>>>> -               __cpu_name[cpu] = "R14000";
>>>>>> +               if (((c->processor_id >> 4) & 0x0f) > 2) {
>>>>>> +                       c->cputype = CPU_R16000;
>>>>>> +                       __cpu_name[cpu] = "R16000";
>>>>>> +               } else {
>>>>>> +                       c->cputype = CPU_R14000;
>>>>>> +                       __cpu_name[cpu] = "R14000";
>>>>>> +               }
>>>>>
>>>>> It looks like this is the only hunk that has a functional change, and
>>>>> that is simply setting __cpu_name[cpu] to "R16000"
>>>>>
>>>>> You can do that without adding CPU_R16000 to the enumeration. I don't
>>>>> see that adding it accomplishes anything.
>>>>>
>>>>
>>>> It mirrors what CPU_R14000 and CPU_R12000 do.  I won't rule out that, down the
>>>> road, something about the R16K might be different enough from the R14K to
>>>> require one of these other spots later on, so adding it now isn't going to
>>>> adversely affect things.
>>>
>>> That's justification for removing CPU_R14000 as well, not adding CPU_R16000.
>>>
>>> Otherwise it's just adding useless code.
>>
>> R14000 has a different CPU PRId than R12000 or R10000, so the code that sets
>> the icache/scache linesz wouldn't know to apply to R14K, including the writing
>> the the FrameMask register in CP0.  Octane and Origin2K/Onyx2 can both use
>> R14000 CPUs, so this is a bad suggestion, as removing R14000 detection would
>> render those systems inoperable with those CPUs.  I know, cause I'm the one
>> that actually sent the R14K patch in 9 years ago w/ commit 44d921b2 .
> 
> Sorry, you're not getting it.
> 
> git grep -B1 CPU_R14000
> 
> Notice how all of the instances of CPU_R14000 are preceded by
> CPU_R12000? That's because CPU_R14000 doesn't do anything differently.
> 
> All you should do to remove CPU_R14000 is to set c->cputype =
> CPU_R12000 in the PRID_IMP_R14000 case in cpu-probe.c.

I see what you're getting at, but I disagree with the reasoning.  The code
reads clearer when it's explicitly stated the way it is, rather than fudging
things and treating an R14K as an R12K for a minor gain of a few cycles.

And since I know there's something "weird" about the R14K right now, one of
those case statements might be needed down the road to do something a little
bit differently for R14K versus R12K and such (maybe in the TLB code, if I can
ever wrap my head around that).

In the end, it's Ralf's call on accepting it.
