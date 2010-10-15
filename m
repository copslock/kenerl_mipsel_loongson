Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Oct 2010 14:54:15 +0200 (CEST)
Received: from mgw2.diku.dk ([130.225.96.92]:47318 "EHLO mgw2.diku.dk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491157Ab0JOMyM (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 15 Oct 2010 14:54:12 +0200
Received: from localhost (localhost [127.0.0.1])
        by mgw2.diku.dk (Postfix) with ESMTP id EE5F019BCD0;
        Fri, 15 Oct 2010 14:54:10 +0200 (CEST)
Received: from mgw2.diku.dk ([127.0.0.1])
 by localhost (mgw2.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 16742-17; Fri, 15 Oct 2010 14:54:09 +0200 (CEST)
Received: from palace.topps.diku.dk (palace.ekstranet.diku.dk [192.38.115.202])
        by mgw2.diku.dk (Postfix) with ESMTP id 3088A19BCD6;
        Fri, 15 Oct 2010 14:54:06 +0200 (CEST)
From:   Julia Lawall <julia@diku.dk>
To:     Pat Gefre <pfg@sgi.com>
Cc:     kernel-janitors@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] drivers/serial/ioc3_serial.c: Return -ENOMEM on memory allocation failure
Date:   Fri, 15 Oct 2010 15:00:09 +0200
Message-Id: <1287147610-8041-6-git-send-email-julia@diku.dk>
X-Mailer: git-send-email 1.7.1
Return-Path: <julia@diku.dk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28086
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: julia@diku.dk
Precedence: bulk
X-list: linux-mips

From: Julia Lawall <julia@diku.dk>

In this code, 0 is returned on memory allocation failure, even though other
failures return -ENOMEM or other similar values.

A simplified version of the semantic match that finds this problem is as
follows: (http://coccinelle.lip6.fr/)

// <smpl>
@@
expression ret;
expression x,e1,e2,e3;
@@

ret = 0
... when != ret = e1
*x = \(kmalloc\|kcalloc\|kzalloc\)(...)
... when != ret = e2
if (x == NULL) { ... when != ret = e3
  return ret;
}
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>

---
 drivers/serial/ioc3_serial.c |    1 +
 1 file changed, 1 insertion(+)

diff -u -p a/drivers/serial/ioc3_serial.c b/drivers/serial/ioc3_serial.c
--- a/drivers/serial/ioc3_serial.c
+++ b/drivers/serial/ioc3_serial.c
@@ -2045,6 +2045,7 @@ ioc3uart_probe(struct ioc3_submodule *is
 		if (!port) {
 			printk(KERN_WARNING
 			       "IOC3 serial memory not available for port\n");
+			ret = -ENOMEM;
 			goto out4;
 		}
 		spin_lock_init(&port->ip_lock);
