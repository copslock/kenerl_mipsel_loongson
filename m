Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Jan 2008 04:58:25 +0000 (GMT)
Received: from gateway-1237.mvista.com ([63.81.120.158]:49127 "EHLO
	dwalker1.mvista.com") by ftp.linux-mips.org with ESMTP
	id S20023569AbYAKE6R (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 11 Jan 2008 04:58:17 +0000
Received: from dwalker1.mvista.com (localhost.localdomain [127.0.0.1])
	by dwalker1.mvista.com (8.14.1/8.14.1) with ESMTP id m0B4rnZn005773;
	Thu, 10 Jan 2008 20:53:49 -0800
Received: (from dwalker@localhost)
	by dwalker1.mvista.com (8.14.1/8.14.1/Submit) id m0B4rmHJ005772;
	Thu, 10 Jan 2008 20:53:48 -0800
X-Authentication-Warning: dwalker1.mvista.com: dwalker set sender to dwalker@mvista.com using -f
Message-Id: <20080111045348.085971795@mvista.com>
User-Agent: quilt/0.46-1
Date:	Thu, 10 Jan 2008 20:53:48 -0800
Message-Id: <20080111045321.274084894@mvista.com>
User-Agent: quilt/0.46-1
Date:	Thu, 10 Jan 2008 20:53:21 -0800
From:	Daniel Walker <dwalker@mvista.com>
To:	brian@murphy.dk
Cc:	mingo@elte.hu
Cc:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org
Subject: [PATCH] mips: picvue: pvc_sem semaphore to mutex
Return-Path: <dwalker@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17979
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dwalker@mvista.com
Precedence: bulk
X-list: linux-mips

This semaphore conforms to the new struct mutex, so I've converted it
to use that new API.

I also changed the name to pvc_mutex, and moved the define to the file
it's used in which allows it to be static.

Signed-off-by: Daniel Walker <dwalker@mvista.com>

---
 arch/mips/lasat/picvue.c      |    2 --
 arch/mips/lasat/picvue.h      |    3 ---
 arch/mips/lasat/picvue_proc.c |   18 ++++++++++--------
 3 files changed, 10 insertions(+), 13 deletions(-)

Index: linux-2.6.23/arch/mips/lasat/picvue.c
===================================================================
--- linux-2.6.23.orig/arch/mips/lasat/picvue.c
+++ linux-2.6.23/arch/mips/lasat/picvue.c
@@ -22,8 +22,6 @@
 
 struct pvc_defs *picvue;
 
-DECLARE_MUTEX(pvc_sem);
-
 static void pvc_reg_write(u32 val)
 {
 	*picvue->reg = val;
Index: linux-2.6.23/arch/mips/lasat/picvue.h
===================================================================
--- linux-2.6.23.orig/arch/mips/lasat/picvue.h
+++ linux-2.6.23/arch/mips/lasat/picvue.h
@@ -4,8 +4,6 @@
  * Brian Murphy <brian.murphy@eicon.com>
  *
  */
-#include <asm/semaphore.h>
-
 struct pvc_defs {
 	volatile u32 *reg;
 	u32 data_shift;
@@ -45,4 +43,3 @@ void pvc_move(u8 cmd);
 void pvc_clear(void);
 void pvc_home(void);
 
-extern struct semaphore pvc_sem;
Index: linux-2.6.23/arch/mips/lasat/picvue_proc.c
===================================================================
--- linux-2.6.23.orig/arch/mips/lasat/picvue_proc.c
+++ linux-2.6.23/arch/mips/lasat/picvue_proc.c
@@ -13,9 +13,11 @@
 #include <linux/interrupt.h>
 
 #include <linux/timer.h>
+#include <linux/mutex.h>
 
 #include "picvue.h"
 
+static DEFINE_MUTEX(pvc_mutex);
 static char pvc_lines[PVC_NLINES][PVC_LINELEN+1];
 static int pvc_linedata[PVC_NLINES];
 static struct proc_dir_entry *pvc_display_dir;
@@ -48,9 +50,9 @@ static int pvc_proc_read_line(char *page
 		return 0;
 	}
 
-	down(&pvc_sem);
+	mutex_lock(&pvc_mutex);
 	page += sprintf(page, "%s\n", pvc_lines[lineno]);
-	up(&pvc_sem);
+	mutex_unlock(&pvc_mutex);
 
 	return page - origpage;
 }
@@ -73,10 +75,10 @@ static int pvc_proc_write_line(struct fi
 	if (buffer[count-1] == '\n')
 		count--;
 
-	down(&pvc_sem);
+	mutex_lock(&pvc_mutex);
 	strncpy(pvc_lines[lineno], buffer, count);
 	pvc_lines[lineno][count] = '\0';
-	up(&pvc_sem);
+	mutex_unlock(&pvc_mutex);
 
 	tasklet_schedule(&pvc_display_tasklet);
 
@@ -89,7 +91,7 @@ static int pvc_proc_write_scroll(struct 
 	int origcount = count;
 	int cmd = simple_strtol(buffer, NULL, 10);
 
-	down(&pvc_sem);
+	mutex_lock(&pvc_mutex);
 	if (scroll_interval != 0)
 		del_timer(&timer);
 
@@ -106,7 +108,7 @@ static int pvc_proc_write_scroll(struct 
 		}
 		add_timer(&timer);
 	}
-	up(&pvc_sem);
+	mutex_unlock(&pvc_mutex);
 
 	return origcount;
 }
@@ -117,9 +119,9 @@ static int pvc_proc_read_scroll(char *pa
 {
 	char *origpage = page;
 
-	down(&pvc_sem);
+	mutex_lock(&pvc_mutex);
 	page += sprintf(page, "%d\n", scroll_dir * scroll_interval);
-	up(&pvc_sem);
+	mutex_unlock(&pvc_mutex);
 
 	return page - origpage;
 }
-- 

-- 
