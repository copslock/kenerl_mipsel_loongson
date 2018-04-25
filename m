Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Apr 2018 17:10:17 +0200 (CEST)
Received: from mout.kundenserver.de ([212.227.126.187]:36363 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994676AbeDYPHfNP-KC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Apr 2018 17:07:35 +0200
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue002 [212.227.15.129]) with ESMTPA (Nemesis) id
 0M6JFz-1eRt9R0ksF-00yMJA; Wed, 25 Apr 2018 17:06:30 +0200
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
Subject: [PATCH v4 13/16] y2038: ipc: Report long times to user space
Date:   Wed, 25 Apr 2018 17:06:03 +0200
Message-Id: <20180425150606.954771-13-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180425132242.1500539-1-arnd@arndb.de>
References: <20180425132242.1500539-1-arnd@arndb.de>
X-Provags-ID: V03:K1:U4bZ56OkJwX121pfYf1OxCU+WQTpWhsRjZP3Yu2XsWUfTW4h9F7
 8M4ApLronLL42j70AlJ8L8nE/NF8G8eKAKgVn92L7MO0AlU6Crh4yjcIFayeBvLAHGhT6yV
 C/dklrPQjCp2qttgopbz8xAmNr5kZo8/Lhep6OFY3zHd2ls0y5MZb4OJK2IZ2inOeiETZW5
 jwNdzMGeqrBSY5CMvq4Eg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:v1ELBJjk/7o=:a1dd3vJ6Iso1u9JooSEz+7
 bB3CFBWaYtL1A3h+wW63eO5Dm1qZW7pvgsNb87u3xmcWsnC+rjhCpujcmU2NvnPPrO2xeDI7Z
 k0cfz3sU4QZqO8bg54FUK4wABNrrD5aYcDi4F5r4Tqx4ZrLcGaIDG7WcI1242K6UK5FvY4ZYu
 8uay4InHjbk7plAVl0c0x105+21vfFe9I/Sn4MZQsqhGVsO05ywgKgRXmqkH/5JtCF6Rektl0
 k9IhDd6mRrY+tKagUtdu1WN2TMn93oVht69HHt1ITAJQ44HijwnDEs8fBxQvxzJzdMw0Yj/1K
 ztq1mScq0oE/onlHHhNNHnmWMG6rdQgRpLyHF3zmrKgIYgD7PWrypzMAnh8ujfms2+w1zzib2
 KZTMYR6mP58dHt2Oyv8yxOwcQ7VFxbdga2Y1f9gd/sIFzRVC8ay/6YV1TCQh9UsDk08OppjSk
 YOp3qqGl0w0XrETtSo9FB5b4kfhkztWJhssOJEgXfNiYYh9ksqk0lGFfeDymrmqiGXEQ06fRe
 wj6+jpIXU6aXvRCxZx/PXociCuT0CGp1xknA1aOqpWzXA+wyoqywK0VJbdIvOCVwqT/PJaTLM
 8bKkU1vxssQiMSG0nKLRBfHLm+fK2Q6BKzuxrfQAR4UJ9drftHOufTXOxI0t7x+SBfp0tmtZM
 zz9MFIv8qzqXjAvwty7QswsRYPeKMOG9mdjuVU8ssXhsWEv2jmXBVqvU7mVg5pHCKDHaG6C+B
 2PfPGXDIJzl50llRpP7mHqpbpZAZ82fQiulDag==
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63774
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

The shmid64_ds/semid64_ds/msqid64_ds data structures have been extended
to contain extra fields for storing the upper bits of the time stamps,
this patch does the other half of the job and and fills the new fields on
32-bit architectures as well as 32-bit tasks running on a 64-bit kernel
in compat mode.

There should be no change for native 64-bit tasks.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 ipc/msg.c | 14 +++++++++++---
 ipc/sem.c | 14 +++++++++++---
 ipc/shm.c | 14 +++++++++++---
 3 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/ipc/msg.c b/ipc/msg.c
