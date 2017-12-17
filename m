Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 17 Dec 2017 17:03:27 +0100 (CET)
Received: from mail-wr0-x243.google.com ([IPv6:2a00:1450:400c:c0c::243]:32870
        "EHLO mail-wr0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990439AbdLQQDUlSCiz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 17 Dec 2017 17:03:20 +0100
Received: by mail-wr0-x243.google.com with SMTP id v21so1265238wrc.0;
        Sun, 17 Dec 2017 08:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=vpO1cY683t0+lK5mzUFmZV7kCASza6in4gjQZXHEQak=;
        b=f2nuT5j1GjoL4JL4EerXj6k3scI7Yt3dX8Y7PMF6mG04EwPG77rA4RKBHiifCIDy1z
         cnjV+yw9e2KAs13hSREOzgH/keZZh8P0dDwttW/m/mxr2Px76bxHyv/6JC9QFAKO8uqq
         mi4VhFvF3n3dJyLpwpkSbSmMQ5Ke7UAc7KBPZ8iu59kEiiEszxJIBZB1IqgbeCvfM9o5
         exT5vdudQhzRHLS35HMJNht35p0BwWiEmbhfCvYcNx3PNepxHlMMaKC8L3s0Hlhy45TB
         XTUo1v2Dyr8lkZy238cEtMhf5uWIyC6dQH91O+IPvZVt8POPzKj/t9JcMnkGZ/DXmTBo
         1OTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vpO1cY683t0+lK5mzUFmZV7kCASza6in4gjQZXHEQak=;
        b=YVMJ7fPV0V1lULDktTLIawssdONhr1yAVL2ZYRQID6k2h14fAQXMs1+RzdeCPJm3tt
         xPpfivuq0GUkryWplIL2jSO3aNyeM1nR+zTyeXoQlxwdZLc7CSBK4MFi5F0Qci1LypdF
         xsQqaAsOEdQXBbkPulgxRGW3d1FxaJymQ1EUogCSlnw7J/o3+yuQEB2QWpncYYsHsEP7
         yPlpAUaDrl8WkaRiIGNeJBhMr4/6CW+Yi46LQ1ZcXIpuYmU2J78HdQBTnEc2BatLXalK
         wgraOWdIZEh7wtrOV6XCKeuQ+936KFmlU5aBQO63HrDplO2dUOk1xXzrozxxpUco0iIe
         /JOg==
X-Gm-Message-State: AKGB3mIvLyh+WdA6VVomKyKV4FNFrgCWM/NGHoMFEQApQx0+I79ZpVH8
        KM6mVPBhRs2n5Dp+8guLppw=
X-Google-Smtp-Source: ACJfBosg+4rxUzoWUeOhquQtdw1WVe864GBsxO3enzT0z8qjSOoNsNgFNcAecTbHX+fcRUgVBqtBgA==
X-Received: by 10.223.196.6 with SMTP id v6mr14681499wrf.236.1513526595304;
        Sun, 17 Dec 2017 08:03:15 -0800 (PST)
Received: from localhost.localdomain ([2001:470:9e39::48e])
        by smtp.gmail.com with ESMTPSA id e197sm6336019wmf.4.2017.12.17.08.03.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Dec 2017 08:03:14 -0800 (PST)
From:   Jonas Gorski <jonas.gorski@gmail.com>
To:     netdev@vger.kernel.org, linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        "David S. Miller" <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH 0/4] bcm63xx_enet: remove mac_id usage
Date:   Sun, 17 Dec 2017 17:02:51 +0100
Message-Id: <20171217160255.30342-1-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.13.2
Return-Path: <jonas.gorski@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61503
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
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

This patchset aims at reducing the platform device id number usage with
the target of making it eventually possible to probe the driver through OF.

Runtested on BCM6358.

Since the patches touch mostly net/, they should go through net-next.

Jonas Gorski (4):
  bcm63xx_enet: just use "enet" as the clock name
  bcm63xx_enet: use platform data for dma channel numbers
  bcm63xx_enet: remove pointless mac_id check
  bcm63xx_enet: use platform device id directly for miibus name

 arch/mips/bcm63xx/dev-enet.c                        |  8 ++++++++
 .../include/asm/mach-bcm63xx/bcm63xx_dev_enet.h     |  4 ++++
 drivers/net/ethernet/broadcom/bcm63xx_enet.c        | 21 +++++----------------
 drivers/net/ethernet/broadcom/bcm63xx_enet.h        |  3 ---
 4 files changed, 17 insertions(+), 19 deletions(-)

-- 
1.9.1
