Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Apr 2018 17:07:16 +0200 (CEST)
Received: from mout.kundenserver.de ([212.227.126.187]:43503 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990493AbeDYPHJTFw8C (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Apr 2018 17:07:09 +0200
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue002 [212.227.15.129]) with ESMTPA (Nemesis) id
 0ME6mN-1fB5oC2lEl-00HQs4; Wed, 25 Apr 2018 17:06:19 +0200
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
Subject: [PATCH v4 01/16] y2038: asm-generic: Extend sysvipc data structures
Date:   Wed, 25 Apr 2018 17:05:51 +0200
Message-Id: <20180425150606.954771-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180425132242.1500539-1-arnd@arndb.de>
References: <20180425132242.1500539-1-arnd@arndb.de>
X-Provags-ID: V03:K1:rzofm/IKNbWPqr4GjH0nXJtjoQAqLmjGLl4jPaangeBZGAU/3ID
 BXqS+Wo6W6wCrzvu4OeX9NstTEhNyOAzesPGsgDacgSgdKkF5uwhOI2wQEGmw4HtAC3gtpu
 gRSuUH5aqKshxU+nPAeaPviSL9kZUPMsdKxx51YbOPhjGaRCvYvPJch9e36xao46BG2CP9X
 bFG5vafR8T3e79vP1ohBg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:J+Cr7WiJN14=:OjPrDbxR1F6EpxUh6UxkIj
 zoDhplfpbIEdabXqD5fy5JLCUVbIjI452WuTZ08UpLMARTN35GkR0wi3jQ7g2iMwxBw3E6jJN
 labRbFM+t717ELT9gLSKspp0Sm3rzVR8VUWoDeOci9MKOKSy2zoUBf8BowxOspls0HpHZPXQn
 AUJ+pZe5z/36Ob0PvMQXW+kIvrpI1YMoOo37uz8yR4897qeCXe8sgrcFPI4COJwWrZtwzgi04
 3g3WlHwsVklNKteJHkD3diAMF1wnebfk2zQ+aIA1e+H15VP9rFljY0oQ9teYn8Nqyl0u1ADbP
 qTy0/J0eNHMf54vOjzC3GyFWoNYQYk9sfgjkj27Utkr5uoeU4ft35HNQMNo2dHjPYS7dZFvkM
 zbdWL8E0XPL/bRLXEQANahoYtylri+cpaRN83ekoL3EDaBS2xfbEuiw7FKxmrkd5tbgewPrl6
 uPf56CYDGmGlcErPO6wmvAWD0MNZtQ6vv7Gm3LFbM55+aM+T8xM7X7XWyHq/N4MQllxMGU0fw
 UjOoR6OoaFpPbUfhLq01jvdJrvH/QYbfoVcrN68Jx+kV3ajDVXfInDSBRfwzrnQhCYy7QDbAg
 EHnZfsNApmXHG6vXK+4kQ1kV51FuNrb6eU7/NI7j4ITjKWjcdYJwkcC2skQtSYXYj+TdLEzrv
 7QL3IeSHNDn0b0QsZJKcocT8H4GKglqV72PSMRrfb67mve/C9pA8UDkgonXOwE010ebtu3PqD
 NNWOVQ7p5e2RxbA1I1d1yimR8zf0HthvqajScQ==
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63762
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

Note that msqid64_ds and shmid64_ds were broken on x32 since commit
f4b4aae18288 ("x86/headers/uapi: Fix __BITS_PER_LONG value for x32
builds"). I have sent a separate fix for that, but as we no longer
have to worry about x32 here, I no longer worry about x32 here and
use 'unsigned long' instead of __kernel_ulong_t.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/uapi/asm-generic/msgbuf.h | 27 +++++++++++++-------------
 include/uapi/asm-generic/sembuf.h | 26 +++++++++++++++----------
 include/uapi/asm-generic/shmbuf.h | 41 +++++++++++++++++++--------------------
 3 files changed, 49 insertions(+), 45 deletions(-)

diff --git a/include/uapi/asm-generic/msgbuf.h b/include/uapi/asm-generic/msgbuf.h
index fb306ebdb36f..9fe4881557cb 100644
--- a/include/uapi/asm-generic/msgbuf.h
+++ b/include/uapi/asm-generic/msgbuf.h
@@ -18,31 +18,30 @@
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
-	__kernel_ulong_t msg_cbytes;	/* current number of bytes on queue */
-	__kernel_ulong_t msg_qnum;	/* number of messages in queue */
-	__kernel_ulong_t msg_qbytes;	/* max number of bytes on queue */
+	unsigned long	msg_cbytes;	/* current number of bytes on queue */
+	unsigned long	msg_qnum;	/* number of messages in queue */
+	unsigned long	 msg_qbytes;	/* max number of bytes on queue */
 	__kernel_pid_t msg_lspid;	/* pid of last msgsnd */
 	__kernel_pid_t msg_lrpid;	/* last receive pid */
-	__kernel_ulong_t __unused4;
-	__kernel_ulong_t __unused5;
+	unsigned long	 __unused4;
+	unsigned long	 __unused5;
 };
 
 #endif /* __ASM_GENERIC_MSGBUF_H */
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
index 2b6c3bb97f97..e504422fc501 100644
--- a/include/uapi/asm-generic/shmbuf.h
+++ b/include/uapi/asm-generic/shmbuf.h
@@ -19,42 +19,41 @@
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
-	__kernel_ulong_t	shm_nattch;	/* no. of current attaches */
-	__kernel_ulong_t	__unused4;
-	__kernel_ulong_t	__unused5;
+	unsigned long		shm_nattch;	/* no. of current attaches */
+	unsigned long		__unused4;
+	unsigned long		__unused5;
 };
 
 struct shminfo64 {
-	__kernel_ulong_t	shmmax;
-	__kernel_ulong_t	shmmin;
-	__kernel_ulong_t	shmmni;
-	__kernel_ulong_t	shmseg;
-	__kernel_ulong_t	shmall;
-	__kernel_ulong_t	__unused1;
-	__kernel_ulong_t	__unused2;
-	__kernel_ulong_t	__unused3;
-	__kernel_ulong_t	__unused4;
+	unsigned long		shmmax;
+	unsigned long		shmmin;
+	unsigned long		shmmni;
+	unsigned long		shmseg;
+	unsigned long		shmall;
+	unsigned long		__unused1;
+	unsigned long		__unused2;
+	unsigned long		__unused3;
+	unsigned long		__unused4;
 };
 
 #endif /* __ASM_GENERIC_SHMBUF_H */
-- 
2.9.0
