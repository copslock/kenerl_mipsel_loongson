Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 May 2012 18:54:31 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:59301 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903692Ab2EVQyY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 May 2012 18:54:24 +0200
Date:   Tue, 22 May 2012 17:54:24 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     "Steven J. Hill" <sjhill@mips.com>
cc:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH 4/9] MIPS: Add microMIPS breakpoints and DSP support.
In-Reply-To: <1336716486-32643-1-git-send-email-sjhill@mips.com>
Message-ID: <alpine.LFD.2.00.1205221738260.3701@eddie.linux-mips.org>
References: <1336716486-32643-1-git-send-email-sjhill@mips.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-archive-position: 33413
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Steven,

> diff --git a/arch/mips/kernel/proc.c b/arch/mips/kernel/proc.c
> index 5542817..2c18317 100644
> --- a/arch/mips/kernel/proc.c
> +++ b/arch/mips/kernel/proc.c
> @@ -64,6 +64,7 @@ static int show_cpuinfo(struct seq_file *m, void *v)
>  				cpu_data[n].watch_reg_masks[i]);
>  		seq_printf(m, "]\n");
>  	}
> +	seq_printf(m, "microMIPS\t\t: %s\n", cpu_has_mmips ? "yes" : "no");
>  	seq_printf(m, "ASEs implemented\t:%s%s%s%s%s%s\n",
>  		      cpu_has_mips16 ? " mips16" : "",
>  		      cpu_has_mdmx ? " mdmx" : "",

 I'm sorry I didn't notice that before, but it got lost in the load of 
formatting changes.  I think this should really be reported along the 
other ASEs in the next line.  Please move it down there, the pattern is 
obvious (and then the MCU ASE may be added too with a simple follow-up 
change).

 However what I would find useful here and what I think is not reported 
anywhere else and otherwise tricky (though possible) to track down is 
whether the kernel itself has been built as a microMIPS or standard MIPS 
binary.  Perhaps you could reuse your entry above for that purpose -- I 
suppose no tool has relied on this /proc/cpuinfo entry to make any 
decisions so far, so it may be the right moment now to get it standardised 
somehow.

 I'll try to get back to the rest of the microMIPS review soon, I welcome 
your submission very warmly, but that's a substantial change and I'm 
really running out of time, sorry about that.

  Maciej
