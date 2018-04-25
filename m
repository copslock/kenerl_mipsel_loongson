Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Apr 2018 17:10:30 +0200 (CEST)
Received: from mout.kundenserver.de ([212.227.126.134]:51859 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993973AbeDYPHksWx-C (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Apr 2018 17:07:40 +0200
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue002 [212.227.15.129]) with ESMTPA (Nemesis) id
 0LhoMU-1eYBkZ1uaY-00nCBZ; Wed, 25 Apr 2018 17:06:25 +0200
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
Subject: [PATCH v4 07/16] y2038: mips: Extend sysvipc data structures
Date:   Wed, 25 Apr 2018 17:05:57 +0200
Message-Id: <20180425150606.954771-7-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180425132242.1500539-1-arnd@arndb.de>
References: <20180425132242.1500539-1-arnd@arndb.de>
X-Provags-ID: V03:K1:itAp7MWdZ9l8iBLwoPc/ZPJtCa4BI0JoCg/2OTDdOsoubMiq5CG
 iViZgHnBfsujx8G1cs/uohCv8aLtE5JhD7yw+5aJ0qUYJdJzla7/HD2KnSIPGzv5oWOZ77F
 XGgWHe87i5IxWwK82f2K3F52Kh9f7I9FO4ad5xWp2xVFMs7f0pCeeeHOlNzPDiDx+T37KO1
 uZmoLuZ44ulrqksNLATOg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:n+l0ziahV08=:N7kjUK3KmVVjGw/Ks/k/4C
 mq1ngZaJ0UdrzNNhkW8gaj/z5ijZ3c3YEqhZpmsoPdhuSqIgc6SX9BR2BfgtMEFpNobkkdDHu
 t+jIfJDIR125BZR82NtZ5dTxqPM/7nn6JqWJMPQX1l0zXCeGp10iYjuoUSj1YrazY1gzj7+yq
 +dvCcSbn5MNFn3eH+D2NdqkKeHjrFQGLkBH5M2i3CxmfulQJpA+UfMakQjnQvfcvSOQMcaiIX
 7r9n2KNihEn8N8FuDA01H6vRPa/akXbBXKz64pMVMeCNfT+ddKY1D5CpWyXjjeXfgkF0fyr3j
 IKcSkSDwqUV9C2TP1p6oqg9TZ9HUKFiaNwZ8ekD3KBdo7efN4i7O+v+nG+/ptC/K3vJQa2ELu
 hn7dtc9C68QD1kPEwcK4vTgZxKUOeEf+ov/UsuKPvNlF3UxENgxNDtNvi+9fGh/UdVxUsniZT
 SRs6sCmB9cn3tqNb8rDJpETwKEd3dSS9DapVG973+eXnbn7V6Evbp+7/u1EtPM9C3vczDIV2Y
 5WqnOJOMeI+6qmdnLgfmG2M85Jsv2Cne3+ZLUa0zbA88qa7+enVWfi6pzqPME4tsbUu4a9T96
 NfTd21juDUj6bQMF345Q7G/8en7M75yHbrpvWrfkDUjhvgOKj6Xnr/6UdhP2Vhd9oXwbVvB7j
 OoO4gw5V3K6NdCwpUh2q+jz61BSOG6/26aeAIYY/m4AbZFZM3FWNP0auNLTdPz4H5E7AMnDwb
 38OyQaJ9KLF5VUIzW7LQf20phjECZPsIZFK7IQ==
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63775
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

MIPS is the weirdest case for sysvipc, because each of the
three data structures is done differently:

* msqid64_ds has padding in the right place so we could in theory
  extend this one to just have 64-bit values instead of time_t.
  As this does not work for most of the other combinations,
  we just handle it in the common manner though.

* semid64_ds has no padding for 64-bit time_t, but has two reserved
  'long' fields, which are sufficient to extend the sem_otime
  and sem_ctime fields to 64 bit. In order to do this, the libc
  implementation will have to copy the data into another structure
  that has the fields in a different order. MIPS is the only
  architecture with this problem, so this is best done in MIPS
  specific libc code.

* shmid64_ds is slightly worse than that, because it has three
  time_t fields but only two unused 32-bit words. As a workaround,
  we extend each field only by 16 bits, ending up with 48-bit
  timestamps that user space again has to work around by itself.

The compat versions of the data structures are changed in the
same way.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/mips/include/asm/compat.h      | 40 ++++++++++++++------------
 arch/mips/include/uapi/asm/msgbuf.h | 57 ++++++++++++++++++++++++-------------
 arch/mips/include/uapi/asm/sembuf.h | 15 ++++++++--
 arch/mips/include/uapi/asm/shmbuf.h | 23 +++++++++++++--
 4 files changed, 94 insertions(+), 41 deletions(-)

diff --git a/arch/mips/include/asm/compat.h b/arch/mips/include/asm/compat.h
index 3e548ee99a2f..78675f19440f 100644
--- a/arch/mips/include/asm/compat.h
+++ b/arch/mips/include/asm/compat.h
@@ -37,9 +37,11 @@ typedef struct {
 typedef s32		compat_timer_t;
 typedef s32		compat_key_t;
 
+typedef s16		compat_short_t;
 typedef s32		compat_int_t;
 typedef s32		compat_long_t;
 typedef s64		compat_s64;
+typedef u16		compat_ushort_t;
 typedef u32		compat_uint_t;
 typedef u32		compat_ulong_t;
 typedef u64		compat_u64;
@@ -157,35 +159,35 @@ struct compat_ipc64_perm {
 
 struct compat_semid64_ds {
 	struct compat_ipc64_perm sem_perm;
-	compat_time_t	sem_otime;
-	compat_time_t	sem_ctime;
+	compat_ulong_t	sem_otime;
+	compat_ulong_t	sem_ctime;
 	compat_ulong_t	sem_nsems;
-	compat_ulong_t	__unused1;
-	compat_ulong_t	__unused2;
+	compat_ulong_t	sem_otime_high;
+	compat_ulong_t	sem_ctime_high;
 };
 
 struct compat_msqid64_ds {
 	struct compat_ipc64_perm msg_perm;
 #ifndef CONFIG_CPU_LITTLE_ENDIAN
-	compat_ulong_t	__unused1;
+	compat_ulong_t	msg_stime_high;
 #endif
-	compat_time_t	msg_stime;
+	compat_ulong_t	msg_stime;
 #ifdef CONFIG_CPU_LITTLE_ENDIAN
-	compat_ulong_t	__unused1;
+	compat_ulong_t	msg_stime_high;
 #endif
 #ifndef CONFIG_CPU_LITTLE_ENDIAN
-	compat_ulong_t	__unused2;
+	compat_ulong_t	msg_rtime_high;
 #endif
-	compat_time_t	msg_rtime;
+	compat_ulong_t	msg_rtime;
 #ifdef CONFIG_CPU_LITTLE_ENDIAN
-	compat_ulong_t	__unused2;
+	compat_ulong_t	msg_rtime_high;
 #endif
 #ifndef CONFIG_CPU_LITTLE_ENDIAN
-	compat_ulong_t	__unused3;
+	compat_ulong_t	msg_ctime_high;
 #endif
-	compat_time_t	msg_ctime;
+	compat_ulong_t	msg_ctime;
 #ifdef CONFIG_CPU_LITTLE_ENDIAN
-	compat_ulong_t	__unused3;
+	compat_ulong_t	msg_ctime_high;
 #endif
 	compat_ulong_t	msg_cbytes;
 	compat_ulong_t	msg_qnum;
@@ -199,14 +201,16 @@ struct compat_msqid64_ds {
 struct compat_shmid64_ds {
 	struct compat_ipc64_perm shm_perm;
 	compat_size_t	shm_segsz;
-	compat_time_t	shm_atime;
-	compat_time_t	shm_dtime;
-	compat_time_t	shm_ctime;
+	compat_ulong_t	shm_atime;
+	compat_ulong_t	shm_dtime;
+	compat_ulong_t	shm_ctime;
 	compat_pid_t	shm_cpid;
 	compat_pid_t	shm_lpid;
 	compat_ulong_t	shm_nattch;
-	compat_ulong_t	__unused1;
-	compat_ulong_t	__unused2;
+	compat_ushort_t	shm_atime_high;
+	compat_ushort_t	shm_dtime_high;
+	compat_ushort_t	shm_ctime_high;
+	compat_ushort_t	__unused2;
 };
 
 /* MIPS has unusual order of fields in stack_t */
diff --git a/arch/mips/include/uapi/asm/msgbuf.h b/arch/mips/include/uapi/asm/msgbuf.h
index eb4d0f9d7364..46aa15b13e4e 100644
--- a/arch/mips/include/uapi/asm/msgbuf.h
+++ b/arch/mips/include/uapi/asm/msgbuf.h
@@ -9,33 +9,15 @@
  * between kernel and user space.
  *
  * Pad space is left for:
- * - extension of time_t to 64-bit on 32-bitsystem to solve the y2038 problem
  * - 2 miscellaneous unsigned long values
  */
 
+#if defined(__mips64)
 struct msqid64_ds {
 	struct ipc64_perm msg_perm;
-#if !defined(__mips64) && defined(__MIPSEB__)
-	unsigned long	__unused1;
-#endif
 	__kernel_time_t msg_stime;	/* last msgsnd time */
-#if !defined(__mips64) && defined(__MIPSEL__)
-	unsigned long	__unused1;
-#endif
-#if !defined(__mips64) && defined(__MIPSEB__)
-	unsigned long	__unused2;
-#endif
 	__kernel_time_t msg_rtime;	/* last msgrcv time */
-#if !defined(__mips64) && defined(__MIPSEL__)
-	unsigned long	__unused2;
-#endif
-#if !defined(__mips64) && defined(__MIPSEB__)
-	unsigned long	__unused3;
-#endif
 	__kernel_time_t msg_ctime;	/* last change time */
-#if !defined(__mips64) && defined(__MIPSEL__)
-	unsigned long	__unused3;
-#endif
 	unsigned long  msg_cbytes;	/* current number of bytes on queue */
 	unsigned long  msg_qnum;	/* number of messages in queue */
 	unsigned long  msg_qbytes;	/* max number of bytes on queue */
@@ -44,5 +26,42 @@ struct msqid64_ds {
 	unsigned long  __unused4;
 	unsigned long  __unused5;
 };
+#elif defined (__MIPSEB__)
+struct msqid64_ds {
+	struct ipc64_perm msg_perm;
+	unsigned long  msg_stime_high;
+	unsigned long  msg_stime;	/* last msgsnd time */
+	unsigned long  msg_rtime_high;
+	unsigned long  msg_rtime;	/* last msgrcv time */
+	unsigned long  msg_ctime_high;
+	unsigned long  msg_ctime;	/* last change time */
+	unsigned long  msg_cbytes;	/* current number of bytes on queue */
+	unsigned long  msg_qnum;	/* number of messages in queue */
+	unsigned long  msg_qbytes;	/* max number of bytes on queue */
+	__kernel_pid_t msg_lspid;	/* pid of last msgsnd */
+	__kernel_pid_t msg_lrpid;	/* last receive pid */
+	unsigned long  __unused4;
+	unsigned long  __unused5;
+};
+#elif defined (__MIPSEL__)
+struct msqid64_ds {
+	struct ipc64_perm msg_perm;
+	unsigned long  msg_stime;	/* last msgsnd time */
+	unsigned long  msg_stime_high;
+	unsigned long  msg_rtime;	/* last msgrcv time */
+	unsigned long  msg_rtime_high;
+	unsigned long  msg_ctime;	/* last change time */
+	unsigned long  msg_ctime_high;
+	unsigned long  msg_cbytes;	/* current number of bytes on queue */
+	unsigned long  msg_qnum;	/* number of messages in queue */
+	unsigned long  msg_qbytes;	/* max number of bytes on queue */
+	__kernel_pid_t msg_lspid;	/* pid of last msgsnd */
+	__kernel_pid_t msg_lrpid;	/* last receive pid */
+	unsigned long  __unused4;
+	unsigned long  __unused5;
+};
+#else
+#warning no endianess set
+#endif
 
 #endif /* _ASM_MSGBUF_H */
diff --git a/arch/mips/include/uapi/asm/sembuf.h b/arch/mips/include/uapi/asm/sembuf.h
index 2c0f507ab7d1..60c89e6cb25b 100644
--- a/arch/mips/include/uapi/asm/sembuf.h
+++ b/arch/mips/include/uapi/asm/sembuf.h
@@ -7,10 +7,11 @@
  * Note extra padding because this structure is passed back and forth
  * between kernel and user space.
  *
- * Pad space is left for:
- * - 2 miscellaneous 64-bit values
+ * Pad space is left for 2 miscellaneous 64-bit values on mips64,
+ * but used for the upper 32 bit of the time values on mips32.
  */
 
+#ifdef __mips64
 struct semid64_ds {
 	struct ipc64_perm sem_perm;		/* permissions .. see ipc.h */
 	__kernel_time_t sem_otime;		/* last semop time */
@@ -19,5 +20,15 @@ struct semid64_ds {
 	unsigned long	__unused1;
 	unsigned long	__unused2;
 };
+#else
+struct semid64_ds {
+	struct ipc64_perm sem_perm;		/* permissions .. see ipc.h */
+	unsigned long   sem_otime;		/* last semop time */
+	unsigned long   sem_ctime;		/* last change time */
+	unsigned long	sem_nsems;		/* no. of semaphores in array */
+	unsigned long	sem_otime_high;
+	unsigned long	sem_ctime_high;
+};
+#endif
 
 #endif /* _ASM_SEMBUF_H */
diff --git a/arch/mips/include/uapi/asm/shmbuf.h b/arch/mips/include/uapi/asm/shmbuf.h
index 379e6bca518b..9b9bba3401f2 100644
--- a/arch/mips/include/uapi/asm/shmbuf.h
+++ b/arch/mips/include/uapi/asm/shmbuf.h
@@ -7,10 +7,13 @@
  * Note extra padding because this structure is passed back and forth
  * between kernel and user space.
  *
- * Pad space is left for:
- * - 2 miscellaneous 32-bit rsp. 64-bit values
+ * As MIPS was lacking proper padding after shm_?time, we use 48 bits
+ * of the padding at the end to store a few additional bits of the time.
+ * libc implementations need to take care to convert this into a proper
+ * data structure when moving to 64-bit time_t.
  */
 
+#ifdef __mips64
 struct shmid64_ds {
 	struct ipc64_perm	shm_perm;	/* operation perms */
 	size_t			shm_segsz;	/* size of segment (bytes) */
@@ -23,6 +26,22 @@ struct shmid64_ds {
 	unsigned long		__unused1;
 	unsigned long		__unused2;
 };
+#else
+struct shmid64_ds {
+	struct ipc64_perm	shm_perm;	/* operation perms */
+	size_t			shm_segsz;	/* size of segment (bytes) */
+	unsigned long		shm_atime;	/* last attach time */
+	unsigned long		shm_dtime;	/* last detach time */
+	unsigned long		shm_ctime;	/* last change time */
+	__kernel_pid_t		shm_cpid;	/* pid of creator */
+	__kernel_pid_t		shm_lpid;	/* pid of last operator */
+	unsigned long		shm_nattch;	/* no. of current attaches */
+	unsigned short		shm_atime_high;
+	unsigned short		shm_dtime_high;
+	unsigned short		shm_ctime_high;
+	unsigned short		__unused1;
+};
+#endif
 
 struct shminfo64 {
 	unsigned long	shmmax;
-- 
2.9.0
