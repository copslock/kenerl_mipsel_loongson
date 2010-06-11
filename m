Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Jun 2010 19:07:00 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:4341 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491165Ab0FKRGy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 11 Jun 2010 19:06:54 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4c126d3f0000>; Fri, 11 Jun 2010 10:07:11 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 11 Jun 2010 10:06:50 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 11 Jun 2010 10:06:50 -0700
Message-ID: <4C126D2A.6040305@caviumnetworks.com>
Date:   Fri, 11 Jun 2010 10:06:50 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100430 Fedora/3.0.4-2.fc12 Thunderbird/3.0.4
MIME-Version: 1.0
To:     Manuel Lauss <manuel.lauss@googlemail.com>
CC:     Jabir M <Jabir_M@pmc-sierra.com>, linux-mips@linux-mips.org,
        ralf@linux-mips.org
Subject: Re:
References: <BE430C874DBA6841A75E65151DCC6E1C0407668F@BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca> <AANLkTimHTt3jCTPrlIDAkdDc8WheBf7bdEThk3JO8yNO@mail.gmail.com>
In-Reply-To: <AANLkTimHTt3jCTPrlIDAkdDc8WheBf7bdEThk3JO8yNO@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Jun 2010 17:06:50.0370 (UTC) FILETIME=[7B942620:01CB0988]
X-archive-position: 27121
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 8198

On 06/11/2010 07:32 AM, Manuel Lauss wrote:
> Hi,
>
> On Fri, Jun 11, 2010 at 4:06 PM, Jabir M<Jabir_M@pmc-sierra.com>  wrote:
>>     I am working on a FPU-less 34k MIPS platform with linux-2.6.24
>> kernel. After running a Darwin media streaming server on the board
>> for a while, my oprofile results shows high utilization on
>> fpu_emulator_cop1Handler()&  r4k_wait().
>>

r4k_wait() is the idle task, so that indicates there is nothing to do at 
those sample points.

>> wiki page http://www.linux-mips.org/wiki/Floating_point says gcc will
>> use hard float as default and soft float is best suited model for a
>> fpu less processor.  Could anyone kindly help me in understanding use
>> of -msoft-float .
>> Whether I need to compile
>>
>> 1. kernel with -msoft-float ? or

The kernel doesn't use floating point.  So it doesn't matter.

>> 2. Glibc ? or
>> 3. Application ? or
>> 4. All the above ?
>

If you don't want to use the kernel's FP emulator, you need 2 and 3.


> I have fought with this in the past; what you need to do is:
> - build gcc with softfloat support (mipsel-softfloat-linux-gnu triplet
> for example),
> - build a libc with this new compiler,
> - then rebuild all libraries and apps with you new softfloat toolchain.
>
> <plug>
> I have a working softfloat environment for MIPS32 here at [1], it includes a
> complete c/c++ toolchain with gcc-4.4.3.   It's built for mips32r1, no idea if
> it is supposed to work with 34k cores.
> </plug>

34k is mips32r2, which will run r1 code with no problem.

>
> Best regards,
>          Manuel Lauss
>
> [1]  http://mlau.at/files/mips32-linux/
>
>
