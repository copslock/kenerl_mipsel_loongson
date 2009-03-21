Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 Mar 2009 13:11:58 +0000 (GMT)
Received: from smtp14.dti.ne.jp ([202.216.231.189]:3968 "EHLO smtp14.dti.ne.jp")
	by ftp.linux-mips.org with ESMTP id S21369751AbZCUNLw (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 21 Mar 2009 13:11:52 +0000
Received: from [192.168.1.5] (PPPax1767.tokyo-ip.dti.ne.jp [210.159.179.17]) by smtp14.dti.ne.jp (3.11s) with ESMTP AUTH id n2LDBnwY018643;Sat, 21 Mar 2009 22:11:50 +0900 (JST)
Message-ID: <49C4E795.4070400@ruby.dti.ne.jp>
Date:	Sat, 21 Mar 2009 22:11:49 +0900
From:	Shinya Kuribayashi <skuribay@ruby.dti.ne.jp>
User-Agent: Thunderbird 2.0.0.21 (X11/20090318)
MIME-Version: 1.0
To:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: [PATCH] MIPS: EMMA2RH: Set UART mapbase
References: <49C4E5D5.4070408@ruby.dti.ne.jp> <49C4E646.7010309@ruby.dti.ne.jp> <49C4E6BC.8040902@ruby.dti.ne.jp>
In-Reply-To: <49C4E6BC.8040902@ruby.dti.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <skuribay@ruby.dti.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22118
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: skuribay@ruby.dti.ne.jp
Precedence: bulk
X-list: linux-mips

Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi@necel.com>
---

 arch/mips/emma/markeins/platform.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/mips/emma/markeins/platform.c b/arch/mips/emma/markeins/platform.c
index d5f47e4..80ae12e 100644
--- a/arch/mips/emma/markeins/platform.c
+++ b/arch/mips/emma/markeins/platform.c
@@ -110,6 +110,7 @@ struct platform_device i2c_emma_devices[] = {
 static struct  plat_serial8250_port platform_serial_ports[] = {
 	[0] = {
 		.membase= (void __iomem*)KSEG1ADDR(EMMA2RH_PFUR0_BASE + 3),
+		.mapbase = EMMA2RH_PFUR0_BASE + 3,
 		.irq = EMMA2RH_IRQ_PFUR0,
 		.uartclk = EMMA2RH_SERIAL_CLOCK,
 		.regshift = 4,
@@ -117,6 +118,7 @@ static struct  plat_serial8250_port platform_serial_ports[] = {
 		.flags = EMMA2RH_SERIAL_FLAGS,
        }, [1] = {
 		.membase = (void __iomem*)KSEG1ADDR(EMMA2RH_PFUR1_BASE + 3),
+		.mapbase = EMMA2RH_PFUR1_BASE + 3,
 		.irq = EMMA2RH_IRQ_PFUR1,
 		.uartclk = EMMA2RH_SERIAL_CLOCK,
 		.regshift = 4,
@@ -124,6 +126,7 @@ static struct  plat_serial8250_port platform_serial_ports[] = {
 		.flags = EMMA2RH_SERIAL_FLAGS,
        }, [2] = {
 		.membase = (void __iomem*)KSEG1ADDR(EMMA2RH_PFUR2_BASE + 3),
+		.mapbase = EMMA2RH_PFUR2_BASE + 3,
 		.irq = EMMA2RH_IRQ_PFUR2,
 		.uartclk = EMMA2RH_SERIAL_CLOCK,
 		.regshift = 4,
