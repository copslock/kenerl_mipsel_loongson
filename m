Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Sep 2010 06:42:16 +0200 (CEST)
Received: from mail-pv0-f177.google.com ([74.125.83.177]:57675 "EHLO
        mail-pv0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491000Ab0I2EmM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Sep 2010 06:42:12 +0200
Received: by pvg12 with SMTP id 12so106982pvg.36
        for <linux-mips@linux-mips.org>; Tue, 28 Sep 2010 21:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=ysYj4J9yCT/qAncHDdH2N1OZI+9h2s9grhgqxxt8bME=;
        b=Ab1mpoI7bHy/BLK4kI6naQO1llzvpMN9qJTDjXcwLc0FmalNQ1trmB5wkbOA9wbLAu
         mLp9pNSGg5pJF/91MIFPf9c9PCgvMCb+A1nj7DDppnTy9r9D6fYqj/WkQJQh2dgCUZ3w
         NYKjmF9jL34FSoJyPifTI7Qd1AKJEzSHlmYyI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=tG5eBfMOj0/cu5BJBetDvMo0aRdodoK63CdnAymJgGZOmX+8aEzNAoliRihcA4T1zx
         qioACqHgu/X9jU9ybjaduEK7UJB+vTrwZIgzP02SWRcvCgHRVzh8HMGxl9/czxklKdwH
         4v2kaIWNQXkjjMFBuEEMveWYkNv4igL6HqRpo=
Received: by 10.114.108.14 with SMTP id g14mr1220396wac.185.1285735325453;
        Tue, 28 Sep 2010 21:42:05 -0700 (PDT)
Received: from localhost.localdomain ([122.163.149.155])
        by mx.google.com with ESMTPS id x9sm13784595waj.15.2010.09.28.21.42.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 28 Sep 2010 21:42:04 -0700 (PDT)
From:   Rahul Ruikar <rahul.ruikar@gmail.com>
To:     Pat Gefre <pfg@sgi.com>, Greg Kroah-Hartman <gregkh@suse.de>,
        Alan Cox <alan@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>
Cc:     linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rahul Ruikar <rahul.ruikar@gmail.com>
Subject: [PATCH] serial: ioc3_serial: release resources in error return path
Date:   Wed, 29 Sep 2010 10:11:19 +0530
Message-Id: <1285735279-2952-1-git-send-email-rahul.ruikar@gmail.com>
X-Mailer: git-send-email 1.7.2.3
X-archive-position: 27886
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rahul.ruikar@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 23013

In ioc3uart_probe()
resources were not released during error return path
- ports[phys_port]

Signed-off-by: Rahul Ruikar <rahul.ruikar@gmail.com>
---
 drivers/serial/ioc3_serial.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/serial/ioc3_serial.c b/drivers/serial/ioc3_serial.c
index 93de907..1a182cf 100644
--- a/drivers/serial/ioc3_serial.c
+++ b/drivers/serial/ioc3_serial.c
@@ -2017,6 +2017,7 @@ ioc3uart_probe(struct ioc3_submodule *is, struct ioc3_driver_data *idd)
 	struct ioc3_port *port;
 	struct ioc3_port *ports[PORTS_PER_CARD];
 	int phys_port;
+	int cnt;
 
 	DPRINT_CONFIG(("%s (0x%p, 0x%p)\n", __func__, is, idd));
 
@@ -2044,7 +2045,7 @@ ioc3uart_probe(struct ioc3_submodule *is, struct ioc3_driver_data *idd)
 		if (!port) {
 			printk(KERN_WARNING
 			       "IOC3 serial memory not available for port\n");
-			goto out4;
+			goto out3;
 		}
 		spin_lock_init(&port->ip_lock);
 
@@ -2138,13 +2139,16 @@ ioc3uart_probe(struct ioc3_submodule *is, struct ioc3_driver_data *idd)
 	/* register port with the serial core */
 
 	if ((ret = ioc3_serial_core_attach(is, idd)))
-		goto out4;
+		goto out3;
 
 	Num_of_ioc3_cards++;
 
 	return ret;
 
 	/* error exits that give back resources */
+out3:
+	for (cnt = 0; cnt < phys_port; cnt++)
+		kfree(ports[cnt]);
 out4:
 	kfree(card_ptr);
 	return ret;
-- 
1.7.2.3
