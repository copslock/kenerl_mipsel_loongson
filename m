Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Apr 2012 09:26:05 +0200 (CEST)
Received: from mail-qa0-f49.google.com ([209.85.216.49]:49180 "EHLO
        mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903590Ab2DPHZt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 Apr 2012 09:25:49 +0200
Received: by qafi29 with SMTP id i29so3342927qaf.15
        for <multiple recipients>; Mon, 16 Apr 2012 00:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=3MzNyNr4xQTUP7dLgmpyCSLN8PzfrlQyWicSCM8xi7k=;
        b=jWbIhmuozsKv0+/RrkIlq8c66yq4X79DbpozK0oo89W5cBHIdi6bZoM+Yo13Aen3l6
         O7eMKNl74lNIN7dyOcTlUE7dGhUZlXNSdAqt/q9WVpDc1BLJmhJTH0VFm9TQtZ5cxKPd
         fCpx4eQqcYm2qfQwhKRrRLCAwXOUad9CMczxTVilgDC9Dn48VVGbaDd56hviLjv4zs0M
         +Y6+JIA7ZsCF1yXOqAI6LN47NdeuZQD7iGQvDDyIOlQ3T7FWi9Tkqau2MABYl8KpJuOT
         nyyrIZt8pDW9EULS5E6I7sfUTA9X3ZxceTvpt06gpGTPTgNaWE9kKkMQKO9GyUc3FRrt
         gyIw==
Received: by 10.224.180.1 with SMTP id bs1mr13974744qab.2.1334561142897;
        Mon, 16 Apr 2012 00:25:42 -0700 (PDT)
Received: from localhost ([61.148.56.138])
        by mx.google.com with ESMTPS id i12sm32932451qad.9.2012.04.16.00.25.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 16 Apr 2012 00:25:42 -0700 (PDT)
From:   Yong Zhang <yong.zhang0@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Yong Zhang <yong.zhang@windriver.com>,
        David Daney <ddaney@caviumnetworks.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH] MIPS: cavium: Don't enable irq in ->init__secondary()
Date:   Mon, 16 Apr 2012 15:25:33 +0800
Message-Id: <1334561133-19139-1-git-send-email-yong.zhang0@gmail.com>
X-Mailer: git-send-email 1.7.5.4
X-archive-position: 32944
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yong.zhang0@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: Yong Zhang <yong.zhang@windriver.com>

Too early to enable irq will break some following action,
such as notify_cpu_starting().

I don't get side effect with this patch.

Signed-off-by: Yong Zhang <yong.zhang0@gmail.com>
Cc: David Daney <ddaney@caviumnetworks.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
---
 arch/mips/cavium-octeon/smp.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/mips/cavium-octeon/smp.c b/arch/mips/cavium-octeon/smp.c
index 97e7ce9..7e65c88 100644
--- a/arch/mips/cavium-octeon/smp.c
+++ b/arch/mips/cavium-octeon/smp.c
@@ -185,7 +185,6 @@ static void __cpuinit octeon_init_secondary(void)
 	octeon_init_cvmcount();
 
 	octeon_irq_setup_secondary();
-	raw_local_irq_enable();
 }
 
 /**
-- 
1.7.5.4
