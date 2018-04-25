Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Apr 2018 17:09:50 +0200 (CEST)
Received: from mout.kundenserver.de ([212.227.126.131]:37673 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994671AbeDYPH2PKDmC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Apr 2018 17:07:28 +0200
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue002 [212.227.15.129]) with ESMTPA (Nemesis) id
 0Mf66r-1f0ffg1bBZ-00OTao; Wed, 25 Apr 2018 17:06:29 +0200
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
Subject: [PATCH v4 12/16] y2038: ipc: Use ktime_get_real_seconds consistently
Date:   Wed, 25 Apr 2018 17:06:02 +0200
Message-Id: <20180425150606.954771-12-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180425132242.1500539-1-arnd@arndb.de>
References: <20180425132242.1500539-1-arnd@arndb.de>
X-Provags-ID: V03:K1:lcpnyjY3zpI5QLP1cubIh+OF+WTg75stSO6F+EFOKuEIoD4DpDw
 OyyeHq0oFXtR/uhFffhgf/VPAV0uKXnLPQXilyLSYcxnLpjOXdDGBzylvhdUEx6KmSRqe+2
 h2Ymqn5cA+QNQBICFqubng5TdXc9HCdRbvMx+EdUmakwvg3nGRPHn8IT0f1c/Cg/CY7ZSVQ
 Te0lvdTzdF1ZZo7rh+ZUg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0GSuoYBPUu8=:6g+iRgz4GwUCeThNrGE2z3
 e5yCaRxYlrxkQzxmVsoSjSFE42YUQ8t0EWyPkirJ/KVZL311TBsZ1DV5hlPGAiqW1wn6AF2b/
 5pZhWVcEHnwZc3LoOAiv8jOVPGWKqn9vtzFDVh1MILW5P/aI+hgkkAkdUbb/gtZKRJl+T0Sdz
 IKKUt4m8K6iTVf2PNyuURPbRXpmEKKgDY+Xvg7nD/AInU1yWBl50P6ZHn27pFxabilKMAAMv1
 CrTTanhr5fbqdHBWO5pYjuLKu1wImmriVlgOXGb3QeyblAoF1s/bRIkhtUbWcHasOwNYaTDro
 74W9zY+f9AkA6NTFOVBoc8GMsQIZjRBcCohGQYZOQEAEMTkBFXXkBQGPD8kn2FVGW0iQP7Nl2
 R4HufrR6SgAHOR5wKSqU0gV1Lm9Wn4liVRusifOP/44KOYpT9HnA7vXc/ZoCNZxP1zQUe0qr3
 fMiOxINmEDPJpnJscmfHvyK5Nz1Vona6HvPjRCsssd3yFWv8fuymJ5YHrJOe4lGow+QnjrjTw
 C0jLvEA84OGpeigtHVObbvRvVWXXOrI6iBR2TUVjUMQIdouVlkMAvKW8oG+rkm9KQERRIpzPP
 hf9JfXuIOqzo6yHu+ism732mxmt3W/Pt/28DpyOLJn9nm2yjJURGqLl2kZSy8YmCl/jW5vtuG
 vyJj82jleHLbv1ZxYlyLpsgdQxwSHt9mo7QD+zI8Oe3Yu4b0Wl5xfRI6JIuSQma4mLSLKIfzR
 CRIiPvDtxAIfucxJSDnZi23h4PEwCn0Uz74Riw==
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63772
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

In some places, we still used get_seconds() instead of
ktime_get_real_seconds(), and I'm changing the remaining ones now to
all use ktime_get_real_seconds() so we use the full available range for
timestamps instead of overflowing the 'unsigned long' return value in
year 2106 on 32-bit kernels.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 ipc/msg.c | 6 +++---
 ipc/sem.c | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/ipc/msg.c b/ipc/msg.c
index 56fd1c73eedc..574f76c9a2ff 100644
--- a/ipc/msg.c
+++ b/ipc/msg.c
@@ -758,7 +758,7 @@ static inline int pipelined_send(struct msg_queue *msq, struct msg_msg *msg,
 				WRITE_ONCE(msr->r_msg, ERR_PTR(-E2BIG));
 			} else {
 				ipc_update_pid(&msq->q_lrpid, task_pid(msr->r_tsk));
-				msq->q_rtime = get_seconds();
+				msq->q_rtime = ktime_get_real_seconds();
 
 				wake_q_add(wake_q, msr->r_tsk);
 				WRITE_ONCE(msr->r_msg, msg);
@@ -859,7 +859,7 @@ static long do_msgsnd(int msqid, long mtype, void __user *mtext,
 	}
 
 	ipc_update_pid(&msq->q_lspid, task_tgid(current));
-	msq->q_stime = get_seconds();
+	msq->q_stime = ktime_get_real_seconds();
 
 	if (!pipelined_send(msq, msg, &wake_q)) {
 		/* no one is waiting for this message, enqueue it */
@@ -1087,7 +1087,7 @@ static long do_msgrcv(int msqid, void __user *buf, size_t bufsz, long msgtyp, in
 
 			list_del(&msg->m_list);
 			msq->q_qnum--;
-			msq->q_rtime = get_seconds();
+			msq->q_rtime = ktime_get_real_seconds();
 			ipc_update_pid(&msq->q_lrpid, task_tgid(current));
 			msq->q_cbytes -= msg->m_ts;
 			atomic_sub(msg->m_ts, &ns->msg_bytes);
diff --git a/ipc/sem.c b/ipc/sem.c
index 06be75d9217a..c6a8a971769d 100644
--- a/ipc/sem.c
+++ b/ipc/sem.c
@@ -104,7 +104,7 @@ struct sem {
 					/* that alter the semaphore */
 	struct list_head pending_const; /* pending single-sop operations */
 					/* that do not alter the semaphore*/
-	time_t	sem_otime;	/* candidate for sem_otime */
+	time64_t	 sem_otime;	/* candidate for sem_otime */
 } ____cacheline_aligned_in_smp;
 
 /* One sem_array data structure for each set of semaphores in the system. */
@@ -984,10 +984,10 @@ static int update_queue(struct sem_array *sma, int semnum, struct wake_q_head *w
 static void set_semotime(struct sem_array *sma, struct sembuf *sops)
 {
 	if (sops == NULL) {
-		sma->sems[0].sem_otime = get_seconds();
+		sma->sems[0].sem_otime = ktime_get_real_seconds();
 	} else {
 		sma->sems[sops[0].sem_num].sem_otime =
-							get_seconds();
+						ktime_get_real_seconds();
 	}
 }
 
-- 
2.9.0
