Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Mar 2018 16:17:11 +0100 (CET)
Received: from mail-qt0-x243.google.com ([IPv6:2607:f8b0:400d:c0d::243]:44786
        "EHLO mail-qt0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994822AbeCIPNrNaWcw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 9 Mar 2018 16:13:47 +0100
Received: by mail-qt0-x243.google.com with SMTP id g60so10993853qtd.11
        for <linux-mips@linux-mips.org>; Fri, 09 Mar 2018 07:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8xu1GlkSCQRrCyIfDq7yQLIl02ea1I5KtORb1apVr/I=;
        b=wLC9waB8YXZ9e82ZvwL5uSk1fMqPCh06dzf9AimeZC5qtdh0+8YTLdK6d0/r6szkhg
         2mzfSoB6r7vB8NpgdCC0TgNFdYKKy3szO4rMVvufEr9l1gogq5z4w8RNwLElc8Sr2nic
         jOsWlxL5herqzXAafD/xDEYYTnWP3mfDovLmM55Ztt2BrBvfWywKY1xNYo+Src9J+ab/
         +qLncg2z0ZV3izR3H9Y177U9Zq3mOeKhjVnzVPa4USbrMhgUfMuT3mO2YUFhH/1+ln08
         wYSXhpygtAl6x0ej5vQ/NX9qCamsy1Pl4vLaB2v2AD3hyRSNkO4m/zaOc5fMGk6ZWFbi
         WMNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8xu1GlkSCQRrCyIfDq7yQLIl02ea1I5KtORb1apVr/I=;
        b=g8FQvU6HKbgcRpsaMFX1ff6C+S2/ZJKdVLJ6il+W/sz09NNlATrG3+NNv8b7GltvUr
         WBIay3sHsZtu9I5wWkuB0/UXbrD3P9dPttsDcpFOx4R7WddoCXF/kMNebRaA92SbzEBa
         0YkUk1XtYowpLolccktDwq681+u4wyRyYog+GlCFr3nVQjJ8NVQ7tEJMZj6HMOKg4fgr
         e4FiiK3OdFZcua5ZuX4UwgiyyBNRkfNOaEdXYeKk2RGoVsgyuYM49g2AAFf8+Zhr6vDz
         daBIjm7+idoKF6taj/8ZuOszol6yEmHCJEZTU/sdu3lOJ50yv44Cms4W/7mTMwluymIg
         VDvw==
X-Gm-Message-State: AElRT7FWsAquNzcK4eykRk5ScDtVbk5L9v1RVEhxv2vcWv9PkFRwy/2Z
        Yt9kvudpgsKYl4iRqFoFUCxWXg==
X-Google-Smtp-Source: AG47ELumJwSqdvga9IcR6YBOS1SPB3Z0Us0C9I8XkEZnhKOFVRwKqT7PsXzALfW8/jpQa9A6hez2ug==
X-Received: by 10.200.7.11 with SMTP id g11mr14022457qth.264.1520608421457;
        Fri, 09 Mar 2018 07:13:41 -0800 (PST)
Received: from localhost.localdomain ([190.210.56.45])
        by smtp.gmail.com with ESMTPSA id d186sm682187qkf.37.2018.03.09.07.13.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Mar 2018 07:13:40 -0800 (PST)
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>
Cc:     linux-mmc@vger.kernel.org, linux-mips@linux-mips.org,
        James Hogan <jhogan@kernel.org>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Subject: [PATCH 14/14] MIPS: configs: ci20: Enable DMA and MMC support
Date:   Fri,  9 Mar 2018 12:12:19 -0300
Message-Id: <20180309151219.18723-15-ezequiel@vanguardiasur.com.ar>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180309151219.18723-1-ezequiel@vanguardiasur.com.ar>
References: <20180309151219.18723-1-ezequiel@vanguardiasur.com.ar>
Return-Path: <ezequiel@vanguardiasur.com.ar>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62891
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ezequiel@vanguardiasur.com.ar
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

This commit enables the SD/MMC support, along with DMA
engine support in the CI20 defconfig.

Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
---
 arch/mips/configs/ci20_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/mips/configs/ci20_defconfig b/arch/mips/configs/ci20_defconfig
index b5f4ad8f2c45..f88b05fd3077 100644
--- a/arch/mips/configs/ci20_defconfig
+++ b/arch/mips/configs/ci20_defconfig
@@ -104,8 +104,11 @@ CONFIG_REGULATOR_FIXED_VOLTAGE=y
 # CONFIG_HID is not set
 # CONFIG_USB_SUPPORT is not set
 CONFIG_MMC=y
+CONFIG_MMC_JZ4740=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_JZ4740=y
+CONFIG_DMADEVICES=y
+CONFIG_DMA_JZ4780=y
 # CONFIG_IOMMU_SUPPORT is not set
 CONFIG_MEMORY=y
 # CONFIG_DNOTIFY is not set
-- 
2.16.2
