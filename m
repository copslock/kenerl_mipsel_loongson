Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Jun 2010 19:33:23 +0200 (CEST)
Received: from gateway13.websitewelcome.com ([67.18.70.11]:59199 "HELO
        gateway13.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with SMTP id S1492167Ab0FKRdR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 11 Jun 2010 19:33:17 +0200
Received: (qmail 2586 invoked from network); 11 Jun 2010 17:38:15 -0000
Received: from gator750.hostgator.com (174.132.194.2)
  by gateway13.websitewelcome.com with SMTP; 11 Jun 2010 17:38:15 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=default; d=paralogos.com;
        h=Received:Message-ID:Date:From:User-Agent:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=Tko3fcN/8k9jKHRit1TKFtvgPSvWEIzcOmo7sQ6zl4j9omljALrutzoMN2D8auc8pZHIuV2MnP/Q9Ga6unCt6VERB+2T9u27Dgc1+GDYNM6pAfFE9wGjPqy72iN82+cQ;
Received: from 216-239-45-4.google.com ([216.239.45.4]:19462 helo=epiktistes.mtv.corp.google.com)
        by gator750.hostgator.com with esmtpa (Exim 4.69)
        (envelope-from <kevink@paralogos.com>)
        id 1ON865-00072E-Pq; Fri, 11 Jun 2010 12:32:49 -0500
Message-ID: <4C127358.3030905@paralogos.com>
Date:   Fri, 11 Jun 2010 10:33:12 -0700
From:   "Kevin D. Kissell" <kevink@paralogos.com>
User-Agent: Thunderbird 2.0.0.24 (X11/20100317)
MIME-Version: 1.0
To:     David Daney <ddaney@caviumnetworks.com>
CC:     Manuel Lauss <manuel.lauss@googlemail.com>,
        Jabir M <Jabir_M@pmc-sierra.com>, linux-mips@linux-mips.org,
        ralf@linux-mips.org
Subject: Re: 
References: <BE430C874DBA6841A75E65151DCC6E1C0407668F@BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca> <AANLkTimHTt3jCTPrlIDAkdDc8WheBf7bdEThk3JO8yNO@mail.gmail.com> <4C126D2A.6040305@caviumnetworks.com>
In-Reply-To: <4C126D2A.6040305@caviumnetworks.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator750.hostgator.com
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - paralogos.com
X-archive-position: 27122
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@paralogos.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 8207

David Daney wrote:
> On 06/11/2010 07:32 AM, Manuel Lauss wrote:
>> Hi,
>>
>> On Fri, Jun 11, 2010 at 4:06 PM, Jabir M<Jabir_M@pmc-sierra.com>  wrote:
>>>     I am working on a FPU-less 34k MIPS platform with linux-2.6.24
>>> kernel. After running a Darwin media streaming server on the board
>>> for a while, my oprofile results shows high utilization on
>>> fpu_emulator_cop1Handler()&  r4k_wait().
>>>
>
> r4k_wait() is the idle task, so that indicates there is nothing to do 
> at those sample points.
Which suggests that the system is either waiting on I/O data, or 
crunching it using a lot of floating point computation.  Normally, a 
high level of idle would indicate that the system is easily keeping up 
with the data stream, but if you're running the 34K as one of the 
available flavors of virtual SMP, you may be seeing a lot of wait loop 
samples because there's only one runnable thread in the job mix.
>
>
>>> wiki page http://www.linux-mips.org/wiki/Floating_point says gcc will
>>> use hard float as default and soft float is best suited model for a
>>> fpu less processor.  Could anyone kindly help me in understanding use
>>> of -msoft-float .
>>> Whether I need to compile
>>>
>>> 1. kernel with -msoft-float ? or
>
> The kernel doesn't use floating point.  So it doesn't matter.
It makes no sense to build the kernel -msoft-float, but it should be 
noted that there are a couple potential places (e.g. ptrace /proc) where 
the difference in user-mode floating point argument passing ABIs is 
kernel-visible.
>
>
>>> 2. Glibc ? or
>>> 3. Application ? or
>>> 4. All the above ?
>>
>
> If you don't want to use the kernel's FP emulator, you need 2 and 3.
>
>
>> I have fought with this in the past; what you need to do is:
>> - build gcc with softfloat support (mipsel-softfloat-linux-gnu triplet
>> for example),
>> - build a libc with this new compiler,
>> - then rebuild all libraries and apps with you new softfloat toolchain.
Let me be a bit more clear on this.  Because of the ABI difference, you 
need to either rebuild your application as a static binary, with the 
main program and *all* constituent libraries likewise rebuilt with 
softfloat, or, if you absolutely need it to be dynamically linked, you 
need to rebuild the shared libraries and *all* programs that might use 
them, which means essentailly a full userland rebuild.

An optimized, assembly-language soft-float library implementation is 
*much* faster than the kernel emulator, but I benchmarked it once upon a 
time against a portable gnu soft-float library in C, and the difference 
wasn't nearly as dramatic.

          Regards,

          Kevin K.
