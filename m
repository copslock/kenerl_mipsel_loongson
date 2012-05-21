Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 May 2012 08:03:11 +0200 (CEST)
Received: from mail-wi0-f171.google.com ([209.85.212.171]:50760 "EHLO
        mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903647Ab2EUGBx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 21 May 2012 08:01:53 +0200
Received: by wibhm14 with SMTP id hm14so1745242wib.6
        for <multiple recipients>; Sun, 20 May 2012 23:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=ovFsYjn17+BCIh8SeCkwPw72lgmLEqbZVYPj8jf2Zpk=;
        b=DX9fAKnLKr4hKoXOrGqzTy4/ouYF0yvWg7h/aNMuUqmNQ9CHcHJpjB64utjjYv2goW
         QXlDHNEZnCRmklkUupjcu+lsfeokigtav2LadsuozL3J4gxMOrrEClkMGzEciJubzORV
         HmGJPT1XMrF2p2RP2XyjGkRB/3doAcqKkCklHW+FCC1cdkI8EJ6Iq57hdJOgCSG81Tbs
         S1ln68uK2Ya+brCJS6CsbtwklaVoVGdmbmaSx/z4m3xcLbLb/yVol8grbb40wF3lOdbd
         bzzhNhXcWgk+G203gzrzqMOkhiYsj8r20XsYb6lxxLgGDqYe27TjwmmLJpyxmNDdrSXm
         90LQ==
Received: by 10.216.198.14 with SMTP id u14mr12229421wen.12.1337580107960;
        Sun, 20 May 2012 23:01:47 -0700 (PDT)
Received: from localhost ([61.148.56.138])
        by mx.google.com with ESMTPS id fo7sm23602644wib.9.2012.05.20.23.01.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 20 May 2012 23:01:47 -0700 (PDT)
From:   Yong Zhang <yong.zhang0@gmail.com>
To:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Cc:     ralf@linux-mips.org, sshtylyov@mvista.com, david.daney@cavium.com
Subject: [PATCH 5/8] MIPS: call ->smp_finish() a little late
Date:   Mon, 21 May 2012 14:00:05 +0800
Message-Id: <1337580008-7280-6-git-send-email-yong.zhang0@gmail.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <1337580008-7280-1-git-send-email-yong.zhang0@gmail.com>
References: <1337580008-7280-1-git-send-email-yong.zhang0@gmail.com>
X-archive-position: 33394
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yong.zhang0@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: Yong Zhang <yong.zhang@windriver.com>

We have move irq enable to ->smp_finish. Place ->smp_finish() a little
late to prepare for move set_cpu_online() into start_secondary.
And it's not necessary to call cpu_set(cpu, cpu_callin_map) and
synchronise_count_slave() with irq enabled.

Signed-off-by: Yong Zhang <yong.zhang0@gmail.com>
Acked-by: David Daney <david.daney@cavium.com>
---
 arch/mips/kernel/smp.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index ba9376b..73a268a 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -122,13 +122,14 @@ asmlinkage __cpuinit void start_secondary(void)
 
 	notify_cpu_starting(cpu);
 
-	mp_ops->smp_finish();
 	set_cpu_sibling_map(cpu);
 
 	cpu_set(cpu, cpu_callin_map);
 
 	synchronise_count_slave();
 
+	mp_ops->smp_finish();
+
 	cpu_idle();
 }
 
-- 
1.7.5.4
