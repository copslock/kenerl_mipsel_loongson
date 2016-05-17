Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 May 2016 07:09:22 +0200 (CEST)
Received: from exsmtp02.microchip.com ([198.175.253.38]:60220 "EHLO
        email.microchip.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27029445AbcEQFIfaWOo6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 May 2016 07:08:35 +0200
Received: from mx.microchip.com (10.10.76.4) by chn-sv-exch02.mchp-main.com
 (10.10.76.38) with Microsoft SMTP Server id 14.3.181.6; Mon, 16 May 2016
 22:08:27 -0700
Received: by mx.microchip.com (sSMTP sendmail emulation); Tue, 17 May 2016
 10:36:40 +0530
From:   Purna Chandra Mandal <purna.mandal@microchip.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>,
        Purna Chandra Mandal <purna.mandal@microchip.com>,
        Jiri Slaby <jslaby@suse.com>, Alan Cox <alan@linux.intel.com>,
        Andrei Pistirica <andrei.pistirica@microchip.com>,
        <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 05/11] serial: pic32_uart: Fix double free of 'sport->irq_fault_name'.
Date:   Tue, 17 May 2016 10:35:54 +0530
Message-ID: <1463461560-9629-5-git-send-email-purna.mandal@microchip.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1463461560-9629-1-git-send-email-purna.mandal@microchip.com>
References: <1463461560-9629-1-git-send-email-purna.mandal@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <Purna.Mandal@microchip.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53471
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: purna.mandal@microchip.com
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

Allocated memory for 'sport->irq_fault_name' is freed twice, first
in error check of 'if(!sport->irq_rx_name)' and other in fallback
handler.

Signed-off-by: Purna Chandra Mandal <purna.mandal@microchip.com>

---

 drivers/tty/serial/pic32_uart.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/serial/pic32_uart.c b/drivers/tty/serial/pic32_uart.c
index 62a43bf..7f8e99b 100644
--- a/drivers/tty/serial/pic32_uart.c
+++ b/drivers/tty/serial/pic32_uart.c
@@ -445,7 +445,6 @@ static int pic32_uart_startup(struct uart_port *port)
 				       sport->idx);
 	if (!sport->irq_rx_name) {
 		dev_err(port->dev, "%s: kasprintf err!", __func__);
-		kfree(sport->irq_fault_name);
 		ret = -ENOMEM;
 		goto out_f;
 	}
-- 
1.8.3.1
