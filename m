Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Apr 2018 17:09:37 +0200 (CEST)
Received: from mout.kundenserver.de ([212.227.126.131]:37881 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994670AbeDYPH1Af3NC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Apr 2018 17:07:27 +0200
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue002 [212.227.15.129]) with ESMTPA (Nemesis) id
 0Lkocf-1edOgq2Zrp-00aoN8; Wed, 25 Apr 2018 17:06:21 +0200
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
Subject: [PATCH v4 02/16] y2038: x86: Extend sysvipc data structures
Date:   Wed, 25 Apr 2018 17:05:52 +0200
Message-Id: <20180425150606.954771-2-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180425132242.1500539-1-arnd@arndb.de>
References: <20180425132242.1500539-1-arnd@arndb.de>
X-Provags-ID: V03:K1:9M4OIQPEi5yzqZ0O/d7f/sTPBFWbwKIJIxL1cS7FymAPahP+/PZ
 fCENTLpok6HumSyjM4fkgb05zQM4d5SEeRJmZ5GLvZiCt4vc2pZYX+F3bnYm534yg0Qi6xp
 A4ivRIFHrY2iOqX5J5faBuvwk/Xma6NreSw26uwJbQf6aiwkasMqKNa0NlNMcwOHVyrChpD
 mZSzp/p2l3Ts5TPvkS4LQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0Td6jEn/6kk=:Io2npe3+BCzZPd1rBwwJz5
 i4e0YrozGCqkH6NOck6RGlipii1e0qfkFvTINUqi4LusfB9BRcXgGE4U6GNmIQO777JPUTUW1
 eV9HN8hsQqHX7rytFkZtf6qs2FRu0jubK24HXT60/eZnQgZuQQoDbK5YbBhUjqADTAnpYj7Hy
 /ntWuezVNb832KbbSLyqVtBWPjMnqST28136Svr2OjgrM6t8GkV9n/XULuGOiMWoIcr9o7zup
 P22ZWSj6Nmh72zJHocLxjVMNYrPifBncvumAk6y0w7T7LQsBmBzzuyTdUxA2MHkhp5r9YDv+N
 kdLy0IiymTEcQnmVkEH71kiSvxecdy8FXNOTEMG38OzkQMdM0pQX8Mp2KWg+Mp+ch8lYF2jtH
 +euXRMGE66teCMuRFxE4uSmVCNXYw1ca/FxsDt17p4gCKpOcGJRgtKfYTw4PkRbr7LluF5O35
 c2ST6xx1cEIPu0pwp0fc7aCrJ3ELyiWFEo5RA4pRqAuxnvaq3Gn4EWibmqs5rhs7eJygee5PA
 O5t9zqMEPW7C34j4plnS/ZHA1uQxwI4bDMV8YKeA/J9BXQvJRxEo3koBMu3oCAXgt4POgJSX6
 c/btpd+Ip2uojMlqfDdBp4FMdXHWbJZ9hMDKqYQTXP1W0qpnXnYgVWaAtI+AsbsqeJPezYmFA
 IOOEqgiNYZmOu8BBynm6BxelZMTJHyn2MCPWDIED7emgwRdeznUEY90G9sVGxC6Gt4oe5BogN
 A9FIvXDyw7/t2LFgl3Wj+2/SRllgg02bKHRxZA==
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63771
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

This extends the x86 copy of the sysvipc data structures to deal with
32-bit user space that has 64-bit time_t and wants to see timestamps
beyond 2038.

Fortunately, x86 has padding for this purpose in all the data structures,
so we can just add extra fields. With msgid64_ds and shmid64_ds, the
data structure is identical to the asm-generic version, which we have
already extended.

For some reason however, the 64-bit version of semid64_ds ended up with
extra padding, so I'm implementing the same approach as the asm-generic
version here, by using separate fields for the upper and lower halves
of the two timestamps.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/include/asm/compat.h      | 32 ++++++++++++++++----------------
 arch/x86/include/uapi/asm/sembuf.h | 11 ++++++++++-
 2 files changed, 26 insertions(+), 17 deletions(-)

