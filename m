Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Nov 2011 07:41:35 +0100 (CET)
Received: from [69.28.251.93] ([69.28.251.93]:46080 "EHLO b32.net"
        rhost-flags-FAIL-FAIL-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903950Ab1KKGlG (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 11 Nov 2011 07:41:06 +0100
Received: (qmail 16038 invoked from network); 11 Nov 2011 06:40:55 -0000
Received: from unknown (HELO vps-1001064-677.cp.jvds.com) (127.0.0.1)
  by 127.0.0.1 with (DHE-RSA-AES128-SHA encrypted) SMTP; 11 Nov 2011 06:40:55 -0000
Received: by vps-1001064-677.cp.jvds.com (sSMTP sendmail emulation); Thu, 10 Nov 2011 22:40:55 -0800
From:   Kevin Cernekee <cernekee@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Subject: [PATCH V2 2/8] MIPS: Clean up whitespace warning in hazards.h
Date:   Thu, 10 Nov 2011 22:30:25 -0800
Message-Id: <e87a9e6aca8237728cb46b3d7059d650@localhost>
In-Reply-To: <5f9666eb295ce196b2a9688afab07dea@localhost>
References: <5f9666eb295ce196b2a9688afab07dea@localhost>
User-Agent: vim 7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-archive-position: 31535
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 10043

Use a tab on second and subsequent lines of multiline #if's, for
consistency with the next commit.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 arch/mips/include/asm/hazards.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/hazards.h b/arch/mips/include/asm/hazards.h
index 4e33216..8f630e4 100644
--- a/arch/mips/include/asm/hazards.h
+++ b/arch/mips/include/asm/hazards.h
@@ -139,8 +139,8 @@ do {									\
 } while (0)
 
 #elif defined(CONFIG_MIPS_ALCHEMY) || defined(CONFIG_CPU_CAVIUM_OCTEON) || \
-      defined(CONFIG_CPU_LOONGSON2) || defined(CONFIG_CPU_R10000) || \
-      defined(CONFIG_CPU_R5500)
+	defined(CONFIG_CPU_LOONGSON2) || defined(CONFIG_CPU_R10000) || \
+	defined(CONFIG_CPU_R5500)
 
 /*
  * R10000 rocks - all hazards handled in hardware, so this becomes a nobrainer.
-- 
1.7.6.3
