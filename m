Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 05 Nov 2011 22:34:48 +0100 (CET)
Received: from [69.28.251.93] ([69.28.251.93]:41244 "EHLO b32.net"
        rhost-flags-FAIL-FAIL-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1904172Ab1KEVdg (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 5 Nov 2011 22:33:36 +0100
Received: (qmail 28069 invoked from network); 5 Nov 2011 17:28:37 -0000
Received: from unknown (HELO vps-1001064-677.cp.jvds.com) (127.0.0.1)
  by 127.0.0.1 with (DHE-RSA-AES128-SHA encrypted) SMTP; 5 Nov 2011 17:28:37 -0000
Received: by vps-1001064-677.cp.jvds.com (sSMTP sendmail emulation); Sat, 05 Nov 2011 10:28:37 -0700
From:   Kevin Cernekee <cernekee@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Subject: [PATCH 4/9] MIPS: Clean up whitespace warning in hazards.h
Date:   Sat, 05 Nov 2011 14:21:13 -0700
Message-Id: <c4c46bb96117cf4f0d7296440cc7c568@localhost>
In-Reply-To: <c2c8833593cb8eeef5c102468e105497@localhost>
References: <c2c8833593cb8eeef5c102468e105497@localhost>
User-Agent: vim 7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-archive-position: 31406
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 4401

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
