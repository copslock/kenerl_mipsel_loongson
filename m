Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Jan 2015 21:19:13 +0100 (CET)
Received: from laurent.telenet-ops.be ([195.130.137.89]:37297 "EHLO
        laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010742AbbALUTLxGM45 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 12 Jan 2015 21:19:11 +0100
Received: from ayla.of.borg ([84.193.93.87])
        by laurent.telenet-ops.be with bizsmtp
        id f8KB1p00K1t5w8s018KBjk; Mon, 12 Jan 2015 21:19:11 +0100
Received: from ramsan.of.borg ([192.168.97.29] helo=ramsan)
        by ayla.of.borg with esmtp (Exim 4.82)
        (envelope-from <geert@linux-m68k.org>)
        id 1YAlSB-0005zW-5P; Mon, 12 Jan 2015 21:19:11 +0100
Received: from geert by ramsan with local (Exim 4.82)
        (envelope-from <geert@linux-m68k.org>)
        id 1YAlSE-00071w-Jf; Mon, 12 Jan 2015 21:19:14 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH resend] mips: Remove unused dt_setup_arch()
Date:   Mon, 12 Jan 2015 21:19:13 +0100
Message-Id: <1421093953-26991-1-git-send-email-geert@linux-m68k.org>
X-Mailer: git-send-email 1.9.1
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45092
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
---
 arch/mips/include/asm/prom.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/mips/include/asm/prom.h b/arch/mips/include/asm/prom.h
index eaa26270a5e574ba..8ebc2aa5f3e1331f 100644
--- a/arch/mips/include/asm/prom.h
+++ b/arch/mips/include/asm/prom.h
@@ -24,13 +24,6 @@ struct boot_param_header;
 extern void __dt_setup_arch(void *bph);
 extern int __dt_register_buses(const char *bus0, const char *bus1);
 
-#define dt_setup_arch(sym)						\
-({									\
-	extern char __dtb_##sym##_begin[];				\
-									\
-	__dt_setup_arch(__dtb_##sym##_begin);				\
-})
-
 #else /* CONFIG_OF */
 static inline void device_tree_init(void) { }
 #endif /* CONFIG_OF */
-- 
1.9.1
