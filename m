Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Oct 2009 18:03:59 +0100 (CET)
Received: from mail-ew0-f216.google.com ([209.85.219.216]:43433 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492788AbZJ1RDx (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 28 Oct 2009 18:03:53 +0100
Received: by ewy12 with SMTP id 12so998504ewy.0
        for <linux-mips@linux-mips.org>; Wed, 28 Oct 2009 10:03:47 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=1Tfs+DnxZB34UXHyOMINSsQcIpHRO/eaCd1VaSs6Ijc=;
        b=PQU9Fsd1Y/JvN6zwf5BchmIgEi/zpQ5C2syEM+QCa0i8Rmwy3gMHmj+JKq40AFcHCf
         bFedzr7fthcrLHub/1JWW04Kq/vl8ik47Ny5rC/bbL/nmheyE4B59IhIWToYofu81jrF
         S8htztA9XJdD2drZoIFUNYpXijdceVPLCfq/o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=bgmb5HFJ/BAtBv5NyLvPTOwrzHvpn05V9n52BSRJuMwyt3c2bPvFKF73sGTM23wHkO
         lyGwYmVWJliWCRqoW4oM987mfxVx7kdAvzW7VkWzCty7BA0MRFGQtmPh5yMyjTBwYB3v
         Z6+7tsdzAZzV653E99IVq21zaucezvRnrTHlU=
Received: by 10.216.87.203 with SMTP id y53mr2337972wee.177.1256749426657;
        Wed, 28 Oct 2009 10:03:46 -0700 (PDT)
Received: from localhost.localdomain (p5496FE70.dip.t-dialin.net [84.150.254.112])
        by mx.google.com with ESMTPS id g9sm4054590gvc.10.2009.10.28.10.03.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 28 Oct 2009 10:03:46 -0700 (PDT)
From:	Manuel Lauss <manuel.lauss@googlemail.com>
To:	linux-netdev@vger.kernel.org
Cc:	linux-mips@linux-mips.org, Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH RESEND] net: au1000_eth: buildfix: add missing capability.h
Date:	Wed, 28 Oct 2009 18:03:50 +0100
Message-Id: <1256749430-15291-1-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.6.5
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24554
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

fixes the following build failure:
  CC      drivers/net/au1000_eth.o
/drivers/net/au1000_eth.c: In function 'au1000_set_settings':
/drivers/net/au1000_eth.c:623: error: implicit declaration of function 'capable'
/drivers/net/au1000_eth.c:623: error: 'CAP_NET_ADMIN' undeclared (first use in this function)
/drivers/net/au1000_eth.c:623: error: (Each undeclared identifier is reported only once
/drivers/net/au1000_eth.c:623: error: for each function it appears in.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
 drivers/net/au1000_eth.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/net/au1000_eth.c b/drivers/net/au1000_eth.c
index 04f63c7..ce6f1ac 100644
--- a/drivers/net/au1000_eth.c
+++ b/drivers/net/au1000_eth.c
@@ -34,6 +34,7 @@
  *
  *
  */
+#include <linux/capability.h>
 #include <linux/dma-mapping.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
-- 
1.6.5
