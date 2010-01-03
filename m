Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 03 Jan 2010 21:18:46 +0100 (CET)
Received: from ey-out-1920.google.com ([74.125.78.150]:35349 "EHLO
        ey-out-1920.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492583Ab0ACURk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 3 Jan 2010 21:17:40 +0100
Received: by ey-out-1920.google.com with SMTP id 4so1898825eyg.52
        for <multiple recipients>; Sun, 03 Jan 2010 12:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:date:subject
         :mime-version:x-uid:x-length:to:cc:reply-to:content-type
         :content-transfer-encoding:message-id;
        bh=kAqGgO0N/sIG3fn1N12EgwuWj1vT6ipoSPzLEOEwTM0=;
        b=Wuu+E0N2i5rlGSmEMrD13Vm2ItH84WBgIbwDDiiX1KkYXYXtQ5/KjeD76gpc+bE8I+
         LIsCrZ5mxOrNQWbgrP3hmFY2BuTvzb38Qre5cTLyHP53R95SXIh8Cebw268X/QGeh9DT
         +Cm42Cs6l3bpyM99wg1P7pGZy/aW44WL0geT0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:date:subject:mime-version:x-uid:x-length:to:cc:reply-to
         :content-type:content-transfer-encoding:message-id;
        b=UPpPFajl/3Eqiy3MA8BIn+ohVecbuv7T1TGjezFCk65s1PD1xUZifZcxmoeCNSHphc
         G1vvFvggyXVT9ydYtvkdR4vYY26nQ9p6Oz93PwCpXdpVuh8ZjiBYJBX9cd4deTYxzp69
         OdVvbYGdp4hwq15GF15LuU6cz3HtxeyIXceBQ=
Received: by 10.213.109.75 with SMTP id i11mr3426701ebp.68.1262549859209;
        Sun, 03 Jan 2010 12:17:39 -0800 (PST)
Received: from lenovo.localnet (92.59.76-86.rev.gaoland.net [86.76.59.92])
        by mx.google.com with ESMTPS id 28sm35691658eyg.12.2010.01.03.12.17.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 03 Jan 2010 12:17:38 -0800 (PST)
From:   Florian Fainelli <florian@openwrt.org>
Date:   Sun, 3 Jan 2010 21:17:37 +0100
Subject: [PATCH 4/4] MTD: include ar7part in the list of partitions parsers
MIME-Version: 1.0
X-Length: 1572
To:     linux-mips@linux-mips.org, linux-mtd@lists.infradead.org,
        David Woodhouse <dwmw2@infradead.org>
Cc:     ralf@linux-mips.org
Reply-To: Florian Fainelli <florian@openwrt.org>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201001032117.37459.florian@openwrt.org>
X-archive-position: 25489
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 1994

This patch modifies the physmap-flash driver to include
the ar7part partition parser in the list of parsers to
use when a physmap-flash driver is registered. This is
required for AR7 to create partitions correctly.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/drivers/mtd/maps/physmap.c b/drivers/mtd/maps/physmap.c
index d9603f7..0e65ee7 100644
--- a/drivers/mtd/maps/physmap.c
+++ b/drivers/mtd/maps/physmap.c
@@ -79,7 +79,7 @@ static const char *rom_probe_types[] = {
 					"map_rom",
 					NULL };
 #ifdef CONFIG_MTD_PARTITIONS
-static const char *part_probe_types[] = { "cmdlinepart", "RedBoot", NULL };
+static const char *part_probe_types[] = { "cmdlinepart", "RedBoot", "ar7part", NULL };
 #endif
 
 static int physmap_flash_probe(struct platform_device *dev)
