Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Oct 2014 14:22:59 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:44242 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012205AbaJWMW5PIbN6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 Oct 2014 14:22:57 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id C71B6EF26ADF3
        for <linux-mips@linux-mips.org>; Thu, 23 Oct 2014 13:22:47 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 23 Oct 2014 13:22:49 +0100
Received: from [192.168.154.142] (192.168.154.142) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.195.1; Thu, 23 Oct
 2014 13:22:49 +0100
Message-ID: <5448F319.50503@imgtec.com>
Date:   Thu, 23 Oct 2014 13:22:49 +0100
From:   Markos Chandras <Markos.Chandras@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     <linux-mips@linux-mips.org>
Subject: Re: [RFC PATCH v3] MIPS: fix build with binutils 2.24.51+
References: <1413022164-317664-1-git-send-email-manuel.lauss@gmail.com> <5448ED4E.7040507@imgtec.com>
In-Reply-To: <5448ED4E.7040507@imgtec.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.142]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43532
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Markos.Chandras@imgtec.com
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

On 10/23/2014 12:58 PM, Markos Chandras wrote:
> On 10/11/2014 11:09 AM, Manuel Lauss wrote:
>> Starting with version 2.24.51.20140728 MIPS binutils complain loudly
>> about mixing soft-float and hard-float object files, leading to this
>> build failure since GCC is invoked with "-msoft-float" on MIPS:
>>
>> {standard input}: Warning: .gnu_attribute 4,3 requires `softfloat'
>>   LD      arch/mips/alchemy/common/built-in.o
>> mipsel-softfloat-linux-gnu-ld: Warning: arch/mips/alchemy/common/built-in.o
>>  uses -msoft-float (set by arch/mips/alchemy/common/prom.o),
>>  arch/mips/alchemy/common/sleeper.o uses -mhard-float
>>
>> To fix this, we detect if GAS is new enough to support "-msoft-float" command
>> option, and if it does, we can let GCC pass it to GAS;  but then we also need
>> to sprinkle the files which make use of floating point registers with the
>> necessary ".set hardfloat" directives.
>>
>> Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
>> ---
>> I've only tested a mips32r1 build, but at least binutils-2.23 and a
>> snapshot from today (with the MIPS fp changes) compile a bootable
>> kernel.
>>
>> Tests on 64bit and with MSA and other extensions also appreciated!
>>
>> v3: incorporate Maciej's suggestions:
>> 	- detect if gas can handle -msoft-float and ".set hardfloat"
>> 	- apply .set hardfloat only where really necessary
>>
>> v2: cover more files
>>
>> This was introduced in binutils commit  351cdf24d223290b15fa991e5052ec9e9bd1e284
>> ("[MIPS] Implement O32 FPXX, FP64 and FP64A ABI extensions").
>>
>>  arch/mips/Makefile                  |  9 +++++++++
>>  arch/mips/include/asm/asmmacro-32.h |  5 +++++
>>  arch/mips/include/asm/asmmacro.h    | 18 ++++++++++++++++++
>>  arch/mips/include/asm/fpregdef.h    | 14 ++++++++++++++
>>  arch/mips/include/asm/mipsregs.h    | 19 +++++++++++++++++++
>>  arch/mips/kernel/genex.S            |  1 +
>>  arch/mips/kernel/r2300_switch.S     |  5 +++++
>>  arch/mips/kernel/r4k_fpu.S          |  7 +++++++
>>  arch/mips/kernel/r4k_switch.S       |  9 +++++++++
>>  arch/mips/kernel/r6000_fpu.S        |  5 +++++
>>  10 files changed, 92 insertions(+)
>>
> Hi,
> 
> I applied this patch but it still does not build for me on a
> malta_defconfig:
> 
> arch/mips/kernel/r4k_fpu.S: Assembler messages:
> arch/mips/kernel/r4k_fpu.S:52: Error: float register should be even, was 1
> arch/mips/kernel/r4k_fpu.S:53: Error: float register should be even, was 3
> arch/mips/kernel/r4k_fpu.S:54: Error: float register should be even, was 5
> arch/mips/kernel/r4k_fpu.S:55: Error: float register should be even, was 7
> ...
> 
> The error is different this time so we probably need a follow-up patch
>

I also get a problem with an older version of binutils (the one from the
latest Sourcery CodeBench toolchain[1])

{standard input}: Assembler messages:
{standard input}:406: Error: opcode not supported on this processor:
mips1 (mips1) `cfc1 $9,$31'
scripts/Makefile.build:257: recipe for target
'arch/mips/kernel/branch.o' failed
make[2]: *** [arch/mips/kernel/branch.o] Error 1

[1] https://sourcery.mentor.com/GNUToolchain/release2791

-- 
markos
