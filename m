Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Oct 2005 01:26:05 +0100 (BST)
Received: from adsl-67-116-42-147.dsl.sntc01.pacbell.net ([67.116.42.147]:49183
	"EHLO avtrex.com") by ftp.linux-mips.org with ESMTP
	id S8133590AbVJHAZq (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 8 Oct 2005 01:25:46 +0100
Received: from [192.168.7.26] ([192.168.7.3]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 7 Oct 2005 17:25:44 -0700
Message-ID: <43471208.3060405@avtrex.com>
Date:	Fri, 07 Oct 2005 17:25:44 -0700
From:	David Daney <ddaney@avtrex.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Re: OProfile cannot be loaded as module...
References: <43470BCF.1070709@avtrex.com>
In-Reply-To: <43470BCF.1070709@avtrex.com>
Content-Type: multipart/mixed;
 boundary="------------030309090201040107050005"
X-OriginalArrivalTime: 08 Oct 2005 00:25:44.0251 (UTC) FILETIME=[D23E80B0:01C5CB9E]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9199
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------030309090201040107050005
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

David Daney wrote:
> arch/mips/oprofile/common.c defines several symbols (op_model_mipsxx and 
> op_model_rm9000) with __attribute__((weak)).  It then assumes that ELF 
> linking conventions will prevail and there will be no problems if they 
> are undefined.
> 
> The problem is if you try to load oprofile as a module.  The kernel 
> module linker evidentially does not understand weak symbols and refuses 
> to load the module because they are undefined.
> 
> Perhaps a single
> 
> extern struct op_mips_model plat_op_model;
> 
> That must be defined by each different implementation.  Deciding one 
> which implementation would then be done at compile time instead of runtime.
> 
> I don't have a patch for this yet, but that is what I am thinking of doing.
> 

Ok, attached is my untested (but it compiles for some architectures) patch.

David Daney

--------------030309090201040107050005
Content-Type: text/plain;
 name="op.d"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="op.d"

diff --git a/arch/mips/oprofile/common.c b/arch/mips/oprofile/common.c
--- a/arch/mips/oprofile/common.c
+++ b/arch/mips/oprofile/common.c
@@ -14,20 +14,17 @@
 
 #include "op_impl.h"
 
-extern struct op_mips_model op_model_mipsxx __attribute__((weak));
-extern struct op_mips_model op_model_rm9000 __attribute__((weak));
-
-static struct op_mips_model *model;
+extern struct op_mips_model *plat_op_model;
 
 static struct op_counter_config ctr[20];
 
 static int op_mips_setup(void)
 {
 	/* Pre-compute the values to stuff in the hardware registers.  */
-	model->reg_setup(ctr);
+	plat_op_model->reg_setup(ctr);
 
 	/* Configure the registers on all cpus.  */
-	on_each_cpu(model->cpu_setup, 0, 0, 1);
+	on_each_cpu(plat_op_model->cpu_setup, 0, 0, 1);
 
         return 0;
 }
@@ -36,7 +33,7 @@ static int op_mips_create_files(struct s
 {
 	int i;
 
-	for (i = 0; i < model->num_counters; ++i) {
+	for (i = 0; i < plat_op_model->num_counters; ++i) {
 		struct dentry *dir;
 		char buf[3];
 
@@ -58,7 +55,7 @@ static int op_mips_create_files(struct s
 
 static int op_mips_start(void)
 {
-	on_each_cpu(model->cpu_start, NULL, 0, 1);
+	on_each_cpu(plat_op_model->cpu_start, NULL, 0, 1);
 
 	return 0;
 }
@@ -66,49 +63,33 @@ static int op_mips_start(void)
 static void op_mips_stop(void)
 {
 	/* Disable performance monitoring for all counters.  */
-	on_each_cpu(model->cpu_stop, NULL, 0, 1);
+	on_each_cpu(plat_op_model->cpu_stop, NULL, 0, 1);
 }
 
 int __init oprofile_arch_init(struct oprofile_operations *ops)
 {
-	struct op_mips_model *lmodel = NULL;
 	int res;
 
 	printk(KERN_INFO "oprofile: In oprofile_arch_init.\n");
 
-	switch (current_cpu_data.cputype) {
-	case CPU_24K:
-		lmodel = &op_model_mipsxx;
-		break;
-
-	case CPU_RM9000:
-		lmodel = &op_model_rm9000;
-		break;
-	};
-
-	if (!lmodel)
-		return -ENODEV;
-
-	res = lmodel->init();
+	res = plat_op_model->init();
 	if (res)
 		return res;
 
-	model = lmodel;
-
 	ops->create_files	= op_mips_create_files;
 	ops->setup		= op_mips_setup;
 	//ops->shutdown         = op_mips_shutdown;
 	ops->start		= op_mips_start;
 	ops->stop		= op_mips_stop;
-	ops->cpu_type		= lmodel->cpu_type;
+	ops->cpu_type		= plat_op_model->cpu_type;
 
 	printk(KERN_INFO "oprofile: using %s performance monitoring.\n",
-	       lmodel->cpu_type);
+	       plat_op_model->cpu_type);
 
 	return 0;
 }
 
 void oprofile_arch_exit(void)
 {
-	model->exit();
+	plat_op_model->exit();
 }
diff --git a/arch/mips/oprofile/op_model_mipsxx.c b/arch/mips/oprofile/op_model_mipsxx.c
--- a/arch/mips/oprofile/op_model_mipsxx.c
+++ b/arch/mips/oprofile/op_model_mipsxx.c
@@ -23,7 +23,7 @@
 
 #define M_COUNTER_OVERFLOW		(1UL    << 31)
 
-struct op_mips_model op_model_mipsxx;
+static struct op_mips_model op_model_mipsxx;
 
 static struct mipsxx_register_config {
 	unsigned int control[4];
@@ -205,7 +205,7 @@ static void mipsxx_exit(void)
 	perf_irq = null_perf_irq;
 }
 
-struct op_mips_model op_model_mipsxx = {
+static struct op_mips_model op_model_mipsxx = {
 	.reg_setup	= mipsxx_reg_setup,
 	.cpu_setup	= mipsxx_cpu_setup,
 	.init		= mipsxx_init,
@@ -213,3 +213,5 @@ struct op_mips_model op_model_mipsxx = {
 	.cpu_start	= mipsxx_cpu_start,
 	.cpu_stop	= mipsxx_cpu_stop,
 };
+
+struct op_mips_model *plat_op_model = &op_model_mipsxx;
diff --git a/arch/mips/oprofile/op_model_rm9000.c b/arch/mips/oprofile/op_model_rm9000.c
--- a/arch/mips/oprofile/op_model_rm9000.c
+++ b/arch/mips/oprofile/op_model_rm9000.c
@@ -126,7 +126,7 @@ static void rm9000_exit(void)
 	free_irq(rm9000_perfcount_irq, NULL);
 }
 
-struct op_mips_model op_model_rm9000 = {
+static struct op_mips_model op_model_rm9000 = {
 	.reg_setup	= rm9000_reg_setup,
 	.cpu_setup	= rm9000_cpu_setup,
 	.init		= rm9000_init,
@@ -136,3 +136,5 @@ struct op_mips_model op_model_rm9000 = {
 	.cpu_type	= "mips/rm9000",
 	.num_counters	= 2
 };
+
+struct op_mips_model *plat_op_model = &op_model_rm9000;

--------------030309090201040107050005--
