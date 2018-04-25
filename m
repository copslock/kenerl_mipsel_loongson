Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Apr 2018 17:08:44 +0200 (CEST)
Received: from mout.kundenserver.de ([212.227.126.131]:60009 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994614AbeDYPHVlcJwC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Apr 2018 17:07:21 +0200
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue002 [212.227.15.129]) with ESMTPA (Nemesis) id
 0LpTKI-1ei3ec2fKg-00fSwT; Wed, 25 Apr 2018 17:06:28 +0200
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
Subject: [PATCH v4 11/16] y2038: xtensa: Extend sysvipc data structures
Date:   Wed, 25 Apr 2018 17:06:01 +0200
Message-Id: <20180425150606.954771-11-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180425132242.1500539-1-arnd@arndb.de>
References: <20180425132242.1500539-1-arnd@arndb.de>
X-Provags-ID: V03:K1:i9UA0urn16lH5JDePVWaotJn6MyPgLR5FfVVrzw5nnNPxOm4u+m
 riIT88wp+mhan2hKzci9CR3aFUrUbzlqeokKS47rOWVrdtHsVQuvjSOnovuLXAj+H7J7Aw9
 RyM3AfCErlZJqOrqV2ujx3kKosgfMIKHftIfYa4cI56loqLmcCuYokhVYKrtE4ew0SIDzXE
 PFRkWR80Y2WN+Q+3jvDqA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:MMC6hV4Smk4=:Ri6ksbuau+5BNTCbTyMUCj
 d/CCHE71Lb4RthMXlTF73W2Kb6JRAMhq60rPHWcJDIY3WZJO4TZJtgqueFD//r5L4fZ1zNMnu
 iOtCjozl35j0/FyW63KO86fBfoXTgu6DtOJhB6IRVxZl1kXXmPNWAOLuvNtdGWL1si5cTlh9g
 1aDEQlN6RFs2S2yBmVL+YGXOfcbqNc+TAcYLBAX2jft4Sk17RthUFG5u/hWMwv4YyjekLzTbt
 sprBskLIXjTTaT4PZdRjfXoMbcP/6qwRCj6/KA+SWVTXU5S3N9/hBYu1SWwumjWSZVBHLR1tN
 ea3HFSRM2gCMzepL5PV9Kdgo4BZkNQJrLrozrqPrbGJMDPweuUA1N35bu4k3m+Rn90FWW7qnr
 vUJ6DJZZ9o4fFnCYxppPvtV6rpVnSXFA/4a8rZbKiw///CwHqyq8/RopFnz+gcZamMxa/dq0r
 UDDMQhnnWaKK+JoYaEBYBSLzJQGKnUBIr2RqYW1pKaYF0hlVS2ro7iYl1TmnfseQ0EE8TyH3W
 wDSds8RLaUBjYs1q7tP1jpd9toP1fVzntejOnWOhNsTsFE23jHdXhumBPAMcF7eoCtXtAWYnM
 I49KOYJ8dW8/bRY8anU+WLYJpeuneNl4AE6tiOX0sa/o5DQREOgZsIWQx5IdZl8FY3AJpJXji
 9dc6tTPNfpO5OekU6oMM8YMTOf61mTSHD7Ap9iH192PGQ1xnwO74HnAPgg9tFE8noJemzUatP
 zkbAELc0yLPQMjgoPlTnk47Z8iuZZt11Ms/ejw==
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63768
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

xtensa, uses a nonstandard variation of the generic sysvipc
data structures, intended to have the padding moved around
so it can deal with big-endian 32-bit user space that has
64-bit time_t.

xtensa tries hard to define the structures so they work
in both big-endian and little-endian systems with padding
on the right side.
However, they only succeeded for for two of the three structures,
and their struct shmid64_ds ended up being defined in two
identical copies, and the big-endian one is wrong.

This takes just take the same approach here that we have for
the asm-generic headers and adds separate 32-bit fields for the
upper halves of the timestamps, to let libc deal with the mess
in user space.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/xtensa/include/uapi/asm/msgbuf.h | 25 ++++++++++++-----------
 arch/xtensa/include/uapi/asm/sembuf.h | 17 ++++++++--------
 arch/xtensa/include/uapi/asm/shmbuf.h | 37 ++++++++---------------------------
 3 files changed, 28 insertions(+), 51 deletions(-)

diff --git a/arch/xtensa/include/uapi/asm/msgbuf.h b/arch/xtensa/include/uapi/asm/msgbuf.h
index 36e2e103ca38..d6915e9f071c 100644
--- a/arch/xtensa/include/uapi/asm/msgbuf.h
+++ b/arch/xtensa/include/uapi/asm/msgbuf.h
@@ -7,7 +7,6 @@
  * between kernel and user space.
  *
  * Pad space is left for:
- * - 64-bit time_t to solve y2038 problem
  * - 2 miscellaneous 32-bit values
  *
  * This file is subject to the terms and conditions of the GNU General
