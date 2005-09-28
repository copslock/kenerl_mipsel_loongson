Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Sep 2005 12:34:55 +0100 (BST)
Received: from topsns.toshiba-tops.co.jp ([202.230.225.5]:1830 "HELO
	topsns.toshiba-tops.co.jp") by ftp.linux-mips.org with SMTP
	id S8133585AbVI1Led (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 28 Sep 2005 12:34:33 +0100
Received: from inside-ms1.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 28 Sep 2005 11:34:31 UT
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 4BC561FE1B;
	Wed, 28 Sep 2005 20:34:30 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 368941FE13;
	Wed, 28 Sep 2005 20:34:30 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id j8SBYToj016584;
	Wed, 28 Sep 2005 20:34:30 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Wed, 28 Sep 2005 20:34:29 +0900 (JST)
Message-Id: <20050928.203429.02302175.nemoto@toshiba-tops.co.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: missing data cache flush for signal trampoline on fork
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9061
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Hi.  The attached test program which is heavily using signal and fork
occasionally killed by SIGSEG, etc.  When it was killed, PC is always
near the stack pointer.

This would happen on CPUs without MIPS_CACHE_IC_F_DC.  D-cache
aliasing is irrelevant.

1. To handle the signal (SIGUSR1), signal-trampoline code are written
to the stack page.

2. They are flushed to memory immediately and I-cache are invalidated.

3. If other thread called fork() before the signal handler is
executed, all writable page (including the stack page) are marked as
COW page.

4. When the user signal handler is to write to the stack, the page
will be copied to new physical page by copy_user_page(), but not
flushed to main memory.  copy_user_page() use kernel virtual address
to copy the data.

5. Then flush_cache_page() is called for the stack page, but it uses
user virtual address and Hit_Invalidate_Writeback_D.  This does not
flush the cache written by copy_user_page().

6. When returned from the user signal handler, the signal trampoline
code might not be written to main memory.  Garbage code will be
executed and the program die.

Here is a test program.

#include <stdio.h>
#include <stdlib.h>
#include <signal.h>
#include <pthread.h>
#include <unistd.h>
#include <sys/types.h>

void sighandler(int sig)
{
	int a;
	*(volatile int *)&a = 0;
}

void *thread_func(void *arg)
{
	pid_t pid = getpid();
	struct sigaction act;
	memset(&act, 0, sizeof(act));
	act.sa_handler = sighandler;
	act.sa_flags = SA_NOMASK | SA_RESTART;
	sigaction(SIGUSR1, &act, 0);
	sig_count = 0;
	while (1)
		kill(pid, SIGUSR1);
}

int
main(int argc, char *argv[])
{
	int i;
	pid_t pid;
	pthread_t tid;
	for (i = 0; i < 4; i++)
		pthread_create(&tid, NULL, thread_func, NULL);
	for (i = 0; i < 1000; i++) {
		pid = fork();
		if (pid == -1) {
			perror("fork");
			exit(1);
		}
		if (pid)
			waitpid(pid, NULL, 0);
		else
			exit(0);
	}
	return 0;
}


If I used indexed-flush for executable page in flush_cache_page(), the
problem disappear.  Is this a right fix?


diff -u linux-mips/arch/mips/mm/c-r4k.c linux/arch/mips/mm/c-r4k.c
--- linux-mips/arch/mips/mm/c-r4k.c	2005-09-22 10:38:23.000000000 +0900
+++ linux/arch/mips/mm/c-r4k.c	2005-09-28 18:50:56.000000000 +0900
@@ -409,15 +409,11 @@
 	 * for every cache flush operation.  So we do indexed flushes
 	 * in that case, which doesn't overly flush the cache too much.
 	 */
-	if ((mm == current->active_mm) && (pte_val(*ptep) & _PAGE_VALID)) {
-		if (cpu_has_dc_aliases || (exec && !cpu_has_ic_fills_f_dc)) {
+	if ((mm == current->active_mm) && (pte_val(*ptep) & _PAGE_VALID) &&
+	    !(exec && !cpu_has_ic_fills_f_dc)) {
+		if (cpu_has_dc_aliases) {
 			r4k_blast_dcache_page(page);
-			if (exec && !cpu_icache_snoops_remote_store)
-				r4k_blast_scache_page(page);
 		}
-		if (exec)
-			r4k_blast_icache_page(page);
-
 		return;
 	}
 
diff -u linux-mips/arch/mips/mm/c-tx39.c linux/arch/mips/mm/c-tx39.c
--- linux-mips/arch/mips/mm/c-tx39.c	2005-09-05 10:16:59.000000000 +0900
+++ linux/arch/mips/mm/c-tx39.c	2005-09-28 18:51:43.000000000 +0900
@@ -213,12 +213,10 @@
 	 * for every cache flush operation.  So we do indexed flushes
 	 * in that case, which doesn't overly flush the cache too much.
 	 */
-	if ((mm == current->active_mm) && (pte_val(*ptep) & _PAGE_VALID)) {
-		if (cpu_has_dc_aliases || exec)
+	if ((mm == current->active_mm) && (pte_val(*ptep) & _PAGE_VALID) &&
+	    !exec) {
+		if (cpu_has_dc_aliases)
 			tx39_blast_dcache_page(page);
-		if (exec)
-			tx39_blast_icache_page(page);
-
 		return;
 	}
 

---
Atsushi Nemoto
