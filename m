Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Oct 2014 18:34:08 +0200 (CEST)
Received: from faui40.informatik.uni-erlangen.de ([131.188.34.40]:47055 "EHLO
        faui40.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011905AbaJTQeGCIy8i (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 Oct 2014 18:34:06 +0200
Received: from faui48e.informatik.uni-erlangen.de (faui48e.informatik.uni-erlangen.de [IPv6:2001:638:a000:4134::ffff:51])
        by faui40.informatik.uni-erlangen.de (Postfix) with ESMTP id 3549658C4C1;
        Mon, 20 Oct 2014 18:34:05 +0200 (CEST)
Received: by faui48e.informatik.uni-erlangen.de (Postfix, from userid 31112)
        id 2591C4E0CD8; Mon, 20 Oct 2014 18:34:05 +0200 (CEST)
From:   Stefan Hengelein <stefan.hengelein@fau.de>
To:     linux-mips@linux-mips.org
Cc:     linux-kernel@vger.kernel.org, ryazanov.s.a@gmail.com,
        ralf@linux-mips.org, Stefan Hengelein <stefan.hengelein@fau.de>
Subject: [PATCH] MIPS: MSP71xx: remove compilation error when CONFIG_MIPS_MT is present
Date:   Mon, 20 Oct 2014 18:33:39 +0200
Message-Id: <1413822819-8827-1-git-send-email-stefan.hengelein@fau.de>
X-Mailer: git-send-email 1.9.1
Return-Path: <sistheng@faui48e.informatik.uni-erlangen.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43357
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: stefan.hengelein@fau.de
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

When CONFIG_MIPS_MT is defined, code is enabled that tries to call
'set_vi_handler()'. This function is declared in <asm/setup.h> but the
header is never included. Therefore, the compilation breaks.

arch/mips/pmcs-msp71xx/msp_irq.c:133: error: implicit declaration of function 'set_vi_handler'

This error was found with vampyr.

Signed-off-by: Stefan Hengelein <stefan.hengelein@fau.de>
---
 arch/mips/pmcs-msp71xx/msp_irq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/pmcs-msp71xx/msp_irq.c b/arch/mips/pmcs-msp71xx/msp_irq.c
index f914c75..8d53d7a 100644
--- a/arch/mips/pmcs-msp71xx/msp_irq.c
+++ b/arch/mips/pmcs-msp71xx/msp_irq.c
@@ -16,6 +16,7 @@
 #include <linux/time.h>
 
 #include <asm/irq_cpu.h>
+#include <asm/setup.h>
 
 #include <msp_int.h>
 
-- 
1.9.1
