Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Apr 2015 00:11:53 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:62818 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011885AbbD1WLvzqHpp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Apr 2015 00:11:51 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 7B893487A7676;
        Tue, 28 Apr 2015 23:11:44 +0100 (IST)
Received: from hhmail02.hh.imgtec.org (10.100.10.20) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Tue, 28 Apr
 2015 23:11:48 +0100
Received: from laptop.hh.imgtec.org (10.100.200.184) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (TLS) id 14.3.224.2; Tue, 28 Apr
 2015 23:11:46 +0100
From:   Ezequiel Garcia <ezequiel.garcia@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Andrew Bresticker <abrestic@chromium.org>,
        James Hartley <james.hartley@imgtec.com>,
        "Ezequiel Garcia" <ezequiel.garcia@imgtec.com>
Subject: [PATCH] MIPS: pistachio: Support 8250-based early printk
Date:   Tue, 28 Apr 2015 19:08:35 -0300
Message-ID: <1430258915-28943-1-git-send-email-ezequiel.garcia@imgtec.com>
X-Mailer: git-send-email 2.3.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.184]
Return-Path: <Ezequiel.Garcia@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47141
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ezequiel.garcia@imgtec.com
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

Pistachio SoCs are capable of early printk with generic 8250 support,
so let's select the options to enable it.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
---
 arch/mips/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index f501665..29d558d 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -386,6 +386,8 @@ config MACH_PISTACHIO
 	select SYS_SUPPORTS_MIPS_CPS
 	select SYS_SUPPORTS_MULTITHREADING
 	select SYS_SUPPORTS_ZBOOT
+	select SYS_HAS_EARLY_PRINTK
+	select USE_GENERIC_EARLY_PRINTK_8250
 	select USE_OF
 	help
 	  This enables support for the IMG Pistachio SoC platform.
-- 
2.3.3
