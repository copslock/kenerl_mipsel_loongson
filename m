Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Apr 2018 16:39:26 +0200 (CEST)
Received: from mout.kundenserver.de ([217.72.192.75]:52087 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992615AbeDSOiy5o1BB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 19 Apr 2018 16:38:54 +0200
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue101 [212.227.15.145]) with ESMTPA (Nemesis) id
 0MbhXp-1et1Fo2fi9-00J2JI; Thu, 19 Apr 2018 16:37:57 +0200
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
Subject: [PATCH v3 12/17] y2038: ipc: Use ktime_get_real_seconds consistently
Date:   Thu, 19 Apr 2018 16:37:32 +0200
Message-Id: <20180419143737.606138-13-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180419143737.606138-1-arnd@arndb.de>
References: <20180419143737.606138-1-arnd@arndb.de>
X-Provags-ID: V03:K1:AJu2JDmyhTJaYI9k0Zdc69izyoMEo0YL+nuQkh2V03hjQ1rd4Ov
 zruaA3lje7KdQL5PWitbTyhVZHbYvJh2RFA6Osql1KYEvvdR4WFv4pjh7VhdH3VLludctrG
 kwaqL818bVfWwNMixkTp746xBv5tgEg2bP8UE22wBPijsCqG61yUXAt1617AncIIRgV9iDV
 ZjflBWNgO/uSVhsMx0eww==
X-UI-Out-Filterresults: notjunk:1;V01:K0:gamAfTntK3c=:Y84ZIW/sL96pFrxVIiQxKO
 XNl5i4VA4tAsRztW5MVcW+5deXMPX0mrHYEiLkvXiSj+GTVhULDHEF2GWRr8LMSS/hc6DNHpA
 IeQzVzt/Ll5oqCYy38voBTLGp25VUAjylYt+SeHGdgH+a57/egjuscZkdYAI+D5XwyluuFr5T
 Ojl/XSRa8EhSChMa3xqUQZ+dlILqEgsrHNwa8Z39muGttZ/gtjbCL3pAQsGDR8RUjgrU93oKW
 pFNxje4WDtcrCdEciG7IQ2dzi3Kgp/r0+QhyD0gUVnJtRs7dq/Qtuq9VoSQ3WVpSuqrfNZP0x
 o0iOBlpHjtaSpQpHMVoxQykWwrba/JqgNVUKZCfEqnOlGK3CMZ5JJvNulR14jB+VKo9I513my
 GPYV97Bp0D/XkIiDkIPxz86q2f52i25Apbgw/tGf7NhtkbLcBrD/HhJ5rQuhvJaFbb/xANGzc
 KNL2YOBI5AzAOS+pmXaw5H4Yl2B8mGR6eeo4dTsWwpfn0rucp/KsyZe4METvgRzZKRifZ/Qzq
 VqR9uPfbb6xwR7zvthg4PjiZoTft/+1hLwivufStEK+ImMs/L5Z1vswGnRxUgARynKUyX4h6m
 tvt7ZDRocyxgQA7jGpubGxAOaTaYTmYiE47roivgLYT/5Nv9f5PNNhT99xtBkevS3jBtDc61E
 B4+vGQt3Gg2vlZFmOSpNSsXGSRsHmwoB5hrm02R2B+r59sD79iuCaQ0JFGCwqQTfcSARGPMft
 4AverK4XmyzeEH81Wl7xyNo8oeJFWUMt9EYEVw==
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63607
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
