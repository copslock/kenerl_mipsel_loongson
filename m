Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jun 2014 17:31:55 +0200 (CEST)
Received: from mail-we0-f172.google.com ([74.125.82.172]:52588 "EHLO
        mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6861642AbaFQOhhRNa7u (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 Jun 2014 16:37:37 +0200
Received: by mail-we0-f172.google.com with SMTP id u57so7443131wes.31
        for <multiple recipients>; Tue, 17 Jun 2014 07:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=7tWBx8LJtZbEpAUVfoPfI91/v9mJnuqHqeFSJ/vWuTc=;
        b=pmXvrIrHfVShR2YHNZzQplFGuamme5Q6of9q0NultQdQ2TqSHc+WRO9Cpdmdizoh8j
         bIj2fgi0pZmyJxqD4flMrfdUstrU+9ll0tY8BLVsX9ipE93/zbEb2qTvOOZPx0RrFz9c
         e9zbSd1NIOyBDpi2hXFEG+NLU6D8jG2C5XuL0ojgJ0FuJ+cLQ75QOphKLgAzsZqurLT0
         kdeWFP0IlHPhamn7BaxqqwIknxKHSHQ5Ers1YYNJAmyQIxI5VAkDCnrC2TkFpCDks9Uk
         Z6rCSKahuBQIEipaY9mun6I/xikQS6F7kW/Xs2t/yr2UA4uyyKOkFB7muISkP7O3WCkf
         /3Cw==
X-Received: by 10.180.99.166 with SMTP id er6mr37326257wib.48.1403015845412;
        Tue, 17 Jun 2014 07:37:25 -0700 (PDT)
Received: from linux-tdhb.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by mx.google.com with ESMTPSA id v8sm41510956eep.13.2014.06.17.07.37.23
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jun 2014 07:37:24 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Subject: [PATCH 2/2] MIPS: BCM47XX: Select SYS_SUPPORTS_HIGHMEM for BCM47XX_BCMA
Date:   Tue, 17 Jun 2014 16:36:51 +0200
Message-Id: <1403015811-31537-2-git-send-email-zajec5@gmail.com>
X-Mailer: git-send-email 1.8.4.5
In-Reply-To: <1403015811-31537-1-git-send-email-zajec5@gmail.com>
References: <1403015811-31537-1-git-send-email-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40593
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zajec5@gmail.com
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

It seems that bcm47xx can handle only 128 MiB of RAM directly. There
are few devices with 256 MiB, but Broadcom's SDK uses highmem to handle
anything above 128 MiB.

Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
---
 arch/mips/bcm47xx/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/bcm47xx/Kconfig b/arch/mips/bcm47xx/Kconfig
index 0375163..fc21d36 100644
--- a/arch/mips/bcm47xx/Kconfig
+++ b/arch/mips/bcm47xx/Kconfig
@@ -20,6 +20,7 @@ config BCM47XX_SSB
 config BCM47XX_BCMA
 	bool "BCMA Support for Broadcom BCM47XX"
 	select SYS_HAS_CPU_MIPS32_R2
+	select SYS_SUPPORTS_HIGHMEM
 	select CPU_MIPSR2_IRQ_VI
 	select BCMA
 	select BCMA_HOST_SOC
-- 
1.8.4.5
