Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 May 2009 07:30:50 +0100 (BST)
Received: from pyxis.i-cable.com ([203.83.115.105]:39220 "HELO
	pyxis.i-cable.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with SMTP id S20023591AbZEHGao (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 8 May 2009 07:30:44 +0100
Received: (qmail 7947 invoked by uid 104); 8 May 2009 06:30:37 -0000
Received: from 203.83.114.121 by pyxis (envelope-from <r0bertz@gentoo.org>, uid 101) with qmail-scanner-2.01 
 (clamdscan: 0.93.3/7733.  
 Clear:RC:1(203.83.114.121):. 
 Processed in 0.151239 secs); 08 May 2009 06:30:37 -0000
Received: from ip114121.hkicable.com (HELO silicon.i-cable.com) (203.83.114.121)
  by 0 with SMTP; 8 May 2009 06:30:36 -0000
Received: from localhost.localdomain (cm222-167-208-75.hkcable.com.hk [222.167.208.75])
	by silicon.i-cable.com (8.13.5/8.13.5) with ESMTP id n486UVwk000812;
	Fri, 8 May 2009 14:30:36 +0800 (HKT)
From:	Zhang Le <r0bertz@gentoo.org>
To:	linux-mips@linux-mips.org
Cc:	Zhang Le <r0bertz@gentoo.org>
Subject: [PATCH 2/3] MIPS: Loongson 2 has cpu_has_uncached_accelerated feature
Date:	Fri,  8 May 2009 14:30:02 +0800
Message-Id: <fb705e2eb405eea04853ae53639457a295a7dd90.1241764065.git.r0bertz@gentoo.org>
X-Mailer: git-send-email 1.6.2.3
In-Reply-To: <a1356a5b181a188435ff569b4f7abe57cf8fd7eb.1241764065.git.r0bertz@gentoo.org>
References: <cover.1241764064.git.r0bertz@gentoo.org>
 <a1356a5b181a188435ff569b4f7abe57cf8fd7eb.1241764065.git.r0bertz@gentoo.org>
In-Reply-To: <cover.1241764064.git.r0bertz@gentoo.org>
References: <cover.1241764064.git.r0bertz@gentoo.org>
Return-Path: <r0bertz@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22663
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: r0bertz@gentoo.org
Precedence: bulk
X-list: linux-mips

Signed-off-by: Zhang Le <r0bertz@gentoo.org>
---
 .../asm/mach-lemote/cpu-feature-overrides.h        |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/mach-lemote/cpu-feature-overrides.h b/arch/mips/include/asm/mach-lemote/cpu-feature-overrides.h
index 52ec54b..700dd17 100644
--- a/arch/mips/include/asm/mach-lemote/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-lemote/cpu-feature-overrides.h
@@ -50,6 +50,7 @@
 #define cpu_has_tlb		1
 #define cpu_has_tx39_cache	0
 #define cpu_has_userlocal	0
+#define cpu_has_uncached_accelerated	1
 #define cpu_has_vce		0
 #define cpu_has_vtag_icache	0
 #define cpu_has_watch		1
-- 
1.6.2.3
