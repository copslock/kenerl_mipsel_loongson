Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Nov 2014 00:37:43 +0100 (CET)
Received: from mail-pd0-f170.google.com ([209.85.192.170]:44638 "EHLO
        mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006920AbaKXXgj7QE8N (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 25 Nov 2014 00:36:39 +0100
Received: by mail-pd0-f170.google.com with SMTP id fp1so10780241pdb.1
        for <linux-mips@linux-mips.org>; Mon, 24 Nov 2014 15:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2trJITNTcx4Ju5Y1pS2yFS1f5VkjVL+ihRt+1komXhI=;
        b=RI9Nn17JtVB5VFz5+hKwtFq2Bv62BS/Nn7kNQEuBYJefBvekq3YTA/w8w0gY4p7vEh
         LAcWjmplYEz+et/76hXLpWQvVVErmKdN4bp+Su2KxvywNeCr6prTLThcqSBZUdvZ8hCz
         2VrP836GVmmiNjspaWZT/RdLQJsmjWe99iuk2vkWu2jfNsFWXVj0K4Tbsz5B4hPNB065
         Fr5GyrnvaILs2fc/XViHQ/53XF4rwudR979P3AmXzoLm2AhQZPsWGCsB2fUd6xfIhXHv
         DNowKiLrEiV4H5xAxaFR0ktj0lmEACXE73NuDEN42qN0I2JEjtDK191ezFQY0gB2dfUY
         D0bw==
X-Received: by 10.70.31.35 with SMTP id x3mr37700976pdh.34.1416872194372;
        Mon, 24 Nov 2014 15:36:34 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id aq1sm13382876pbd.29.2014.11.24.15.36.32
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 24 Nov 2014 15:36:33 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.cz, robh@kernel.org,
        grant.likely@linaro.org
Cc:     arnd@arndb.de, f.fainelli@gmail.com, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@linux-mips.org
Subject: [PATCH V3 4/7] serial: core: Add big-endian iotype
Date:   Mon, 24 Nov 2014 15:36:19 -0800
Message-Id: <1416872182-6440-5-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1416872182-6440-1-git-send-email-cernekee@gmail.com>
References: <1416872182-6440-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44416
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
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

Since most drivers interpret UPIO_MEM32 to mean "little-endian" and use
readl/writel to access the registers, add a parallel UPIO_MEM32BE to
request the use of big-endian MMIO accessors (ioread32be/iowrite32be).

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 drivers/tty/serial/serial_core.c |  2 ++
 include/linux/serial_core.h      | 13 +++++++------
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index eaeb9a0..ecc7d6c 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2092,6 +2092,7 @@ uart_report_port(struct uart_driver *drv, struct uart_port *port)
 		break;
 	case UPIO_MEM:
 	case UPIO_MEM32:
+	case UPIO_MEM32BE:
 	case UPIO_AU:
 	case UPIO_TSI:
 		snprintf(address, sizeof(address),
@@ -2736,6 +2737,7 @@ int uart_match_port(struct uart_port *port1, struct uart_port *port2)
 		       (port1->hub6   == port2->hub6);
 	case UPIO_MEM:
 	case UPIO_MEM32:
+	case UPIO_MEM32BE:
 	case UPIO_AU:
 	case UPIO_TSI:
 		return (port1->mapbase == port2->mapbase);
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 21c2e05..d2d5bf6 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -140,12 +140,13 @@ struct uart_port {
 	unsigned char		iotype;			/* io access style */
 	unsigned char		unused1;
 
-#define UPIO_PORT		(0)
-#define UPIO_HUB6		(1)
-#define UPIO_MEM		(2)
-#define UPIO_MEM32		(3)
-#define UPIO_AU			(4)			/* Au1x00 and RT288x type IO */
-#define UPIO_TSI		(5)			/* Tsi108/109 type IO */
+#define UPIO_PORT		(0)			/* 8b I/O port access */
+#define UPIO_HUB6		(1)			/* Hub6 ISA card */
+#define UPIO_MEM		(2)			/* 8b MMIO access */
+#define UPIO_MEM32		(3)			/* 32b little endian */
+#define UPIO_MEM32BE		(4)			/* 32b big endian */
+#define UPIO_AU			(5)			/* Au1x00 and RT288x type IO */
+#define UPIO_TSI		(6)			/* Tsi108/109 type IO */
 
 	unsigned int		read_status_mask;	/* driver specific */
 	unsigned int		ignore_status_mask;	/* driver specific */
-- 
2.1.0
