Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 May 2012 12:12:12 +0200 (CEST)
Received: from mail-pz0-f49.google.com ([209.85.210.49]:51296 "EHLO
        mail-pz0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903633Ab2EQKLV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 May 2012 12:11:21 +0200
Received: by mail-pz0-f49.google.com with SMTP id m1so2524865dad.36
        for <multiple recipients>; Thu, 17 May 2012 03:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=H/QHpfizoWNWtBQZUObs6w8GV4soSBibMU1be/RCDz4=;
        b=uksrqXGwzKmUzzIP0qeCtKp2ZoBDfB92sDS6nqo3xzCR7hsnx73aIy2NrjgN0Fz9Vy
         45hdl2OD+nC3rw/zKCtLBwGAlrCaejIjkmzl5McnOtnjQ8B7Ac3rPVGVx9uT3volpfTF
         /tB4c3FnLGJ+J+dguxpsHZMG9MWcyXAVn8GVj9gef3R2AczCQA2LiImvi0q9zAI1wBTO
         hg4Wy0Xr8eqZM6URrqiopyUSW1MHCNiP7iku93VZKrOkQ6XbwcOY5Ikvc7CM3hVT/Yze
         UdGTuQ6Ia7uHRXIbeG7IrvC4XQoS6+YwdXUs+Ivqt8n85P60DztpKna38mJEmqfGvGJf
         pqmQ==
Received: by 10.68.217.67 with SMTP id ow3mr25079203pbc.16.1337249481067;
        Thu, 17 May 2012 03:11:21 -0700 (PDT)
Received: from localhost ([221.223.131.58])
        by mx.google.com with ESMTPS id ss8sm8645106pbc.43.2012.05.17.03.11.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 17 May 2012 03:11:20 -0700 (PDT)
From:   Yong Zhang <yong.zhang0@gmail.com>
To:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Cc:     ralf@linux-mips.org, david.daney@cavium.com
Subject: [PATCH 4/8] MIPS: Yosemite: delay irq enable to ->smp_finish()
Date:   Thu, 17 May 2012 18:10:06 +0800
Message-Id: <1337249410-7162-5-git-send-email-yong.zhang0@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1337249410-7162-1-git-send-email-yong.zhang0@gmail.com>
References: <1337249410-7162-1-git-send-email-yong.zhang0@gmail.com>
X-archive-position: 33345
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yong.zhang0@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: Yong Zhang <yong.zhang@windriver.com>

To prepare for smoothing set_cpu_[active|online]() mess up

Signed-off-by: Yong Zhang <yong.zhang0@gmail.com>
---
 arch/mips/pmc-sierra/yosemite/smp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/pmc-sierra/yosemite/smp.c b/arch/mips/pmc-sierra/yosemite/smp.c
index b71fae2..5edab2b 100644
--- a/arch/mips/pmc-sierra/yosemite/smp.c
+++ b/arch/mips/pmc-sierra/yosemite/smp.c
@@ -115,11 +115,11 @@ static void yos_send_ipi_mask(const struct cpumask *mask, unsigned int action)
  */
 static void __cpuinit yos_init_secondary(void)
 {
-	set_c0_status(ST0_CO | ST0_IE | ST0_IM);
 }
 
 static void __cpuinit yos_smp_finish(void)
 {
+	set_c0_status(ST0_CO | ST0_IM | ST0_IE);
 }
 
 /* Hook for after all CPUs are online */
-- 
1.7.1
