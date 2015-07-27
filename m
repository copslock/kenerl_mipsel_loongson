Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jul 2015 22:04:09 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:27821 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011440AbbG0UD3lPr0X (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 27 Jul 2015 22:03:29 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 57CBC666AD901;
        Mon, 27 Jul 2015 21:03:20 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 27 Jul 2015 21:03:24 +0100
Received: from localhost (10.100.200.213) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Mon, 27 Jul
 2015 21:03:23 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Guenter Roeck <linux@roeck-us.net>,
        Matthew Fortune <matthew.fortune@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        "Ralf Baechle" <ralf@linux-mips.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 16/16] MIPS: drop EXPERIMENTAL tag from O32+FP64 & MSA
Date:   Mon, 27 Jul 2015 12:58:27 -0700
Message-ID: <1438027107-24420-17-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.4.6
In-Reply-To: <1438027107-24420-1-git-send-email-paul.burton@imgtec.com>
References: <1438027107-24420-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.213]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48474
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

Changes in v2: None

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
2.4.6
