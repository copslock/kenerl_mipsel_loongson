Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Jan 2015 17:20:58 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:52737 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012309AbbA3QUzv0xSW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 30 Jan 2015 17:20:55 +0100
Date:   Fri, 30 Jan 2015 16:20:55 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Markos Chandras <markos.chandras@imgtec.com>
cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH 1/2] MIPS: Makefile: Set correct ISA level for MIPS
 ASEs
In-Reply-To: <1422629056-27715-1-git-send-email-markos.chandras@imgtec.com>
Message-ID: <alpine.LFD.2.11.1501301606470.28301@eddie.linux-mips.org>
References: <1422629056-27715-1-git-send-email-markos.chandras@imgtec.com>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45581
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

On Fri, 30 Jan 2015, Markos Chandras wrote:

> @@ -131,14 +131,14 @@ cflags-$(CONFIG_CPU_LITTLE_ENDIAN)	+= $(shell $(CC) -dumpmachine |grep -q 'mips.
>  # Warning: the 64-bit MIPS architecture does not support the `smartmips' extension
>  # Pass -Wa,--no-warn to disable all assembler warnings until the kernel code has
>  # been fixed properly.
> -cflags-$(CONFIG_CPU_HAS_SMARTMIPS)	+= $(call cc-option,-msmartmips) -Wa,--no-warn
> -cflags-$(CONFIG_CPU_MICROMIPS) += $(call cc-option,-mmicromips)
> +cflags-$(CONFIG_CPU_HAS_SMARTMIPS)	+= $(call cc-option,-march=mips32r2 -msmartmips) -Wa,--no-warn
> +cflags-$(CONFIG_CPU_MICROMIPS) += $(call cc-option,-march=mips32r2 -mmicromips)

 The SmartMIPS ASE has been there since r1, e.g. the 4KSd core so you want 
to allow `-march=mips32', but also `-march=mips32r2' if running on earlier 
processors is not needed.

 I think to ensure the right ISA option has been selected it will be the 
best to make it happen in Kconfig, by making CPU_HAS_SMARTMIPS and 
CPU_MICROMIPS depend on the right CPU selection option.  Have you 
considered such an approach (and disregarded it for some reason)?

>  
>  cflags-$(CONFIG_SB1XXX_CORELIS)	+= $(call cc-option,-mno-sched-prolog) \
>  				   -fno-omit-frame-pointer
>  
>  ifeq ($(CONFIG_CPU_HAS_MSA),y)
> -toolchain-msa	:= $(call cc-option-yn,-mhard-float -mfp64 -Wa$(comma)-mmsa)
> +toolchain-msa	:= $(call cc-option-yn,-march=mips32r2 -mhard-float -mfp64 -Wa$(comma)-mmsa)
>  cflags-$(toolchain-msa)		+= -DTOOLCHAIN_SUPPORTS_MSA
>  endif

 Similarly here, is CPU_HAS_MSA incompatible with `-march=mips64r2'?

  Maciej
