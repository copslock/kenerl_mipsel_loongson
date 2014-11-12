Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Nov 2014 21:55:12 +0100 (CET)
Received: from mail-pd0-f178.google.com ([209.85.192.178]:51598 "EHLO
        mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013569AbaKLUyla5GAO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 Nov 2014 21:54:41 +0100
Received: by mail-pd0-f178.google.com with SMTP id fp1so12835888pdb.23
        for <linux-mips@linux-mips.org>; Wed, 12 Nov 2014 12:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fcFQOtM91Pswv+qYEEFpHC9nB9vzqDzszAVWYyJzqos=;
        b=JMXXf4sYGAEuUaM9BPiW3n2Ij6SUrhrMCCynjQ6RDYTxzDhXu9ifk4BOXQNGknNS1/
         SvmM/rqVg7EQVTilulpzRSc8bKF/3oiXNHU33QCn8bb8npsvVpaketGU5d/tNoG28ti4
         QmnVXva002Ncab0rJuF3h8DaqjsP0Cyj89BXprI7nEZIcNKNt2g2an3Q6ol+c3LHrolK
         NwWDIOsnhm1kckVbfsNg+hsTYYfMGvVNwo+uQyN5B6a9T2zJ4sQjZnsARDF5WCXRk1Q5
         4lykDLbDWuJFDct3/kkOvH2Ioxvm8/2/aet2tRWNfryJVfabi/MLaMtH9UFCk9EJGezG
         Wehg==
X-Received: by 10.70.3.196 with SMTP id e4mr50308294pde.35.1415825675691;
        Wed, 12 Nov 2014 12:54:35 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id z15sm23050495pdi.6.2014.11.12.12.54.33
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 12 Nov 2014 12:54:35 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.cz, robh@kernel.org
Cc:     arnd@arndb.de, daniel@zonque.org, haojian.zhuang@gmail.com,
        robert.jarzmik@free.fr, grant.likely@linaro.org,
        f.fainelli@gmail.com, mbizon@freebox.fr, jogo@openwrt.org,
        linux-mips@linux-mips.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH V2 02/10] serial: core: Add big-endian iotype
Date:   Wed, 12 Nov 2014 12:53:59 -0800
Message-Id: <1415825647-6024-3-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1415825647-6024-1-git-send-email-cernekee@gmail.com>
References: <1415825647-6024-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44077
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
2.1.1
