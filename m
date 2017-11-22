Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Nov 2017 10:58:34 +0100 (CET)
Received: from 19pmail.ess.barracuda.com ([64.235.150.245]:49106 "EHLO
        19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990409AbdKVJ61z84zn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 Nov 2017 10:58:27 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx29.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Wed, 22 Nov 2017 09:57:59 +0000
Received: from mredfearn-linux.mipstec.com (10.150.130.83) by
 MIPSMAIL01.mipstec.com (10.20.43.31) with Microsoft SMTP Server (TLS) id
 14.3.361.1; Wed, 22 Nov 2017 01:57:51 -0800
From:   Matt Redfearn <matt.redfearn@mips.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>
CC:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        <linux-serial@vger.kernel.org>, <linux-mips@linux-mips.org>,
        Matt Redfearn <matt.redfearn@mips.com>,
        "stable # 4 . 14" <stable@vger.kernel.org>,
        "Marc Gonzalez" <marc_gonzalez@sigmadesigns.com>,
        Jiri Slaby <jslaby@suse.com>, <linux-kernel@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: [PATCH 1/2] serial: 8250_early: Only set divisor if valid clk & baud
Date:   Wed, 22 Nov 2017 09:57:28 +0000
Message-ID: <1511344649-27612-1-git-send-email-matt.redfearn@mips.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
X-BESS-ID: 1511344679-637139-12578-470676-3
X-BESS-VER: 2017.14-r1710272128
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.187188
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Matt.Redfearn@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61046
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@mips.com
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

If either uartclk or baud are 0, avoid calculating and setting a divisor
based on them since the output will almost certainly be garbage.

This also allows platforms such as the MIPS generic kernel, which has no
way to know a valid BASE_BASE for the board it is actually booted on at
compile time, to set BASE_BAUD to 0 and avoid early_8250 setting a bad
divisor.

This fixes a regression caused by commit 31cb9a8575ca ("earlycon:
initialise baud field of earlycon device structure"), which changed the
behavior of of_setup_earlycon such that it sets a baud rate in the
earlycon structure where previously it was left as 0. All boards
supported by the MIPS generic kernel started outputting garbage from the
boot console due to an incorrect divisor being set.

Fixes: 31cb9a8575ca ("earlycon: initialise baud field of earlycon device structure")
Cc: stable <stable@vger.kernel.org> # 4.14
Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
---

 drivers/tty/serial/8250/8250_early.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_early.c b/drivers/tty/serial/8250/8250_early.c
index af72ec32e404..f135c1846477 100644
--- a/drivers/tty/serial/8250/8250_early.c
+++ b/drivers/tty/serial/8250/8250_early.c
@@ -125,12 +125,14 @@ static void __init init_port(struct earlycon_device *device)
 	serial8250_early_out(port, UART_FCR, 0);	/* no fifo */
 	serial8250_early_out(port, UART_MCR, 0x3);	/* DTR + RTS */
 
-	divisor = DIV_ROUND_CLOSEST(port->uartclk, 16 * device->baud);
-	c = serial8250_early_in(port, UART_LCR);
-	serial8250_early_out(port, UART_LCR, c | UART_LCR_DLAB);
-	serial8250_early_out(port, UART_DLL, divisor & 0xff);
-	serial8250_early_out(port, UART_DLM, (divisor >> 8) & 0xff);
-	serial8250_early_out(port, UART_LCR, c & ~UART_LCR_DLAB);
+	if (port->uartclk && device->baud) {
+		divisor = DIV_ROUND_CLOSEST(port->uartclk, 16 * device->baud);
+		c = serial8250_early_in(port, UART_LCR);
+		serial8250_early_out(port, UART_LCR, c | UART_LCR_DLAB);
+		serial8250_early_out(port, UART_DLL, divisor & 0xff);
+		serial8250_early_out(port, UART_DLM, (divisor >> 8) & 0xff);
+		serial8250_early_out(port, UART_LCR, c & ~UART_LCR_DLAB);
+	}
 }
 
 int __init early_serial8250_setup(struct earlycon_device *device,
-- 
2.7.4
