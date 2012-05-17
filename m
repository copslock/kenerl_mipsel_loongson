Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 May 2012 12:11:00 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:50802 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903633Ab2EQKKr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 May 2012 12:10:47 +0200
Received: by pbbrq13 with SMTP id rq13so2660880pbb.36
        for <multiple recipients>; Thu, 17 May 2012 03:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=ohw5wuf8zcn0CZKhKJoZ23rdD17C0uKJdcyAdSszrNE=;
        b=u8HqoSbyLSMTPRUpbKNW/bE6tTd43dSwwz48T68jTpKyTuk+ls2zYZwlI31NW3L29a
         Wk9V07PgDDd6fMsizSgS4uOHZ3qGOuKLSC4LeeLtu2xITmSWYJ9/wHx/2jbvbfpMltVd
         j/pNJZkbLiRW+0mUpY6QFZbHfSJS5Tjbo04lnQRZXYSKzVl23iRwzyoUFB/nzwrZoUfy
         77HZKWOtTJXlQx2Eqk2mdyenG0b6Pndbo0L5ls63NCjhvEucfwly0irIaI9xGlvOYyBy
         kfDjpeMpzadmBAFDev0/Lx6OlLfaHvjYLW1aNhBECN5G21lgzbG6VaZkOamvnmCbR1O/
         HGLA==
Received: by 10.68.135.71 with SMTP id pq7mr4841649pbb.102.1337249440266;
        Thu, 17 May 2012 03:10:40 -0700 (PDT)
Received: from localhost ([221.223.131.58])
        by mx.google.com with ESMTPS id jv6sm8641233pbc.40.2012.05.17.03.10.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 17 May 2012 03:10:39 -0700 (PDT)
From:   Yong Zhang <yong.zhang0@gmail.com>
To:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Cc:     ralf@linux-mips.org, david.daney@cavium.com
Subject: [PATCH 1/8] MIPS: Octeon: delay enable irq to ->smp_finish()
Date:   Thu, 17 May 2012 18:10:03 +0800
Message-Id: <1337249410-7162-2-git-send-email-yong.zhang0@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1337249410-7162-1-git-send-email-yong.zhang0@gmail.com>
References: <1337249410-7162-1-git-send-email-yong.zhang0@gmail.com>
X-archive-position: 33342
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
Cc: David Daney <david.daney@cavium.com>
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
1.7.1
