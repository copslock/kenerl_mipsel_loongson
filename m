Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Mar 2017 14:10:20 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:2308 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993423AbdCDNKNvp0sM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 4 Mar 2017 14:10:13 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 3AA17A2550A1B;
        Sat,  4 Mar 2017 13:10:03 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 hhmail02.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Sat, 4 Mar 2017 13:10:06 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     <linux-kernel@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jason Uy <jason.uy@broadcom.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Heiko Stuebner <heiko@sntech.de>,
        David Daney <david.daney@cavium.com>,
        Russell King <linux@armlinux.org.uk>,
        <linux-serial@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-mips@linux-mips.org>,
        <bcm-kernel-feedback-list@broadcom.com>
Subject: [PATCH] serial: 8250_dw: Fix breakage when HAVE_CLK=n
Date:   Sat, 4 Mar 2017 13:09:58 +0000
Message-ID: <20170304130958.23655-1-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.11.1
In-Reply-To: <CAHp75Ved2h2WyWBokEOsDmAyB3w3iM=uh-9Bq01mU1ST4FapWQ@mail.gmail.com>
References: <CAHp75Ved2h2WyWBokEOsDmAyB3w3iM=uh-9Bq01mU1ST4FapWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57033
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

Commit 6a171b299379 ("serial: 8250_dw: Allow hardware flow control to be
used") recently broke the 8250_dw driver on platforms which don't select
HAVE_CLK, as dw8250_set_termios() gets confused by the behaviour of the
fallback HAVE_CLK=n clock API in linux/clk.h which pretends everything
is fine but returns (valid) NULL clocks and 0 HZ clock rates.

That 0 rate is written into the uartclk resulting in a crash at boot,
e.g. on Cavium Octeon III based UTM-8 we get something like this:

1180000000800.serial: ttyS0 at MMIO 0x1180000000800 (irq = 41, base_baud = 25000000) is a OCTEON
------------[ cut here ]------------
WARNING: CPU: 2 PID: 1 at drivers/tty/serial/serial_core.c:441 uart_get_baud_rate+0xfc/0x1f0
...
Call Trace:
...
[<ffffffff8149c2e4>] uart_get_baud_rate+0xfc/0x1f0
[<ffffffff814a5098>] serial8250_do_set_termios+0xb0/0x440
[<ffffffff8149c710>] uart_set_options+0xe8/0x190
[<ffffffff814a6cdc>] serial8250_console_setup+0x84/0x158
[<ffffffff814a11ec>] univ8250_console_setup+0x54/0x70
[<ffffffff811901a0>] register_console+0x1c8/0x418
[<ffffffff8149f004>] uart_add_one_port+0x434/0x4b0
[<ffffffff814a1af8>] serial8250_register_8250_port+0x2d8/0x440
[<ffffffff814aa620>] dw8250_probe+0x388/0x5e8
...

The clock API is defined such that NULL is a valid clock handle so it
wouldn't be right to check explicitly for NULL. Instead treat a
clk_round_rate() return value of 0 as an error which prevents uartclk
being overwritten.

Fixes: 6a171b299379 ("serial: 8250_dw: Allow hardware flow control to be used")
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jason Uy <jason.uy@broadcom.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: David Daney <david.daney@cavium.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-serial@vger.kernel.org
Cc: linux-clk@vger.kernel.org
Cc: linux-mips@linux-mips.org
Cc: bcm-kernel-feedback-list@broadcom.com
---
 drivers/tty/serial/8250/8250_dw.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 223ac234ddb2..e65808c482f1 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -267,6 +267,8 @@ static void dw8250_set_termios(struct uart_port *p, struct ktermios *termios,
 	rate = clk_round_rate(d->clk, baud * 16);
 	if (rate < 0)
 		ret = rate;
+	else if (rate == 0)
+		ret = -ENOENT;
 	else
 		ret = clk_set_rate(d->clk, rate);
 	clk_prepare_enable(d->clk);
-- 
2.11.1
