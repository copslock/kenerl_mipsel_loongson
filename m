Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Aug 2011 16:37:37 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:33190 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491162Ab1HCOhe (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 3 Aug 2011 16:37:34 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id p73EbQbk010460;
        Wed, 3 Aug 2011 15:37:26 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p73EbODL010459;
        Wed, 3 Aug 2011 15:37:24 +0100
Date:   Wed, 3 Aug 2011 15:37:24 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org
Cc:     John Crispin <blogic@openwrt.org>,
        Thomas Langer <thomas.langer@lantiq.com>,
        linux-mips@linux-mips.org
Subject: [PATCH] SERIAL: Lantiq: Set timeout in uart_port
Message-ID: <20110803143724.GB8673@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 30822
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 2400

From: John Crispin <blogic@openwrt.org>

Without this patch apps using readline hang.

Signed-off-by: Thomas Langer <thomas.langer@lantiq.com>
Signed-off-by: John Crispin <blogic@openwrt.org>
Cc: linux-mips@linux-mips.org
Cc: linux-serial@vger.kernel.org
---
No replies when John Crispin first posted this patch.  He's on vacation
so I'm reposting hoping for an ack.  I'd prefer to merge this through
the MIPS tree along with other lantiq fixes -- thanks.

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