index 574f76c9a2ff..3b6545302598 100644
--- a/ipc/msg.c
+++ b/ipc/msg.c
@@ -537,6 +537,11 @@ static int msgctl_stat(struct ipc_namespace *ns, int msqid,
 	p->msg_stime  = msq->q_stime;
 	p->msg_rtime  = msq->q_rtime;
 	p->msg_ctime  = msq->q_ctime;
+#ifndef CONFIG_64BIT
+	p->msg_stime_high = msq->q_stime >> 32;
+	p->msg_rtime_high = msq->q_rtime >> 32;
+	p->msg_ctime_high = msq->q_ctime >> 32;
+#endif
 	p->msg_cbytes = msq->q_cbytes;
 	p->msg_qnum   = msq->q_qnum;
 	p->msg_qbytes = msq->q_qbytes;
@@ -646,9 +651,12 @@ static int copy_compat_msqid_to_user(void __user *buf, struct msqid64_ds *in,
 		struct compat_msqid64_ds v;
 		memset(&v, 0, sizeof(v));
 		to_compat_ipc64_perm(&v.msg_perm, &in->msg_perm);
-		v.msg_stime = in->msg_stime;
-		v.msg_rtime = in->msg_rtime;
-		v.msg_ctime = in->msg_ctime;
+		v.msg_stime	 = lower_32_bits(in->msg_stime);
+		v.msg_stime_high = upper_32_bits(in->msg_stime);
+		v.msg_rtime	 = lower_32_bits(in->msg_rtime);
+		v.msg_rtime_high = upper_32_bits(in->msg_rtime);
+		v.msg_ctime	 = lower_32_bits(in->msg_ctime);
+		v.msg_ctime_high = upper_32_bits(in->msg_ctime);
 		v.msg_cbytes = in->msg_cbytes;
 		v.msg_qnum = in->msg_qnum;
 		v.msg_qbytes = in->msg_qbytes;
diff --git a/ipc/sem.c b/ipc/sem.c
index c6a8a971769d..8935cd8cf166 100644
--- a/ipc/sem.c
+++ b/ipc/sem.c
@@ -1214,6 +1214,7 @@ static int semctl_stat(struct ipc_namespace *ns, int semid,
 			 int cmd, struct semid64_ds *semid64)
 {
 	struct sem_array *sma;
+	time64_t semotime;
 	int id = 0;
 	int err;
 
@@ -1257,8 +1258,13 @@ static int semctl_stat(struct ipc_namespace *ns, int semid,
 	}
 
 	kernel_to_ipc64_perm(&sma->sem_perm, &semid64->sem_perm);
-	semid64->sem_otime = get_semotime(sma);
+	semotime = get_semotime(sma);
+	semid64->sem_otime = semotime;
 	semid64->sem_ctime = sma->sem_ctime;
+#ifndef CONFIG_64BIT
+	semid64->sem_otime_high = semotime >> 32;
+	semid64->sem_ctime_high = sma->sem_ctime >> 32;
+#endif
 	semid64->sem_nsems = sma->sem_nsems;
 
 	ipc_unlock_object(&sma->sem_perm);
@@ -1704,8 +1710,10 @@ static int copy_compat_semid_to_user(void __user *buf, struct semid64_ds *in,
 		struct compat_semid64_ds v;
 		memset(&v, 0, sizeof(v));
 		to_compat_ipc64_perm(&v.sem_perm, &in->sem_perm);
-		v.sem_otime = in->sem_otime;
-		v.sem_ctime = in->sem_ctime;
+		v.sem_otime	 = lower_32_bits(in->sem_otime);
+		v.sem_otime_high = upper_32_bits(in->sem_otime);
+		v.sem_ctime	 = lower_32_bits(in->sem_ctime);
+		v.sem_ctime_high = upper_32_bits(in->sem_ctime);
 		v.sem_nsems = in->sem_nsems;
 		return copy_to_user(buf, &v, sizeof(v));
 	} else {
diff --git a/ipc/shm.c b/ipc/shm.c
index 3cf48988d68c..0075990338f4 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -1002,6 +1002,11 @@ static int shmctl_stat(struct ipc_namespace *ns, int shmid,
 	tbuf->shm_atime	= shp->shm_atim;
 	tbuf->shm_dtime	= shp->shm_dtim;
 	tbuf->shm_ctime	= shp->shm_ctim;
+#ifndef CONFIG_64BIT
+	tbuf->shm_atime_high = shp->shm_atim >> 32;
+	tbuf->shm_dtime_high = shp->shm_dtim >> 32;
+	tbuf->shm_ctime_high = shp->shm_ctim >> 32;
+#endif
 	tbuf->shm_cpid	= pid_vnr(shp->shm_cprid);
 	tbuf->shm_lpid	= pid_vnr(shp->shm_lprid);
 	tbuf->shm_nattch = shp->shm_nattch;
@@ -1233,9 +1238,12 @@ static int copy_compat_shmid_to_user(void __user *buf, struct shmid64_ds *in,
 		struct compat_shmid64_ds v;
 		memset(&v, 0, sizeof(v));
 		to_compat_ipc64_perm(&v.shm_perm, &in->shm_perm);
-		v.shm_atime = in->shm_atime;
-		v.shm_dtime = in->shm_dtime;
-		v.shm_ctime = in->shm_ctime;
+		v.shm_atime	 = lower_32_bits(in->shm_atime);
+		v.shm_atime_high = upper_32_bits(in->shm_atime);
+		v.shm_dtime	 = lower_32_bits(in->shm_dtime);
+		v.shm_dtime_high = upper_32_bits(in->shm_dtime);
+		v.shm_ctime	 = lower_32_bits(in->shm_ctime);
+		v.shm_ctime_high = upper_32_bits(in->shm_ctime);
 		v.shm_segsz = in->shm_segsz;
 		v.shm_nattch = in->shm_nattch;
 		v.shm_cpid = in->shm_cpid;
-- 
2.9.0
