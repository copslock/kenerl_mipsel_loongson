Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Oct 2017 17:17:42 +0200 (CEST)
Received: from smtprelay0045.hostedemail.com ([216.40.44.45]:59460 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23992181AbdJTPRffqf6Q (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 20 Oct 2017 17:17:35 +0200
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 258B4180A8135;
        Fri, 20 Oct 2017 15:17:33 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: page74_5ea46ee289d5c
X-Filterd-Recvd-Size: 4552
Received: from XPS-9350 (unknown [47.151.150.235])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Fri, 20 Oct 2017 15:17:30 +0000 (UTC)
Message-ID: <1508512648.30181.1.camel@perches.com>
Subject: Re: [PATCH] MIPS: kernel: proc: Remove spurious white space in
 cpuinfo
From:   Joe Perches <joe@perches.com>
To:     Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
        linux-mips@linux-mips.org
Cc:     Dragan Cecavac <dragan.cecavac@mips.com>,
        Aleksandar Markovic <aleksandar.markovic@mips.com>,
        Douglas Leung <douglas.leung@mips.com>,
        Goran Ferenc <goran.ferenc@mips.com>,
        James Hogan <james.hogan@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-kernel@vger.kernel.org,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Miodrag Dinic <miodrag.dinic@mips.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Paul Burton <paul.burton@mips.com>,
        Petar Jovanovic <petar.jovanovic@mips.com>,
        Raghu Gandham <raghu.gandham@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>
Date:   Fri, 20 Oct 2017 08:17:28 -0700
In-Reply-To: <1508509203-30661-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1508509203-30661-1-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.22.6-1ubuntu1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-Path: <joe@perches.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60508
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joe@perches.com
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

On Fri, 2017-10-20 at 16:20 +0200, Aleksandar Markovic wrote:
> From: Dragan Cecavac <dragan.cecavac@mips.com>
> 
> Remove unnecessary space from FPU info segment of /proc/cpuinfo.
> 
> Signed-off-by: Dragan Cecavac <dragan.cecavac@mips.com>
> Signed-off-by: Aleksandar Markovic <aleksandar.markovic@mips.com>
> ---
>  arch/mips/kernel/proc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/mips/kernel/proc.c b/arch/mips/kernel/proc.c
> index bd9bf52..99f9aab 100644
> --- a/arch/mips/kernel/proc.c
> +++ b/arch/mips/kernel/proc.c
> @@ -58,7 +58,7 @@ static int show_cpuinfo(struct seq_file *m, void *v)
>  
>  	seq_printf(m, "processor\t\t: %ld\n", n);
>  	sprintf(fmt, "cpu model\t\t: %%s V%%d.%%d%s\n",
> -		      cpu_data[n].options & MIPS_CPU_FPU ? "  FPU V%d.%d" : "");
> +		      cpu_data[n].options & MIPS_CPU_FPU ? " FPU V%d.%d" : "");
>  	seq_printf(m, fmt, __cpu_name[n],
>  		      (version >> 4) & 0x0f, version & 0x0f,
>  		      (fp_vers >> 4) & 0x0f, fp_vers & 0x0f);

That's somewhat unpleasant code as it formats a fmt string
and the compiler can not verify fmt and args.

Perhaps something like the below is preferable:
---
 arch/mips/kernel/proc.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/arch/mips/kernel/proc.c b/arch/mips/kernel/proc.c
index bd9bf528f19b..dda4af8fcd7b 100644
--- a/arch/mips/kernel/proc.c
+++ b/arch/mips/kernel/proc.c
@@ -38,7 +38,6 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 	unsigned long n = (unsigned long) v - 1;
 	unsigned int version = cpu_data[n].processor_id;
 	unsigned int fp_vers = cpu_data[n].fpu_id;
-	char fmt [64];
 	int i;
 
 #ifdef CONFIG_SMP
@@ -57,11 +56,13 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 	}
 
 	seq_printf(m, "processor\t\t: %ld\n", n);
-	sprintf(fmt, "cpu model\t\t: %%s V%%d.%%d%s\n",
-		      cpu_data[n].options & MIPS_CPU_FPU ? "  FPU V%d.%d" : "");
-	seq_printf(m, fmt, __cpu_name[n],
-		      (version >> 4) & 0x0f, version & 0x0f,
+	seq_printf(m, "cpu model\t\t: %s V%d.%d",
+		   __cpu_name[n], (version >> 4) & 0x0f, version & 0x0f);
+	if (cpu_data[n].options & MIPS_CPU_FPU)
+		seq_printf(m, " FPU V%d.%d\n",
 		      (fp_vers >> 4) & 0x0f, fp_vers & 0x0f);
+	else
+		seq_printf(m, "\n");
 	seq_printf(m, "BogoMIPS\t\t: %u.%02u\n",
 		      cpu_data[n].udelay_val / (500000/HZ),
 		      (cpu_data[n].udelay_val / (5000/HZ)) % 100);
@@ -143,10 +144,13 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 		seq_printf(m, "VP\t\t\t: %d\n", cpu_vpe_id(&cpu_data[n]));
 #endif
 
-	sprintf(fmt, "VCE%%c exceptions\t\t: %s\n",
-		      cpu_has_vce ? "%u" : "not available");
-	seq_printf(m, fmt, 'D', vced_count);
-	seq_printf(m, fmt, 'I', vcei_count);
+	if (cpu_has_vce) {
+		seq_printf(m, "VCE%c exceptions\t\t: %u\n", 'D', vced_count);
+		seq_printf(m, "VCE%c exceptions\t\t: %u\n", 'I', vcei_count);
+	} else {
+		seq_printf(m, "VCE%c exceptions\t\t: not available\n", 'D');
+		seq_printf(m, "VCE%c exceptions\t\t: not available\n", 'I');
+	}
 
 	proc_cpuinfo_notifier_args.m = m;
 	proc_cpuinfo_notifier_args.n = n;
