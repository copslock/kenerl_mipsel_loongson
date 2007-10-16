Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Oct 2007 18:48:32 +0100 (BST)
Received: from E23SMTP06.au.ibm.com ([202.81.18.175]:54159 "EHLO
	e23smtp06.au.ibm.com") by ftp.linux-mips.org with ESMTP
	id S20027704AbXJPRsA (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 16 Oct 2007 18:48:00 +0100
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.18.234])
	by e23smtp06.au.ibm.com (8.13.1/8.13.1) with ESMTP id l9GHlpLM027524;
	Wed, 17 Oct 2007 03:47:51 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id l9GHlp7L548912;
	Wed, 17 Oct 2007 03:47:52 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l9GHixvh015326;
	Wed, 17 Oct 2007 03:44:59 +1000
Received: from gondor.in.ibm.com ([9.124.219.197])
	by d23av01.au.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id l9GHiwQR015114;
	Wed, 17 Oct 2007 03:44:58 +1000
Received: from gondor.in.ibm.com (gondor.in.ibm.com [127.0.0.1])
	by gondor.in.ibm.com (Postfix) with ESMTP id ABDCC2457DC;
	Tue, 16 Oct 2007 23:10:17 +0530 (IST)
Received: (from dhaval@localhost)
	by gondor.in.ibm.com (8.14.1/8.14.1/Submit) id l9GHeGn9005845;
	Tue, 16 Oct 2007 23:10:16 +0530
Date:	Tue, 16 Oct 2007 23:10:16 +0530
From:	Dhaval Giani <dhaval@linux.vnet.ibm.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
	Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>
Subject: Re: Build breakage if !SYSFS
Message-ID: <20071016174016.GC5693@linux.vnet.ibm.com>
Reply-To: Dhaval Giani <dhaval@linux.vnet.ibm.com>
References: <20071016130231.GA10778@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071016130231.GA10778@linux-mips.org>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <dhaval@linux.vnet.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17074
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dhaval@linux.vnet.ibm.com
Precedence: bulk
X-list: linux-mips

On Tue, Oct 16, 2007 at 02:02:31PM +0100, Ralf Baechle wrote:
> Changeset 5cb350baf580017da38199625b7365b1763d7180 causes build breakage
> if sysfs support is disabled:
> 
> kernel/built-in.o: In function `uids_kobject_init':
> (.init.text+0x1488): undefined reference to `kernel_subsys'
> kernel/built-in.o: In function `uids_kobject_init':
> (.init.text+0x1490): undefined reference to `kernel_subsys'
> kernel/built-in.o: In function `uids_kobject_init':
> (.init.text+0x1480): undefined reference to `kernel_subsys'
> kernel/built-in.o: In function `uids_kobject_init':
> (.init.text+0x1494): undefined reference to `kernel_subsys'
> 
> This breaks for example mipssim_defconfig.
> 
>   Ralf

Hi Ralf,

Can you try this and confirm if it works?

--

When CONFIG_SYSFS is not set, CONFIG_FAIR_USER_SCHED fails to build
with

kernel/built-in.o: In function `uids_kobject_init':
(.init.text+0x1488): undefined reference to `kernel_subsys'
kernel/built-in.o: In function `uids_kobject_init':
(.init.text+0x1490): undefined reference to `kernel_subsys'
kernel/built-in.o: In function `uids_kobject_init':
(.init.text+0x1480): undefined reference to `kernel_subsys'
kernel/built-in.o: In function `uids_kobject_init':
(.init.text+0x1494): undefined reference to `kernel_subsys'

This patch fixes this build error.

Signed-off-by: Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>
Signed-off-by: Dhaval Giani <dhaval@linux.vnet.ibm.com>

---
 include/linux/sched.h |    2 ++
 kernel/user.c         |   23 +++++++++++++++--------
 2 files changed, 17 insertions(+), 8 deletions(-)

Index: current/include/linux/sched.h
===================================================================
--- current.orig/include/linux/sched.h
+++ current/include/linux/sched.h
@@ -602,10 +602,12 @@ struct user_struct {
 
 #ifdef CONFIG_FAIR_USER_SCHED
 	struct task_group *tg;
+#ifdef CONFIG_SYSFS
 	struct kset kset;
 	struct subsys_attribute user_attr;
 	struct work_struct work;
 #endif
+#endif
 };
 
 #ifdef CONFIG_FAIR_USER_SCHED
Index: current/kernel/user.c
===================================================================
--- current.orig/kernel/user.c
+++ current/kernel/user.c
@@ -87,9 +87,6 @@ static inline struct user_struct *uid_ha
 
 #ifdef CONFIG_FAIR_USER_SCHED
 
-static struct kobject uids_kobject; /* represents /sys/kernel/uids directory */
-static DEFINE_MUTEX(uids_mutex);
-
 static void sched_destroy_user(struct user_struct *up)
 {
 	sched_destroy_group(up->tg);
@@ -111,6 +108,19 @@ static void sched_switch_user(struct tas
 	sched_move_task(p);
 }
 
+#else	/* CONFIG_FAIR_USER_SCHED */
+
+static void sched_destroy_user(struct user_struct *up) { }
+static int sched_create_user(struct user_struct *up) { return 0; }
+static void sched_switch_user(struct task_struct *p) { }
+
+#endif	/* CONFIG_FAIR_USER_SCHED */
+
+#if defined(CONFIG_FAIR_USER_SCHED) && defined(CONFIG_SYSFS)
+
+static struct kobject uids_kobject; /* represents /sys/kernel/uids directory */
+static DEFINE_MUTEX(uids_mutex);
+
 static inline void uids_mutex_lock(void)
 {
 	mutex_lock(&uids_mutex);
@@ -257,11 +267,8 @@ static inline void free_user(struct user
 	schedule_work(&up->work);
 }
 
-#else	/* CONFIG_FAIR_USER_SCHED */
+#else	/* CONFIG_FAIR_USER_SCHED && CONFIG_SYSFS */
 
-static void sched_destroy_user(struct user_struct *up) { }
-static int sched_create_user(struct user_struct *up) { return 0; }
-static void sched_switch_user(struct task_struct *p) { }
 static inline int user_kobject_create(struct user_struct *up) { return 0; }
 static inline void uids_mutex_lock(void) { }
 static inline void uids_mutex_unlock(void) { }
@@ -280,7 +287,7 @@ static inline void free_user(struct user
 	kmem_cache_free(uid_cachep, up);
 }
 
-#endif	/* CONFIG_FAIR_USER_SCHED */
+#endif
 
 /*
  * Locate the user_struct for the passed UID.  If found, take a ref on it.  The

-- 
regards,
Dhaval
