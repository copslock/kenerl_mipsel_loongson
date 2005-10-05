Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Oct 2005 06:06:28 +0100 (BST)
Received: from adsl-67-116-42-147.dsl.sntc01.pacbell.net ([67.116.42.147]:33043
	"EHLO avtrex.com") by ftp.linux-mips.org with ESMTP
	id S8133498AbVJEFGM (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 5 Oct 2005 06:06:12 +0100
Received: from [192.168.7.26] ([192.168.7.3]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 4 Oct 2005 22:06:10 -0700
Message-ID: <43435F42.9050500@avtrex.com>
Date:	Tue, 04 Oct 2005 22:06:10 -0700
From:	David Daney <ddaney@avtrex.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: [PATCH] Fix oprofile compilation error.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Oct 2005 05:06:10.0278 (UTC) FILETIME=[80193860:01C5C96A]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9143
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

Looks like oprofile_arch_init() was changed so that we have to fill in 
the caller's oprofile_operations instead of setting a pointer to ours.

We can now make the prototype oprofile_operations be __initdata as a 
copy is being made.


Signed-off-by: David Daney <ddaney@avtrex.com>


diff --git a/arch/mips/oprofile/common.c b/arch/mips/oprofile/common.c
--- a/arch/mips/oprofile/common.c
+++ b/arch/mips/oprofile/common.c
@@ -68,7 +68,7 @@ static void op_mips_stop(void)
         on_each_cpu(model->cpu_stop, NULL, 0, 1);
  }

-static struct oprofile_operations oprof_mips_ops = {
+static struct oprofile_operations oprof_mips_ops __initdata = {
         .create_files   = op_mips_create_files,
         .setup          = op_mips_setup,
         .start          = op_mips_start,
@@ -76,7 +76,7 @@ static struct oprofile_operations oprof_
         .cpu_type       = NULL
  };

-int __init oprofile_arch_init(struct oprofile_operations **ops)
+int __init oprofile_arch_init(struct oprofile_operations *ops)
  {
         struct op_mips_model *lmodel = NULL;
         int res;
@@ -101,7 +101,7 @@ int __init oprofile_arch_init(struct opr
         model = lmodel;

         oprof_mips_ops.cpu_type = lmodel->cpu_type;
-       *ops = &oprof_mips_ops;
+       *ops = oprof_mips_ops;

         printk(KERN_INFO "oprofile: using %s performance monitoring.\n",
                lmodel->cpu_type);
