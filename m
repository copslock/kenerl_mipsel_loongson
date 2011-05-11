Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 May 2011 22:23:14 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:17651 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491148Ab1EKUWn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 11 May 2011 22:22:43 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4dcaf04f0002>; Wed, 11 May 2011 13:23:43 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Wed, 11 May 2011 13:22:41 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Wed, 11 May 2011 13:22:41 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id p4BKMbmx032650;
        Wed, 11 May 2011 13:22:37 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id p4BKMbAD032649;
        Wed, 11 May 2011 13:22:37 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>,
        John Crispin <blogic@openwrt.org>
Subject: [PATCH 2/3] MIPS: lantiq: Fix section mismatch in gpio_stp.c
Date:   Wed, 11 May 2011 13:22:26 -0700
Message-Id: <1305145347-32605-3-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1305145347-32605-1-git-send-email-ddaney@caviumnetworks.com>
References: <1305145347-32605-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 11 May 2011 20:22:41.0152 (UTC) FILETIME=[2D8FB000:01CC1019]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29942
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

ltq_stp_probe() cannot be __init if ltq_stp_driver isn't also.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
Cc: John Crispin <blogic@openwrt.org>
---
 arch/mips/lantiq/xway/gpio_stp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/lantiq/xway/gpio_stp.c b/arch/mips/lantiq/xway/gpio_stp.c
index efa3782..eed5a45 100644
--- a/arch/mips/lantiq/xway/gpio_stp.c
+++ b/arch/mips/lantiq/xway/gpio_stp.c
@@ -111,7 +111,7 @@ static int ltq_stp_hw_init(void)
 	return 0;
 }
 
-static int __init ltq_stp_probe(struct platform_device *pdev)
+static int ltq_stp_probe(struct platform_device *pdev)
 {
 	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	int ret = 0;
-- 
1.7.2.3
