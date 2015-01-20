Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Jan 2015 01:56:27 +0100 (CET)
Received: from resqmta-ch2-08v.sys.comcast.net ([69.252.207.40]:36645 "EHLO
        resqmta-ch2-08v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011719AbbATA4VQe4CT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Jan 2015 01:56:21 +0100
Received: from resomta-ch2-11v.sys.comcast.net ([69.252.207.107])
        by resqmta-ch2-08v.sys.comcast.net with comcast
        id i0vz1p0012Ka2Q5010wCoY; Tue, 20 Jan 2015 00:56:12 +0000
Received: from [192.168.1.13] ([73.212.71.42])
        by resomta-ch2-11v.sys.comcast.net with comcast
        id i0wB1p00P0uk1nt010wBY3; Tue, 20 Jan 2015 00:56:12 +0000
Message-ID: <54BDA7A6.1040506@gentoo.org>
Date:   Mon, 19 Jan 2015 19:56:06 -0500
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
MIME-Version: 1.0
To:     Matt Turner <mattst88@gmail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: Add R16000 detection
References: <54BC5E43.8060606@gentoo.org> <CAEdQ38H=bHCYm21LrA=EoENRj8jwKU2jk3u36s+hqfzU0VYQSQ@mail.gmail.com>
In-Reply-To: <CAEdQ38H=bHCYm21LrA=EoENRj8jwKU2jk3u36s+hqfzU0VYQSQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1421715372;
        bh=a/PxWz0qgtabpjy1J2fguDlUR1L4dyz7ypnhNt10+Q8=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=DJrvQjjjDoAH/9X5dVC4SgcIPsML8q+88GL712g0lmgv1KJqKMEMgiUXuIm4rGLeJ
         xiQoxzQp5unoepIsPjw0oajYnNrRkktOyBx0QZXyiEv3Pg2/zO4k5ZPj3XozFoEJ7D
         rPHlO/KyuFwM1/7M6qYS8AT+yjB4tHVmlnZUmaOJkZDXFGImRCtY+hB3AReD5+apCF
         lRb0zHicxewaTGKlN9RIvZxMcpnYpPc0DznRB3xGKf8Jvw9LuVa4H9UgKnI3fhKxHN
         apYCTv7Y0nWcdUr4dbyf1tTjbspHVHhSB8XUp+1BwiZNVAvMPFrykZ+Fo5tnzZyu6o
         5xwIy3QqPqYDA==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45343
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

On 01/19/2015 14:34, Matt Turner wrote:
> On Sun, Jan 18, 2015 at 5:30 PM, Joshua Kinard <kumba@gentoo.org> wrote:
>> From: Joshua Kinard <kumba@gentoo.org>
>>
>> This allows the kernel to correctly detect an R16000 MIPS CPU on systems that
>> have those.  Otherwise, such systems will detect the CPU as an R14000, due to
>> similarities in the CPU PRId value.
>>
>> Signed-off-by: Joshua Kinard <kumba@gentoo.org>
>> ---
>>  arch/mips/include/asm/cpu-type.h     |    1 +
>>  arch/mips/include/asm/cpu.h          |    6 +++---
>>  arch/mips/kernel/cpu-probe.c         |    9 +++++++--
>>  arch/mips/kernel/perf_event_mipsxx.c |    1 +
>>  arch/mips/mm/c-r4k.c                 |    4 ++++
>>  arch/mips/mm/page.c                  |    1 +
>>  arch/mips/mm/tlb-r4k.c               |    3 ++-
>>  arch/mips/mm/tlbex.c                 |    1 +
>>  arch/mips/oprofile/common.c          |    1 +
>>  arch/mips/oprofile/op_model_mipsxx.c |    1 +
>>  10 files changed, 22 insertions(+), 6 deletions(-)
>>
>> linux-mips-add-r16000-detection.patch
>> diff --git a/arch/mips/include/asm/cpu-type.h b/arch/mips/include/asm/cpu-type.h
>> index b4e2bd8..d85fc26 100644
>> --- a/arch/mips/include/asm/cpu-type.h
>> +++ b/arch/mips/include/asm/cpu-type.h
>> @@ -150,6 +150,7 @@ static inline int __pure __get_cpu_type(const int cpu_type)
>>         case CPU_R10000:
>>         case CPU_R12000:
>>         case CPU_R14000:
>> +       case CPU_R16000:
>>  #endif
>>  #ifdef CONFIG_SYS_HAS_CPU_RM7000
>>         case CPU_RM7000:
>> diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
>> index 33866fc..53acfce 100644
>> --- a/arch/mips/include/asm/cpu.h
>> +++ b/arch/mips/include/asm/cpu.h
>> @@ -67,7 +67,7 @@
>>  #define PRID_IMP_R4300         0x0b00
>>  #define PRID_IMP_VR41XX                0x0c00
>>  #define PRID_IMP_R12000                0x0e00
>> -#define PRID_IMP_R14000                0x0f00
>> +#define PRID_IMP_R14000                0x0f00          /* R14K && R16K */
>>  #define PRID_IMP_R8000         0x1000
>>  #define PRID_IMP_PR4450                0x1200
>>  #define PRID_IMP_R4600         0x2000
>> @@ -283,8 +283,8 @@ enum cpu_type_enum {
>>         CPU_R4000PC, CPU_R4000SC, CPU_R4000MC, CPU_R4200, CPU_R4300, CPU_R4310,
>>         CPU_R4400PC, CPU_R4400SC, CPU_R4400MC, CPU_R4600, CPU_R4640, CPU_R4650,
>>         CPU_R4700, CPU_R5000, CPU_R5500, CPU_NEVADA, CPU_R5432, CPU_R10000,
>> -       CPU_R12000, CPU_R14000, CPU_VR41XX, CPU_VR4111, CPU_VR4121, CPU_VR4122,
>> -       CPU_VR4131, CPU_VR4133, CPU_VR4181, CPU_VR4181A, CPU_RM7000,
>> +       CPU_R12000, CPU_R14000, CPU_R16000, CPU_VR41XX, CPU_VR4111, CPU_VR4121,
>> +       CPU_VR4122, CPU_VR4131, CPU_VR4133, CPU_VR4181, CPU_VR4181A, CPU_RM7000,
>>         CPU_SR71000, CPU_TX49XX,
>>
>>         /*
>> diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
>> index 5342674..3f334a8 100644
>> --- a/arch/mips/kernel/cpu-probe.c
>> +++ b/arch/mips/kernel/cpu-probe.c
>> @@ -833,8 +833,13 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
>>                 c->tlbsize = 64;
>>                 break;
>>         case PRID_IMP_R14000:
>> -               c->cputype = CPU_R14000;
>> -               __cpu_name[cpu] = "R14000";
>> +               if (((c->processor_id >> 4) & 0x0f) > 2) {
>> +                       c->cputype = CPU_R16000;
>> +                       __cpu_name[cpu] = "R16000";
>> +               } else {
>> +                       c->cputype = CPU_R14000;
>> +                       __cpu_name[cpu] = "R14000";
>> +               }
> 
> It looks like this is the only hunk that has a functional change, and
> that is simply setting __cpu_name[cpu] to "R16000"
> 
> You can do that without adding CPU_R16000 to the enumeration. I don't
> see that adding it accomplishes anything.
> 

It mirrors what CPU_R14000 and CPU_R12000 do.  I won't rule out that, down the
road, something about the R16K might be different enough from the R14K to
require one of these other spots later on, so adding it now isn't going to
adversely affect things.  Only IP35 has R16K's anyways, which doesn't support
Linux just yet.  It's a "for the future" patch.  Last of the R-series anyways,
since the R18000 died before it ever became silicon.

--J
