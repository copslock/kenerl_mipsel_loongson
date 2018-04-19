Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Apr 2018 16:41:01 +0200 (CEST)
Received: from mout.kundenserver.de ([217.72.192.74]:60871 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994664AbeDSOjDC2MmB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 19 Apr 2018 16:39:03 +0200
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue101 [212.227.15.145]) with ESMTPA (Nemesis) id
 0MDgWE-1fD0AE2Zuo-00H7Jv; Thu, 19 Apr 2018 16:37:48 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, libc-alpha@sourceware.org,
        tglx@linutronix.de, deepa.kernel@gmail.com,
        viro@zeniv.linux.org.uk, ebiederm@xmission.com,
        albert.aribaud@3adev.fr, linux-s390@vger.kernel.org,
        schwidefsky@de.ibm.com, x86@kernel.org, catalin.marinas@arm.com,
        will.deacon@arm.com, linux-mips@linux-mips.org, jhogan@kernel.org,
        ralf@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org
Subject: [PATCH v3 01/17] y2038: asm-generic: Extend sysvipc data structures
Date:   Thu, 19 Apr 2018 16:37:21 +0200
Message-Id: <20180419143737.606138-2-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180419143737.606138-1-arnd@arndb.de>
References: <20180419143737.606138-1-arnd@arndb.de>
X-Provags-ID: V03:K1:4xrHhOyONM1SnmBBiZZBn0APMxEIEhx+LVcWRJQt3EynvbndZbu
 VoTF7eU1WYMeEVku+X1x4Ei59LCYcejFN+wsErGymyEg6/UXriB9xf+2QohCuwjj1B9iVXT
 XUF1bifhVrEdYUlXhR9AwSTeEo/yvte+S6H//XZNmBqm44lEsx5Vg0w3ITXdh36QhogKpZj
 EGhaSVXJJeFCLJML/FSAw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:o/U3HjYUbjg=:BYXFOB+tOwYJRCHYWLv/hV
 z3jY7I/RvQykLGWQgsrckLNeqa27VqrPTt6tJDckPkJAhhsfBHzCLHi3woigmMkFcZ5o3Lnjn
 QAaBYhLcGo8xB3kAAjzbat0e2tt+VAcXPx4JuPu3rPqX9aoEKNns61G/rDVwb74+NQuIoJqFe
 uA9vC2xZQY7x8wrqDxNO8k6D0zMF8rPqztZ/Unn5ikilMCX0NU3YFt+1lyWzi8rLhx8YGF+GH
 HZIUwtKRX8CP7otx/jy6oylVAE+FHyWm7fj1QHnn+rb5Os6PO0PsXrZihWKVpAc2WurzIRU4Y
 oFTXgqhBxOnDiyUDDK8eRvQW0LswEl2THEVCRPgHH7rFy0Oo9AvZDJSncoOyiA3fvMIONJNy4
 Ei2s0I+zXkmZKSj8rUU9Zu35e4kYPNINZRZLUN8uz0HUvS23lgL6b5hM0gWZgcyGS3nTGTxQg
 My18eFqo2MWAiDZ6Qw4Lcsra0Db05zf7I3gcgAaO3s/o58t5siERfNV1sY51MLXLbwmA+AhUm
 hIThMZoVs9Djl9GQHkojI4TVpayPk9h/xso+JTmzRUvNRSI4zW16PvkM8Aj2VyT/j/fv9WvgL
 09XIxpbqU+hTnLf/NRjJ+jUmXI6VkdCyizBAMX4vukNFzArBMiF33EkXlrzBcQKdcfyAYS9En
 bTNNVd7olgCErO2f+CbFSSo8gDOHoHsmx70+9T7g8kQw9XPDwd/N6hWGN6U9SYzrXKx+VxbFz
 biKQuqKIepOBHAkbFiwADd27N6MxecU/nBQNRg==
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63613
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

Most architectures now use the asm-generic copy of the sysvipc data
structures (msqid64_ds, semid64_ds, shmid64_ds), which use 32-bit
__kernel_time_t on 32-bit architectures but have padding behind them to
allow extending the type to 64-bit.

Unfortunately, that fails on all big-endian architectures, which have the
padding on the wrong side. As so many of them get it wrong, we decided to
not bother even trying to fix it up when we introduced the asm-generic
copy. Instead we always use the padding word now to provide the upper
32 bits of the seconds value, regardless of the endianess.

A libc implementation on a typical big-endian system can deal with
this by providing its own copy of the structure definition to user
space, and swapping the two 32-bit words before returning from the
semctl/shmctl/msgctl system calls.

ARM64 and s/390 are architectures that use these generic headers and
also provide support for compat mode on 64-bit kernels, so we adapt
their copies here as well.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/uapi/asm-generic/msgbuf.h | 17 ++++++++---------
 include/uapi/asm-generic/sembuf.h | 26 ++++++++++++++++----------
 include/uapi/asm-generic/shmbuf.h | 17 ++++++++---------
 3 files changed, 32 insertions(+), 28 deletions(-)

