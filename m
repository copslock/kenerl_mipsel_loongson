Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Jan 2015 06:12:03 +0100 (CET)
Received: from mail-qa0-f42.google.com ([209.85.216.42]:65411 "EHLO
        mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006533AbbATFMBZjDvt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Jan 2015 06:12:01 +0100
Received: by mail-qa0-f42.google.com with SMTP id dc16so26794469qab.1;
        Mon, 19 Jan 2015 21:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=L4cXpDV8VTsyENQr+MCm9GvJfkb4LDWVau33AvuNxBY=;
        b=slpRgqYo8+ghk+l254EShmSqkJEY/auR8/zDVoHPr2PgJv3hhGaifoBHJe1tpmeNnJ
         Ow4puSCzIL/+iFM8LGhK9YSX3RG5vB6nokP/S+Je3BcrcRiNv7v73Vfn3Pva5kEH90C2
         BoDGGsffdpr3u2y1ffAhPURw/R9GuBDH2IlzkHLQ0J4HYfoYNsFNyiaK3PABnM+2A5p0
         Nqpi1Um70Sqoreqe2AMcJiptzxy6R3Dkuu1OHu89qhB3d7JHQ13E3U5P0USWNhb7b4qa
         RW0i5nLLBYYkvuSdoky+ocvfKHFnsYEciurUNr+QR7BIcqUEfSwvITO7LDYv4Q9LMMas
         yiIQ==
X-Received: by 10.224.63.70 with SMTP id a6mr55759583qai.42.1421730715602;
 Mon, 19 Jan 2015 21:11:55 -0800 (PST)
MIME-Version: 1.0
Received: by 10.229.188.138 with HTTP; Mon, 19 Jan 2015 21:11:35 -0800 (PST)
In-Reply-To: <54BDD5DA.6070405@gentoo.org>
References: <54BC5E43.8060606@gentoo.org> <CAEdQ38H=bHCYm21LrA=EoENRj8jwKU2jk3u36s+hqfzU0VYQSQ@mail.gmail.com>
 <54BDA7A6.1040506@gentoo.org> <CAEdQ38HrwAWmPEFd6V+yxL5pMV-0Wa24Ly_bDPM6qbQD=i5jOQ@mail.gmail.com>
 <54BDD5DA.6070405@gentoo.org>
From:   Matt Turner <mattst88@gmail.com>
Date:   Mon, 19 Jan 2015 21:11:35 -0800
Message-ID: <CAEdQ38GHvbbSF0k0mQTAjMd8hn0D0Bg0hE2LHptxpkQV_gohGQ@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Add R16000 detection
To:     Joshua Kinard <kumba@gentoo.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <mattst88@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45350
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

On Mon, Jan 19, 2015 at 8:13 PM, Joshua Kinard <kumba@gentoo.org> wrote:
> On 01/19/2015 21:43, Matt Turner wrote:
>> On Mon, Jan 19, 2015 at 4:56 PM, Joshua Kinard <kumba@gentoo.org> wrote:
>>> On 01/19/2015 14:34, Matt Turner wrote:
>>>> On Sun, Jan 18, 2015 at 5:30 PM, Joshua Kinard <kumba@gentoo.org> wrote:
>>>>> diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
>>>>> index 5342674..3f334a8 100644
>>>>> --- a/arch/mips/kernel/cpu-probe.c
>>>>> +++ b/arch/mips/kernel/cpu-probe.c
>>>>> @@ -833,8 +833,13 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
>>>>>                 c->tlbsize = 64;
>>>>>                 break;
>>>>>         case PRID_IMP_R14000:
>>>>> -               c->cputype = CPU_R14000;
>>>>> -               __cpu_name[cpu] = "R14000";
>>>>> +               if (((c->processor_id >> 4) & 0x0f) > 2) {
>>>>> +                       c->cputype = CPU_R16000;
>>>>> +                       __cpu_name[cpu] = "R16000";
>>>>> +               } else {
>>>>> +                       c->cputype = CPU_R14000;
>>>>> +                       __cpu_name[cpu] = "R14000";
>>>>> +               }
>>>>
>>>> It looks like this is the only hunk that has a functional change, and
>>>> that is simply setting __cpu_name[cpu] to "R16000"
>>>>
>>>> You can do that without adding CPU_R16000 to the enumeration. I don't
>>>> see that adding it accomplishes anything.
>>>>
>>>
>>> It mirrors what CPU_R14000 and CPU_R12000 do.  I won't rule out that, down the
>>> road, something about the R16K might be different enough from the R14K to
>>> require one of these other spots later on, so adding it now isn't going to
>>> adversely affect things.
>>
>> That's justification for removing CPU_R14000 as well, not adding CPU_R16000.
>>
>> Otherwise it's just adding useless code.
>
> R14000 has a different CPU PRId than R12000 or R10000, so the code that sets
> the icache/scache linesz wouldn't know to apply to R14K, including the writing
> the the FrameMask register in CP0.  Octane and Origin2K/Onyx2 can both use
> R14000 CPUs, so this is a bad suggestion, as removing R14000 detection would
> render those systems inoperable with those CPUs.  I know, cause I'm the one
> that actually sent the R14K patch in 9 years ago w/ commit 44d921b2 .

Sorry, you're not getting it.

git grep -B1 CPU_R14000

Notice how all of the instances of CPU_R14000 are preceded by
CPU_R12000? That's because CPU_R14000 doesn't do anything differently.

All you should do to remove CPU_R14000 is to set c->cputype =
CPU_R12000 in the PRID_IMP_R14000 case in cpu-probe.c.
