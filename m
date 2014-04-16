Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Apr 2014 15:08:09 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.89.28.114]:37478 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6837176AbaDPNGgHcbhC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Apr 2014 15:06:36 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 8FF177D48A0C0
        for <linux-mips@linux-mips.org>; Wed, 16 Apr 2014 14:06:22 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (192.168.5.97) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.181.6; Wed, 16 Apr
 2014 14:06:25 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (192.168.5.97) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Wed, 16 Apr 2014 14:06:24 +0100
Received: from pburton-linux.le.imgtec.org (192.168.154.79) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Wed, 16 Apr 2014 14:06:23 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 36/39] MIPS: include cpuidle Kconfig menu
Date:   Wed, 16 Apr 2014 14:06:20 +0100
Message-ID: <1397653580-4868-1-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <1397652810-4336-1-git-send-email-paul.burton@imgtec.com>
References: <1397652810-4336-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.79]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39843
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

This patch simply includes the cpuidle Kconfig entries in preparation
for cpuidle drivers used on MIPS systems.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
 arch/mips/Kconfig | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 860a1e9..a3f32e7 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2678,12 +2678,16 @@ endmenu
 config MIPS_EXTERNAL_TIMER
 	bool
 
-if CPU_SUPPORTS_CPUFREQ && MIPS_EXTERNAL_TIMER
 menu "CPU Power Management"
+
+if CPU_SUPPORTS_CPUFREQ && MIPS_EXTERNAL_TIMER
 source "drivers/cpufreq/Kconfig"
-endmenu
 endif
 
+source "drivers/cpuidle/Kconfig"
+
+endmenu
+
 source "net/Kconfig"
 
 source "drivers/Kconfig"
-- 
1.8.5.3
