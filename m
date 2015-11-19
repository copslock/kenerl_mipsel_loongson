Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Nov 2015 03:35:24 +0100 (CET)
Received: from mail-pa0-f50.google.com ([209.85.220.50]:35389 "EHLO
        mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011975AbbKSCfXIkwhC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 19 Nov 2015 03:35:23 +0100
Received: by pacej9 with SMTP id ej9so64366717pac.2;
        Wed, 18 Nov 2015 18:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=yodLIgxGclGd6o1XfiQJQqtKZkkBoWfxXsEW1JsAE34=;
        b=RlFoD1xcSFaBcYlnjbkVhNgwEfl6GCly3P9FqVELruUBdlCxaanMvELzZOj7dpe16R
         0CAWP7t9iyl4d7MPGLhPec7YEAo2c3SQvEws3zQzVUzH8uKQ1khitrPSVyFVPBCLt/dx
         k4C5JIbokbUAYUn3oFoe/DhdjyeOhXI0RZhaldg8/hvomJKzdfFQTKfVGiZku71hRq/q
         bOAxuVcC4LCh5jqHI2VccBMEVMoyUojxHPeI9eqY/FN6irQHrA3OAJn25ta8Qvxgfxv6
         hbPVdQJMLv/+DmYnYouUmwkx0O9+0xksb6huGc5RKvLUZzUVQWwFjvDs4uy311nPaflG
         Es3Q==
X-Received: by 10.68.201.73 with SMTP id jy9mr7076417pbc.102.1447900517039;
        Wed, 18 Nov 2015 18:35:17 -0800 (PST)
Received: from praha.local.private ([211.255.134.165])
        by smtp.gmail.com with ESMTPSA id ns1sm6719515pbc.67.2015.11.18.18.35.14
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 18 Nov 2015 18:35:16 -0800 (PST)
From:   Jaedon Shin <jaedon.shin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Kevin Cernekee <cernekee@gmail.com>,
        Dragan Stancevic <dragan.stancevic@gmail.com>,
        Jaedon Shin <jaedon.shin@gmail.com>
Subject: [PATCH 0/7] cleanup and add device tree for BCM7xxx platforms
Date:   Thu, 19 Nov 2015 11:34:46 +0900
Message-Id: <1447900493-1167-1-git-send-email-jaedon.shin@gmail.com>
X-Mailer: git-send-email 2.6.3
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49984
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jaedon.shin@gmail.com
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

Hi all,

This patch series is including device tree entries that clean up existing
entries and adds missing entries for BCM7xxx platforms.

Jaedon Shin (7):
  MIPS: BMIPS: remove unused aliases in device tree
  MIPS: BMIPS: remove wrong sata properties
  MIPS: BMIPS: fix phy name in device tree
  MIPS: BMIPS: fix interrupt number in bcm7425.dtsi
  MIPS: BMIPS: add device tree entry for BCM7xxx UART
  MIPS: BMIPS: add device tree entry for BCM7xxx I2C
  MIPS: BMIPS: add device tree entry for BCM7xxx SATA

 arch/mips/boot/dts/brcm/bcm7125.dtsi     |  69 +++++++++++++++-
 arch/mips/boot/dts/brcm/bcm7346.dtsi     |   6 +-
 arch/mips/boot/dts/brcm/bcm7358.dtsi     |   2 -
 arch/mips/boot/dts/brcm/bcm7360.dtsi     |  42 +++++++++-
 arch/mips/boot/dts/brcm/bcm7362.dtsi     |   6 +-
 arch/mips/boot/dts/brcm/bcm7420.dtsi     |  77 +++++++++++++++++-
 arch/mips/boot/dts/brcm/bcm7425.dtsi     | 100 +++++++++++++++++++++--
 arch/mips/boot/dts/brcm/bcm7435.dtsi     | 134 ++++++++++++++++++++++++++++++-
 arch/mips/boot/dts/brcm/bcm97125cbmb.dts |  24 ++++++
 arch/mips/boot/dts/brcm/bcm97360svmb.dts |   8 ++
 arch/mips/boot/dts/brcm/bcm97420c.dts    |  28 +++++++
 arch/mips/boot/dts/brcm/bcm97425svmb.dts |  28 +++++++
 arch/mips/boot/dts/brcm/bcm97435svmb.dts |  36 +++++++++
 13 files changed, 534 insertions(+), 26 deletions(-)

--
2.6.3
