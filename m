Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Oct 2015 03:45:19 +0200 (CEST)
Received: from mail-pa0-f54.google.com ([209.85.220.54]:35405 "EHLO
        mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010688AbbJWBpRcxm5B (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Oct 2015 03:45:17 +0200
Received: by pasz6 with SMTP id z6so102428931pas.2;
        Thu, 22 Oct 2015 18:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=imzh7bUiG9xnoAB5pMlvaCLQew5tMiWeVeAe7HIsblw=;
        b=UjwRsK46BCiBN1EYK9YOn+MiQEn5OYSYZ5wKejTXG78mB7JdfM9QdS3jxD1aqqEmLZ
         tmAcmG14gmQxUDK3wvxYkj4Wk43O3VJn9f9d0M9aW6QsZFmj177FzzZBp1g4Fws//QH4
         cfveS17Mcdz0w6d/puS5IqamAO6rK6cKk4aYp7CSgrOS/hDBe1Tvj6+h40PLtskyEza/
         ntZV/hFItDlfxVnoq2yIp0fgIxW+JSmmrPwrfCpmE/F2JIJy2MQkTcOWSD7SsL+w/eQ0
         tDEPhLOI/+QlLC9eSV2NrfRWcW9lj6tnD4nm+3Xp+Ypz5+SpVZS0oTfz06sQ/7XJF9NL
         O+9g==
X-Received: by 10.68.68.233 with SMTP id z9mr21035661pbt.132.1445564711291;
        Thu, 22 Oct 2015 18:45:11 -0700 (PDT)
Received: from localhost.localdomain ([125.176.118.36])
        by smtp.gmail.com with ESMTPSA id u10sm15955594pbs.63.2015.10.22.18.45.07
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 22 Oct 2015 18:45:10 -0700 (PDT)
From:   Jaedon Shin <jaedon.shin@gmail.com>
To:     Tejun Heo <tj@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-ide@vger.kernel.org, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, Jaedon Shin <jaedon.shin@gmail.com>
Subject: [PATCH 00/10] add support SATA for BMIPS_GENERIC
Date:   Fri, 23 Oct 2015 10:44:13 +0900
Message-Id: <1445564663-66824-1-git-send-email-jaedon.shin@gmail.com>
X-Mailer: git-send-email 2.6.2
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49641
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

This patch series adds support SATA for BMIPS_GENERIC.

Ralf,
I request you to drop already submitted patches for NAND device nodes.
It is merge conflicts with this patches.
http://patchwork.linux-mips.org/patch/10577/
http://patchwork.linux-mips.org/patch/10578/
http://patchwork.linux-mips.org/patch/10579/
http://patchwork.linux-mips.org/patch/10580/

Jaedon Shin (10):
  ata: ahci_brcmstb: make the driver buildable on BMIPS_GENERIC
  ata: ahch_brcmstb: add data for port offset
  ata: ahci_brcmstb: add support 40nm platforms
  phy: phy_brcmstb_sata: make the driver buildable on BMIPS_GENERIC
  phy: phy_brcmstb_sata: remove unused definitions
  phy: phy_brcmstb_sata: add data for phy offset
  phy: phy_brcmstb_sata: add support 40nm platforms
  MIPS: BMIPS: brcmstb: add SATA nodes for bcm7346
  MIPS: BMIPS: brcmstb: add SATA nodes for bcm7360
  MIPS: BMIPS: brcmstb: add SATA nodes for bcm7362

 arch/mips/boot/dts/brcm/bcm7346.dtsi      | 40 +++++++++++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm7360.dtsi      | 40 +++++++++++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm7362.dtsi      | 40 +++++++++++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm97346dbsmb.dts |  8 +++++++
 arch/mips/boot/dts/brcm/bcm97360svmb.dts  |  8 +++++++
 arch/mips/boot/dts/brcm/bcm97362svmb.dts  |  8 +++++++
 drivers/ata/Kconfig                       |  2 +-
 drivers/ata/ahci_brcmstb.c                | 34 +++++++++++++++++++-------
 drivers/phy/Kconfig                       |  4 ++--
 drivers/phy/phy-brcmstb-sata.c            | 34 ++++++++++++++++++--------
 10 files changed, 196 insertions(+), 22 deletions(-)

-- 
2.6.2
