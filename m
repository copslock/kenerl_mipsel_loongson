Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Jan 2007 16:53:51 +0000 (GMT)
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:14210 "EHLO
	ebiederm.dsl.xmission.com") by ftp.linux-mips.org with ESMTP
	id S28580797AbXAPQlt (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 16 Jan 2007 16:41:49 +0000
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.8/8.13.8/Debian-2) with ESMTP id l0GGeweR001005;
	Tue, 16 Jan 2007 09:40:58 -0700
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.8/8.13.8/Submit) id l0GGev0l001004;
	Tue, 16 Jan 2007 09:40:57 -0700
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
Subject: [PATCH 33/59] sysctl: s390 move sysctl definitions to sysctl.h
Date:	Tue, 16 Jan 2007 09:39:38 -0700
Message-Id: <11689656572714-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.5.0.rc1.gb60d
In-Reply-To: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>
References: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>
Return-Path: <eric@ebiederm.dsl.xmission.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13641
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ebiederm@xmission.com
Precedence: bulk
X-list: linux-mips

From: Eric W. Biederman <ebiederm@xmission.com> - unquoted

We need to have the the definition of all top level sysctl
directories registers in sysctl.h so we don't conflict by
accident and cause abi problems.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 arch/s390/appldata/appldata.h |    3 +--
 arch/s390/kernel/debug.c      |    1 -
 arch/s390/mm/cmm.c            |    4 ----
 include/linux/sysctl.h        |    7 +++++++
 4 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/s390/appldata/appldata.h b/arch/s390/appldata/appldata.h
index 0429481..4069b81 100644
--- a/arch/s390/appldata/appldata.h
+++ b/arch/s390/appldata/appldata.h
@@ -21,8 +21,7 @@
 #define APPLDATA_RECORD_NET_SUM_ID	0x03	/* must be < 256 !     */
 #define APPLDATA_RECORD_PROC_ID		0x04
 
-#define CTL_APPLDATA 		2120	/* sysctl IDs, must be unique */
-#define CTL_APPLDATA_TIMER 	2121
+#define CTL_APPLDATA_TIMER 	2121	/* sysctl IDs, must be unique */
 #define CTL_APPLDATA_INTERVAL 	2122
 #define CTL_APPLDATA_MEM	2123
 #define CTL_APPLDATA_OS		2124
diff --git a/arch/s390/kernel/debug.c b/arch/s390/kernel/debug.c
index bb57bc0..c81f8e5 100644
--- a/arch/s390/kernel/debug.c
+++ b/arch/s390/kernel/debug.c
@@ -852,7 +852,6 @@ debug_finish_entry(debug_info_t * id, debug_entry_t* active, int level,
 static int debug_stoppable=1;
 static int debug_active=1;
 
-#define CTL_S390DBF 5677
 #define CTL_S390DBF_STOPPABLE 5678
 #define CTL_S390DBF_ACTIVE 5679
 
diff --git a/arch/s390/mm/cmm.c b/arch/s390/mm/cmm.c
index 607f50e..df733d5 100644
--- a/arch/s390/mm/cmm.c
+++ b/arch/s390/mm/cmm.c
@@ -256,10 +256,6 @@ cmm_skip_blanks(char *cp, char **endp)
 }
 
 #ifdef CONFIG_CMM_PROC
-/* These will someday get removed. */
-#define VM_CMM_PAGES		1111
-#define VM_CMM_TIMED_PAGES	1112
-#define VM_CMM_TIMEOUT		1113
 
 static struct ctl_table cmm_table[];
 
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 71c16b4..56d0161 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -73,6 +73,8 @@ enum
 	CTL_SUNRPC=7249,	/* sunrpc debug */
 	CTL_PM=9899,		/* frv power management */
 	CTL_FRV=9898,		/* frv specific sysctls */
+	CTL_S390DBF=5677,	/* s390 debug */
+	CTL_APPLDATA=2120,	/* s390 appldata */
 };
 
 /* CTL_BUS names: */
@@ -205,6 +207,11 @@ enum
 	VM_PANIC_ON_OOM=33,	/* panic at out-of-memory */
 	VM_VDSO_ENABLED=34,	/* map VDSO into new processes? */
 	VM_MIN_SLAB=35,		 /* Percent pages ignored by zone reclaim */
+
+	/* s390 vm cmm sysctls */
+	VM_CMM_PAGES=1111,
+	VM_CMM_TIMED_PAGES=1112,
+	VM_CMM_TIMEOUT=1113,
 };
 
 
-- 
1.4.4.1.g278f
