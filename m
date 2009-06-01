Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Jun 2009 19:22:36 +0100 (WEST)
Received: from mail-ew0-f219.google.com ([209.85.219.219]:49475 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20023557AbZFASW3 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 1 Jun 2009 19:22:29 +0100
Received: by ewy19 with SMTP id 19so8332065ewy.0
        for <multiple recipients>; Mon, 01 Jun 2009 11:22:23 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:date:subject
         :mime-version:x-uid:x-length:to:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=ygdtgisMu2Uhymmguzq4woplwKIJcrdb3dOJHTkJ/uc=;
        b=m0kFGW1ffAwxGzjIv80z8g5MjVnfC9k6ud8fc5NFcDlyACuqe6Ri2HcBx9vuLnmAaP
         x3i69TtiwNvrxOuBe81iBDp1gzYtPzmsRhPShgCAI8n1sH7MV4D71j3jIj2zhQkvtGQe
         UA57SlxJ8UEpAmBYFPA7qNwTCd4JBbR3B9j9k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:date:subject:mime-version:x-uid:x-length:to
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=Xx6s4su/8QXoWM696npMxQI/LnSQpPUtVXSl/uDru5ZO9lrGwMaYXZaxKS1Ekyrc7m
         XnsOYHn5BYaOgimp8I+Tu8sFG3+1oNzohbKd33bWqf0COv6F0i8B3MoUBB3UohI2iH0I
         n2UwIzihM5zQTkaD1qOiF9hbUeazLEeaI3S2o=
Received: by 10.210.29.9 with SMTP id c9mr4372192ebc.48.1243880543484;
        Mon, 01 Jun 2009 11:22:23 -0700 (PDT)
Received: from florian (207.130.195-77.rev.gaoland.net [77.195.130.207])
        by mx.google.com with ESMTPS id 7sm36386eyg.47.2009.06.01.11.22.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 01 Jun 2009 11:22:22 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
Date:	Mon, 1 Jun 2009 20:22:20 +0200
Subject: [PATCH 2/3 v2] bcm63xx: select SSB since we are using ssb_arch_set_fallback_sprom
MIME-Version: 1.0
X-UID:	211
X-Length: 1386
To:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	Maxime Bizon <mbizon@freebox.fr>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200906012022.20804.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23155
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

This patch makes the BCM963xx boards select SSB since we
unconditionnaly use ssb_arch_set_fallback_sprom. Without
this linking would fail with an undefined reference.

Changes from v1:
- this only applies to BCM963xx boards and not 63xx as a whole

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/arch/mips/bcm63xx/boards/Kconfig b/arch/mips/bcm63xx/boards/Kconfig
index da5eeaa..c6aed33 100644
--- a/arch/mips/bcm63xx/boards/Kconfig
+++ b/arch/mips/bcm63xx/boards/Kconfig
@@ -5,6 +5,7 @@ choice
 
 config BOARD_BCM963XX
        bool "Generic Broadcom 963xx boards"
+	select SSB
        help
 
 endchoice
