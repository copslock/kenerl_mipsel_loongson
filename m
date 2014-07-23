Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Jul 2014 15:43:33 +0200 (CEST)
Received: from mail-we0-f172.google.com ([74.125.82.172]:61082 "EHLO
        mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6826470AbaGWNm4aHOpt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Jul 2014 15:42:56 +0200
Received: by mail-we0-f172.google.com with SMTP id x48so1224831wes.3
        for <linux-mips@linux-mips.org>; Wed, 23 Jul 2014 06:42:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JhI23+YoO1l7p/YwCG8Uf+JG8G7+zLhjXnDv5vAgUAo=;
        b=ZDE4cZApDS5a/bUXI89tUTe1gu/o5QO32mKwNZi94yxqaJDSNjMmRb5dn+c8CNhmkM
         tBWiz3DjJnAPo7uIc80NnSIr/YQTmFyTIKk6gPa1P1XVJViOWrPPkJEzxY8fm24jI6aN
         dwdKcDgqh0YmfzDdihkV6Re9EU8UmntBy0o6FupdXjCyG/nJKVqc2hdLV82+l8mYQ61D
         pZt1jpHlr6L51VvjBJ82d6pon24Xkm7yQsE6ETzGpAXrI+PVr4zvZ3HW5FyWH/Gne9m7
         CWSEhqcLUUiVNxUp1aeYorCqNyL93meWrsz5lL1JCQz+RPvmgUogLJFHRO/wFJ2pUcf2
         FbUg==
X-Gm-Message-State: ALoCoQlqnKGMbc1oQROfxdgU3XpRFy+Mhz8mEv0xDxKLMFoxxIbH6SLKq6T9MIQgi6Mn3p/wj01r
X-Received: by 10.180.19.1 with SMTP id a1mr25361995wie.16.1406122971061;
        Wed, 23 Jul 2014 06:42:51 -0700 (PDT)
Received: from localhost.localdomain (host31-50-226-70.range31-50.btcentralplus.com. [31.50.226.70])
        by mx.google.com with ESMTPSA id w10sm9359341wie.22.2014.07.23.06.42.50
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Jul 2014 06:42:50 -0700 (PDT)
From:   Alex Smith <alex@alex-smith.me.uk>
To:     linux-mips@linux-mips.org
Cc:     Alex Smith <alex@alex-smith.me.uk>, <stable@vger.kernel.org>
Subject: [PATCH 02/11] MIPS: ptrace: Test correct task's flags in task_user_regset_view()
Date:   Wed, 23 Jul 2014 14:40:07 +0100
Message-Id: <1406122816-2424-3-git-send-email-alex@alex-smith.me.uk>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1406122816-2424-1-git-send-email-alex@alex-smith.me.uk>
References: <1406122816-2424-1-git-send-email-alex@alex-smith.me.uk>
Return-Path: <alex@alex-smith.me.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41518
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

task_user_regset_view() should test for TIF_32BIT_REGS in the flags of
the specified task, not of the current task.

Signed-off-by: Alex Smith <alex@alex-smith.me.uk>
Cc: <stable@vger.kernel.org> # v3.13+
---
 arch/mips/kernel/ptrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kernel/ptrace.c b/arch/mips/kernel/ptrace.c
index 6063b11..8f2130a 100644
--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -398,7 +398,7 @@ const struct user_regset_view *task_user_regset_view(struct task_struct *task)
 #endif
 
 #ifdef CONFIG_MIPS32_O32
-		if (test_thread_flag(TIF_32BIT_REGS))
+		if (test_tsk_thread_flag(task, TIF_32BIT_REGS))
 			return &user_mips_view;
 #endif
 
-- 
1.9.1
