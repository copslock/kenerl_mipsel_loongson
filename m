Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 May 2015 07:39:43 +0200 (CEST)
Received: from mail-lb0-f170.google.com ([209.85.217.170]:36045 "EHLO
        mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006519AbbE2Fjlzc-E6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 29 May 2015 07:39:41 +0200
Received: by lbbqq2 with SMTP id qq2so41763600lbb.3;
        Thu, 28 May 2015 22:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=vzlP9NvGRXUrfyspbdGaJhN4nnrqKpK4WSKM8VZLJqE=;
        b=c7hIK642DSkJ7wz+k0ngBz3ZpxnS4OfoRPy7Afzz74/xCI+eAcbKT9pBx6N0EPSSAs
         mVsPG4Jt5gaPSieVutCzCCAKtqOXrVufaO6/gZU8ptXbnI7zqOZDYwckJ44zZwMkD2yk
         +Dm5ypnK1JrNwwXD5eAxiFSQ56qZCqZS++V+EB1ggXM6NxMoA0p0bXiWj9a4/amJ5fEY
         Rxd8cnki0YhkatTZt8cY7L4bgEaF4yX8zfDD2+WzwzY4aSetfa+BfVMqQCKBt/5fWS14
         7TEMw+poH/2IbIlrIE8UYdhNuQ42BNgEJFVzS3zIKPIjmEOD9wTdEG2aeUgMlW//apIB
         fjnw==
X-Received: by 10.152.5.198 with SMTP id u6mr6205931lau.48.1432877979248;
        Thu, 28 May 2015 22:39:39 -0700 (PDT)
Received: from linux-tdhb.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by mx.google.com with ESMTPSA id xx2sm1102547lbb.13.2015.05.28.22.39.38
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 May 2015 22:39:38 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        Arend van Spriel <arend@broadcom.com>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Subject: [PATCH] MAINTAINERS: Add Broadcom BCM47xx entry
Date:   Fri, 29 May 2015 07:39:26 +0200
Message-Id: <1432877966-5820-1-git-send-email-zajec5@gmail.com>
X-Mailer: git-send-email 1.8.4.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47721
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

Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 474bcb6..643dc00 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2161,6 +2161,14 @@ F:	arch/mips/bcm3384/*
 F:	arch/mips/include/asm/mach-bcm3384/*
 F:	arch/mips/kernel/*bmips*
 
+BROADCOM BCM47XX MIPS ARCHITECTURE
+M:	Hauke Mehrtens <hauke@hauke-m.de>
+M:	Rafał Miłecki <zajec5@gmail.com>
+L:	linux-mips@linux-mips.org
+S:	Maintained
+F:	arch/mips/bcm47xx/*
+F:	arch/mips/include/asm/mach-bcm47xx/*
+
 BROADCOM BCM5301X ARM ARCHITECTURE
 M:	Hauke Mehrtens <hauke@hauke-m.de>
 L:	linux-arm-kernel@lists.infradead.org
-- 
1.8.4.5
