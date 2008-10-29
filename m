Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Oct 2008 12:17:51 +0000 (GMT)
Received: from h4.dl5rb.org.uk ([81.2.74.4]:63617 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S22652919AbYJ2MRm (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 29 Oct 2008 12:17:42 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m9TCHcbh026961;
	Wed, 29 Oct 2008 12:17:38 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m9TCHbfb026959;
	Wed, 29 Oct 2008 12:17:37 GMT
Date:	Wed, 29 Oct 2008 12:17:37 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	linux-mips@linux-mips.org,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>,
	Paul Gortmaker <Paul.Gortmaker@windriver.com>
Subject: Re: [PATCH 15/36] Probe for Cavium OCTEON CPUs.
Message-ID: <20081029121737.GA26256@linux-mips.org>
References: <1225152181-3221-6-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-7-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-8-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-9-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-10-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-11-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-12-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-13-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-14-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-15-git-send-email-ddaney@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1225152181-3221-15-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21073
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Oct 27, 2008 at 05:02:47PM -0700, David Daney wrote:

> Signed-off-by: Tomaso Paoletti <tpaoletti@caviumnetworks.com>
> Signed-off-by: Paul Gortmaker <Paul.Gortmaker@windriver.com>
> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
> ---
>  arch/mips/kernel/cpu-probe.c |   26 ++++++++++++++++++++++++++
>  1 files changed, 26 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
> index 30f7e8c..fc2403c 100644
> --- a/arch/mips/kernel/cpu-probe.c
> +++ b/arch/mips/kernel/cpu-probe.c
> @@ -154,6 +154,7 @@ void __init check_wait(void)
>  	case CPU_25KF:
>  	case CPU_PR4450:
>  	case CPU_BCM3302:
> +	case CPU_CAVIUM_OCTEON:
>  		cpu_wait = r4k_wait;
>  		break;
>  
> @@ -815,6 +816,27 @@ static inline void cpu_probe_broadcom(struct cpuinfo_mips *c)
>  	}
>  }
>  
> +static inline void cpu_probe_cavium(struct cpuinfo_mips *c)
> +{
> +	decode_configs(c);
> +	switch (c->processor_id & 0xff00) {
> +	case PRID_IMP_CAVIUM_CN38XX:
> +	case PRID_IMP_CAVIUM_CN31XX:
> +	case PRID_IMP_CAVIUM_CN30XX:
> +	case PRID_IMP_CAVIUM_CN58XX:
> +	case PRID_IMP_CAVIUM_CN56XX:
> +	case PRID_IMP_CAVIUM_CN50XX:
> +	case PRID_IMP_CAVIUM_CN52XX:
> +		c->cputype = CPU_CAVIUM_OCTEON;
> +		break;
> +	default:
> +		printk(KERN_INFO "Unknown Octeon chip!\n");
> +		c->cputype = CPU_UNKNOWN;
> +		break;
> +	}
> +	mips_probe_watch_registers(c);

We probably should move the mips_probe_watch_registers() into
mips_probe_watch_registers().  I notice the function is only getting
called from cpu_probe_mips().  Iow the watch register support won't work
for CPUs made by any other vendor.  So I suggest below patch.  Plus
all of the above patch sans the mips_probe_watch_registers call on top.

  Ralf

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 0cf1545..008230f 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -652,21 +652,24 @@ static inline unsigned int decode_config3(struct cpuinfo_mips *c)
 
 static void __cpuinit decode_configs(struct cpuinfo_mips *c)
 {
+	int ok;
+
 	/* MIPS32 or MIPS64 compliant CPU.  */
 	c->options = MIPS_CPU_4KEX | MIPS_CPU_4K_CACHE | MIPS_CPU_COUNTER |
 	             MIPS_CPU_DIVEC | MIPS_CPU_LLSC | MIPS_CPU_MCHECK;
 
 	c->scache.flags = MIPS_CACHE_NOT_PRESENT;
 
-	/* Read Config registers.  */
-	if (!decode_config0(c))
-		return;			/* actually worth a panic() */
-	if (!decode_config1(c))
-		return;
-	if (!decode_config2(c))
-		return;
-	if (!decode_config3(c))
-		return;
+	ok = decode_config0(c);			/* Read Config registers.  */
+	BUG_ON(!ok);
+	if (ok)
+		ok = decode_config1(c))
+	if (ok)
+		ok = decode_config2(c);
+	if (ok)
+		ok = decode_config3(c);
+
+	mips_probe_watch_registers(c);
 }
 
 #ifdef CONFIG_CPU_MIPSR2
@@ -678,7 +681,6 @@ static inline void spram_config(void) {}
 static inline void cpu_probe_mips(struct cpuinfo_mips *c)
 {
 	decode_configs(c);
-	mips_probe_watch_registers(c);
 	switch (c->processor_id & 0xff00) {
 	case PRID_IMP_4KC:
 		c->cputype = CPU_4KC;
