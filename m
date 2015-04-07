Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Apr 2015 00:04:27 +0200 (CEST)
Received: from mail-pa0-f74.google.com ([209.85.220.74]:33794 "EHLO
        mail-pa0-f74.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27014567AbbDGWEZzxqBo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 8 Apr 2015 00:04:25 +0200
Received: by pabli10 with SMTP id li10so5739999pab.1
        for <linux-mips@linux-mips.org>; Tue, 07 Apr 2015 15:04:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JzCnq/aKXyMyuIPGtzF2PnfeKLZquzktzSsusq8EHp8=;
        b=eyKhpgUYTu13Lyc4ogAkpT4Z52fUzi61G3nivz/mG5fZbyJbftMi/O4d+It6sbMKSE
         bTD8In2QYBF0KQ+EImRaO2Z879EWEbnTQfTeSdcgI+RtsSr0Kvtfe17bCUnWWY942tl8
         lP13TZ/VgPdYfhmfeK6uvWlT5Z1/ceVbPB7mTxfQEzB3C058rEwJOl1BG/bU2JzvEGME
         GrLOVoalR4uPE7or/qpBnEjacti2/ee26c9nFCKBnlhWeEmeFahABmFQmXJtzu0QQbeY
         EGvY+w71a2ZLr0GypZKXYobvL3VOvmsjGZw/oT1E+UaNz3Y04RbENM9dfZ5LwVGTzS+V
         du5A==
X-Gm-Message-State: ALoCoQmcWDgS/9EDU6LQtfNE5PvrVdU4jhu5DnBxDWddoWF8czdtMTbMJlNAiS1PFDFNGB1e9OVQ
X-Received: by 10.66.150.133 with SMTP id ui5mr26608636pab.33.1428444260738;
        Tue, 07 Apr 2015 15:04:20 -0700 (PDT)
Received: from corpmail-nozzle1-1.hot.corp.google.com ([100.108.1.104])
        by gmr-mx.google.com with ESMTPS id t22si408700yho.2.2015.04.07.15.04.20
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Apr 2015 15:04:20 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com ([172.22.65.70])
        by corpmail-nozzle1-1.hot.corp.google.com with ESMTP id usVfEEgZ.1; Tue, 07 Apr 2015 15:04:20 -0700
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id 89DC0220568; Tue,  7 Apr 2015 15:04:19 -0700 (PDT)
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     devicetree@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org,
        Andrew Bresticker <abrestic@chromium.org>,
        James Hartley <james.hartley@imgtec.com>,
        Damien Horsley <Damien.Horsley@imgtec.com>
Subject: [PATCH V2 0/3] Pistachio USB2.0 PHY
Date:   Tue,  7 Apr 2015 15:04:15 -0700
Message-Id: <1428444258-25852-1-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.2.0.rc0.207.ga3a616c
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46822
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

This series adds support for the USB2.0 PHY present on the IMG Pistachio SoC.

Based on mips-for-linux-next and tested on the IMG Pistachio BuB.  If possible,
I'd like this to go through the MIPS tree with Kishon's ACK.

Cc: James Hartley <james.hartley@imgtec.com>
Cc: Damien Horsley <Damien.Horsley@imgtec.com>

Changes from v1:
 - Added patch to enable PHY driver in pistachio_defconfig
 - Fixed a couple of spelling errors

Andrew Bresticker (3):
  phy: Add binding document for Pistachio USB2.0 PHY
  phy: Add driver for Pistachio USB2.0 PHY
  MIPS: pistachio: Enable USB PHY driver in defconfig

 .../devicetree/bindings/phy/pistachio-usb-phy.txt  |  29 +++
 arch/mips/configs/pistachio_defconfig              |   1 +
 drivers/phy/Kconfig                                |   7 +
 drivers/phy/Makefile                               |   1 +
 drivers/phy/phy-pistachio-usb.c                    | 206 +++++++++++++++++++++
 include/dt-bindings/phy/phy-pistachio-usb.h        |  16 ++
 6 files changed, 260 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/pistachio-usb-phy.txt
 create mode 100644 drivers/phy/phy-pistachio-usb.c
 create mode 100644 include/dt-bindings/phy/phy-pistachio-usb.h

-- 
2.2.0.rc0.207.ga3a616c
