Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Sep 2013 15:29:31 +0200 (CEST)
Received: from mail-bk0-f50.google.com ([209.85.214.50]:61630 "EHLO
        mail-bk0-f50.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6862318Ab3IRN0iU31Xa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Sep 2013 15:26:38 +0200
Received: by mail-bk0-f50.google.com with SMTP id mz11so2793321bkb.37
        for <multiple recipients>; Wed, 18 Sep 2013 06:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qGUzxlzBGVxioF5be096o8borPTa7AXLzPFt0Po++aQ=;
        b=O8U+80oLus+TdBmRjWY4AdzJdflcSE4XbY9h8/pOJveWaj+l07NP2vUrLnhpCEsIi8
         tIlAZuuKpeauOHaNHkLHHnqzLZnlBK1cxwpdjMpUwVTarctzoNL+KUzQCstkoA3fYqz8
         3yIFT70GYBlZlSB2zSuZ4ASmw1Qi348cMY8NJJtvWe1Zlsh/02xRyyQ8mF9wPA0wEU2I
         Xq5pwuN36kPWTA1vcC/oGqDOF0tv7wkzL2iCYL3YCA1q15PGKq3QxYMJWhC21k+R++sC
         tLCk2CDh30elOfdaiohtGW0ODSSS5P+OBIRLJGYchXjvu08oSqAHMnH/pHYUltmBnWDR
         FPdw==
X-Received: by 10.205.10.132 with SMTP id pa4mr33988060bkb.15.1379510792748;
        Wed, 18 Sep 2013 06:26:32 -0700 (PDT)
Received: from localhost (port-55509.pppoe.wtnet.de. [46.59.217.135])
        by mx.google.com with ESMTPSA id no2sm899090bkb.15.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 18 Sep 2013 06:26:32 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Rob Herring <rob.herring@calxeda.com>,
        Grant Likely <grant.likely@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Russell King <linux@arm.linux.org.uk>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/10] of/i2c: Resolve interrupt references at probe time
Date:   Wed, 18 Sep 2013 15:24:51 +0200
Message-Id: <1379510692-32435-10-git-send-email-treding@nvidia.com>
X-Mailer: git-send-email 1.8.4
In-Reply-To: <1379510692-32435-1-git-send-email-treding@nvidia.com>
References: <1379510692-32435-1-git-send-email-treding@nvidia.com>
Return-Path: <thierry.reding@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37863
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thierry.reding@gmail.com
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

Instead of resolving interrupt references at device creation time, delay
resolution until probe time. At device creation time, there is nothing
that can be done if an interrupt parent isn't ready yet, and the device
will end up with an invalid interrupt number (0).

If the interrupt reference is resolved at probe time, the device's probe
can be deferred, so that it's interrupt resolution can be retried after
more devices (possibly including its interrupt parent) have been probed.

However, individual drivers shouldn't be required to do that themselves,
over and over again, so this commit implements this functionality within
the I2C core.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Changes in v2:
- use __irq_of_parse_and_map() instead of of_irq_get()

 drivers/i2c/i2c-core.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 29d3f04..5b4f289 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -236,6 +236,22 @@ int i2c_recover_bus(struct i2c_adapter *adap)
 	return adap->bus_recovery_info->recover_bus(adap);
 }
 
+static int of_i2c_probe(struct i2c_client *client)
+{
+	struct device_node *np = client->dev.of_node;
+	int ret;
+
+	/* skip if the device node specifies no interrupts */
+	if (of_get_property(np, "interrupts", NULL)) {
+		ret = __irq_of_parse_and_map(client->dev.of_node, 0,
+					     &client->irq);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static int i2c_device_probe(struct device *dev)
 {
 	struct i2c_client	*client = i2c_verify_client(dev);
@@ -254,6 +270,12 @@ static int i2c_device_probe(struct device *dev)
 					client->flags & I2C_CLIENT_WAKE);
 	dev_dbg(dev, "probe\n");
 
+	if (IS_ENABLED(CONFIG_OF) && dev->of_node) {
+		status = of_i2c_probe(client);
+		if (status)
+			return status;
+	}
+
 	status = driver->probe(client, i2c_match_id(driver->id_table, client));
 	if (status) {
 		client->driver = NULL;
@@ -1002,7 +1024,6 @@ static void of_i2c_register_devices(struct i2c_adapter *adap)
 			continue;
 		}
 
-		info.irq = irq_of_parse_and_map(node, 0);
 		info.of_node = of_node_get(node);
 		info.archdata = &dev_ad;
 
@@ -1016,7 +1037,6 @@ static void of_i2c_register_devices(struct i2c_adapter *adap)
 			dev_err(&adap->dev, "of_i2c: Failure registering %s\n",
 				node->full_name);
 			of_node_put(node);
-			irq_dispose_mapping(info.irq);
 			continue;
 		}
 	}
-- 
1.8.4
