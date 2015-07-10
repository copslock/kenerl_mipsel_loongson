Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Jul 2015 17:06:00 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:43389 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009981AbbGJPFXlqdyp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 10 Jul 2015 17:05:23 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 4DC1FE31E2D24;
        Fri, 10 Jul 2015 16:05:15 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 10 Jul 2015 16:05:17 +0100
Received: from localhost (10.100.200.2) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Fri, 10 Jul
 2015 16:05:17 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Matthew Fortune <matthew.fortune@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 16/16] MIPS: drop EXPERIMENTAL tag from O32+FP64 & MSA
Date:   Fri, 10 Jul 2015 16:00:25 +0100
Message-ID: <1436540426-10021-17-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.4.4
In-Reply-To: <1436540426-10021-1-git-send-email-paul.burton@imgtec.com>
References: <1436540426-10021-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.2]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48192
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

CONFIG_MIPS_O32_FP64_SUPPORT and CONFIG_CPU_HAS_MSA are in pretty good
shape these days, and in much wider use than they once were. Stop
referring to them as EXPERIMENTAL.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>

---

 arch/mips/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index a3b1ffe..1c657e0 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2301,7 +2301,7 @@ config CPU_MICROMIPS
 endchoice
 
 config CPU_HAS_MSA
-	bool "Support for the MIPS SIMD Architecture (EXPERIMENTAL)"
+	bool "Support for the MIPS SIMD Architecture"
 	depends on CPU_SUPPORTS_MSA
 	depends on 64BIT || MIPS_O32_FP64_SUPPORT
 	help
@@ -2641,7 +2641,7 @@ config SECCOMP
 	  If unsure, say Y. Only embedded should say N here.
 
 config MIPS_O32_FP64_SUPPORT
-	bool "Support for O32 binaries using 64-bit FP (EXPERIMENTAL)"
+	bool "Support for O32 binaries using 64-bit FP"
 	depends on 32BIT || MIPS32_O32
 	help
 	  When this is enabled, the kernel will support use of 64-bit floating
-- 
2.4.4