diff --git a/arch/x86/include/asm/compat.h b/arch/x86/include/asm/compat.h
index 7cd314b71c51..fb97cf7c4137 100644
--- a/arch/x86/include/asm/compat.h
+++ b/arch/x86/include/asm/compat.h
@@ -134,10 +134,10 @@ struct compat_ipc64_perm {
 
 struct compat_semid64_ds {
 	struct compat_ipc64_perm sem_perm;
-	compat_time_t  sem_otime;
-	compat_ulong_t __unused1;
-	compat_time_t  sem_ctime;
-	compat_ulong_t __unused2;
+	compat_ulong_t sem_otime;
+	compat_ulong_t sem_otime_high;
+	compat_ulong_t sem_ctime;
+	compat_ulong_t sem_ctime_high;
 	compat_ulong_t sem_nsems;
 	compat_ulong_t __unused3;
 	compat_ulong_t __unused4;
@@ -145,12 +145,12 @@ struct compat_semid64_ds {
 
 struct compat_msqid64_ds {
 	struct compat_ipc64_perm msg_perm;
-	compat_time_t  msg_stime;
-	compat_ulong_t __unused1;
-	compat_time_t  msg_rtime;
-	compat_ulong_t __unused2;
-	compat_time_t  msg_ctime;
-	compat_ulong_t __unused3;
+	compat_ulong_t msg_stime;
+	compat_ulong_t msg_stime_high;
+	compat_ulong_t msg_rtime;
+	compat_ulong_t msg_rtime_high;
+	compat_ulong_t msg_ctime;
+	compat_ulong_t msg_ctime_high;
 	compat_ulong_t msg_cbytes;
 	compat_ulong_t msg_qnum;
 	compat_ulong_t msg_qbytes;
@@ -163,12 +163,12 @@ struct compat_msqid64_ds {
 struct compat_shmid64_ds {
 	struct compat_ipc64_perm shm_perm;
 	compat_size_t  shm_segsz;
-	compat_time_t  shm_atime;
-	compat_ulong_t __unused1;
-	compat_time_t  shm_dtime;
-	compat_ulong_t __unused2;
-	compat_time_t  shm_ctime;
-	compat_ulong_t __unused3;
+	compat_ulong_t shm_atime;
+	compat_ulong_t shm_atime_high;
+	compat_ulong_t shm_dtime;
+	compat_ulong_t shm_dtime_high;
+	compat_ulong_t shm_ctime;
+	compat_ulong_t shm_ctime_high;
 	compat_pid_t   shm_cpid;
 	compat_pid_t   shm_lpid;
 	compat_ulong_t shm_nattch;
diff --git a/arch/x86/include/uapi/asm/sembuf.h b/arch/x86/include/uapi/asm/sembuf.h
index cabd7476bd6c..89de6cd9f0a7 100644
--- a/arch/x86/include/uapi/asm/sembuf.h
+++ b/arch/x86/include/uapi/asm/sembuf.h
@@ -8,15 +8,24 @@
  * between kernel and user space.
  *
  * Pad space is left for:
- * - 64-bit time_t to solve y2038 problem
  * - 2 miscellaneous 32-bit values
+ *
+ * x86_64 and x32 incorrectly added padding here, so the structures
+ * are still incompatible with the padding on x86.
  */
 struct semid64_ds {
 	struct ipc64_perm sem_perm;	/* permissions .. see ipc.h */
+#ifdef __i386__
+	unsigned long	sem_otime;	/* last semop time */
+	unsigned long	sem_otime_high;
+	unsigned long	sem_ctime;	/* last change time */
+	unsigned long	sem_ctime_high;
+#else
 	__kernel_time_t	sem_otime;	/* last semop time */
 	__kernel_ulong_t __unused1;
 	__kernel_time_t	sem_ctime;	/* last change time */
 	__kernel_ulong_t __unused2;
+#endif
 	__kernel_ulong_t sem_nsems;	/* no. of semaphores in array */
 	__kernel_ulong_t __unused3;
 	__kernel_ulong_t __unused4;
-- 
2.9.0
