Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Jun 2009 19:25:32 +0100 (WEST)
Received: from mail-ew0-f219.google.com ([209.85.219.219]:59021 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20024088AbZFASZZ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 1 Jun 2009 19:25:25 +0100
Received: by ewy19 with SMTP id 19so8334607ewy.0
        for <multiple recipients>; Mon, 01 Jun 2009 11:25:19 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:date:subject
         :mime-version:x-uid:x-length:to:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=G3jVgWeU9aOqkZ3pEG3Agj8r/eY3DEq7UHa5ahaACLM=;
        b=P7AgCDyupid6il6K8h70VIFpfJj/xMX+dpm/5q/FZzKoQdPB46Xjw7v2IzyN/fBmGi
         BKzjq9zlKQxPNsMc21dn5+tAesI9N7keo867Er4dIzN5BLl5ut0SG1xQo+aHMu3WHyJS
         rpRhp/z9TrI2n568dsj3X56yWZJ/i+sDEjIdE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:date:subject:mime-version:x-uid:x-length:to
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=UcuRrLxWyCDfVKk3giCaP6zSmdFmHuLD0mWQyCh9Nxz7votq69+04GcBaO+0QB+pNQ
         vo8K9YAthtCv3SDGwQ6mphx3mlHNQ+SfVmxHDNq090SRNT7XnwSaHfjGYraglEfl/cym
         61+IPD7DpqPpPEAkdKQyDEJeKGZUZMRPRZHFo=
Received: by 10.210.19.7 with SMTP id 7mr2228805ebs.57.1243880270839;
        Mon, 01 Jun 2009 11:17:50 -0700 (PDT)
Received: from florian (207.130.195-77.rev.gaoland.net [77.195.130.207])
        by mx.google.com with ESMTPS id 10sm235818eyz.21.2009.06.01.11.17.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 01 Jun 2009 11:17:50 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
Date:	Mon, 1 Jun 2009 20:17:48 +0200
Subject: [PATCH 2/3] bcm63xx: select SSB since we are using ssb_arch_set_fallback_sprom
MIME-Version: 1.0
X-UID:	194
X-Length: 1343
To:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	Maxime Bizon <mbizon@freebox.fr>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200906012017.48965.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23157
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

This patch makes BCM63XX select SSB since we unconditionnaly
use ssb_arch_set_fallback_sprom. Without this linking would
fail with an undefined reference.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 05ee268..e1f0917 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -72,6 +72,7 @@ config BCM63XX
 	select SYS_HAS_EARLY_PRINTK
 	select SWAP_IO_SPACE
 	select ARCH_REQUIRE_GPIOLIB
+	select SSB
 	help
 	 Support for BCM63XX based boards
 
