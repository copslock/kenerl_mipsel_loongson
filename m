Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Nov 2013 12:13:06 +0100 (CET)
Received: from gerard.telenet-ops.be ([195.130.132.48]:38057 "EHLO
        gerard.telenet-ops.be" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822678Ab3KSLMnY6DFx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 19 Nov 2013 12:12:43 +0100
Received: from ayla.of.borg ([84.193.72.141])
        by gerard.telenet-ops.be with bizsmtp
        id rPCi1m00M32ts5g0HPCirl; Tue, 19 Nov 2013 12:12:42 +0100
Received: from geert by ayla.of.borg with local (Exim 4.76)
        (envelope-from <geert@linux-m68k.org>)
        id 1VijEX-00076g-UO; Tue, 19 Nov 2013 12:12:41 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Rob Herring <rob.herring@calxeda.com>
Cc:     devicetree@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>, linux-mips@linux-mips.org
Subject: [PATCH 6/9] mips: Remove unused dt_setup_arch()
Date:   Tue, 19 Nov 2013 12:12:31 +0100
Message-Id: <1384859554-27268-6-git-send-email-geert@linux-m68k.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1384859554-27268-1-git-send-email-geert@linux-m68k.org>
References: <5283A000.8090007@gmail.com>
 <1384859554-27268-1-git-send-email-geert@linux-m68k.org>
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38540
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
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

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: John Crispin <blogic@openwrt.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/include/asm/prom.h |    7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/mips/include/asm/prom.h b/arch/mips/include/asm/prom.h
index ccd2b75f152c..7e2ee8301c06 100644
--- a/arch/mips/include/asm/prom.h
+++ b/arch/mips/include/asm/prom.h
@@ -23,13 +23,6 @@ struct boot_param_header;
 
 extern void __dt_setup_arch(struct boot_param_header *bph);
 
-#define dt_setup_arch(sym)						\
-({									\
-	extern struct boot_param_header __dtb_##sym##_begin;		\
-									\
-	__dt_setup_arch(&__dtb_##sym##_begin);				\
-})
-
 #else /* CONFIG_OF */
 static inline void device_tree_init(void) { }
 #endif /* CONFIG_OF */
-- 
1.7.9.5
