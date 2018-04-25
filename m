Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Apr 2018 17:08:16 +0200 (CEST)
Received: from mout.kundenserver.de ([212.227.126.133]:59191 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994585AbeDYPHS10N5C (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Apr 2018 17:07:18 +0200
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue002 [212.227.15.129]) with ESMTPA (Nemesis) id
 0MBvyp-1f4WEW3d6l-00ArI0; Wed, 25 Apr 2018 17:06:28 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org
Cc:     linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        libc-alpha@sourceware.org, tglx@linutronix.de,
        deepa.kernel@gmail.com, viro@zeniv.linux.org.uk,
        ebiederm@xmission.com, albert.aribaud@3adev.fr,
        linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, x86@kernel.org,
        catalin.marinas@arm.com, will.deacon@arm.com,
        linux-mips@linux-mips.org, jhogan@kernel.org, ralf@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        zackw@panix.com, noloader@gmail.com, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v4 10/16] y2038: powerpc: Extend sysvipc data structures
Date:   Wed, 25 Apr 2018 17:06:00 +0200
Message-Id: <20180425150606.954771-10-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180425132242.1500539-1-arnd@arndb.de>
References: <20180425132242.1500539-1-arnd@arndb.de>
X-Provags-ID: V03:K1:AJ/tef5cJddhW1oEuNpeQuPNKtgCoKDvB1vagfpfQTDk7kjak14
 aU/h2enflkBXfdgRYmCiaCjLk4dTQVOv364fTXKduL3JD0k+IV18+FG/wJrmAT+dOQ1CugE
 uyFfpHzznWGu536KEoBgVmqD5zRf9bUkZBQ0rsvKKMUT9DSrwmhC20LABsy/k0t56v3N2jA
 8xEpW4zb8mWiquIIgetAA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:SmonRXXo8Ic=:apgSAv9A4yY7Lucdjcl/es
 qXlEtAygRHBR+0td32zGr1ZY1WD3e4pPUWQsZXmgOF6NXUHz9N98WkSktEOUFCXh2QtDxS/Pd
 pr2QASNIqQT2s8g7yLU2iXFyDNm6xGccSom33N9AMTPSpCEYYHqcyR9XSBvTQ9ner9TmHvCPc
 zAhkHjQ7RXnX5qFrvQxpq8QRJ/Z4wFjQxrdV3aWy/Vl7GPz/LjorzJ/1WtIVyGfhb/OjlADSQ
 yUaSRdK/mn7HgbGT+1Sj/m4Ogm/yPhlc23+dQDpVlZwu1b11A4eahwi0B+EQr8hdYtGopWQa7
 5i6KwSL0YqpTMCQkaPEyF5KJm3ZwsFsleiplyIeEjiIqlpvnULfcNfAkkJYnfvn8nzlsdUbuM
 hRRAk2RuoO7tXjqfVkC6Hm+94tVkgaV6ztyzytdFBhnMH1aDCEgkB6n0g7goZBubQCwSLi3tO
 tcCBQMjre4VB2xetZnHpJ7A5rupBoDZY98T8jW155KfpUKlipIG2qeONELG3cN8PnKEvebUbR
 Vz5234JkaGt2h3opNutvUUaxB5Y7h4pVAuOzrybHFGMw8ng/pig6IDz4ozsJbVOjuIzslg5rU
 lAKjO52Ogppsk7D/VOgiOz1neLcjzYwHsgXa0jKPYzWCZd32BMB/Xna0bYwIFqwVPloW8HsBM
 MngPg9ZbtgJgGBZrjzYxmf1SgIXsGY9ZjKaKIV1EPFkno0Big5kKjwSmXkGMgXv/ZRVC4TOpy
 L5r/bECriMwSbFDokJafYEsQrPHtI55fx7QUGg==
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63766
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

