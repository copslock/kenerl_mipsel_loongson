Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 31 Oct 2014 17:13:58 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:52785 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012297AbaJaQN5EiBHC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 31 Oct 2014 17:13:57 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id B02E6AC804038;
        Fri, 31 Oct 2014 16:13:47 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 31 Oct 2014 16:13:50 +0000
Received: from [192.168.154.149] (192.168.154.149) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Fri, 31 Oct
 2014 16:13:50 +0000
Message-ID: <5453B53D.7060409@imgtec.com>
Date:   Fri, 31 Oct 2014 16:13:49 +0000
From:   Markos Chandras <Markos.Chandras@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     Manuel Lauss <manuel.lauss@gmail.com>,
        Linux-MIPS <linux-mips@linux-mips.org>
CC:     Matthew Fortune <Matthew.Fortune@imgtec.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [RFC PATCH v6] MIPS: fix build with binutils 2.24.51+
References: <1414771394-24314-1-git-send-email-manuel.lauss@gmail.com>
In-Reply-To: <1414771394-24314-1-git-send-email-manuel.lauss@gmail.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.149]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43808
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

On 10/31/2014 04:03 PM, Manuel Lauss wrote:
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
> Compiles with binutils 2.23 and current git head, tested with alchemy (mips32r1)
> and maltasmvp_defconfig (64bit)
> 
> Tests with MSA and other extensions also appreciated!
> 
> v6: #undef fp so that the preprocessor does not replace the fp in 
> 	.set fp=64 with $30...  Fixes 64bit build.

Technically speaking, a maltasmvp_defconfig selects CONFIG_32BIT=y so
it's still a 32-bit build.
> [...]

Ok the fp problem went away but I still have the even/odd errors with my
tools

arch/mips/kernel/r4k_switch.S: Assembler messages:
arch/mips/kernel/r4k_switch.S:81: Error: float register should be even,
was 1
arch/mips/kernel/r4k_switch.S:81: Error: float register should be even,
was 3
arch/mips/kernel/r4k_switch.S:81: Error: float register should be even,
was 5
arch/mips/kernel/r4k_switch.S:81: Error: float register should be even,
was 7
arch/mips/kernel/r4k_switch.S:81: Error: float register should be even,
was 9
arch/mips/kernel/r4k_switch.S:81: Error: float register should be even,
was 11
arch/mips/kernel/r4k_switch.S:81: Error: float register should be even,
was 13
arch/mips/kernel/r4k_switch.S:81: Error: float register should be even,
was 15
arch/mips/kernel/r4k_switch.S:81: Error: float register should be even,
was 17
arch/mips/kernel/r4k_switch.S:81: Error: float register should be even,
was 19

The following patch did not help either:

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 58076472bdd8..b8bb7e170fee 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -56,7 +56,7 @@ ifdef CONFIG_FUNCTION_GRAPH_TRACER
   endif
 endif
 cflags-y += $(call cc-option, -mno-check-zero-division)
-
+cflags-y += -mno-odd-spreg

This is with a regular maltasmvp_defconfig

I guess my gcc version is newer than yours. Matthew?

-- 
markos
