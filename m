Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Dec 2013 16:05:06 +0100 (CET)
Received: from mail-ee0-f46.google.com ([74.125.83.46]:56762 "EHLO
        mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6867271Ab3LSPEmuf185 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 19 Dec 2013 16:04:42 +0100
Received: by mail-ee0-f46.google.com with SMTP id d49so533479eek.33
        for <multiple recipients>; Thu, 19 Dec 2013 07:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=inB09bzHnUxDaCAx6tG9cj7K65BporWNxhJZ0mM2UtQ=;
        b=Kw6LrtnQgpRh3ei+R7OHXCkuia2HppiT3BPRZZzPX2RaZTHlDKfdjWCY18RVwwbqgK
         PG5qfDtOdRp8Jqwrxa7DWz0/IZxPlY9xoaj3bH+N/cqbrZqHbSMjDytrNO9QmbDgDckF
         /QtxGru/Cv8CXW6J+bDP0Mt/NWsf89jS+PzOrJN+8d59cCXMg2XliL2of8u3Y48jFVPG
         3DGNOnskuSZRZBZRQ5PRNfQlZ19B98B1vEzmqTrWnLSLvvn510OV7bw9ZfQDLOe9mLWJ
         QlXEJVa+04oJnQArXGAbCchcvZWFgR/167WDlzeza4/RiU0RAkag2dS0UM0KrsDqGD+u
         ONZw==
X-Received: by 10.15.61.134 with SMTP id i6mr214289eex.48.1387465477582;
        Thu, 19 Dec 2013 07:04:37 -0800 (PST)
Received: from localhost.tiszanet.hu (mail.mediaweb.hu. [62.201.96.214])
        by mx.google.com with ESMTPSA id h48sm10102799eev.3.2013.12.19.07.04.36
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Dec 2013 07:04:36 -0800 (PST)
From:   Levente Kurusa <levex@linux.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Levente Kurusa <levex@linux.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH 15/38] mips: txx9: 7segled: add missing put_device call
Date:   Thu, 19 Dec 2013 16:03:26 +0100
Message-Id: <1387465429-3568-16-git-send-email-levex@linux.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1387465429-3568-2-git-send-email-levex@linux.com>
References: <1387465429-3568-2-git-send-email-levex@linux.com>
Return-Path: <ilevex.linux@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38759
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: levex@linux.com
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

This is required so that we give up the last reference to the device.

Also, add a new tx_7segled_release function which will be called after the
put_device to ensure that device is kfree'd.

Signed-off-by: Levente Kurusa <levex@linux.com>
---
 arch/mips/txx9/generic/7segled.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/mips/txx9/generic/7segled.c b/arch/mips/txx9/generic/7segled.c
index 4642f56..3caa548 100644
--- a/arch/mips/txx9/generic/7segled.c
+++ b/arch/mips/txx9/generic/7segled.c
@@ -83,6 +83,10 @@ static struct bus_type tx_7segled_subsys = {
 	.dev_name	= "7segled",
 };
 
+void tx_7segled_release(struct device *dev) {
+	kfree(dev);
+}
+
 static int __init tx_7segled_init_sysfs(void)
 {
 	int error, i;
@@ -103,11 +107,14 @@ static int __init tx_7segled_init_sysfs(void)
 		}
 		dev->id = i;
 		dev->bus = &tx_7segled_subsys;
+		dev->release = &tx_7segled_release;
 		error = device_register(dev);
-		if (!error) {
-			device_create_file(dev, &dev_attr_ascii);
-			device_create_file(dev, &dev_attr_raw);
+		if (error) {
+			put_device(dev);
+			return error;
 		}
+		device_create_file(dev, &dev_attr_ascii);
+		device_create_file(dev, &dev_attr_raw);	
 	}
 	return error;
 }
-- 
1.8.3.1
