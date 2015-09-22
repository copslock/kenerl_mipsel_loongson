Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Sep 2015 19:17:06 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:37514 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008556AbbIVRREkl7cr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Sep 2015 19:17:04 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id D6DF82841A23A;
        Tue, 22 Sep 2015 18:16:54 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 22 Sep 2015 18:16:58 +0100
Received: from localhost (192.168.159.189) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Tue, 22 Sep
 2015 18:16:57 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] MIPS: allow 24Hz timer frequency
Date:   Tue, 22 Sep 2015 10:16:39 -0700
Message-ID: <1442942199-32523-1-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.5.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.189]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49283
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

A boundary exists beyond which the timer frequency becomes high enough
that timer interrupts saturate the system and either cause it to slow to
a crawl or stop functioning entirely. Where that boundary lies depends
upon a number of factors such as the overhead of each interrupt and the
overall speed of the CPU, but correlates strongly with the clock
frequency at which the CPU runs. When running on emulators during
bringup or debug of a CPU that clock frequency is very low, which
results in the boundary at which the timer frequency becomes
unsustainable being very low. The current minimum of 48Hz pushes against
boundary in certain situations in current systems. Allow the kernel to
be configured for a 24Hz timer frequency in order to avoid problems on
such slow running systems.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/Kconfig | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index e3aa5b0..79cac90 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2529,6 +2529,9 @@ choice
 	help
 	 Allows the configuration of the timer frequency.
 
+	config HZ_24
+		bool "24 HZ" if SYS_SUPPORTS_24HZ || SYS_SUPPORTS_ARBIT_HZ
+
 	config HZ_48
 		bool "48 HZ" if SYS_SUPPORTS_48HZ || SYS_SUPPORTS_ARBIT_HZ
 
@@ -2552,6 +2555,9 @@ choice
 
 endchoice
 
+config SYS_SUPPORTS_24HZ
+	bool
+
 config SYS_SUPPORTS_48HZ
 	bool
 
@@ -2575,13 +2581,18 @@ config SYS_SUPPORTS_1024HZ
 
 config SYS_SUPPORTS_ARBIT_HZ
 	bool
-	default y if !SYS_SUPPORTS_48HZ && !SYS_SUPPORTS_100HZ && \
-		     !SYS_SUPPORTS_128HZ && !SYS_SUPPORTS_250HZ && \
-		     !SYS_SUPPORTS_256HZ && !SYS_SUPPORTS_1000HZ && \
+	default y if !SYS_SUPPORTS_24HZ && \
+		     !SYS_SUPPORTS_48HZ && \
+		     !SYS_SUPPORTS_100HZ && \
+		     !SYS_SUPPORTS_128HZ && \
+		     !SYS_SUPPORTS_250HZ && \
+		     !SYS_SUPPORTS_256HZ && \
+		     !SYS_SUPPORTS_1000HZ && \
 		     !SYS_SUPPORTS_1024HZ
 
 config HZ
 	int
+	default 24 if HZ_24
 	default 48 if HZ_48
 	default 100 if HZ_100
 	default 128 if HZ_128
-- 
2.5.3
