Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Apr 2011 14:32:44 +0200 (CEST)
Received: from mail-bw0-f49.google.com ([209.85.214.49]:47661 "EHLO
        mail-bw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491071Ab1DHMcl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 Apr 2011 14:32:41 +0200
Received: by bwz1 with SMTP id 1so3360758bwz.36
        for <multiple recipients>; Fri, 08 Apr 2011 05:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=npGl7l+TV6P9af+LHyosMQNUYegC2YQbCOB7SQRgMqQ=;
        b=Eo2+QKn7+5uq8vgTF6Fp3BYpfFmEou9BIUBJuW0nJK7MPLd5p6xXl3Gm636rHBsJzN
         REMwhrgUjQcCLNJtIQiYfcy3KizI6ftq/+pfrCE2mKfn3ZWxOupw1l5SzcnhbTwn1vKd
         3hmuXVWgBI/H9wiSta4R5hGARiDv59M9pLvhg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=JtDA+CYWZxUQ6V1ckqEucB0USWfX92wXayAkI7Vaxn1gQlwMUDCS8aHXWLglKZx+7O
         tqq01CmoOVU0DCD2lrwB7M0vZtJgObKtRyA0uTnv2X7ynISeLGEV5z/I0cULNa2qiKiZ
         YolEEGc6wPbAN+hyVTVVYjtTtaCvTyX53/nXc=
Received: by 10.204.80.29 with SMTP id r29mr1879452bkk.195.1302265952030;
        Fri, 08 Apr 2011 05:32:32 -0700 (PDT)
Received: from localhost.localdomain (dslb-088-073-061-184.pools.arcor-ip.net [88.73.61.184])
        by mx.google.com with ESMTPS id c11sm1625572bkc.2.2011.04.08.05.32.29
        (version=SSLv3 cipher=OTHER);
        Fri, 08 Apr 2011 05:32:30 -0700 (PDT)
From:   Jonas Gorski <jonas.gorski@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Florian Fainelli <florian@openwrt.org>
Subject: [PATCH] MIPS: bcm63xx: Fix header_crc comment in bcm963xx_tag.h
Date:   Fri,  8 Apr 2011 14:32:15 +0200
Message-Id: <1302265935-23802-1-git-send-email-jonas.gorski@gmail.com>
X-Mailer: git-send-email 1.5.6.5
Return-Path: <jonas.gorski@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29713
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
Precedence: bulk
X-list: linux-mips

The CRC32 actually includes the tag_version.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---

This was already wrong in the original Broadcom sources (and it still 
seems to be).

 arch/mips/include/asm/mach-bcm63xx/bcm963xx_tag.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm963xx_tag.h b/arch/mips/include/asm/mach-bcm63xx/bcm963xx_tag.h
index 5325084..73c499f 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm963xx_tag.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm963xx_tag.h
@@ -88,7 +88,7 @@ struct bcm_tag {
 	char kernel_crc[CRC_LEN];
 	/* 228-235: Unused at present */
 	char reserved1[8];
-	/* 236-239: CRC32 of header excluding tagVersion */
+	/* 236-239: CRC32 of header excluding last 20 bytes */
 	char header_crc[CRC_LEN];
 	/* 240-255: Unused at present */
 	char reserved2[16];
-- 
1.5.6.5
