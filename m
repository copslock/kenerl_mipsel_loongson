Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Aug 2009 22:54:34 +0200 (CEST)
Received: from mail-ew0-f216.google.com ([209.85.219.216]:33516 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493246AbZHDUxC (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 4 Aug 2009 22:53:02 +0200
Received: by mail-ew0-f216.google.com with SMTP id 12so5358211ewy.0
        for <multiple recipients>; Tue, 04 Aug 2009 13:53:02 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:date:subject
         :mime-version:x-uid:x-length:to:cc:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=xZKilqz1apxCCbFsQ4q8gEZ+/abUd52aQXnmBLLTulA=;
        b=Twhs/h9d4zqgfcI7V+4Aoe42NQV0vCQ7PC5kT0iArcLrkdSwR+UUv5BMUqXndkal4v
         0wvEvQZ7tIZ1Jhun0NFbkA5UGGX1150yz9gdEMRGD6o5y1ECmQNbYBbs32WWvZRUX6Oy
         ctL/TrUeyhEUc9+odoGXC6H1tF0PMy/Q+Cfzc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:date:subject:mime-version:x-uid:x-length:to:cc
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=vmGdKj+WaYmiQSzOAaqrcqkpu+jYhucbn+E/saj4E+o0lrgfmLIbQ2xHKEZV7HJxJO
         tHp0TBhIVuGXwRNtuKOHvC6l0SoqGIhw8xarcFwRFzkRyHGgYfkz1N8vlB7J1XHaqFE8
         lwFloJRrxBaJMMiXGw78KWC5rheha439kEjmk=
Received: by 10.210.105.12 with SMTP id d12mr9179485ebc.53.1249419182020;
        Tue, 04 Aug 2009 13:53:02 -0700 (PDT)
Received: from florian (135.87.196-77.rev.gaoland.net [77.196.87.135])
        by mx.google.com with ESMTPS id 28sm3160484eye.44.2009.08.04.13.53.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 04 Aug 2009 13:53:01 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
Date:	Tue, 4 Aug 2009 22:53:00 +0200
Subject: [PATCH 5/5] cpmac: bump version to 0.5.1
MIME-Version: 1.0
X-UID:	1123
X-Length: 1299
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org, netdev@vger.kernel.org,
	David Miller <davem@davemloft.net>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200908042253.00563.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23833
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips


Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/drivers/net/cpmac.c b/drivers/net/cpmac.c
index 12a521e..0ef7467 100644
--- a/drivers/net/cpmac.c
+++ b/drivers/net/cpmac.c
@@ -54,7 +54,7 @@ module_param(dumb_switch, int, 0444);
 MODULE_PARM_DESC(debug_level, "Number of NETIF_MSG bits to enable");
 MODULE_PARM_DESC(dumb_switch, "Assume switch is not connected to MDIO bus");
 
-#define CPMAC_VERSION "0.5.0"
+#define CPMAC_VERSION "0.5.1"
 /* frame size + 802.1q tag */
 #define CPMAC_SKB_SIZE		(ETH_FRAME_LEN + 4)
 #define CPMAC_QUEUES	8
