Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Jul 2014 18:09:11 +0200 (CEST)
Received: from helium.waldemar-brodkorb.de ([89.238.66.15]:41230 "EHLO
        helium.waldemar-brodkorb.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6861041AbaGBQJJ2ni9j (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 Jul 2014 18:09:09 +0200
Received: by helium.waldemar-brodkorb.de (Postfix, from userid 1000)
        id ABCB4104B3; Wed,  2 Jul 2014 18:09:08 +0200 (CEST)
Date:   Wed, 2 Jul 2014 18:09:08 +0200
From:   Waldemar Brodkorb <wbx@openadk.org>
To:     Linux MIPS Mailing List <linux-mips@linux-mips.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org, florian@openwrt.org
Subject: [PATCH] fix reregistering of serial console
Message-ID: <20140702160908.GA12510@waldemar-brodkorb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Operating-System: Linux 3.2.0-4-amd64 x86_64
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <wbx@openadk.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40988
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wbx@openadk.org
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

Runtime tested on Mikrotik RB532 board.
Thanks goes to Geert Uytterhoeven for the explanation of the problem.

"I'm afraid this is not gonna help. When the port is unregistered,
its type will be reset to PORT_UNKNOWN.
So before registering it again, its type must be set again the actual
serial driver, cfr. the change to of_serial.c."

Signed-off-by: Waldemar Brodkorb <wbx@openadk.org>
---
 arch/mips/rb532/devices.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/rb532/devices.c b/arch/mips/rb532/devices.c
index 3af00b2..ba61268 100644
--- a/arch/mips/rb532/devices.c
+++ b/arch/mips/rb532/devices.c
@@ -223,6 +223,7 @@ static struct platform_device rb532_wdt = {
 
 static struct plat_serial8250_port rb532_uart_res[] = {
 	{
+		.type           = PORT_16550A,
 		.membase	= (char *)KSEG1ADDR(REGBASE + UART0BASE),
 		.irq		= UART0_IRQ,
 		.regshift	= 2,
-- 
1.7.10.4