@@ -21,19 +20,19 @@
 struct msqid64_ds {
 	struct ipc64_perm msg_perm;
 #ifdef __XTENSA_EB__
-	unsigned int	__unused1;
-	__kernel_time_t msg_stime;	/* last msgsnd time */
-	unsigned int	__unused2;
-	__kernel_time_t msg_rtime;	/* last msgrcv time */
-	unsigned int	__unused3;
-	__kernel_time_t msg_ctime;	/* last change time */
+	unsigned long  msg_stime_high;
+	unsigned long  msg_stime;	/* last msgsnd time */
+	unsigned long  msg_rtime_high;
+	unsigned long  msg_rtime;	/* last msgrcv time */
+	unsigned long  msg_ctime_high;
+	unsigned long  msg_ctime;	/* last change time */
 #elif defined(__XTENSA_EL__)
-	__kernel_time_t msg_stime;	/* last msgsnd time */
-	unsigned int	__unused1;
-	__kernel_time_t msg_rtime;	/* last msgrcv time */
-	unsigned int	__unused2;
-	__kernel_time_t msg_ctime;	/* last change time */
-	unsigned int	__unused3;
+	unsigned long  msg_stime;	/* last msgsnd time */
+	unsigned long  msg_stime_high;
+	unsigned long  msg_rtime;	/* last msgrcv time */
+	unsigned long  msg_rtime_high;
+	unsigned long  msg_ctime;	/* last change time */
+	unsigned long  msg_ctime_high;
 #else
 # error processor byte order undefined!
 #endif
diff --git a/arch/xtensa/include/uapi/asm/sembuf.h b/arch/xtensa/include/uapi/asm/sembuf.h
index f61b6331a10c..09f348d643f1 100644
--- a/arch/xtensa/include/uapi/asm/sembuf.h
+++ b/arch/xtensa/include/uapi/asm/sembuf.h
@@ -14,7 +14,6 @@
  * between kernel and user space.
  *
  * Pad space is left for:
- * - 64-bit time_t to solve y2038 problem
  * - 2 miscellaneous 32-bit values
  *
  */
@@ -27,15 +26,15 @@
 struct semid64_ds {
 	struct ipc64_perm sem_perm;		/* permissions .. see ipc.h */
 #ifdef __XTENSA_EL__
-	__kernel_time_t	sem_otime;		/* last semop time */
-	unsigned long	__unused1;
-	__kernel_time_t	sem_ctime;		/* last change time */
-	unsigned long	__unused2;
+	unsigned long	sem_otime;		/* last semop time */
+	unsigned long	sem_otime_high;
+	unsigned long	sem_ctime;		/* last change time */
+	unsigned long	sem_ctime_high;
 #else
-	unsigned long	__unused1;
-	__kernel_time_t	sem_otime;		/* last semop time */
-	unsigned long	__unused2;
-	__kernel_time_t	sem_ctime;		/* last change time */
+	unsigned long	sem_otime_high;
+	unsigned long	sem_otime;		/* last semop time */
+	unsigned long	sem_ctime_high;
+	unsigned long	sem_ctime;		/* last change time */
 #endif
 	unsigned long	sem_nsems;		/* no. of semaphores in array */
 	unsigned long	__unused3;
diff --git a/arch/xtensa/include/uapi/asm/shmbuf.h b/arch/xtensa/include/uapi/asm/shmbuf.h
index 26550bdc8430..554a57a6a90f 100644
--- a/arch/xtensa/include/uapi/asm/shmbuf.h
+++ b/arch/xtensa/include/uapi/asm/shmbuf.h
@@ -4,10 +4,10 @@
  *
  * The shmid64_ds structure for Xtensa architecture.
  * Note extra padding because this structure is passed back and forth
- * between kernel and user space.
+ * between kernel and user space, but the padding is on the wrong
+ * side for big-endian xtensa, for historic reasons.
  *
  * Pad space is left for:
- * - 64-bit time_t to solve y2038 problem
  * - 2 miscellaneous 32-bit values
  *
  * This file is subject to the terms and conditions of the GNU General Public
@@ -20,42 +20,21 @@
 #ifndef _XTENSA_SHMBUF_H
 #define _XTENSA_SHMBUF_H
 
-#if defined (__XTENSA_EL__)
 struct shmid64_ds {
 	struct ipc64_perm	shm_perm;	/* operation perms */
 	size_t			shm_segsz;	/* size of segment (bytes) */
-	__kernel_time_t		shm_atime;	/* last attach time */
-	unsigned long		__unused1;
-	__kernel_time_t		shm_dtime;	/* last detach time */
-	unsigned long		__unused2;
-	__kernel_time_t		shm_ctime;	/* last change time */
-	unsigned long		__unused3;
+	unsigned long		shm_atime;	/* last attach time */
+	unsigned long		shm_atime_high;
+	unsigned long		shm_dtime;	/* last detach time */
+	unsigned long		shm_dtime_high;
+	unsigned long		shm_ctime;	/* last change time */
+	unsigned long		shm_ctime_high;
 	__kernel_pid_t		shm_cpid;	/* pid of creator */
 	__kernel_pid_t		shm_lpid;	/* pid of last operator */
 	unsigned long		shm_nattch;	/* no. of current attaches */
 	unsigned long		__unused4;
 	unsigned long		__unused5;
 };
-#elif defined (__XTENSA_EB__)
-struct shmid64_ds {
-	struct ipc64_perm	shm_perm;	/* operation perms */
-	size_t			shm_segsz;	/* size of segment (bytes) */
-	__kernel_time_t		shm_atime;	/* last attach time */
-	unsigned long		__unused1;
-	__kernel_time_t		shm_dtime;	/* last detach time */
-	unsigned long		__unused2;
-	__kernel_time_t		shm_ctime;	/* last change time */
-	unsigned long		__unused3;
-	__kernel_pid_t		shm_cpid;	/* pid of creator */
-	__kernel_pid_t		shm_lpid;	/* pid of last operator */
-	unsigned long		shm_nattch;	/* no. of current attaches */
-	unsigned long		__unused4;
-	unsigned long		__unused5;
-};
-#else
-# error endian order not defined
-#endif
-
 
 struct shminfo64 {
 	unsigned long	shmmax;
-- 
2.9.0
