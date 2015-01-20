Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Jan 2015 05:13:29 +0100 (CET)
Received: from resqmta-po-12v.sys.comcast.net ([96.114.154.171]:42210 "EHLO
        resqmta-po-12v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010140AbbATEN2ZiK2P (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Jan 2015 05:13:28 +0100
Received: from resomta-po-05v.sys.comcast.net ([96.114.154.229])
        by resqmta-po-12v.sys.comcast.net with comcast
        id i4D51p0084xDoy8014DNe5; Tue, 20 Jan 2015 04:13:22 +0000
Received: from [192.168.1.13] ([73.212.71.42])
        by resomta-po-05v.sys.comcast.net with comcast
        id i4DL1p0010uk1nt014DL4h; Tue, 20 Jan 2015 04:13:21 +0000
Message-ID: <54BDD5DA.6070405@gentoo.org>
Date:   Mon, 19 Jan 2015 23:13:14 -0500
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
MIME-Version: 1.0
To:     Matt Turner <mattst88@gmail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: Add R16000 detection
References: <54BC5E43.8060606@gentoo.org> <CAEdQ38H=bHCYm21LrA=EoENRj8jwKU2jk3u36s+hqfzU0VYQSQ@mail.gmail.com> <54BDA7A6.1040506@gentoo.org> <CAEdQ38HrwAWmPEFd6V+yxL5pMV-0Wa24Ly_bDPM6qbQD=i5jOQ@mail.gmail.com>
In-Reply-To: <CAEdQ38HrwAWmPEFd6V+yxL5pMV-0Wa24Ly_bDPM6qbQD=i5jOQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1421727202;
        bh=etCBFaB0czSv+qb1YwI3xxQ0kSM4quOJyEfxQFMnBVE=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=q4wPzaMXb6NbyI8QMgW7Kwe+lEyfrQRSFUTq773SP4vnhnrE9FFltCD6JaQAl9dIB
         IaTIQB1vj3qGDReZAos608Lah0ooLeQuceIsshSKq7XAzkLreY/LrKYL/gSeOhCZEn
         l2g3Kam5STgWSYqVBC1fKckFWp9pFS38XP6SQI/fA5RYxTJcCY4BuPqxO5JIzdju/3
         uDXhZw4xQRhzUXDkS1yNjnsX5hl8yt5q0dIpSPfZTinIHL1q46r403L2yQrz7pVBqO
         6yQD6aawqF01oYZBnSqX9HGGxgepOM6DgIN9ofgBDpYUjBsTVTdisYRJO+Bwlg5MPV
         MiDrzWT8C/zug==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45349
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

On 01/19/2015 21:43, Matt Turner wrote:
> On Mon, Jan 19, 2015 at 4:56 PM, Joshua Kinard <kumba@gentoo.org> wrote:
>> On 01/19/2015 14:34, Matt Turner wrote:
>>> On Sun, Jan 18, 2015 at 5:30 PM, Joshua Kinard <kumba@gentoo.org> wrote:
>>>> diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
>>>> index 5342674..3f334a8 100644
>>>> --- a/arch/mips/kernel/cpu-probe.c
>>>> +++ b/arch/mips/kernel/cpu-probe.c
>>>> @@ -833,8 +833,13 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
>>>>                 c->tlbsize = 64;
>>>>                 break;
>>>>         case PRID_IMP_R14000:
>>>> -               c->cputype = CPU_R14000;
>>>> -               __cpu_name[cpu] = "R14000";
>>>> +               if (((c->processor_id >> 4) & 0x0f) > 2) {
>>>> +                       c->cputype = CPU_R16000;
>>>> +                       __cpu_name[cpu] = "R16000";
>>>> +               } else {
>>>> +                       c->cputype = CPU_R14000;
>>>> +                       __cpu_name[cpu] = "R14000";
>>>> +               }
>>>
>>> It looks like this is the only hunk that has a functional change, and
>>> that is simply setting __cpu_name[cpu] to "R16000"
>>>
>>> You can do that without adding CPU_R16000 to the enumeration. I don't
>>> see that adding it accomplishes anything.
>>>
>>
>> It mirrors what CPU_R14000 and CPU_R12000 do.  I won't rule out that, down the
>> road, something about the R16K might be different enough from the R14K to
>> require one of these other spots later on, so adding it now isn't going to
>> adversely affect things.
> 
> That's justification for removing CPU_R14000 as well, not adding CPU_R16000.
> 
> Otherwise it's just adding useless code.

R14000 has a different CPU PRId than R12000 or R10000, so the code that sets
the icache/scache linesz wouldn't know to apply to R14K, including the writing
the the FrameMask register in CP0.  Octane and Origin2K/Onyx2 can both use
R14000 CPUs, so this is a bad suggestion, as removing R14000 detection would
render those systems inoperable with those CPUs.  I know, cause I'm the one
that actually sent the R14K patch in 9 years ago w/ commit 44d921b2 .

I'm also for reducing code and all, but this isn't the case in which to do it.
 You're quibbling over the addition of an one new enum item, one new if-else
statement, one extra logical-OR conditional to an existing if statement, and
nine new case statements, some of which only execute once during the CPU
probing portion of boot.

There are likely a lot of better places in the existing code that could use
some optimization or dead code removal.

--J
