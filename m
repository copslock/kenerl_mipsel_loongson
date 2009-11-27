Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Nov 2009 07:55:15 +0100 (CET)
Received: from mail-ew0-f223.google.com ([209.85.219.223]:49360 "EHLO
        mail-ew0-f223.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491944AbZK0GzM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 27 Nov 2009 07:55:12 +0100
Received: by ewy23 with SMTP id 23so1451047ewy.24
        for <multiple recipients>; Thu, 26 Nov 2009 22:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=ch7RgbAWX+BlFXw2IGnDKO7wu72PvcxCIJ8kaIJBY5w=;
        b=Pzg2n1iZi0lbp3mqbODdVwMjAhxeLml8OEAgkgAAOkCS1u7m06StYEzyQCp0YTlgiH
         w726N3lK6naVP0yTpWlraWCv5dV0UneL3lY2t1f8olSt+0Vfi0zjhTn7ZMcK9T2/gKcw
         0kNsU4zWdIW52ctcJL5ctsFhBekSL7IgLeo14=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=pRxvAVDgvy/aQc3prQcFpH/ol56cfzqDnEcECCp2fBFM58ILjRtKvwI8RLLw/DjeyJ
         ut3ZAK7hfhhoyoB5lVSEDLaXtW1QPhtqkyjfpGq4YI4qNdzcSkd7YjGKfHTisVLNk5Lm
         Cw9I94p+tLihm3tzABXuJOLWTsGmftaLwgMV0=
Received: by 10.213.100.161 with SMTP id y33mr791889ebn.2.1259304905149;
        Thu, 26 Nov 2009 22:55:05 -0800 (PST)
Received: from x200.malnet.ru ([213.171.34.231])
        by mx.google.com with ESMTPS id 28sm778695eye.3.2009.11.26.22.55.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 26 Nov 2009 22:55:04 -0800 (PST)
Date:   Fri, 27 Nov 2009 09:55:03 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     ralf@linux-mips.org
Cc:     akpm@linux-foundation.org, linux-mips@linux-mips.org
Subject: [PATCH] mips lasat: convert to proc_fops/seq_file
Message-ID: <20091127065502.GE26327@x200.malnet.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Return-Path: <adobriyan@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25167
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: adobriyan@gmail.com
Precedence: bulk
X-list: linux-mips

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 arch/mips/lasat/picvue_proc.c |  106 ++++++++++++++++++++++++++----------------
 1 file changed, 66 insertions(+), 40 deletions(-)

--- a/arch/mips/lasat/picvue_proc.c
+++ b/arch/mips/lasat/picvue_proc.c
@@ -10,6 +10,7 @@
 #include <linux/errno.h>
 
 #include <linux/proc_fs.h>
+#include <linux/seq_file.h>
 #include <linux/interrupt.h>
 
 #include <linux/timer.h>
@@ -38,12 +39,9 @@ static void pvc_display(unsigned long data)
 
 static DECLARE_TASKLET(pvc_display_tasklet, &pvc_display, 0);
 
-static int pvc_proc_read_line(char *page, char **start,
-			     off_t off, int count,
-			     int *eof, void *data)
+static int pvc_line_proc_show(struct seq_file *m, void *v)
 {
-	char *origpage = page;
-	int lineno = *(int *)data;
+	int lineno = *(int *)m->private;
 
 	if (lineno < 0 || lineno > PVC_NLINES) {
 		printk(KERN_WARNING "proc_read_line: invalid lineno %d\n", lineno);
@@ -51,17 +49,23 @@ static int pvc_proc_read_line(char *page, char **start,
 	}
 
 	mutex_lock(&pvc_mutex);
-	page += sprintf(page, "%s\n", pvc_lines[lineno]);
+	seq_printf(m, "%s\n", pvc_lines[lineno]);
 	mutex_unlock(&pvc_mutex);
 
-	return page - origpage;
+	return 0;
+}
+
+static int pvc_line_proc_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, pvc_line_proc_show, PDE(inode)->data);
 }
 
