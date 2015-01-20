Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Jan 2015 00:42:40 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:50746 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011713AbbATXmijlq7v (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Jan 2015 00:42:38 +0100
Date:   Tue, 20 Jan 2015 23:42:38 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Markos Chandras <markos.chandras@imgtec.com>
cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH RFC v2 30/70] MIPS: kernel: proc: Add MIPS R6 support to
 /proc/cpuinfo
In-Reply-To: <1421405389-15512-31-git-send-email-markos.chandras@imgtec.com>
Message-ID: <alpine.LFD.2.11.1501202336540.28301@eddie.linux-mips.org>
References: <1421405389-15512-1-git-send-email-markos.chandras@imgtec.com> <1421405389-15512-31-git-send-email-markos.chandras@imgtec.com>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45379
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

> Print 'mips64r6' and/or 'mips32r6' if the kernel is running on
> a MIPS R6 core.
> 
> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
> ---
>  arch/mips/kernel/proc.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/mips/kernel/proc.c b/arch/mips/kernel/proc.c
> index 097fc8d14e42..a8fdf9685cad 100644
> --- a/arch/mips/kernel/proc.c
> +++ b/arch/mips/kernel/proc.c
> @@ -82,7 +82,9 @@ static int show_cpuinfo(struct seq_file *m, void *v)
>  		seq_printf(m, "]\n");
>  	}
>  
> -	seq_printf(m, "isa\t\t\t: mips1");
> +	seq_printf(m, "isa\t\t\t:"); 
> +	if (!cpu_has_mips_r6)
> +		seq_printf(m, " mips1");

 I think define `cpu_has_mips_r1' instead and use it here.  It may turn 
out needed elsewhere too.  We probably don't need a new `MIPS_CPU_ISA_I' 
bit at this stage so this could be:

#define cpu_has_mips_r1		(!cpu_has_mips_r6)

for now, and we can determine later on if the new bit is indeed required.

  Maciej
