Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Jan 2007 16:53:23 +0000 (GMT)
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:8578 "EHLO
	ebiederm.dsl.xmission.com") by ftp.linux-mips.org with ESMTP
	id S28580796AbXAPQlr (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 16 Jan 2007 16:41:47 +0000
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.8/8.13.8/Debian-2) with ESMTP id l0GGeiRq000971;
	Tue, 16 Jan 2007 09:40:44 -0700
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.8/8.13.8/Submit) id l0GGeiTR000969;
	Tue, 16 Jan 2007 09:40:44 -0700
From:	"Eric W. Biederman" <ebiederm@xmission.com>
To:	"<Andrew Morton" <akpm@osdl.org>
Cc:	<linux-kernel@vger.kernel.org>, <containers@lists.osdl.org>,
	<netdev@vger.kernel.org>, xfs-masters@oss.sgi.com, xfs@oss.sgi.com,
	linux-scsi@vger.kernel.org, James.Bottomley@SteelEye.com,
	minyard@acm.org, openipmi-developer@lists.sourceforge.net,
	<tony.luck@intel.com>, linux-mips@linux-mips.org,
	ralf@linux-mips.org, schwidefsky@de.ibm.com,
	heiko.carstens@de.ibm.com, linux390@de.ibm.com,
	linux-390@vm.marist.edu, paulus@samba.org, linuxppc-dev@ozlabs.org,
	lethal@linux-sh.org, linuxsh-shmedia-dev@lists.sourceforge.net,
	<ak@suse.de>, vojtech@suse.cz, clemens@ladisch.de,
	a.zummo@towertech.it, rtc-linux@googlegroups.com,
	linux-parport@lists.infradead.org, andrea@suse.de,
	tim@cyberelk.net, philb@gnu.org, aharkes@cs.cmu.edu,
	coda@cs.cmu.edu, codalist@TELEMANN.coda.cs.cmu.edu,
	aia21@cantab.net, linux-ntfs-dev@lists.sourceforge.net,
	mark.fasheh@oracle.com, kurt.hackel@oracle.com,
	"Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 25/59] sysctl: C99 convert arch/frv/kernel/pm.c
Date:	Tue, 16 Jan 2007 09:39:30 -0700
Message-Id: <11689656443582-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.5.0.rc1.gb60d
In-Reply-To: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>
References: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>
Return-Path: <eric@ebiederm.dsl.xmission.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13640
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ebiederm@xmission.com
Precedence: bulk
X-list: linux-mips

From: Eric W. Biederman <ebiederm@xmission.com> - unquoted

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 arch/frv/kernel/pm.c |   50 +++++++++++++++++++++++++++++++++++++++++++-------
 1 files changed, 43 insertions(+), 7 deletions(-)

diff --git a/arch/frv/kernel/pm.c b/arch/frv/kernel/pm.c
index c1840d6..aa50333 100644
--- a/arch/frv/kernel/pm.c
+++ b/arch/frv/kernel/pm.c
@@ -401,17 +401,53 @@ static int cm_sysctl(ctl_table *table, int __user *name, int nlen,
 
 static struct ctl_table pm_table[] =
 {
-	{CTL_PM_SUSPEND, "suspend", NULL, 0, 0200, NULL, &sysctl_pm_do_suspend},
-	{CTL_PM_CMODE, "cmode", &clock_cmode_current, sizeof(int), 0644, NULL, &cmode_procctl, &cmode_sysctl, NULL},
-	{CTL_PM_P0, "p0", &clock_p0_current, sizeof(int), 0644, NULL, &p0_procctl, &p0_sysctl, NULL},
-	{CTL_PM_CM, "cm", &clock_cm_current, sizeof(int), 0644, NULL, &cm_procctl, &cm_sysctl, NULL},
-	{0}
+	{
+		.ctl_name	= CTL_PM_SUSPEND,
+		.procname	= "suspend",
+		.data		= NULL,
+		.maxlen		= 0,
+		.mode		= 0200,
+		.proc_handler	= &sysctl_pm_do_suspend,
+	},
+	{
+		.ctl_name	= CTL_PM_CMODE,
+		.procname	= "cmode",
+		.data		= &clock_cmode_current,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &cmode_procctl,
+		.strategy	= &cmode_sysctl,
+	},
+	{
+		.ctl_name	= CTL_PM_P0,
+		.procname	= "p0",
+		.data		= &clock_p0_current,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &p0_procctl,
+		.strategy	= &p0_sysctl,
+	},
+	{
+		.ctl_name	= CTL_PM_CM,
+		.procname	= "cm",
+		.data		= &clock_cm_current,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &cm_procctl,
+		.strategy	= &cm_sysctl,
+	},
+	{ .ctl_name = 0}
 };
 
 static struct ctl_table pm_dir_table[] =
 {
-	{CTL_PM, "pm", NULL, 0, 0555, pm_table},
-	{0}
+	{
+		.ctl_name	= CTL_PM,
+		.procname	= "pm",
+		.mode		= 0555,
+		.child		= pm_table,
+	},
+	{ .ctl_name = 0}
 };
 
 /*
-- 
1.4.4.1.g278f
