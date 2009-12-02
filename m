Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Dec 2009 13:07:31 +0100 (CET)
Received: from ey-out-1920.google.com ([74.125.78.149]:42939 "EHLO
        ey-out-1920.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492553AbZLBMH2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 Dec 2009 13:07:28 +0100
Received: by ey-out-1920.google.com with SMTP id 5so33480eyb.52
        for <multiple recipients>; Wed, 02 Dec 2009 04:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:date:subject
         :mime-version:x-uid:x-length:organization:to:cc:content-type
         :content-transfer-encoding:message-id;
        bh=anD/4BEIJvCegGY/KvZ9kxxPT7V+iTVEO5UShj60ILM=;
        b=nfiaA19kbpmwfdUs5ItmDERRZXjKKeU+q8KU8gPy4ju3GKHUEdJ12gvPjN4cHQJvtf
         QpK+4fsk64e2neua2hVOiqe2Ohg3XjTOh84rZxROP2a7g2gSsbmNCpd/N7QEecK8MiVu
         89ntscLqB0Q+zTJQhTAM7C2JSgCLgJqV06X8w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:date:subject:mime-version:x-uid:x-length:organization
         :to:cc:content-type:content-transfer-encoding:message-id;
        b=RG5icN8ESZoqV2GayemgPlNtYhnG7nXREcEaulYSeYduKHrW3vtcmwxQQkNTTRo3I+
         kbWDM84LIQnkDzrt6V87VmQfbI03d6mY6WmuNmbb1TGfDmxFtEoPmldvMhVtvcFfSztZ
         w8+4/DYdfjVNsbjUdIuf6OsZQEfZ2eF6yg7o4=
Received: by 10.213.79.84 with SMTP id o20mr6920596ebk.62.1259755646074;
        Wed, 02 Dec 2009 04:07:26 -0800 (PST)
Received: from flexo.localnet (bobafett.staff.proxad.net [213.228.1.121])
        by mx.google.com with ESMTPS id 13sm692902ewy.1.2009.12.02.04.07.25
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 02 Dec 2009 04:07:25 -0800 (PST)
From:   Florian Fainelli <florian@openwrt.org>
Date:   Wed, 2 Dec 2009 13:07:01 +0100
Subject: [PATCH] rb532: fix devices.c compilation
MIME-Version: 1.0
X-UID:  150
X-Length: 1609
Organization: OpenWrt
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200912021307.02014.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25269
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

We should now use dev_set_drvdata to set the driver
driver_data field.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/arch/mips/rb532/devices.c b/arch/mips/rb532/devices.c
index 9f40e1f..041fc1a 100644
--- a/arch/mips/rb532/devices.c
+++ b/arch/mips/rb532/devices.c
@@ -110,7 +110,6 @@ static struct korina_device korina_dev0_data = {
 static struct platform_device korina_dev0 = {
 	.id = -1,
 	.name = "korina",
-	.dev.driver_data = &korina_dev0_data,
 	.resource = korina_dev0_res,
 	.num_resources = ARRAY_SIZE(korina_dev0_res),
 };
@@ -332,6 +331,8 @@ static int __init plat_setup_devices(void)
 	/* set the uart clock to the current cpu frequency */
 	rb532_uart_res[0].uartclk = idt_cpu_freq;
 
+	dev_set_drvdata(&korina_dev0.dev, &korina_dev0_data);
+
 	return platform_add_devices(rb532_devs, ARRAY_SIZE(rb532_devs));
 }
 
