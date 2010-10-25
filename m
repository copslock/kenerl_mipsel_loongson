Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Oct 2010 18:44:30 +0200 (CEST)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:38409 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491005Ab0JYQoZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 25 Oct 2010 18:44:25 +0200
Received: by fxm15 with SMTP id 15so2494748fxm.36
        for <multiple recipients>; Mon, 25 Oct 2010 09:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=dEne5QOZ/rI4vUFg2Nr0bxvuzU3/pbZE6tjd+gZi804=;
        b=Ldp98VeWBui0NgKaXj+q11xIVVUFCBaGy6y/W06P9KSlAWbaCubHvYW5wA7gYjwdiX
         HWj7gkFi+wNpnOQNAljNPQFFJSTONzHMRl4f4bwevg/g9y99sWUM6zQYx+NV6iTCBy5+
         NSSPxytDUXxaeo+6vgv56YcHsEdeLaThnaIy8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=Xec91M+dRhs/15dgbVDmDdXQGak4WsuB2+4yH1675xA52r6iksULLZ+s7NvZW9E/mq
         VQO6IB0DuZo+slsniHIDgAzKfyRmnZ6eBKa62FZqte+4EFZ7KZzByxRPN0T+n2DYUcFW
         IZ1qL/nkhiYQ0gmg+vxDMZbvS9M19zsV8TEtk=
Received: by 10.216.199.81 with SMTP id w59mr570869wen.100.1288025060050;
        Mon, 25 Oct 2010 09:44:20 -0700 (PDT)
Received: from localhost.localdomain (188-22-147-239.adsl.highway.telekom.at [188.22.147.239])
        by mx.google.com with ESMTPS id x12sm4321855weq.42.2010.10.25.09.44.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 25 Oct 2010 09:44:19 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH V2] MIPS: Alchemy: fix build with SERIAL_8250=n
Date:   Mon, 25 Oct 2010 18:44:11 +0200
Message-Id: <1288025051-17145-1-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.3.2
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28232
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

In commit 7d172bfe ("Alchemy: Add UART PM methods") I introduced
platform PM methods which call a function of the 8250 driver;
this patch works around link failures when the kernel is built
without 8250 support.

Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---
V2: added commit name to patch description as per Sergei's suggestion.

 arch/mips/alchemy/common/platform.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/mips/alchemy/common/platform.c b/arch/mips/alchemy/common/platform.c
index 3691630..9e7814d 100644
--- a/arch/mips/alchemy/common/platform.c
+++ b/arch/mips/alchemy/common/platform.c
@@ -27,6 +27,7 @@
 static void alchemy_8250_pm(struct uart_port *port, unsigned int state,
 			    unsigned int old_state)
 {
+#ifdef CONFIG_SERIAL_8250
 	switch (state) {
 	case 0:
 		if ((__raw_readl(port->membase + UART_MOD_CNTRL) & 3) != 3) {
@@ -49,6 +50,7 @@ static void alchemy_8250_pm(struct uart_port *port, unsigned int state,
 		serial8250_do_pm(port, state, old_state);
 		break;
 	}
+#endif
 }
 
 #define PORT(_base, _irq)					\
-- 
1.7.3.2
