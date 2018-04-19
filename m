Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Apr 2018 16:39:57 +0200 (CEST)
Received: from mout.kundenserver.de ([212.227.17.10]:60849 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994588AbeDSOi4LvGrB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 19 Apr 2018 16:38:56 +0200
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue101 [212.227.15.145]) with ESMTPA (Nemesis) id
 0MDgWE-1fD0CC1pZ0-00H7Jv; Thu, 19 Apr 2018 16:37:54 +0200
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
Subject: [PATCH v3 08/17] y2038: parisc: Extend sysvipc data structures
Date:   Thu, 19 Apr 2018 16:37:28 +0200
Message-Id: <20180419143737.606138-9-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180419143737.606138-1-arnd@arndb.de>
References: <20180419143737.606138-1-arnd@arndb.de>
X-Provags-ID: V03:K1:hXsofrq6YYoHsNTaoTZjQIKNVgChazLtmXpnvEIFkAtnMp0Ugk6
 uBnxFoKt0D3l8KFmm0GLrVKeinuGAo+WZfBw4KfeCoQPIpzVxoj+3Lfp756lyk9Eyngcr59
 mN2VEbXMpbWksrttrlRw8WnwCUZGylUcXSKM2omfkKv78XuohsFRnrqvyvKrjWQIsyy7Rzc
 oqE7G316dZiBbGBSdiZbg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:vD4RPaVT6R0=:0O6PVWnhY80zW8xGWOVbjv
 6HK08EPQq4k3wxVLiyh5nZHy0mBKzvaj4HEcu60UiHfdOxa1XsMIOuj2p5OdANSlvuW/CV/aX
 iRKbM5AMqsvBMPsSTeIVyxfSl3dzaUTKNnjHm7T4D67jrCAJeXZN4RmQBrAa3vv7S5etL6v5z
 NWTGjVLPJK3eUKJNa/EKj1rTjg7gwscmiYjLVjmxRVpHJ0AIthrJDOh4qlkrHZ6LJmH2YVtJh
 hX33hkMOsWnbgsg612fdcAT+Z6mw4jaZqgkwFCx9/m8KXoLRHED68u2D0A0TZafe02hRakXq1
 aVw6t3LHmrqMZb0wgSjsNvARVWqLJh+o7C6TIcOkf2tomhJwv0y+SLMvkrMVsfRuyRQ3E1HEC
 whv+8CNaN3mn3vndIYq8MN/vVqgnnh7ayl6hbtQU7dx4N3lbT9QW2fGNSqeYGImCUMaTI+PMN
 g5JtV9LJQCTcnsIn6KOBxKi7bJhfB4zCTM2k4ZCeIQLZ6cSELWm02QY7C00uFjMAePj+mHTuK
 lUQ0CyGZCr3eL0mrHhd7NC4Z0jS/hPd3d2tY2awaQt01+qid5pfq4BygLU+OSWWZ1aN4VKCf0
 0k/zGaQIGxonV4Wh2Zq7hnIqPMjVTBptoLbjkzrcH+Xkh/luLQN6zo1TumCMJC0VJ4A9OgSva
 XzZhplU3A3Cd0bDgVphQyvy8+dxNfQy61ktpAIgElHvkmXQPjIgMoBg2v+8Sx8/oJin7M9qM2
 kPoZa4F8+wG2FBJiI1t+OdckKzBf4THwl+daDA==
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63609
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

parisc, uses a nonstandard variation of the generic sysvipc
data structures, intended to have the padding moved around
so it can deal with big-endian 32-bit user space that has
64-bit time_t.

Unlike most architectures, parisc actually succeeded in
defining this right for big-endian CPUs, but as everyone else
got it wrong, we just use the same hack everywhere.

This takes just take the same approach here that we have for
the asm-generic headers and adds separate 32-bit fields for the
upper halves of the timestamps, to let libc deal with the mess
in user space.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/parisc/include/asm/compat.h      | 32 ++++++++++++++++----------------
 arch/parisc/include/uapi/asm/msgbuf.h | 33 ++++++++++++++++-----------------
 arch/parisc/include/uapi/asm/sembuf.h | 16 ++++++++--------
 arch/parisc/include/uapi/asm/shmbuf.h | 19 ++++++++-----------
 4 files changed, 48 insertions(+), 52 deletions(-)

