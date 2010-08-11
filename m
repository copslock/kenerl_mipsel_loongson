Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Aug 2010 12:12:12 +0200 (CEST)
Received: from mgw2.diku.dk ([130.225.96.92]:49105 "EHLO mgw2.diku.dk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492325Ab0HKKMG (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 11 Aug 2010 12:12:06 +0200
Received: from localhost (localhost [127.0.0.1])
        by mgw2.diku.dk (Postfix) with ESMTP id 9705D19BEA1;
        Wed, 11 Aug 2010 12:12:02 +0200 (CEST)
Received: from mgw2.diku.dk ([127.0.0.1])
 by localhost (mgw2.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 24288-10; Wed, 11 Aug 2010 12:12:00 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
        by mgw2.diku.dk (Postfix) with ESMTP id 1F36919BE9F;
        Wed, 11 Aug 2010 12:12:00 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
        by nhugin.diku.dk (Postfix) with ESMTP
        id DBDA96DFD0B; Wed, 11 Aug 2010 12:10:41 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3767)
        id F3959200C3; Wed, 11 Aug 2010 12:11:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by ask.diku.dk (Postfix) with ESMTP id EBEC7200BB;
        Wed, 11 Aug 2010 12:11:59 +0200 (CEST)
Date:   Wed, 11 Aug 2010 12:11:59 +0200 (CEST)
From:   Julia Lawall <julia@diku.dk>
To:     Pat Gefre <pfg@sgi.com>, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH 5/5] drivers/serial: Return -ENOMEM on memory allocation
 failure
Message-ID: <Pine.LNX.4.64.1008111211440.8669@ask.diku.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <julia@diku.dk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27610
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
I believe this code also leaks earlier instances of port, which are only
referenced by card_ptr, which is freed in the error handling code at the
end of the function.  A lot of operations are done on port on each
iteration, however, so I'm not sure whether it is good enough to just free
them.  Perhaps there is some way to call ioc3uart_remove?

 drivers/serial/ioc3_serial.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/serial/ioc3_serial.c b/drivers/serial/ioc3_serial.c
index 93de907..800c546 100644
--- a/drivers/serial/ioc3_serial.c
+++ b/drivers/serial/ioc3_serial.c
@@ -2044,6 +2044,7 @@ ioc3uart_probe(struct ioc3_submodule *is, struct ioc3_driver_data *idd)
 		if (!port) {
 			printk(KERN_WARNING
 			       "IOC3 serial memory not available for port\n");
+			ret = -ENOMEM;
 			goto out4;
 		}
 		spin_lock_init(&port->ip_lock);
