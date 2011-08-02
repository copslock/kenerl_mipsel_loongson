Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Aug 2011 19:51:53 +0200 (CEST)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:33355 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491202Ab1HBRvW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Aug 2011 19:51:22 +0200
Received: by fxd20 with SMTP id 20so73189fxd.36
        for <multiple recipients>; Tue, 02 Aug 2011 10:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=E5TMJ74bk9AKptiOrFpoqm36gTnDcR1m3PV44DG4kdw=;
        b=SukXTT0JXE4yFa4qOyRMS9MPd61aGXrQaXxvI2xGpXt3qMMNTkY9q8DLVyheVosKF+
         ShUfImexHs/jRS9aacc4UFVYvFv/0J0cd7aklEnKhWbSfwfvW+fP8ELqVBhUu+igQKrZ
         6KtphkzBTOy1gDNA/wcZ/ROfKdChoNWLDREl0=
Received: by 10.223.18.25 with SMTP id u25mr8394492faa.69.1312307476915;
        Tue, 02 Aug 2011 10:51:16 -0700 (PDT)
Received: from localhost.localdomain (188-22-5-211.adsl.highway.telekom.at [188.22.5.211])
        by mx.google.com with ESMTPS id r12sm3608450fam.24.2011.08.02.10.51.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 02 Aug 2011 10:51:16 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH 01/15] MIPS: Alchemy: fix typo in MAC0 registration
Date:   Tue,  2 Aug 2011 19:50:56 +0200
Message-Id: <1312307470-6841-2-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <1312307470-6841-1-git-send-email-manuel.lauss@googlemail.com>
References: <1312307470-6841-1-git-send-email-manuel.lauss@googlemail.com>
X-archive-position: 30797
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 1612

Harmless typo which prints an error message although MAC0 was
registered successfully.

Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---
 arch/mips/alchemy/common/platform.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/alchemy/common/platform.c b/arch/mips/alchemy/common/platform.c
index 3b2c18b..f72c48d 100644
--- a/arch/mips/alchemy/common/platform.c
+++ b/arch/mips/alchemy/common/platform.c
@@ -492,7 +492,7 @@ static void __init alchemy_setup_macs(int ctype)
 		memcpy(au1xxx_eth0_platform_data.mac, ethaddr, 6);
 
 	ret = platform_device_register(&au1xxx_eth0_device);
-	if (!ret)
+	if (ret)
 		printk(KERN_INFO "Alchemy: failed to register MAC0\n");
 
 
-- 
1.7.6
