Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Mar 2010 23:36:46 +0100 (CET)
Received: from mail-bw0-f226.google.com ([209.85.218.226]:38502 "EHLO
        mail-bw0-f226.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492355Ab0CAWgW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 1 Mar 2010 23:36:22 +0100
Received: by bwz26 with SMTP id 26so2428504bwz.27
        for <multiple recipients>; Mon, 01 Mar 2010 14:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:date:subject
         :mime-version:x-uid:x-length:to:reply-to:content-type
         :content-transfer-encoding:message-id;
        bh=v4kNBoTbH27PTU++wnf23JL9aSfxk6nOL/kyLTA7R1c=;
        b=uM2E/PDpB79d66jI76s7BuE82T8gn1/L+7BVT2K4Oty30XVgF39AuNStRM2ZqSeyuL
         hjVwaxzgjxIV6hSr+atarumSDgQsVDetsryM/ChxStfazPu5GSoO1K4IkqH1ZanQwjb4
         EYhJ3WwtZeIH9GCRvsD4pD6CwYQIamIKEN0QI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:date:subject:mime-version:x-uid:x-length:to:reply-to
         :content-type:content-transfer-encoding:message-id;
        b=edbcEtddfOAg5OUfB0nKWFvP/fXm19Do+9kSi5dHLKncKX6in95Abkt5K8A4rpLUd2
         uk7HcJjfldtnSRXmv4caI4dkXfm+ISozpPXMz2tyrTwMltCoTFA4hGREga7FOOPLo5WA
         SyGGoZbhr9V0TXB7oVq7uK4uV5//DlL11hay8=
Received: by 10.204.5.216 with SMTP id 24mr3550155bkw.141.1267482977126;
        Mon, 01 Mar 2010 14:36:17 -0800 (PST)
Received: from lenovo.localnet (153.44.69-86.rev.gaoland.net [86.69.44.153])
        by mx.google.com with ESMTPS id s17sm1094478bkd.6.2010.03.01.14.36.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 01 Mar 2010 14:36:16 -0800 (PST)
From:   Florian Fainelli <florian@openwrt.org>
Date:   Mon, 1 Mar 2010 23:36:15 +0100
Subject: [PATCH 1/4] bcm63xx: fix tabs vs spaces in board_bcm963xx.c
MIME-Version: 1.0
X-UID:  177
X-Length: 1342
To:     ralf@linux-mips.org, linux-mips@linux-mips.org
Reply-To: Florian Fainelli <florian@openwrt.org>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201003012336.15400.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26080
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips


Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/arch/mips/bcm63xx/boards/board_bcm963xx.c b/arch/mips/bcm63xx/boards/board_bcm963xx.c
index 90faa37..00fa96b 100644
--- a/arch/mips/bcm63xx/boards/board_bcm963xx.c
+++ b/arch/mips/bcm63xx/boards/board_bcm963xx.c
@@ -361,9 +361,9 @@ static struct board_info __initdata board_FAST2404 = {
 	.expected_cpu_id		= 0x6348,
 
 	.has_uart0			= 1,
-        .has_enet0			= 1,
-        .has_enet1			= 1,
-        .has_pci			= 1,
+	.has_enet0			= 1,
+	.has_enet1			= 1,
+	.has_pci			= 1,
 
 	.enet0 = {
 		.has_phy		= 1,
