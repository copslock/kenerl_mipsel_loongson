Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 May 2018 15:14:26 +0200 (CEST)
Received: from nbd.name ([IPv6:2a01:4f8:221:3d45::2]:43100 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993997AbeEGNORVyM0A (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 7 May 2018 15:14:17 +0200
From:   John Crispin <john@phrozen.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-serial@vger.kernel.org, linux-mips@linux-mips.org,
        John Crispin <john@phrozen.org>
Subject: [PATCH] tty: serial: drop ATH79 specific SoC symbols
Date:   Mon,  7 May 2018 15:14:07 +0200
Message-Id: <20180507131407.11312-1-john@phrozen.org>
X-Mailer: git-send-email 2.11.0
Return-Path: <john@phrozen.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63883
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: john@phrozen.org
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

QCA MIPS support is being converted to pure OF. As part of this we are
dropping the SOC_AR* symbols. Additionally the SERIAL_AR933X style tty
is also found on a few SoCs newer that the AR933x.

This patch changes the dependency to ATH79, thus fixing the 2 issues
described above.

Signed-off-by: John Crispin <john@phrozen.org>
---
 drivers/tty/serial/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 3682fd3e960c..c92bd969bbf9 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1469,7 +1469,7 @@ config SERIAL_XILINX_PS_UART_CONSOLE
 
 config SERIAL_AR933X
 	tristate "AR933X serial port support"
-	depends on HAVE_CLK && SOC_AR933X
+	depends on HAVE_CLK && ATH79
 	select SERIAL_CORE
 	help
 	  If you have an Atheros AR933X SOC based board and want to use the
-- 
2.11.0
