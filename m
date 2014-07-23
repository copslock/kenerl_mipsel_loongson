Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Jul 2014 15:43:04 +0200 (CEST)
Received: from mail-wi0-f170.google.com ([209.85.212.170]:55583 "EHLO
        mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6831986AbaGWNmqVdb9- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Jul 2014 15:42:46 +0200
Received: by mail-wi0-f170.google.com with SMTP id f8so7605386wiw.3
        for <linux-mips@linux-mips.org>; Wed, 23 Jul 2014 06:42:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AVGmNuCKMO8ghmDpjfz7gMOKPWvt2y9lZho9T6kFtk4=;
        b=h4XboofwetePit7UhUefHPVdLEuKH77zAz4maYLs/E/gOpUv3uQfTJDgHPQTiRPBji
         veKDeu9/1Jr4yKDxrj2jKIvD6l/wtqmidLfyjZOvme6yfebMIZnUT1EVRIgOWJ2q4MC6
         rNHmVV5ix3GhO22mr35q/GaI8d4KbKa8mDRMRIkeZPurvmfD5rVG1UHgXNJ1yYB3AffE
         5d82maGY/VPm1iN/Z2tj3fAQR7pNCeUR4yz7gOGS7I2yXKLfcrXKbm774bx5idc7/OSn
         TVDdWU1JDODMxuRwDUWiLX/BVvoQ9sWpek5AG6U2/YobO5pvTSWg7t/OgXuwFsESpPW/
         zJmA==
X-Gm-Message-State: ALoCoQm2SVSC0aXSd8WF1L6iEfQL8Y3vCvYuEsfTBsPTe+cZs7DeSUS4Pq6vUoxt2dMl9Fuwqzos
X-Received: by 10.194.24.2 with SMTP id q2mr1798006wjf.91.1406122961035;
        Wed, 23 Jul 2014 06:42:41 -0700 (PDT)
Received: from localhost.localdomain (host31-50-226-70.range31-50.btcentralplus.com. [31.50.226.70])
        by mx.google.com with ESMTPSA id w10sm9359341wie.22.2014.07.23.06.42.39
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Jul 2014 06:42:40 -0700 (PDT)
From:   Alex Smith <alex@alex-smith.me.uk>
To:     linux-mips@linux-mips.org
Cc:     Alex Smith <alex@alex-smith.me.uk>, <stable@vger.kernel.org>
Subject: [PATCH 01/11] MIPS: ptrace: Avoid smp_processor_id() when retrieving FPU IR
Date:   Wed, 23 Jul 2014 14:40:06 +0100
Message-Id: <1406122816-2424-2-git-send-email-alex@alex-smith.me.uk>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1406122816-2424-1-git-send-email-alex@alex-smith.me.uk>
References: <1406122816-2424-1-git-send-email-alex@alex-smith.me.uk>
Return-Path: <alex@alex-smith.me.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41517
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alex@alex-smith.me.uk
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

Whenever ptrace attempts to retrieve the FPU implementation register it
accesses it through current_cpu_data, which calls smp_processor_id().
Since the code may execute with preemption enabled, this can trigger
a warning. Fix this by using boot_cpu_data to get the IR instead.

Signed-off-by: Alex Smith <alex@alex-smith.me.uk>
Cc: <stable@vger.kernel.org> # v3.15+
---
 arch/mips/kernel/ptrace.c   | 4 ++--
 arch/mips/kernel/ptrace32.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/kernel/ptrace.c b/arch/mips/kernel/ptrace.c
index f639ccd..6063b11 100644
--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -129,7 +129,7 @@ int ptrace_getfpregs(struct task_struct *child, __u32 __user *data)
 	}
 
 	__put_user(child->thread.fpu.fcr31, data + 64);
-	__put_user(current_cpu_data.fpu_id, data + 65);
+	__put_user(boot_cpu_data.fpu_id, data + 65);
 
 	return 0;
 }
@@ -480,7 +480,7 @@ long arch_ptrace(struct task_struct *child, long request,
 			break;
 		case FPC_EIR:
 			/* implementation / version register */
-			tmp = current_cpu_data.fpu_id;
+			tmp = boot_cpu_data.fpu_id;
 			break;
 		case DSP_BASE ... DSP_BASE + 5: {
 			dspreg_t *dregs;
diff --git a/arch/mips/kernel/ptrace32.c b/arch/mips/kernel/ptrace32.c
index b40c3ca..a83fb73 100644
--- a/arch/mips/kernel/ptrace32.c
+++ b/arch/mips/kernel/ptrace32.c
@@ -129,7 +129,7 @@ long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 			break;
 		case FPC_EIR:
 			/* implementation / version register */
-			tmp = current_cpu_data.fpu_id;
+			tmp = boot_cpu_data.fpu_id;
 			break;
 		case DSP_BASE ... DSP_BASE + 5: {
 			dspreg_t *dregs;
-- 
1.9.1
