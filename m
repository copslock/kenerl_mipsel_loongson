Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Jan 2015 00:56:13 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:41706 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011645AbbASX4L00ps5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Jan 2015 00:56:11 +0100
Date:   Mon, 19 Jan 2015 23:56:11 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Markos Chandras <markos.chandras@imgtec.com>
cc:     linux-mips@linux-mips.org,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Subject: Re: [PATCH RFC v2 04/70] MIPS: Add build support for the MIPS R6
 ISA
In-Reply-To: <1421405389-15512-5-git-send-email-markos.chandras@imgtec.com>
Message-ID: <alpine.LFD.2.11.1501192235010.28301@eddie.linux-mips.org>
References: <1421405389-15512-1-git-send-email-markos.chandras@imgtec.com> <1421405389-15512-5-git-send-email-markos.chandras@imgtec.com>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45338
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
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

On Fri, 16 Jan 2015, Markos Chandras wrote:

> diff --git a/arch/mips/Makefile b/arch/mips/Makefile
> index 2563a088d3b8..b54d5a14b9f0 100644
> --- a/arch/mips/Makefile
> +++ b/arch/mips/Makefile
> @@ -156,10 +156,14 @@ cflags-$(CONFIG_CPU_MIPS32_R1)	+= $(call cc-option,-march=mips32,-mips32 -U_MIPS
>  			-Wa,-mips32 -Wa,--trap
>  cflags-$(CONFIG_CPU_MIPS32_R2)	+= $(call cc-option,-march=mips32r2,-mips32r2 -U_MIPS_ISA -D_MIPS_ISA=_MIPS_ISA_MIPS32) \
>  			-Wa,-mips32r2 -Wa,--trap
> +cflags-$(CONFIG_CPU_MIPS32_R6)	+= $(call cc-option,-march=mips32r6,-mips32r6 -U_MIPS_ISA -D_MIPS_ISA=_MIPS_ISA_MIPS32) \
> +			-Wa,-mips32r6 -Wa,--trap
>  cflags-$(CONFIG_CPU_MIPS64_R1)	+= $(call cc-option,-march=mips64,-mips64 -U_MIPS_ISA -D_MIPS_ISA=_MIPS_ISA_MIPS64) \
>  			-Wa,-mips64 -Wa,--trap
>  cflags-$(CONFIG_CPU_MIPS64_R2)	+= $(call cc-option,-march=mips64r2,-mips64r2 -U_MIPS_ISA -D_MIPS_ISA=_MIPS_ISA_MIPS64) \
>  			-Wa,-mips64r2 -Wa,--trap
> +cflags-$(CONFIG_CPU_MIPS64_R6)	+= $(call cc-option,-march=mips64r6,-mips64r6 -U_MIPS_ISA -D_MIPS_ISA=_MIPS_ISA_MIPS32) \
> +			-Wa,-mips64r6 -Wa,--trap

 I think there is no sense to carry on this GCC 3.2/3.3 compatibility 
cruft for R6, there's no chance for this to work with those ancient 
compilers that these hacks have been intended for.  These arrangements 
come from 9200c0b2:

commit 9200c0b2a07c430bd98c546fc44b94f50e67ac62
Author: Ralf Baechle <ralf@linux-mips.org>
Date:   Thu Apr 6 00:44:25 2006 +0100

    [MIPS] Fix Makefile bugs for MIPS32/MIPS64 R1 and R2.

    This fixes kernel builds with gcc 3.2 (not 64-bit, that is looking like
    it is beyond recovery) and 3.3.  With these bugs fixed we now also can
    get undo 3b4c4996a0c24da9e6f8be764e3950b756b18cc0 and similar bits for
    SMTC that were added in 79cc8007b93838a670b164b8a55ab3e735a12a8b.

(where the arrangement switched from older yet a fallback that used flags 
like `-mips2 -mtune=r4600 -Wa,-mips32' to support GCC 2.95.x or suchlike) 
-- so please just make them plain:

cflags-$(CONFIG_CPU_MIPS32_R6)	+= -march=mips32r6 -Wa,--trap
cflags-$(CONFIG_CPU_MIPS64_R6)	+= -march=mips64r6 -Wa,--trap

Any compiler that supports R6 (and `-mips64r6' for that matter) will 
support `-march=mips64r6' and will pass this option down to GAS.

 I can take blame for some of this stuff BTW, with 2c6e7315:

commit 2c6e7315369ff6195c816d804b1e89d206aed06a
Author: Maciej W. Rozycki <macro@linux-mips.org>
Date:   Mon Dec 22 16:59:09 2003 +0000

    Support for newer gcc/gas options.

-- so I roughly know what is going on here and I think you can trust me 
that you don't want to go down the complicated path.

  Maciej
