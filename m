Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g638BvRw019527
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 3 Jul 2002 01:11:57 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g638BvA1019526
	for linux-mips-outgoing; Wed, 3 Jul 2002 01:11:57 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from iris1.csv.ica.uni-stuttgart.de (iris1.csv.ica.uni-stuttgart.de [129.69.118.2])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g638BmRw019510
	for <linux-mips@oss.sgi.com>; Wed, 3 Jul 2002 01:11:48 -0700
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp (Exim 3.36 #2)
	id 17PfGK-000x2D-00
	for linux-mips@oss.sgi.com; Wed, 03 Jul 2002 10:13:20 +0200
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 17PfIa-0003nx-00
	for <linux-mips@oss.sgi.com>; Wed, 03 Jul 2002 10:15:40 +0200
Date: Wed, 3 Jul 2002 10:15:40 +0200
To: linux-mips@oss.sgi.com
Subject: Re: Small correction for fault.c
Message-ID: <20020703081539.GU16753@rembrandt.csv.ica.uni-stuttgart.de>
References: <20020703144404.4d349037.yoichi_yuasa@montavista.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020703144404.4d349037.yoichi_yuasa@montavista.co.jp>
User-Agent: Mutt/1.3.28i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Yoichi Yuasa wrote:
> Hi,
> 
> I found a include file required for "arch/mips/mm/fault.c".
> This is for unblank_screen().
> 
> --- linux.orig/arch/mips/mm/fault.c     Thu Jun 27 14:14:14 2002
> +++ linux/arch/mips/mm/fault.c  Wed Jul  3 14:37:03 2002
> @@ -19,6 +19,7 @@
>  #include <linux/smp.h>
>  #include <linux/smp_lock.h>
>  #include <linux/version.h>
> +#include <linux/vt_kern.h>

For MIPS64 this fails (MAX_NR_CONSOLES is defined in linux/tty.h):

In file included from fault.c:23:
/bigdisk/combined/source-linux/include/linux/vt_kern.h:32: error:
MAX_NR_CONSOLES' undeclared here (not in a function)

I would prefer the patch below.


Thiemo


diff -BurpNX /bigdisk/src/dontdiff source-linux-orig/arch/mips/mm/fault.c source-linux/arch/mips/mm/fault.c
--- source-linux-orig/arch/mips/mm/fault.c	Sat Jun  1 22:41:25 2002
+++ source-linux/arch/mips/mm/fault.c	Wed Jul  3 10:13:26 2002
@@ -44,6 +44,8 @@ extern spinlock_t timerlist_lock;
  */
 void bust_spinlocks(int yes)
 {
+	extern void unblank_screen(void);
+
 	spin_lock_init(&timerlist_lock);
 	if (yes) {
 		oops_in_progress = 1;
diff -BurpNX /bigdisk/src/dontdiff source-linux-orig/arch/mips64/mm/fault.c source-linux/arch/mips64/mm/fault.c
--- source-linux-orig/arch/mips64/mm/fault.c	Mon Jul  1 12:05:04 2002
+++ source-linux/arch/mips64/mm/fault.c	Wed Jul  3 10:13:26 2002
@@ -66,6 +66,8 @@ extern spinlock_t timerlist_lock;
  */
 void bust_spinlocks(int yes)
 {
+	extern void unblank_screen(void);
+
 	spin_lock_init(&timerlist_lock);
 	if (yes) {
 		oops_in_progress = 1;
