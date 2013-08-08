Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Aug 2013 15:38:39 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:59729 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6822308Ab3HHNigITSoW (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 8 Aug 2013 15:38:36 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org, linux-mips@linux-mips.org,
        Thomas Langer <thomas.langer@lantiq.com>
Subject: [PATCH 1/2] serial: MIPS: lantiq: add clk_enable() call to driver
Date:   Thu,  8 Aug 2013 15:31:26 +0200
Message-Id: <1375968687-8704-1-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37474
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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

From: Thomas Langer <thomas.langer@lantiq.com>

Enable the clock if one is present when setting up the console.

Signed-off-by: Thomas Langer <thomas.langer@lantiq.com>
Acked-by: John Crispin <blogic@openwrt.org>
---
 drivers/tty/serial/lantiq.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/lantiq.c b/drivers/tty/serial/lantiq.c
index 15733da..ce1ea35 100644
--- a/drivers/tty/serial/lantiq.c
+++ b/drivers/tty/serial/lantiq.c
@@ -636,6 +636,9 @@ lqasc_console_setup(struct console *co, char *options)
 
 	port = &ltq_port->port;
 
+	if (ltq_port->clk)
+		clk_enable(ltq_port->clk);
+
 	port->uartclk = clk_get_rate(ltq_port->fpiclk);
 
 	if (options)
-- 
1.7.10.4