diff --git a/include/uapi/asm-generic/msgbuf.h b/include/uapi/asm-generic/msgbuf.h
index fb306ebdb36f..d2169cae93b8 100644
--- a/include/uapi/asm-generic/msgbuf.h
+++ b/include/uapi/asm-generic/msgbuf.h
@@ -18,23 +18,22 @@
  * On big-endian systems, the padding is in the wrong place.
  *
  * Pad space is left for:
- * - 64-bit time_t to solve y2038 problem
  * - 2 miscellaneous 32-bit values
  */
 
 struct msqid64_ds {
 	struct ipc64_perm msg_perm;
+#if __BITS_PER_LONG == 64
 	__kernel_time_t msg_stime;	/* last msgsnd time */
-#if __BITS_PER_LONG != 64
-	unsigned long	__unused1;
-#endif
 	__kernel_time_t msg_rtime;	/* last msgrcv time */
-#if __BITS_PER_LONG != 64
-	unsigned long	__unused2;
-#endif
 	__kernel_time_t msg_ctime;	/* last change time */
-#if __BITS_PER_LONG != 64
-	unsigned long	__unused3;
+#else
+	unsigned long	msg_stime;	/* last msgsnd time */
+	unsigned long	msg_stime_high;
+	unsigned long	msg_rtime;	/* last msgrcv time */
+	unsigned long	msg_rtime_high;
+	unsigned long	msg_ctime;	/* last change time */
+	unsigned long	msg_ctime_high;
 #endif
 	__kernel_ulong_t msg_cbytes;	/* current number of bytes on queue */
 	__kernel_ulong_t msg_qnum;	/* number of messages in queue */
diff --git a/include/uapi/asm-generic/sembuf.h b/include/uapi/asm-generic/sembuf.h
index cbf9cfe977d6..0bae010f1b64 100644
--- a/include/uapi/asm-generic/sembuf.h
+++ b/include/uapi/asm-generic/sembuf.h
@@ -13,23 +13,29 @@
  * everyone just ended up making identical copies without specific
  * optimizations, so we may just as well all use the same one.
  *
- * 64 bit architectures typically define a 64 bit __kernel_time_t,
+ * 64 bit architectures use a 64-bit __kernel_time_t here, while
+ * 32 bit architectures have a pair of unsigned long values.
  * so they do not need the first two padding words.
- * On big-endian systems, the padding is in the wrong place.
  *
- * Pad space is left for:
- * - 64-bit time_t to solve y2038 problem
- * - 2 miscellaneous 32-bit values
+ * On big-endian systems, the padding is in the wrong place for
+ * historic reasons, so user space has to reconstruct a time_t
+ * value using
+ *
+ * user_semid_ds.sem_otime = kernel_semid64_ds.sem_otime +
+ *		((long long)kernel_semid64_ds.sem_otime_high << 32)
+ *
+ * Pad space is left for 2 miscellaneous 32-bit values
  */
 struct semid64_ds {
 	struct ipc64_perm sem_perm;	/* permissions .. see ipc.h */
+#if __BITS_PER_LONG == 64
 	__kernel_time_t	sem_otime;	/* last semop time */
-#if __BITS_PER_LONG != 64
-	unsigned long	__unused1;
-#endif
 	__kernel_time_t	sem_ctime;	/* last change time */
-#if __BITS_PER_LONG != 64
-	unsigned long	__unused2;
+#else
+	unsigned long	sem_otime;	/* last semop time */
+	unsigned long	sem_otime_high;
+	unsigned long	sem_ctime;	/* last change time */
+	unsigned long	sem_ctime_high;
 #endif
 	unsigned long	sem_nsems;	/* no. of semaphores in array */
 	unsigned long	__unused3;
diff --git a/include/uapi/asm-generic/shmbuf.h b/include/uapi/asm-generic/shmbuf.h
index 2b6c3bb97f97..602f1b5b462b 100644
--- a/include/uapi/asm-generic/shmbuf.h
+++ b/include/uapi/asm-generic/shmbuf.h
@@ -19,24 +19,23 @@
  *
  *
  * Pad space is left for:
- * - 64-bit time_t to solve y2038 problem
  * - 2 miscellaneous 32-bit values
  */
 
 struct shmid64_ds {
 	struct ipc64_perm	shm_perm;	/* operation perms */
 	size_t			shm_segsz;	/* size of segment (bytes) */
+#if __BITS_PER_LONG == 64
 	__kernel_time_t		shm_atime;	/* last attach time */
-#if __BITS_PER_LONG != 64
-	unsigned long		__unused1;
-#endif
 	__kernel_time_t		shm_dtime;	/* last detach time */
-#if __BITS_PER_LONG != 64
-	unsigned long		__unused2;
-#endif
 	__kernel_time_t		shm_ctime;	/* last change time */
-#if __BITS_PER_LONG != 64
-	unsigned long		__unused3;
+#else
+	unsigned long		shm_atime;	/* last attach time */
+	unsigned long		shm_atime_high;
+	unsigned long		shm_dtime;	/* last detach time */
+	unsigned long		shm_dtime_high;
+	unsigned long		shm_ctime;	/* last change time */
+	unsigned long		shm_ctime_high;
 #endif
 	__kernel_pid_t		shm_cpid;	/* pid of creator */
 	__kernel_pid_t		shm_lpid;	/* pid of last operator */
-- 
2.9.0
