Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Nov 2017 15:43:29 +0100 (CET)
Received: from 19pmail.ess.barracuda.com ([64.235.154.231]:57884 "EHLO
        19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990483AbdKWOnVvzaFT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 Nov 2017 15:43:21 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1411.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Thu, 23 Nov 2017 14:43:11 +0000
Received: from [10.20.78.152] (10.20.78.152) by mips01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server id 14.3.361.1; Thu, 23 Nov 2017
 06:42:46 -0800
Date:   Thu, 23 Nov 2017 14:42:35 +0000
From:   "Maciej W. Rozycki" <macro@mips.com>
To:     James Hogan <james.hogan@mips.com>
CC:     <linux-mips@linux-mips.org>, James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH] MIPS: Fix odd fp register warnings with MIPS64r2
In-Reply-To: <20171110205519.25884-1-james.hogan@mips.com>
Message-ID: <alpine.DEB.2.00.1711231420400.4290@tp.orcam.me.uk>
References: <20171110205519.25884-1-james.hogan@mips.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-BESS-ID: 1511448169-452059-26978-703940-15
X-BESS-VER: 2017.14.1-r1710272128
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.01
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.187232
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
        0.01 BSF_SC0_SA_TO_FROM_DOMAIN_MATCH META: Sender Domain Matches Recipient Domain 
X-BESS-Outbound-Spam-Status: SCORE=0.01 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, BSF_SC0_SA_TO_FROM_DOMAIN_MATCH
X-BESS-BRTS-Status: 1
Return-Path: <Maciej.Rozycki@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61057
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@mips.com
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

On Fri, 10 Nov 2017, James Hogan wrote:

> Building 32-bit MIPS64r2 kernels produces warnings like the following
> on certain toolchains (such as GNU assembler 2.24.90, but not GNU
> assembler 2.28.51) since commit 22b8ba765a72 ("MIPS: Fix MIPS64 FP
> save/restore on 32-bit kernels"), due to the exposure of fpu_save_16odd
> from fpu_save_double and fpu_restore_16odd from fpu_restore_double:
> 
> arch/mips/kernel/r4k_fpu.S:47: Warning: float register should be even, was 1
> ...
> arch/mips/kernel/r4k_fpu.S:59: Warning: float register should be even, was 1
> ...

 Hmm, versions 2.24.90 and 2.28.51 are otherwise unindentified development 
snapshots; I think it would be slightly more appropriate if you referred 
to actual release versions, such as 2.25 and 2.29 respectively (if they 
indeed expose the same symptoms), especially as people other than 
toolchain developers and testers are generally expected not to use 
development snapshots.

 Also I find it suspicious that you say that the message has since 
vanished, as I can clearly reproduce it with current head (2.29.51):

$ cat oddfpr.s
	.module mips64r2
foo:
	ldc1	$f1, 0($2)
$ as -o oddfpr.o oddfpr.s
oddfpr.s: Assembler messages:
oddfpr.s:3: Warning: float register should be even, was 1
$ 

Can you send me a .s file produced from r4k_fpu.S along with compiler 
flags used?

> This appears to be because .set mips64r2 does not change the FPU ABI to
> 64-bit when -march=mips64r2 (or e.g. -march=xlp) is provided on the
> command line on that toolchain, from the default FPU ABI of 32-bit due
> to the -mabi=32. This makes access to the odd FPU registers invalid.

 Correct, the purpose of `.set arch=mips64r2', which is the canonical form 
`.set mips64r2' is equivalent to, and indeed any `.set arch=...' 
pseudo-op, is only to change the set of instructions accepted within the 
limits determined by the ABI chosen with `-mabi=...' (or its equivalent 
short forms) and not the ABI itself.

 The patch itself LGTM.

Reviewed-by: Maciej W. Rozycki <macro@mips.com>

  Maciej
