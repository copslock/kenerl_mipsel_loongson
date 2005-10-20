Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Oct 2005 07:03:37 +0100 (BST)
Received: from adsl-67-116-42-147.dsl.sntc01.pacbell.net ([67.116.42.147]:61206
	"EHLO avtrex.com") by ftp.linux-mips.org with ESMTP
	id S8133374AbVJTGDT (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 20 Oct 2005 07:03:19 +0100
Received: from dl2.hq2.avtrex.com (dl2.hq2.avtrex.com [127.0.0.1])
	by avtrex.com (8.13.1/8.13.1) with ESMTP id j9K63G6Z001289;
	Wed, 19 Oct 2005 23:03:16 -0700
Received: (from daney@localhost)
	by dl2.hq2.avtrex.com (8.13.1/8.13.1/Submit) id j9K63Gum001286;
	Wed, 19 Oct 2005 23:03:16 -0700
From:	David Daney <ddaney@avtrex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17239.13092.785385.20266@dl2.hq2.avtrex.com>
Date:	Wed, 19 Oct 2005 23:03:16 -0700
To:	linux-mips@linux-mips.org
CC:	linux-kernel@vger.kernel.org
Subject: Patch: ATI Xilleon port 3/11 serial/8250 Set UART_CAP_FIFO in early_serial_setup
X-Mailer: VM 7.19 under Emacs 21.3.1
Reply-To: ddaney@avtrex.com
Return-Path: <daney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9283
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

This is the third part of my Xilleon port.

I am sending the full set of patches to linux-mips@linux-mips.org
which is archived at: http://www.linux-mips.org/archives/

Only the patches that touch generic parts of the kernel are coming
here.

The Xilleon's (32bit MIPS SOC) serial ports do not work right if the
fifo is not enabled.  This prevented early serial support from
working.

The fix is to set UART_CAP_FIFO in early_serial_setup iff the hardware
says it supports it.

Patch against 2.6.14-rc2 from linux-mips.org

Signed-off-by: David Daney <ddaney@avtrex.com>

Set UART_CAP_FIFO in early_serial_setup() if the port has that
capability.  Needed by xilleon port.

---
commit e65836c84865cbcf3abc445984bacc583624e347
tree 9c198c5858e4c8c500327e7947c69921355dea9b
parent 2a66e82b3d2b02aca88cc2f60286fba0c114139d
author David Daney <daney@dl2.hq2.avtrex.com> Tue, 04 Oct 2005 14:02:44 -0700
committer David Daney <daney@dl2.hq2.avtrex.com> Tue, 04 Oct 2005 14:02:44 -0700

 drivers/serial/8250.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -2283,6 +2283,8 @@ int __init early_serial_setup(struct uar
 	serial8250_isa_init_ports();
 	serial8250_ports[port->line].port	= *port;
 	serial8250_ports[port->line].port.ops	= &serial8250_pops;
+        if (uart_config[port->type].flags & UART_CAP_FIFO)
+            serial8250_ports[port->line].capabilities |= UART_CAP_FIFO;
 	return 0;
 }
 
