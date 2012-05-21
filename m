Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 May 2012 08:01:05 +0200 (CEST)
Received: from mail-we0-f177.google.com ([74.125.82.177]:63089 "EHLO
        mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903554Ab2EUGAi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 21 May 2012 08:00:38 +0200
Received: by werc12 with SMTP id c12so3762952wer.36
        for <multiple recipients>; Sun, 20 May 2012 23:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=JuiyImB6cSiEdx9VBh8AaOfx9jmv7ena1Qntb1eUkrw=;
        b=dqEopw+YpQ4ptdFoaHWZlFoPX1jAuzPkYs/TyfDz5MQ/5QKrXPWBEcVOLZ9tX5GVx3
         Epld42ErJLwFE6sfzv4M4+T/XWlsiya82hxGCPV+JnGI3jSVJ8I/sOu7isByPBWb0TAV
         OeFtoIDThQPOE8F8dwIuPb1B5ZWUTCf1T0s+clMNa+K7ieSXRRrB5l589CdSQ9cZTSCd
         rkmdHK8cXf3b9BblcsZOBDA9Ag3Ze1tT3yn9oGNOqaqB78g1HSbx4wqVRcFchpyRN6bI
         x4WOPlivGIooawI6I/Kh/w2g6TNxT5SbVkhrBTFkIkFmWTlic6irXq6oLllweW3MbGd7
         i8ww==
Received: by 10.180.82.195 with SMTP id k3mr21960968wiy.9.1337580033377;
        Sun, 20 May 2012 23:00:33 -0700 (PDT)
Received: from localhost ([61.148.56.138])
        by mx.google.com with ESMTPS id ez4sm23581476wid.3.2012.05.20.23.00.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 20 May 2012 23:00:32 -0700 (PDT)
From:   Yong Zhang <yong.zhang0@gmail.com>
To:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Cc:     ralf@linux-mips.org, sshtylyov@mvista.com, david.daney@cavium.com
Subject: [PATCH 1/8] MIPS: Octeon: delay enable irq to ->smp_finish()
Date:   Mon, 21 May 2012 14:00:01 +0800
Message-Id: <1337580008-7280-2-git-send-email-yong.zhang0@gmail.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <1337580008-7280-1-git-send-email-yong.zhang0@gmail.com>
References: <1337580008-7280-1-git-send-email-yong.zhang0@gmail.com>
X-archive-position: 33390
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
Cc: Ralf Baechle <ralf@linux-mips.org>
Acked-by: David Daney <david.daney@cavium.com>
---
 arch/mips/cavium-octeon/smp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/cavium-octeon/smp.c b/arch/mips/cavium-octeon/smp.c
index 97e7ce9..ef9c34a 100644
--- a/arch/mips/cavium-octeon/smp.c
+++ b/arch/mips/cavium-octeon/smp.c
@@ -185,7 +185,6 @@ static void __cpuinit octeon_init_secondary(void)
 	octeon_init_cvmcount();
 
 	octeon_irq_setup_secondary();
-	raw_local_irq_enable();
 }
 
 /**
@@ -233,6 +232,7 @@ static void octeon_smp_finish(void)
 
 	/* to generate the first CPU timer interrupt */
 	write_c0_compare(read_c0_count() + mips_hpt_frequency / HZ);
+	local_irq_enable();
 }
 
 /**
-- 
1.7.5.4
