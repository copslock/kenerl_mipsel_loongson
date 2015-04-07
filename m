Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Apr 2015 00:05:22 +0200 (CEST)
Received: from mail-qk0-f201.google.com ([209.85.220.201]:34252 "EHLO
        mail-qk0-f201.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27014925AbbDGWE1WVsOS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 8 Apr 2015 00:04:27 +0200
Received: by qkbw1 with SMTP id w1so12928419qkb.1
        for <linux-mips@linux-mips.org>; Tue, 07 Apr 2015 15:04:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jYm2ErXXDg1abk1sxAqpTjaEP+/bjyr6QXiwdHwyEvo=;
        b=QDG0lcRFu6hWof0cmrp9M/dGclfTm27sIvb/WTHnD+qWe9NfgGZZ6SlIksW/oBxGtV
         8MsvWHcJZm2ycNpFGRsg4K2+995tqK9Sr792TfmhbtgOLncGqSwfjUHrBUxcPso4CeDm
         CvXJBIECBhsznEBNgaf2zmtelJjcB6eT/8jARPrsbNdCv1xEK2BpmTe0y8vC60ePmXGp
         h2m4d7rtUmVPy9oGkm/p2IyrSvB49LCpvYeqk8fwozBztcuNkp430+GK00rhbTKTesdD
         PKOl3iPJHHrAcQrK3qBHiUzQDOSJ9t3vAhiaumlV7m/l9/s0oD0tOtYl32y06pU0RzwS
         3sPA==
X-Gm-Message-State: ALoCoQlurdghvqoWmFD/R4QQTM0EU/84ysrlDBz1wAELe1uDDoaYQbZFdmC1k0iRwhYKtxa/o45X
X-Received: by 10.236.16.130 with SMTP id h2mr26488721yhh.36.1428444262782;
        Tue, 07 Apr 2015 15:04:22 -0700 (PDT)
Received: from corpmail-nozzle1-1.hot.corp.google.com ([100.108.1.104])
        by gmr-mx.google.com with ESMTPS id z21si392162yhc.5.2015.04.07.15.04.22
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Apr 2015 15:04:22 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com ([172.22.65.70])
        by corpmail-nozzle1-1.hot.corp.google.com with ESMTP id 42HowY8A.1; Tue, 07 Apr 2015 15:04:22 -0700
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id D808A220568; Tue,  7 Apr 2015 15:04:21 -0700 (PDT)
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     devicetree@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org,
        Andrew Bresticker <abrestic@chromium.org>,
        James Hartley <james.hartley@imgtec.com>,
        Damien Horsley <Damien.Horsley@imgtec.com>
Subject: [PATCH V2 3/3] MIPS: pistachio: Enable USB PHY driver in defconfig
Date:   Tue,  7 Apr 2015 15:04:18 -0700
Message-Id: <1428444258-25852-4-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.2.0.rc0.207.ga3a616c
In-Reply-To: <1428444258-25852-1-git-send-email-abrestic@chromium.org>
References: <1428444258-25852-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46825
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: abrestic@chromium.org
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

Update pistachio_defconfig to enable Pistachio's USB PHY driver.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
---
New for v2.
---
 arch/mips/configs/pistachio_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/configs/pistachio_defconfig b/arch/mips/configs/pistachio_defconfig
index f22e92e..1646cce 100644
--- a/arch/mips/configs/pistachio_defconfig
+++ b/arch/mips/configs/pistachio_defconfig
@@ -272,6 +272,7 @@ CONFIG_IIO=y
 CONFIG_CC10001_ADC=y
 CONFIG_PWM=y
 CONFIG_PWM_IMG=y
+CONFIG_PHY_PISTACHIO_USB=y
 CONFIG_ANDROID=y
 CONFIG_EXT4_FS=y
 CONFIG_EXT4_FS_POSIX_ACL=y
-- 
2.2.0.rc0.207.ga3a616c
