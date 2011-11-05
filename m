Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 05 Nov 2011 22:34:27 +0100 (CET)
Received: from [69.28.251.93] ([69.28.251.93]:41227 "EHLO b32.net"
        rhost-flags-FAIL-FAIL-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1904168Ab1KEVdc (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 5 Nov 2011 22:33:32 +0100
Received: (qmail 28064 invoked from network); 5 Nov 2011 17:28:32 -0000
Received: from unknown (HELO vps-1001064-677.cp.jvds.com) (127.0.0.1)
  by 127.0.0.1 with (DHE-RSA-AES128-SHA encrypted) SMTP; 5 Nov 2011 17:28:32 -0000
Received: by vps-1001064-677.cp.jvds.com (sSMTP sendmail emulation); Sat, 05 Nov 2011 10:28:32 -0700
From:   Kevin Cernekee <cernekee@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Subject: [PATCH 3/9] MIPS: BMIPS: Add XKS01 feature flag to Kconfig
Date:   Sat, 05 Nov 2011 14:21:12 -0700
Message-Id: <2eda9a788a1682b6db6d2adf3ba6ebc1@localhost>
In-Reply-To: <c2c8833593cb8eeef5c102468e105497@localhost>
References: <c2c8833593cb8eeef5c102468e105497@localhost>
User-Agent: vim 7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-archive-position: 31405
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 4400

Many BMIPS processors have the ability to extend kseg0 to 1024MB in
order to reclaim large amounts of kernel virtual address space.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 arch/mips/Kconfig |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 8b231ba..2983b5f 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1990,6 +1990,9 @@ config CPU_HAS_SMARTMIPS
 config CPU_HAS_WB
 	bool
 
+config XKS01
+	bool
+
 #
 # Vectored interrupt mode is an R2 feature
 #
-- 
1.7.6.3
