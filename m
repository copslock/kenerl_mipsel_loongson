Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Aug 2012 15:16:11 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:34913 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903438Ab2HQNQD (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 17 Aug 2012 15:16:03 +0200
Message-ID: <502E43CC.2030509@phrozen.org>
Date:   Fri, 17 Aug 2012 15:14:52 +0200
From:   John Crispin <john@phrozen.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.24) Gecko/20111114 Icedove/3.1.16
MIME-Version: 1.0
To:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Whitespace and various formatting clean-ups for
 microMIPS.
References: <1343166045-1974-1-git-send-email-sjhill@mips.com>
In-Reply-To: <1343166045-1974-1-git-send-email-sjhill@mips.com>
X-Enigmail-Version: 1.1.2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 34253
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: john@phrozen.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On 24/07/12 23:40, Steven J. Hill wrote:
> diff --git a/arch/mips/kernel/proc.c b/arch/mips/kernel/proc.c
> index 5542817..5569d09 100644
> --- a/arch/mips/kernel/proc.c
> +++ b/arch/mips/kernel/proc.c
> @@ -64,13 +64,14 @@ static int show_cpuinfo(struct seq_file *m, void *v)
>  				cpu_data[n].watch_reg_masks[i]);
>  		seq_printf(m, "]\n");
>  	}
> -	seq_printf(m, "ASEs implemented\t:%s%s%s%s%s%s\n",
> +	seq_printf(m, "ASEs implemented\t:%s%s%s%s%s%s%s\n",
>  		      cpu_has_mips16 ? " mips16" : "",
>  		      cpu_has_mdmx ? " mdmx" : "",
>  		      cpu_has_mips3d ? " mips3d" : "",
>  		      cpu_has_smartmips ? " smartmips" : "",
>  		      cpu_has_dsp ? " dsp" : "",
> -		      cpu_has_mipsmt ? " mt" : ""
> +		      cpu_has_mipsmt ? " mt" : "",
> +		      cpu_has_mmips ? " micromips" : ""
>  		);
>  	seq_printf(m, "shadow register sets\t: %d\n",
>  		      cpu_data[n].srsets);


Hi,

this looks like it should not be part of the patch ?

John
