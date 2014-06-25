Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Jun 2014 01:41:41 +0200 (CEST)
Received: from mail-qg0-f41.google.com ([209.85.192.41]:34672 "EHLO
        mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6859925AbaFYXliwDnT8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 26 Jun 2014 01:41:38 +0200
Received: by mail-qg0-f41.google.com with SMTP id i50so2378718qgf.28
        for <multiple recipients>; Wed, 25 Jun 2014 16:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=6TRA+CFn6f3adU+KjgrHb8PG8y3Q1FyQNWs3Uc/mJcQ=;
        b=lCZO0JzDr7uKiYoqaA+aLTEvRSWNhZzrftrZmANNqLauMy4aR8CgCDMqegvC2u1nh9
         nERUIHA/wSZwB/CqnGi/MOCRdAMyRj2yDux0uIFzqsMlaFOuUxVsf6NFqfo+lTSXhJ4F
         Q0U4qN1PqGoBdbAF+eQBVh16seyq5kgq0b7n15h0UxLVkds6eo0mGz4k4MQ4VQxdODc8
         sm236vBlZx2thgLX2EBaF3zC9B5VcBrdWJddWEdA38/14Gc7skk9gGKYulZML7/i1Jwg
         g/LwLQsw9ayRV/1jegkzGnDDw6kQrhAwMmURXb73FU42o7HGRgKubY9iiTmlKY/01svi
         9qFw==
X-Received: by 10.224.131.74 with SMTP id w10mr17064548qas.100.1403739692661;
        Wed, 25 Jun 2014 16:41:32 -0700 (PDT)
Received: from fainelli-desktop.broadcom.com (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by mx.google.com with ESMTPSA id m1sm8304879qaz.27.2014.06.25.16.41.31
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 25 Jun 2014 16:41:32 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, blogic@openwrt.org, anemo@mba.ocn.ne.jp,
        chris@mips.com, Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH] MIPS: document the cca= command-line parameter
Date:   Wed, 25 Jun 2014 16:41:13 -0700
Message-Id: <1403739673-7422-1-git-send-email-f.fainelli@gmail.com>
X-Mailer: git-send-email 1.9.1
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40837
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Commit 351336929ccf222ae38ff0cb7a8dd5fd5c6236a0 ("[MIPS] Allow setting
of the cache attribute at run time") introduced the 'cca=' kernel
command-line parameter which allows overriding the kernel pages
cacheable attributes, document that parameter.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 Documentation/kernel-parameters.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 6eaa9cdb7094..d6f26d017dc0 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -566,6 +566,11 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 			possible to determine what the correct size should be.
 			This option provides an override for these situations.
 
+	cca=		[MIPS] Override the kernel pages cacheable attribute.
+			Accepted values range from 0 to 7 inclusive. See
+			arch/mips/include/asm/pgtable-bits.h for platform
+			specific values (SB1, Loongson3 and others).
+
 	ccw_timeout_log [S390]
 			See Documentation/s390/CommonIO for details.
 
-- 
1.9.1
