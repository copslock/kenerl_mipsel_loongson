Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Jan 2015 00:49:29 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:50869 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011713AbbATXt1h-WGU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Jan 2015 00:49:27 +0100
Date:   Tue, 20 Jan 2015 23:49:27 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Markos Chandras <markos.chandras@imgtec.com>
cc:     linux-mips@linux-mips.org,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Subject: Re: [PATCH RFC v2 31/70] MIPS: kernel: traps: Add MIPS R6 related
 definitions
In-Reply-To: <1421405389-15512-32-git-send-email-markos.chandras@imgtec.com>
Message-ID: <alpine.LFD.2.11.1501202344170.28301@eddie.linux-mips.org>
References: <1421405389-15512-1-git-send-email-markos.chandras@imgtec.com> <1421405389-15512-32-git-send-email-markos.chandras@imgtec.com>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45380
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

> diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
> index 461653ea28c8..81cface72bb0 100644
> --- a/arch/mips/kernel/traps.c
> +++ b/arch/mips/kernel/traps.c
> @@ -1649,7 +1649,7 @@ asmlinkage void cache_parity_error(void)
>  	printk("Decoded c0_cacheerr: %s cache fault in %s reference.\n",
>  	       reg_val & (1<<30) ? "secondary" : "primary",
>  	       reg_val & (1<<31) ? "data" : "insn");
> -	if (cpu_has_mips_r2 &&
> +	if ((cpu_has_mips_r2 || cpu_has_mips_r6) &&

 Same observation about the `cpu_has_mips_r2_r6' macro as in the other 
e-mail.  Likewise throughout this patch.  I won't repeat it for any 
further occurences in the remaining patches, please assume this 
automatically and revise the changes yourself.

>  	    ((current_cpu_data.processor_id & 0xff0000) == PRID_COMP_MIPS)) {

 Hmm, this could and should use `PRID_COMP_MASK' rather than hardcoded 
0xff0000.  Similarly elsewhere down this patch.  That'd be a separate 
cleanup.

  Maciej
