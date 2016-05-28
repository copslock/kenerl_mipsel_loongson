Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 May 2016 11:52:18 +0200 (CEST)
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35231 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27037190AbcE1JwQ1giz- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 28 May 2016 11:52:16 +0200
Received: by mail-pf0-f195.google.com with SMTP id f144so9162402pfa.2;
        Sat, 28 May 2016 02:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=XPm2zkB2pTxSNJNKvKMXWNx+b2B6J2zwxJyqKhF/TFc=;
        b=UZawoBysmAxN3s1vhwNSo1upLl1jdoQWY1tF5SqtxhkHFyNLF5oXAO+Y8Kjmx7j47j
         SKU72L+nkKrJ/SyiKhEuLDylU9TdkaV669G0MhIYN7DRaUTVZavngR4ARG/srdkqQsfe
         Ewy7aNzW0tzRb0C19YjPdcJ+EG3pCpisLocrvVI9z5saHkUMSgNswZQOaZ9zzsHfgUA8
         /VeLh3YYxV/UTq9isgESKcCf+mYs1Wx+AhdyH5QfgQT8u1m0g/YONGfeWN3rR7uVq5Ff
         CJHQKeZ6kqywNAr7ofA5N+CbhrDTfJczCCQgNZkdZTKpdYHJ4K/dCV+kmlH25vf0C95+
         MCzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XPm2zkB2pTxSNJNKvKMXWNx+b2B6J2zwxJyqKhF/TFc=;
        b=Hs66cnAOSbhPZRERN2yj5YolVYsNsIJrE/wrSoNxz7fGYOckI/ayIBMVn/hKG0O+QO
         dg5vqHiGEaO4B2Yr68ZeeD5FO1bCFYmdx6Kd4fLNMBz66Buu+rGyBhO9tV5IBr4OvvMO
         O6RkfQMnU63ujI+ROf1mZ0p9XAvezXOgA6dkWUxazBMu4a73o/JfdJDesaZWjoe7d7Hp
         fxbglps3ri5CfSlQKHq9HV3zapDsirhMUdBTpHtHhP0JCaBRVvMSBNgsMY+YeTAitxaM
         HPJx4mwPMs4CG3nEIklXG/A/qjUHy+36PR583aNhylyVNyH4l85fCnVAhCG9Ai5I6OkU
         BCUA==
X-Gm-Message-State: ALyK8tLz8t1+MsJta+yR3hRRylXYVCFSWJc8ndXrqerEfGwAJ7NGpisvyxKgvi+d1MZ+SQ==
X-Received: by 10.98.8.146 with SMTP id 18mr25934661pfi.14.1464429128236;
        Sat, 28 May 2016 02:52:08 -0700 (PDT)
Received: from localhost.localdomain ([175.111.195.49])
        by smtp.gmail.com with ESMTPSA id m64sm19539935pfc.19.2016.05.28.02.52.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 28 May 2016 02:52:07 -0700 (PDT)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Kelvin Cheung <keguang.zhang@gmail.com>
Subject: [PATCH] MIPS: Loongson1B: Remove ARCH_WANT_OPTIONAL_GPIOLIB
Date:   Sat, 28 May 2016 17:51:51 +0800
Message-Id: <1464429112-27590-1-git-send-email-keguang.zhang@gmail.com>
X-Mailer: git-send-email 1.9.1
Return-Path: <keguang.zhang@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53683
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: keguang.zhang@gmail.com
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

From: Kelvin Cheung <keguang.zhang@gmail.com>

This patch removes ARCH_WANT_OPTIONAL_GPIOLIB due to upstream changes.

Signed-off-by: Kelvin Cheung <keguang.zhang@gmail.com>
---
 arch/mips/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 5663f41..34ed662 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1404,7 +1404,6 @@ config CPU_LOONGSON1B
 	bool "Loongson 1B"
 	depends on SYS_HAS_CPU_LOONGSON1B
 	select CPU_LOONGSON1
-	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select LEDS_GPIO_REGISTER
 	help
 	  The Loongson 1B is a 32-bit SoC, which implements the MIPS32
-- 
1.9.1
