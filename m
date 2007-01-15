Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Jan 2007 21:14:36 +0000 (GMT)
Received: from ug-out-1314.google.com ([66.249.92.169]:62548 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20045658AbXAOVOb (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 15 Jan 2007 21:14:31 +0000
Received: by ug-out-1314.google.com with SMTP id 40so1601735uga
        for <linux-mips@linux-mips.org>; Mon, 15 Jan 2007 13:14:30 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=JR4F35IhU4a5IfohyWnMgJWVyPkbqGbe51SuBHJn7eGNnqY2t8zPH9AXASNe4B5APqTL4BA3xl/MaEw7hbgHP4i+JFm4ric1TpqfVMYg/+IctbWAPSqBuN931tSev1HTa26kejqlJ4qRTNNA/UDNXKxCKAy4HjYVFJeXaUdfEHY=
Received: by 10.66.232.9 with SMTP id e9mr6057303ugh.1168895670335;
        Mon, 15 Jan 2007 13:14:30 -0800 (PST)
Received: from gmail.com ( [217.67.117.64])
        by mx.google.com with ESMTP id 59sm7384968ugf.2007.01.15.13.14.29;
        Mon, 15 Jan 2007 13:14:29 -0800 (PST)
Received: by gmail.com (nbSMTP-1.00) for uid 1000
	(using TLSv1/SSLv3 with cipher DES-CBC3-SHA (168/168 bits))
	adobriyan@gmail.com; Tue, 16 Jan 2007 00:14:15 +0300 (MSK)
Date:	Tue, 16 Jan 2007 00:14:13 +0300
From:	Alexey Dobriyan <adobriyan@gmail.com>
To:	akpm@osdl.org
Cc:	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: [PATCH] seq_file conversion: APM on mips
Message-ID: <20070115211413.GB5010@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Return-Path: <adobriyan@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13601
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: adobriyan@gmail.com
Precedence: bulk
X-list: linux-mips

Compile-tested.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 arch/mips/kernel/apm.c |   28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

--- a/arch/mips/kernel/apm.c
+++ b/arch/mips/kernel/apm.c
@@ -15,6 +15,7 @@ #include <linux/poll.h>
 #include <linux/timer.h>
 #include <linux/slab.h>
 #include <linux/proc_fs.h>
+#include <linux/seq_file.h>
 #include <linux/miscdevice.h>
 #include <linux/apm_bios.h>
 #include <linux/capability.h>
@@ -434,11 +435,10 @@ #ifdef CONFIG_PROC_FS
  *	-1: Unknown
  *   8) min = minutes; sec = seconds
  */
-static int apm_get_info(char *buf, char **start, off_t fpos, int length)
+static int proc_apm_show(struct seq_file *m, void *v)
 {
 	struct apm_power_info info;
 	char *units;
-	int ret;
 
 	info.ac_line_status = 0xff;
 	info.battery_status = 0xff;
@@ -456,14 +456,26 @@ static int apm_get_info(char *buf, char 
 	case 1: 	units = "sec";	break;
 	}
 
-	ret = sprintf(buf, "%s 1.2 0x%02x 0x%02x 0x%02x 0x%02x %d%% %d %s\n",
+	seq_printf(m, "%s 1.2 0x%02x 0x%02x 0x%02x 0x%02x %d%% %d %s\n",
 		     driver_version, APM_32_BIT_SUPPORT,
 		     info.ac_line_status, info.battery_status,
 		     info.battery_flag, info.battery_life,
 		     info.time, units);
+	return 0;
+}
 
- 	return ret;
+static int proc_apm_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, proc_apm_show, NULL);
 }
+
+static const struct file_operations proc_apm_fops = {
+	.owner		= THIS_MODULE,
+	.open		= proc_apm_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
 #endif
 
 static int kapmd(void *arg)
@@ -529,7 +541,13 @@ static int __init apm_init(void)
 	}
 
 #ifdef CONFIG_PROC_FS
-	create_proc_info_entry("apm", 0, NULL, apm_get_info);
+	{
+		struct proc_dir_entry *pde;
+
+		pde = create_proc_entry("apm", 0, NULL);
+		if (pde)
+			pde->proc_fops = &proc_apm_fops;
+	}
 #endif
 
 	ret = misc_register(&apm_device);
