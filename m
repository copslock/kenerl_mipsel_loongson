Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 06 May 2012 02:30:08 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:44223 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903603Ab2EFAaB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 6 May 2012 02:30:01 +0200
Date:   Sun, 6 May 2012 01:30:01 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     "Steven J. Hill" <sjhill@mips.com>
cc:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH v2,03/10] MIPS: Add support for the M14K core.
In-Reply-To: <1334865913-12212-2-git-send-email-sjhill@mips.com>
Message-ID: <alpine.LFD.2.00.1205060118260.19691@eddie.linux-mips.org>
References: <1334865913-12212-1-git-send-email-sjhill@mips.com> <1334865913-12212-2-git-send-email-sjhill@mips.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-archive-position: 33164
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Thu, 19 Apr 2012, Steven J. Hill wrote:

> diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
> index ddd8b4a..00e5adf 100644
> --- a/arch/mips/include/asm/cpu.h
> +++ b/arch/mips/include/asm/cpu.h
> @@ -95,6 +95,7 @@
>  #define PRID_IMP_74K		0x9700
>  #define PRID_IMP_1004K		0x9900
>  #define PRID_IMP_1074K		0x9a00
> +#define PRID_IMP_14K		0x9c00

 Here and all over this change -- shouldn't this be spelled M14K rather 
than 14K just as for M4K vs 4K?  I think pretending the M14K is a 14K will 
cause us unnecessary hassle if an actual 14K is ever made (there's some 
functional pattern in how the M4K compares to the 4K and then how the 
transition from the M4K to the M14K has been made; if the 4K RTL is ever 
ported to microMIPS support one might expect it to be called the 14K, so 
let's keep the name space clean).

 Or actually this should even be PRID_IMP_M14KC (and likewise elsewhere 
throughout) as the M14K has a different PRId -> 0x9b00.  Let's keep the 
naming correct.

  Maciej
