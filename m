Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Aug 2009 22:54:09 +0200 (CEST)
Received: from mail-ew0-f216.google.com ([209.85.219.216]:33516 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493245AbZHDUxB (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 4 Aug 2009 22:53:01 +0200
Received: by mail-ew0-f216.google.com with SMTP id 12so5358211ewy.0
        for <multiple recipients>; Tue, 04 Aug 2009 13:53:01 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:date:subject
         :mime-version:x-uid:x-length:to:cc:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=Pus7d8m17fZ7RFdD29x1dlmrpZPtsZ2QMPFIimTDFb0=;
        b=VQkfXmMI/o7e3N55kARorppyS1XxWdKzSZvMY1Km0kwVRp7lNAtmJBYmHmfgBIjqwV
         4BMiP1kOlEsymbt7wxlU7bPssipfzCetOid99GcmTpWb82OcBd7uAy635YIQ7LyLoifl
         fNDn1A0DHy5ae+faX17EhFmmNibGZxgzmrOTU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:date:subject:mime-version:x-uid:x-length:to:cc
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=YLu+ZM7wQ8/SFh8dhXkOk8zKxqz45RBODCtT5mvQomGMipooSHg1BIWy+N2nM4V1Pl
         aqeGLoFheHUEqS1TSCqBh8WWTY15wS6taxhMykXDrYZO+rivZzrlEgrpoNB1ZsSmTGry
         pCRjLTr3mQ/Zot24HOdMbj3nvLZkSMJ4GKIQ0=
Received: by 10.210.87.14 with SMTP id k14mr9439942ebb.90.1249419181428;
        Tue, 04 Aug 2009 13:53:01 -0700 (PDT)
Received: from florian (135.87.196-77.rev.gaoland.net [77.196.87.135])
        by mx.google.com with ESMTPS id 28sm3160484eye.44.2009.08.04.13.53.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 04 Aug 2009 13:53:01 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
Date:	Tue, 4 Aug 2009 22:52:57 +0200
Subject: [PATCH 4/5] cpmac: wait longer after MDIO reset
MIME-Version: 1.0
X-UID:	1122
X-Length: 1452
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org, netdev@vger.kernel.org,
	David Miller <davem@davemloft.net>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200908042252.57848.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23832
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

This patch slows down the MDIO_ALIVE busy waiting to let
switches and PHY come up after reset. Previous loop was
too quick for IC+175C and ADM6996C/L switches to come up.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/drivers/net/cpmac.c b/drivers/net/cpmac.c
index f2fc722..12a521e 100644
--- a/drivers/net/cpmac.c
+++ b/drivers/net/cpmac.c
@@ -1245,11 +1245,11 @@ int __devinit cpmac_init(void)
 
 	cpmac_mii->reset(cpmac_mii);
 
-	for (i = 0; i < 300000; i++)
+	for (i = 0; i < 300; i++)
 		if ((mask = cpmac_read(cpmac_mii->priv, CPMAC_MDIO_ALIVE)))
 			break;
 		else
-			cpu_relax();
+			msleep(10);
 
 	mask &= 0x7fffffff;
 	if (mask & (mask - 1)) {