powerpc, uses a nonstandard variation of the generic sysvipc
data structures, intended to have the padding moved around
so it can deal with big-endian 32-bit user space that has
64-bit time_t.

powerpc has the same definition as parisc and sparc, but now also
supports little-endian mode, which is now wrong because the
padding is made for big-endian user space.

This takes just take the same approach here that we have for
the asm-generic headers and adds separate 32-bit fields for the
upper halves of the timestamps, to let libc deal with the mess
in user space.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/include/asm/compat.h      | 32 ++++++++++++++++----------------
 arch/powerpc/include/uapi/asm/msgbuf.h | 18 +++++++++---------
 arch/powerpc/include/uapi/asm/sembuf.h | 14 +++++++-------
 arch/powerpc/include/uapi/asm/shmbuf.h | 19 ++++++++-----------
 4 files changed, 40 insertions(+), 43 deletions(-)

diff --git a/arch/powerpc/include/asm/compat.h b/arch/powerpc/include/asm/compat.h
index b4773c81f7d5..85c8af2bb272 100644
--- a/arch/powerpc/include/asm/compat.h
+++ b/arch/powerpc/include/asm/compat.h
@@ -162,10 +162,10 @@ struct compat_ipc64_perm {
 
 struct compat_semid64_ds {
 	struct compat_ipc64_perm sem_perm;
-	unsigned int __unused1;
-	compat_time_t sem_otime;
-	unsigned int __unused2;
-	compat_time_t sem_ctime;
+	unsigned int sem_otime_high;
+	unsigned int sem_otime;
+	unsigned int sem_ctime_high;
+	unsigned int sem_ctime;
 	compat_ulong_t sem_nsems;
 	compat_ulong_t __unused3;
 	compat_ulong_t __unused4;
@@ -173,12 +173,12 @@ struct compat_semid64_ds {
 
 struct compat_msqid64_ds {
 	struct compat_ipc64_perm msg_perm;
-	unsigned int __unused1;
-	compat_time_t msg_stime;
-	unsigned int __unused2;
-	compat_time_t msg_rtime;
-	unsigned int __unused3;
-	compat_time_t msg_ctime;
+	unsigned int msg_stime_high;
+	unsigned int msg_stime;
+	unsigned int msg_rtime_high;
+	unsigned int msg_rtime;
+	unsigned int msg_ctime_high;
+	unsigned int msg_ctime;
 	compat_ulong_t msg_cbytes;
 	compat_ulong_t msg_qnum;
 	compat_ulong_t msg_qbytes;
@@ -190,12 +190,12 @@ struct compat_msqid64_ds {
 
 struct compat_shmid64_ds {
 	struct compat_ipc64_perm shm_perm;
-	unsigned int __unused1;
-	compat_time_t shm_atime;
-	unsigned int __unused2;
-	compat_time_t shm_dtime;
-	unsigned int __unused3;
-	compat_time_t shm_ctime;
+	unsigned int shm_atime_high;
+	unsigned int shm_atime;
+	unsigned int shm_dtime_high;
+	unsigned int shm_dtime;
+	unsigned int shm_ctime_high;
+	unsigned int shm_ctime;
 	unsigned int __unused4;
 	compat_size_t shm_segsz;
 	compat_pid_t shm_cpid;
diff --git a/arch/powerpc/include/uapi/asm/msgbuf.h b/arch/powerpc/include/uapi/asm/msgbuf.h
index 65beb0942500..2b1b37797a47 100644
--- a/arch/powerpc/include/uapi/asm/msgbuf.h
+++ b/arch/powerpc/include/uapi/asm/msgbuf.h
@@ -10,18 +10,18 @@
 
 struct msqid64_ds {
 	struct ipc64_perm msg_perm;
-#ifndef __powerpc64__
-	unsigned int	__unused1;
-#endif
+#ifdef __powerpc64__
 	__kernel_time_t msg_stime;	/* last msgsnd time */
-#ifndef __powerpc64__
-	unsigned int	__unused2;
-#endif
 	__kernel_time_t msg_rtime;	/* last msgrcv time */
-#ifndef __powerpc64__
-	unsigned int	__unused3;
-#endif
 	__kernel_time_t msg_ctime;	/* last change time */
+#else
+	unsigned long  msg_stime_high;
+	unsigned long  msg_stime;	/* last msgsnd time */
+	unsigned long  msg_rtime_high;
+	unsigned long  msg_rtime;	/* last msgrcv time */
+	unsigned long  msg_ctime_high;
+	unsigned long  msg_ctime;	/* last change time */
+#endif
 	unsigned long  msg_cbytes;	/* current number of bytes on queue */
 	unsigned long  msg_qnum;	/* number of messages in queue */
 	unsigned long  msg_qbytes;	/* max number of bytes on queue */
diff --git a/arch/powerpc/include/uapi/asm/sembuf.h b/arch/powerpc/include/uapi/asm/sembuf.h
index 8f393d60f02d..3f60946f77e3 100644
--- a/arch/powerpc/include/uapi/asm/sembuf.h
+++ b/arch/powerpc/include/uapi/asm/sembuf.h
@@ -15,20 +15,20 @@
  * between kernel and user space.
  *
  * Pad space is left for:
- * - 64-bit time_t to solve y2038 problem
- * - 2 miscellaneous 32-bit values
+ * - 2 miscellaneous 32/64-bit values
  */
 
 struct semid64_ds {
 	struct ipc64_perm sem_perm;	/* permissions .. see ipc.h */
 #ifndef __powerpc64__
-	unsigned long	__unused1;
-#endif
+	unsigned long	sem_otime_high;
+	unsigned long	sem_otime;	/* last semop time */
+	unsigned long	sem_ctime_high;
+	unsigned long	sem_ctime;	/* last change time */
+#else
 	__kernel_time_t	sem_otime;	/* last semop time */
-#ifndef __powerpc64__
-	unsigned long	__unused2;
-#endif
 	__kernel_time_t	sem_ctime;	/* last change time */
+#endif
 	unsigned long	sem_nsems;	/* no. of semaphores in array */
 	unsigned long	__unused3;
 	unsigned long	__unused4;
diff --git a/arch/powerpc/include/uapi/asm/shmbuf.h b/arch/powerpc/include/uapi/asm/shmbuf.h
index deb1c3e503d3..b591c4d7e4c5 100644
--- a/arch/powerpc/include/uapi/asm/shmbuf.h
+++ b/arch/powerpc/include/uapi/asm/shmbuf.h
@@ -16,25 +16,22 @@
  * between kernel and user space.
  *
  * Pad space is left for:
- * - 64-bit time_t to solve y2038 problem
  * - 2 miscellaneous 32-bit values
  */
 
 struct shmid64_ds {
 	struct ipc64_perm	shm_perm;	/* operation perms */
-#ifndef __powerpc64__
-	unsigned long		__unused1;
-#endif
+#ifdef __powerpc64__
 	__kernel_time_t		shm_atime;	/* last attach time */
-#ifndef __powerpc64__
-	unsigned long		__unused2;
-#endif
 	__kernel_time_t		shm_dtime;	/* last detach time */
-#ifndef __powerpc64__
-	unsigned long		__unused3;
-#endif
 	__kernel_time_t		shm_ctime;	/* last change time */
-#ifndef __powerpc64__
+#else
+	unsigned long		shm_atime_high;
+	unsigned long		shm_atime;	/* last attach time */
+	unsigned long		shm_dtime_high;
+	unsigned long		shm_dtime;	/* last detach time */
+	unsigned long		shm_ctime_high;
+	unsigned long		shm_ctime;	/* last change time */
 	unsigned long		__unused4;
 #endif
 	size_t			shm_segsz;	/* size of segment (bytes) */
-- 
2.9.0
