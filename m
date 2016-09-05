Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Sep 2016 18:19:07 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:48282 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992241AbcIEQTAn0Yfu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 5 Sep 2016 18:19:00 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id EA03974698916;
        Mon,  5 Sep 2016 17:18:40 +0100 (IST)
Received: from mredfearn-linux.le.imgtec.org (10.150.130.83) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Mon, 5 Sep 2016 17:18:43 +0100
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] MIPS: rb532: Fix undefined reference to setup_serial_port
Date:   Mon, 5 Sep 2016 17:18:40 +0100
Message-ID: <1473092320-30019-1-git-send-email-matt.redfearn@imgtec.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55039
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@imgtec.com
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

If the rb532 machine is compiled without CONFIG_SERIAL_8250, the
following linker error occurs

arch/mips/built-in.o: In function `setup_serial_port':
(.init.text+0x20c): undefined reference to `early_serial_setup'

Fix this by wrapping registration of the rb532 uart in an ifdef
CONFIG_SERIAL_8250.

Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>

---

 arch/mips/rb532/serial.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/mips/rb532/serial.c b/arch/mips/rb532/serial.c
index 70482540b3db..f0ea2de38840 100644
--- a/arch/mips/rb532/serial.c
+++ b/arch/mips/rb532/serial.c
@@ -36,6 +36,8 @@
 
 extern unsigned int idt_cpu_freq;
 
+#ifdef CONFIG_SERIAL_8250
+
 static struct uart_port rb532_uart = {
 	.flags = UPF_BOOT_AUTOCONF,
 	.line = 0,
@@ -52,3 +54,6 @@ int __init setup_serial_port(void)
 	return early_serial_setup(&rb532_uart);
 }
 arch_initcall(setup_serial_port);
+
+#endif /* CONFIG_SERIAL_8250 */
+
-- 
2.7.4
