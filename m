Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Aug 2013 21:02:12 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:50276 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6865319Ab3HITBlqjpxB (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 9 Aug 2013 21:01:41 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org, linux-mips@linux-mips.org,
        Thomas Langer <thomas.langer@lantiq.com>
Subject: [PATCH V2 1/2] serial: MIPS: lantiq: add clk_enable() call to driver
Date:   Fri,  9 Aug 2013 20:54:30 +0200
Message-Id: <1376074471-29404-1-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37503
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
Changes in V2:
* make use of IS_ERR()

 drivers/tty/serial/lantiq.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/lantiq.c b/drivers/tty/serial/lantiq.c
index 15733da..93ac046 100644
--- a/drivers/tty/serial/lantiq.c
+++ b/drivers/tty/serial/lantiq.c
@@ -636,6 +636,9 @@ lqasc_console_setup(struct console *co, char *options)
 
 	port = &ltq_port->port;
 
+	if (!IS_ERR(ltq_port->clk))
+		clk_enable(ltq_port->clk);
+
 	port->uartclk = clk_get_rate(ltq_port->fpiclk);
 
 	if (options)
-- 
1.7.10.4
