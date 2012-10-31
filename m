Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Oct 2012 13:58:45 +0100 (CET)
Received: from mms2.broadcom.com ([216.31.210.18]:2705 "EHLO mms2.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6824847Ab2JaM6oKfy-x (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 31 Oct 2012 13:58:44 +0100
Received: from [10.9.200.133] by mms2.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Wed, 31 Oct 2012 05:56:40 -0700
X-Server-Uuid: 4500596E-606A-40F9-852D-14843D8201B2
Received: from mail-irva-13.broadcom.com (10.11.16.103) by
 IRVEXCHHUB02.corp.ad.broadcom.com (10.9.200.133) with Microsoft SMTP
 Server id 8.2.247.2; Wed, 31 Oct 2012 05:57:57 -0700
Received: from netl-snoppy.ban.broadcom.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 5F2DA40FE3; Wed, 31
 Oct 2012 05:58:26 -0700 (PDT)
From:   "Jayachandran C" <jchandra@broadcom.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
cc:     "Jayachandran C" <jchandra@broadcom.com>
Subject: [PATCH 03/15] MIPS: Netlogic: select MIPSR2 for XLP
Date:   Wed, 31 Oct 2012 18:31:29 +0530
Message-ID: <3172102a3b041fdefbc721e3a25a95427bdec384.1351688140.git.jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1351688140.git.jchandra@broadcom.com>
References: <cover.1351688140.git.jchandra@broadcom.com>
MIME-Version: 1.0
X-WSS-ID: 7C8FFF823QC1968380-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-archive-position: 34795
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jchandra@broadcom.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

This allows us to use the r2 optimized code from kernel headers
while compilation.

Disable PGD_C0_CONTEXT option for XLP, which does not work.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/Kconfig |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index c40d282..346b44d 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1525,6 +1525,7 @@ config CPU_XLP
 	select WEAK_ORDERING
 	select WEAK_REORDERING_BEYOND_LLSC
 	select CPU_HAS_PREFETCH
+	select CPU_MIPSR2
 	help
 	  Netlogic Microsystems XLP processors.
 endchoice
@@ -1738,7 +1739,7 @@ config CPU_SUPPORTS_UNCACHED_ACCELERATED
 	bool
 config MIPS_PGD_C0_CONTEXT
 	bool
-	default y if 64BIT && CPU_MIPSR2
+	default y if 64BIT && CPU_MIPSR2 && !CPU_XLP
 
 #
 # Set to y for ptrace access to watch registers.
-- 
1.7.9.5
