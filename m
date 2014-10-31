Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 31 Oct 2014 12:41:15 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:18773 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009840AbaJaLlNUvwCl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 31 Oct 2014 12:41:13 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 047A7EB8F9441;
        Fri, 31 Oct 2014 11:41:04 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 31 Oct 2014 11:41:06 +0000
Received: from [192.168.154.149] (192.168.154.149) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Fri, 31 Oct
 2014 11:41:05 +0000
Message-ID: <54537551.6080404@imgtec.com>
Date:   Fri, 31 Oct 2014 11:41:05 +0000
From:   Markos Chandras <Markos.Chandras@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     Manuel Lauss <manuel.lauss@gmail.com>,
        Linux-MIPS <linux-mips@linux-mips.org>
CC:     Matthew Fortune <Matthew.Fortune@imgtec.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [RFC PATCH v5] MIPS: fix build with binutils 2.24.51+
References: <1414700683-121426-1-git-send-email-manuel.lauss@gmail.com>
In-Reply-To: <1414700683-121426-1-git-send-email-manuel.lauss@gmail.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.149]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43803
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

On 10/30/2014 08:24 PM, Manuel Lauss wrote:
> Starting with version 2.24.51.20140728 MIPS binutils complain loudly
> about mixing soft-float and hard-float object files, leading to this
> build failure since GCC is invoked with "-msoft-float" on MIPS:
> 
> {standard input}: Warning: .gnu_attribute 4,3 requires `softfloat'
>   LD      arch/mips/alchemy/common/built-in.o
> mipsel-softfloat-linux-gnu-ld: Warning: arch/mips/alchemy/common/built-in.o
>  uses -msoft-float (set by arch/mips/alchemy/common/prom.o),
>  arch/mips/alchemy/common/sleeper.o uses -mhard-float
> 
> To fix this, we detect if GAS is new enough to support "-msoft-float" command
> option, and if it does, we can let GCC pass it to GAS;  but then we also need
> to sprinkle the files which make use of floating point registers with the
> necessary ".set hardfloat" directives.
> 
> Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
> ---
> Compiles with binutils 2.23 and current git head, 32bit mips32r1 tested only.
> 
> Tests on 64bit and with MSA and other extensions also appreciated!
> Markos: I can't reproduce the malta defconfig error you're seeing, at least
> not with sourceware sources.
> 
> v5: fixed issues with code for 32bit mips32r2 using .set mips64r2 outlined
>     by Matthew: what the code really wants is 64bit float support, but not
>     64bit mips code.
> 
> v4: fixed issues outlined by Markos and Matthew.
> 
> v3: incorporate Maciej's suggestions:
> 	- detect if gas can handle -msoft-float and ".set hardfloat"
> 	- apply .set hardfloat only where really necessary
> 
> v2: cover more files
> 
> This was introduced in binutils commit  351cdf24d223290b15fa991e5052ec9e9bd1e284
> ("[MIPS] Implement O32 FPXX, FP64 and FP64A ABI extensions").
> 

Hello,

I still can't build it with the toolchain I am using over here. This is
with a regular maltasmvp_defconfig

arch/mips/kernel/r4k_fpu.S: Assembler messages:
arch/mips/kernel/r4k_fpu.S:47: Warning: tried to set unrecognized
symbol: $30=64

arch/mips/kernel/r4k_fpu.S:54: Error: float register should be even, was 1
arch/mips/kernel/r4k_fpu.S:55: Error: float register should be even, was 3
arch/mips/kernel/r4k_fpu.S:56: Error: float register should be even, was 5
arch/mips/kernel/r4k_fpu.S:57: Error: float register should be even, was 7
arch/mips/kernel/r4k_fpu.S:58: Error: float register should be even, was 9
arch/mips/kernel/r4k_fpu.S:59: Error: float register should be even, was 11
arch/mips/kernel/r4k_fpu.S:60: Error: float register should be even, was 13
arch/mips/kernel/r4k_fpu.S:61: Error: float register should be even, was 15
arch/mips/kernel/r4k_fpu.S:62: Error: float register should be even, was 17
arch/mips/kernel/r4k_fpu.S:63: Error: float register should be even, was 19
arch/mips/kernel/r4k_fpu.S:64: Error: float register should be even, was 21
arch/mips/kernel/r4k_fpu.S:65: Error: float register should be even, was 23
arch/mips/kernel/r4k_fpu.S:66: Error: float register should be even, was 25
arch/mips/kernel/r4k_fpu.S:67: Error: float register should be even, was 27
arch/mips/kernel/r4k_fpu.S:68: Error: float register should be even, was 29
arch/mips/kernel/r4k_fpu.S:69: Error: float register should be even, was 31
arch/mips/kernel/r4k_fpu.S:168: Warning: tried to set unrecognized
symbol: $30=64


-- 
markos
