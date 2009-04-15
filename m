Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Apr 2009 10:02:11 +0100 (BST)
Received: from sitar.i-cable.com ([203.83.115.100]:38338 "HELO
	sitar.i-cable.com") by ftp.linux-mips.org with SMTP
	id S20022882AbZDOJCF (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 15 Apr 2009 10:02:05 +0100
Received: (qmail 757 invoked by uid 508); 15 Apr 2009 09:01:56 -0000
Received: from 203.83.114.122 by sitar (envelope-from <r0bertz@gentoo.org>, uid 505) with qmail-scanner-1.25 
 (clamdscan: 0.93.3/8786.  
 Clear:RC:1(203.83.114.122):. 
 Processed in 0.107237 secs); 15 Apr 2009 09:01:56 -0000
Received: from ip114122.hkicable.com (HELO xenon.i-cable.com) (203.83.114.122)
  by 0 with SMTP; 15 Apr 2009 09:01:56 -0000
Received: from localhost.localdomain (cm222-167-208-75.hkcable.com.hk [222.167.208.75])
	by xenon.i-cable.com (8.13.5/8.13.5) with ESMTP id n3F91rak004975;
	Wed, 15 Apr 2009 17:01:55 +0800 (CST)
From:	Zhang Le <r0bertz@gentoo.org>
To:	linux-mips@linux-mips.org
Cc:	yanh@lemote.com, zhangfx@lemote.com, penglj@lemote.com,
	Zhang Le <r0bertz@gentoo.org>
Subject: [PATCH] Loongson 2 requires no NOP insns to work around hazards
Date:	Wed, 15 Apr 2009 17:01:52 +0800
Message-Id: <1239786112-22120-1-git-send-email-r0bertz@gentoo.org>
X-Mailer: git-send-email 1.6.2
Return-Path: <r0bertz@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22338
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: r0bertz@gentoo.org
Precedence: bulk
X-list: linux-mips

Quoting from Loongson2FUserGuide.pdf:

5.22.1 Hazards
The processor detects most of the pipeline hazards in hardware, including CP0 hazards and
load hazards. No NOP instructions are required to correct instruction sequences.

Signed-off-by: Zhang Le <r0bertz@gentoo.org>
---
 arch/mips/include/asm/hazards.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/include/asm/hazards.h b/arch/mips/include/asm/hazards.h
index 134e1fc..19d1141 100644
--- a/arch/mips/include/asm/hazards.h
+++ b/arch/mips/include/asm/hazards.h
@@ -139,7 +139,7 @@ do {									\
 } while (0)
 
 #elif defined(CONFIG_CPU_R10000) || defined(CONFIG_CPU_CAVIUM_OCTEON) || \
-      defined(CONFIG_CPU_R5500)
+      defined(CONFIG_CPU_R5500) || defined(CONFIG_CPU_LOONGSON2)
 
 /*
  * R10000 rocks - all hazards handled in hardware, so this becomes a nobrainer.
-- 
1.6.2