-static int pvc_proc_write_line(struct file *file, const char *buffer,
-			   unsigned long count, void *data)
+static ssize_t pvc_line_proc_write(struct file *file, const char __user *buf,
+				   size_t count, loff_t *pos)
 {
-	int origcount = count;
-	int lineno = *(int *)data;
+	int lineno = *(int *)PDE(file->f_path.dentry->d_inode)->data;
+	char kbuf[PVC_LINELEN];
+	size_t len;
 
 	if (lineno < 0 || lineno > PVC_NLINES) {
 		printk(KERN_WARNING "proc_write_line: invalid lineno %d\n",
@@ -69,27 +73,46 @@ static int pvc_proc_write_line(struct file *file, const char *buffer,
 		return origcount;
 	}
 
-	if (count > PVC_LINELEN)
-		count = PVC_LINELEN;
+	len = min(count, sizeof(kbuf) - 1);
+	if (copy_from_user(kbuf, buf, len))
+		return -EFAULT;
+	kbuf[len] = '\0';
 
-	if (buffer[count-1] == '\n')
-		count--;
+	if (len > 0 && kbuf[len - 1] == '\n')
+		len--;
 
 	mutex_lock(&pvc_mutex);
-	strncpy(pvc_lines[lineno], buffer, count);
-	pvc_lines[lineno][count] = '\0';
+	strncpy(pvc_lines[lineno], kbuf, len);
+	pvc_lines[lineno][len] = '\0';
 	mutex_unlock(&pvc_mutex);
 
 	tasklet_schedule(&pvc_display_tasklet);
 
-	return origcount;
+	return count;
 }
 
-static int pvc_proc_write_scroll(struct file *file, const char *buffer,
-			   unsigned long count, void *data)
+static const struct file_operations pvc_line_proc_fops = {
+	.owner		= THIS_MODULE,
+	.open		= pvc_line_proc_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+	.write		= pvc_line_proc_write,
+};
+
+static ssize_t pvc_scroll_proc_write(struct file *file, const char __user *buf,
+				     size_t count, loff_t *pos)
 {
-	int origcount = count;
-	int cmd = simple_strtol(buffer, NULL, 10);
+	char kbuf[42];
+	size_t len;
+	int cmd;
+
+	len = min(count, sizeof(kbuf) - 1);
+	if (copy_from_user(kbuf, buf, len))
+		return -EFAULT;
+	kbuf[len] = '\0';
+
+	cmd = simple_strtol(kbuf, NULL, 10);
 
 	mutex_lock(&pvc_mutex);
 	if (scroll_interval != 0)
@@ -110,22 +133,31 @@ static int pvc_proc_write_scroll(struct file *file, const char *buffer,
 	}
 	mutex_unlock(&pvc_mutex);
 
-	return origcount;
+	return count;
 }
 
-static int pvc_proc_read_scroll(char *page, char **start,
-			     off_t off, int count,
-			     int *eof, void *data)
+static int pvc_scroll_proc_show(struct seq_file *m, void *v)
 {
-	char *origpage = page;
-
 	mutex_lock(&pvc_mutex);
-	page += sprintf(page, "%d\n", scroll_dir * scroll_interval);
+	seq_printf(m, "%d\n", scroll_dir * scroll_interval);
 	mutex_unlock(&pvc_mutex);
 
-	return page - origpage;
+	return 0;
+}
+
+static int pvc_scroll_proc_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, pvc_scroll_proc_show, NULL);
 }
 
+static const struct file_operations pvc_scroll_proc_fops = {
+	.owner		= THIS_MODULE,
+	.open		= pvc_scroll_proc_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+	.write		= pvc_scroll_proc_write,
+};
 
 void pvc_proc_timerfunc(unsigned long data)
 {
@@ -163,22 +195,16 @@ static int __init pvc_proc_init(void)
 		pvc_linedata[i] = i;
 	}
 	for (i = 0; i < PVC_NLINES; i++) {
-		proc_entry = create_proc_entry(pvc_linename[i], 0644,
-					       pvc_display_dir);
+		proc_entry = proc_create_data(pvc_linename[i], 0644, pvc_display_dir,
+					&pvc_line_proc_fops, &pvc_linedata[i]);
 		if (proc_entry == NULL)
 			goto error;
-
-		proc_entry->read_proc = pvc_proc_read_line;
-		proc_entry->write_proc = pvc_proc_write_line;
-		proc_entry->data = &pvc_linedata[i];
 	}
-	proc_entry = create_proc_entry("scroll", 0644, pvc_display_dir);
+	proc_entry = proc_create("scroll", 0644, pvc_display_dir,
+				 &pvc_scroll_proc_fops);
 	if (proc_entry == NULL)
 		goto error;
 
-	proc_entry->write_proc = pvc_proc_write_scroll;
-	proc_entry->read_proc = pvc_proc_read_scroll;
-
 	init_timer(&timer);
 	timer.function = pvc_proc_timerfunc;
 
