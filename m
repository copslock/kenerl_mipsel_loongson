Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Oct 2013 13:17:40 +0200 (CEST)
Received: from mms2.broadcom.com ([216.31.210.18]:2543 "EHLO mms2.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6817088Ab3JYLRgSQB7v (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 25 Oct 2013 13:17:36 +0200
Received: from [10.9.208.55] by mms2.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Fri, 25 Oct 2013 04:17:12 -0700
X-Server-Uuid: 4500596E-606A-40F9-852D-14843D8201B2
Received: from IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) by
 IRVEXCHCAS07.corp.ad.broadcom.com (10.9.208.55) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Fri, 25 Oct 2013 04:17:22 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) with Microsoft SMTP
 Server id 14.1.438.0; Fri, 25 Oct 2013 04:17:22 -0700
Received: from netl-snoppy.ban.broadcom.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 16106246A5; Fri, 25
 Oct 2013 04:17:20 -0700 (PDT)
From:   "Jayachandran C" <jchandra@broadcom.com>
To:     linux-mips@linux-mips.org
cc:     "Markos Chandras" <markos.chandras@imgtec.com>,
        "Jayachandran C" <jchandra@broadcom.com>
Subject: [PATCH] MIPS: Netlogic: Remove XLR early serial setup
Date:   Fri, 25 Oct 2013 16:54:15 +0530
Message-ID: <1382700255-26119-1-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1376571575-29037-1-git-send-email-markos.chandras@imgtec.com>
References: <1376571575-29037-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
X-WSS-ID: 7E748CB24RS1406178-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38391
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jchandra@broadcom.com
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

The early serial code is not needed because we already have early
printk support provided by common/earlycons.c

This change also fixes the following build error that occurs when
CONFIG_SERIAL_8250 is not configured for Netlogic XLR boards:

arch/mips/built-in.o: In function `nlm_early_serial_setup':
setup.c:(.init.text+0x274): undefined reference to `early_serial_setup'
make: *** [vmlinux] Error 1

Reported-by: Markos Chandras <markos.chandras@imgtec.com>
Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/include/asm/netlogic/xlr/xlr.h |    5 -----
 arch/mips/netlogic/xlr/platform.c        |    4 ++--
 arch/mips/netlogic/xlr/setup.c           |   20 --------------------
 3 files changed, 2 insertions(+), 27 deletions(-)

diff --git a/arch/mips/include/asm/netlogic/xlr/xlr.h b/arch/mips/include/asm/netlogic/xlr/xlr.h
index c1667e0..ceb991c 100644
--- a/arch/mips/include/asm/netlogic/xlr/xlr.h
+++ b/arch/mips/include/asm/netlogic/xlr/xlr.h
@@ -35,11 +35,6 @@
 #ifndef _ASM_NLM_XLR_H
 #define _ASM_NLM_XLR_H
 
-/* Platform UART functions */
-struct uart_port;
-unsigned int nlm_xlr_uart_in(struct uart_port *, int);
-void nlm_xlr_uart_out(struct uart_port *, int, int);
-
 /* SMP helpers */
 void xlr_wakeup_secondary_cpus(void);
 
diff --git a/arch/mips/netlogic/xlr/platform.c b/arch/mips/netlogic/xlr/platform.c
index 7b96a91..4785932 100644
--- a/arch/mips/netlogic/xlr/platform.c
+++ b/arch/mips/netlogic/xlr/platform.c
@@ -23,7 +23,7 @@
 #include <asm/netlogic/xlr/pic.h>
 #include <asm/netlogic/xlr/xlr.h>
 
-unsigned int nlm_xlr_uart_in(struct uart_port *p, int offset)
+static unsigned int nlm_xlr_uart_in(struct uart_port *p, int offset)
 {
 	uint64_t uartbase;
 	unsigned int value;
@@ -41,7 +41,7 @@ unsigned int nlm_xlr_uart_in(struct uart_port *p, int offset)
 	return value;
 }
 
-void nlm_xlr_uart_out(struct uart_port *p, int offset, int value)
+static void nlm_xlr_uart_out(struct uart_port *p, int offset, int value)
 {
 	uint64_t uartbase;
 
diff --git a/arch/mips/netlogic/xlr/setup.c b/arch/mips/netlogic/xlr/setup.c
index 214d123..de1f287 100644
--- a/arch/mips/netlogic/xlr/setup.c
+++ b/arch/mips/netlogic/xlr/setup.c
@@ -60,25 +60,6 @@ unsigned int  nlm_threads_per_core = 1;
 struct nlm_soc_info nlm_nodes[NLM_NR_NODES];
 cpumask_t nlm_cpumask = CPU_MASK_CPU0;
 
-static void __init nlm_early_serial_setup(void)
-{
-	struct uart_port s;
-	unsigned long uart_base;
-
-	uart_base = (unsigned long)nlm_mmio_base(NETLOGIC_IO_UART_0_OFFSET);
-	memset(&s, 0, sizeof(s));
-	s.flags		= ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST;
-	s.iotype	= UPIO_MEM32;
-	s.regshift	= 2;
-	s.irq		= PIC_UART_0_IRQ;
-	s.uartclk	= PIC_CLK_HZ;
-	s.serial_in	= nlm_xlr_uart_in;
-	s.serial_out	= nlm_xlr_uart_out;
-	s.mapbase	= uart_base;
-	s.membase	= (unsigned char __iomem *)uart_base;
-	early_serial_setup(&s);
-}
-
 static void nlm_linux_exit(void)
 {
 	uint64_t gpiobase;
@@ -215,7 +196,6 @@ void __init prom_init(void)
 	memcpy(reset_vec, (void *)nlm_reset_entry,
 			(nlm_reset_entry_end - nlm_reset_entry));
 
-	nlm_early_serial_setup();
 	build_arcs_cmdline(argv);
 	prom_add_memory();
 
-- 
1.7.9.5