diff --git a/arch/parisc/include/asm/compat.h b/arch/parisc/include/asm/compat.h
index 0cdfec8857bd..ab8a54771507 100644
--- a/arch/parisc/include/asm/compat.h
+++ b/arch/parisc/include/asm/compat.h
@@ -138,10 +138,10 @@ struct compat_ipc64_perm {
 
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
@@ -149,12 +149,12 @@ struct compat_semid64_ds {
 
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
@@ -166,12 +166,12 @@ struct compat_msqid64_ds {
 
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
diff --git a/arch/parisc/include/uapi/asm/msgbuf.h b/arch/parisc/include/uapi/asm/msgbuf.h
index b48b810e626b..6a2e9ab2ef8d 100644
--- a/arch/parisc/include/uapi/asm/msgbuf.h
+++ b/arch/parisc/include/uapi/asm/msgbuf.h
@@ -10,31 +10,30 @@
  * between kernel and user space.
  *
  * Pad space is left for:
- * - 64-bit time_t to solve y2038 problem
  * - 2 miscellaneous 32-bit values
  */
 
 struct msqid64_ds {
 	struct ipc64_perm msg_perm;
-#if __BITS_PER_LONG != 64
-	unsigned int   __pad1;
-#endif
+#if __BITS_PER_LONG == 64
 	__kernel_time_t msg_stime;	/* last msgsnd time */
-#if __BITS_PER_LONG != 64
-	unsigned int   __pad2;
-#endif
 	__kernel_time_t msg_rtime;	/* last msgrcv time */
-#if __BITS_PER_LONG != 64
-	unsigned int   __pad3;
-#endif
 	__kernel_time_t msg_ctime;	/* last change time */
-	unsigned long msg_cbytes;	/* current number of bytes on queue */
-	unsigned long msg_qnum;		/* number of messages in queue */
-	unsigned long msg_qbytes;	/* max number of bytes on queue */
-	__kernel_pid_t msg_lspid;	/* pid of last msgsnd */
-	__kernel_pid_t msg_lrpid;	/* last receive pid */
-	unsigned long __unused1;
-	unsigned long __unused2;
+#else
+	unsigned long	msg_stime_high;
+	unsigned long	msg_stime;	/* last msgsnd time */
+	unsigned long	msg_rtime_high;
+	unsigned long	msg_rtime;	/* last msgrcv time */
+	unsigned long	msg_ctime_high;
+	unsigned long	msg_ctime;	/* last change time */
+#endif
+	unsigned long	msg_cbytes;	/* current number of bytes on queue */
+	unsigned long	msg_qnum;	/* number of messages in queue */
+	unsigned long	msg_qbytes;	/* max number of bytes on queue */
+	__kernel_pid_t	msg_lspid;	/* pid of last msgsnd */
+	__kernel_pid_t	msg_lrpid;	/* last receive pid */
+	unsigned long	__unused1;
+	unsigned long	__unused2;
 };
 
 #endif /* _PARISC_MSGBUF_H */
diff --git a/arch/parisc/include/uapi/asm/sembuf.h b/arch/parisc/include/uapi/asm/sembuf.h
index 746c5d86a9b1..3c31163b1241 100644
--- a/arch/parisc/include/uapi/asm/sembuf.h
+++ b/arch/parisc/include/uapi/asm/sembuf.h
@@ -10,21 +10,21 @@
  * between kernel and user space.
  *
  * Pad space is left for:
- * - 64-bit time_t to solve y2038 problem
  * - 2 miscellaneous 32-bit values
  */
 
 struct semid64_ds {
 	struct ipc64_perm sem_perm;		/* permissions .. see ipc.h */
-#if __BITS_PER_LONG != 64
-	unsigned int	__pad1;
-#endif
+#if __BITS_PER_LONG == 64
 	__kernel_time_t	sem_otime;		/* last semop time */
-#if __BITS_PER_LONG != 64
-	unsigned int	__pad2;
-#endif
 	__kernel_time_t	sem_ctime;		/* last change time */
-	unsigned long 	sem_nsems;		/* no. of semaphores in array */
+#else
+	unsigned long	sem_otime_high;
+	unsigned long	sem_otime;		/* last semop time */
+	unsigned long	sem_ctime_high;
+	unsigned long	sem_ctime;		/* last change time */
+#endif
+	unsigned long	sem_nsems;		/* no. of semaphores in array */
 	unsigned long	__unused1;
 	unsigned long	__unused2;
 };
diff --git a/arch/parisc/include/uapi/asm/shmbuf.h b/arch/parisc/include/uapi/asm/shmbuf.h
index cd4dbce55d0b..c89b3dd8db21 100644
--- a/arch/parisc/include/uapi/asm/shmbuf.h
+++ b/arch/parisc/include/uapi/asm/shmbuf.h
@@ -10,25 +10,22 @@
  * between kernel and user space.
  *
  * Pad space is left for:
- * - 64-bit time_t to solve y2038 problem
  * - 2 miscellaneous 32-bit values
  */
 
 struct shmid64_ds {
 	struct ipc64_perm	shm_perm;	/* operation perms */
-#if __BITS_PER_LONG != 64
-	unsigned int		__pad1;
-#endif
+#if __BITS_PER_LONG == 64
 	__kernel_time_t		shm_atime;	/* last attach time */
-#if __BITS_PER_LONG != 64
-	unsigned int		__pad2;
-#endif
 	__kernel_time_t		shm_dtime;	/* last detach time */
-#if __BITS_PER_LONG != 64
-	unsigned int		__pad3;
-#endif
 	__kernel_time_t		shm_ctime;	/* last change time */
-#if __BITS_PER_LONG != 64
+#else
+	unsigned long		shm_atime_high;
+	unsigned long		shm_atime;	/* last attach time */
+	unsigned long		shm_dtime_high;
+	unsigned long		shm_dtime;	/* last detach time */
+	unsigned long		shm_ctime_high;
+	unsigned long		shm_ctime;	/* last change time */
 	unsigned int		__pad4;
 #endif
 	__kernel_size_t		shm_segsz;	/* size of segment (bytes) */
-- 
2.9.0
