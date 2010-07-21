Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Jul 2010 22:59:31 +0200 (CEST)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:57499 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492393Ab0GUU70 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Jul 2010 22:59:26 +0200
Received: by wyb35 with SMTP id 35so35387wyb.36
        for <multiple recipients>; Wed, 21 Jul 2010 13:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:date:subject
         :mime-version:x-uid:x-length:to:reply-to:content-type
         :content-transfer-encoding:message-id;
        bh=qJw9UtZ8CAin8tgs/82Ntm5gRcNT2BitevDkhOVe6sI=;
        b=HrfGtNUgULVfHj0MWpN3BNOi7tSUvtzb+FlqyN1nYnKo75JmhF8NKEVMBge0hi4Jdl
         f/b+NabCyf78qAGr/tzMVt40kA033ItgEiUgTAYzm7rPNuHUWpRMW+DKc+MWwYG1wrqE
         rozMUdAtmu2sd13K8pmDRpDM/JYW7sSEDOecg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:date:subject:mime-version:x-uid:x-length:to:reply-to
         :content-type:content-transfer-encoding:message-id;
        b=Lw3nSDBeEnnMvStDf5na/xWCBoLadJJdJdpvb2D/yvTF1nuemPNQBF6CyTGrAx/BCb
         WrR3OvabfhAutGR7D/5CRV8DqDk57bRyzXinNLOt9auG+UzHLSm8VYnqZilQgQthrKxR
         sjpNvqVKUTPIBixIYflHJZxnANv9gXOhkhwZc=
Received: by 10.227.157.135 with SMTP id b7mr731708wbx.111.1279745958926;
        Wed, 21 Jul 2010 13:59:18 -0700 (PDT)
Received: from lenovo.localnet (florian.mimichou.net [88.178.11.95])
        by mx.google.com with ESMTPS id p52sm3626884weq.20.2010.07.21.13.59.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 21 Jul 2010 13:59:14 -0700 (PDT)
From:   Florian Fainelli <florian@openwrt.org>
Date:   Wed, 21 Jul 2010 22:59:26 +0200
Subject: [PATCH] BCM63XX: prevent second enet registration on BCM6338
MIME-Version: 1.0
X-UID:  138
X-Length: 1413
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Reply-To: Florian Fainelli <florian@openwrt.org>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201007212259.28442.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27430
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

This SoC has only one Ethernet MAC, so prevent registration of a second one.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/arch/mips/bcm63xx/dev-enet.c b/arch/mips/bcm63xx/dev-enet.c
index 9f544ba..39c2336 100644
--- a/arch/mips/bcm63xx/dev-enet.c
+++ b/arch/mips/bcm63xx/dev-enet.c
@@ -104,6 +104,9 @@ int __init bcm63xx_enet_register(int unit,
 	if (unit > 1)
 		return -ENODEV;
 
+	if (unit == 1 && BCMCPU_IS_6338())
+		return -ENODEV;
+
 	if (!shared_device_registered) {
 		shared_res[0].start = bcm63xx_regset_address(RSET_ENETDMA);
 		shared_res[0].end = shared_res[0].start;
