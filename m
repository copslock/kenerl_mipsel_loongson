Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Jul 2011 22:04:03 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:44587 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491152Ab1GRUDE (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 18 Jul 2011 22:03:04 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <blogic@openwrt.org>,
        Thomas Langer <thomas.langer@lantiq.com>,
        linux-mips@linux-mips.org, linux-serial@vger.kernel.org
Subject: [PATCH 3/3] MIPS: lantiq: set timeout in uart_port
Date:   Mon, 18 Jul 2011 22:04:13 +0200
Message-Id: <1311019453-21277-3-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1311019453-21277-1-git-send-email-blogic@openwrt.org>
References: <1311019453-21277-1-git-send-email-blogic@openwrt.org>
X-archive-position: 30647
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 12693

Without this patch apps using readline hang.

Signed-off-by: Thomas Langer <thomas.langer@lantiq.com>
Signed-off-by: John Crispin <blogic@openwrt.org>
Cc: linux-mips@linux-mips.org
Cc: linux-serial@vger.kernel.org
---
 drivers/tty/serial/lantiq.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/lantiq.c b/drivers/tty/serial/lantiq.c
index 58cf279..bc95f52 100644
--- a/drivers/tty/serial/lantiq.c
+++ b/drivers/tty/serial/lantiq.c
@@ -478,8 +478,10 @@ lqasc_set_termios(struct uart_port *port,
 	spin_unlock_irqrestore(&ltq_asc_lock, flags);
 
 	/* Don't rewrite B0 */
-        if (tty_termios_baud_rate(new))
+	if (tty_termios_baud_rate(new))
 		tty_termios_encode_baud_rate(new, baud, baud);
+
+	uart_update_timeout(port, cflag, baud);
 }
 
 static const char*
-- 
1.7.2.3
