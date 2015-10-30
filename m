Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Oct 2015 15:01:42 +0100 (CET)
Received: from mail-pa0-f47.google.com ([209.85.220.47]:35827 "EHLO
        mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010999AbbJ3OBkaR3W0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 30 Oct 2015 15:01:40 +0100
Received: by pasz6 with SMTP id z6so75568651pas.2;
        Fri, 30 Oct 2015 07:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=kz2/exbazH+sLLtj0PN50hyR67mmaysH1xUDT8x8icI=;
        b=MA1awrHpDTEx2gMRzQioN3cbaw5Jw+SuaiCI/ddPWmI772yk4FeFjSlxYLkmweybww
         VG844JZqRubCJfC2fsceJ25wnQuSPQNMfaSU+W1931AK9nblTh2kpt5VBRLR0wVlNqce
         0i7O/iumgPu/p3racONT9+G1DR7FOOTkMct7k+k7puXxxH/UQcAIfzuDhD8nRGCoMj0R
         ZbfaiNqwqYpKqudO5kBzV+c4zXkcTmVoSLH7rvS86s5Y02IN//RSv6+U+hXPfCdT26Xi
         HrGKQ/iVf8rJE68dPL9Y6VUGbpvCulJKSSsUoyrADFPfkREY6Fa0bL5M9WxGu4nrkcPR
         Cffg==
X-Received: by 10.66.190.33 with SMTP id gn1mr9194561pac.102.1446213694681;
        Fri, 30 Oct 2015 07:01:34 -0700 (PDT)
Received: from localhost.localdomain ([59.12.167.210])
        by smtp.gmail.com with ESMTPSA id zk3sm8473164pbb.41.2015.10.30.07.01.31
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 30 Oct 2015 07:01:34 -0700 (PDT)
From:   Jaedon Shin <jaedon.shin@gmail.com>
To:     Brian Norris <computersforpeace@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Kevin Cernekee <cernekee@gmail.com>,
        Dragan Stancevic <dragan.stancevic@gmail.com>,
        linux-ide@vger.kernel.org, Linux-MIPS <linux-mips@linux-mips.org>,
        devicetree@vger.kernel.org, Jaedon Shin <jaedon.shin@gmail.com>
Subject: [v4 00/10] add support SATA for BMIPS_GENERIC
Date:   Fri, 30 Oct 2015 23:01:14 +0900
Message-Id: <1446213684-2625-1-git-send-email-jaedon.shin@gmail.com>
X-Mailer: git-send-email 2.6.2
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49788
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

This patch series add support SATA for BMIPS_GENERIC.

Changes in v4:
- remove unused properties from bcm{7425,7342,7362}.dtsi

Changes in v3:
- fix typo quirk instead of quick
- disable NCQ before initialzing SATA controller endianness
- fix misnomer controlling phy interface
- remove brcm,broken-ncq and brcm,broken-phy properties from devicetree
- use compatible string for quirks
- use list for compatible strings
- add "Acked-by:" tags

Changes in v2:
- adds quirk for ncq
- adds quirk for phy interface control
- remove unused definitions in ahci_brcmstb
- combines compatible string

Jaedon Shin (10):
  ata: ahci_brcmstb: add support MIPS-based platforms
  ata: ahci_brcmstb: add quirk for broken ncq
  ata: ahci_brcmstb: add quirk for different phy
  ata: ahci_brcmstb: remove unused definitions
  phy: phy_brcmstb_sata: remove duplicate definitions
  phy: phy_brcmstb_sata: add data for phy version
  phy: phy_brcmstb_sata: add support MIPS-based platforms
  MIPS: BMIPS: brcmstb: add SATA/PHY nodes for bcm7425
  MIPS: BMIPS: brcmstb: add SATA/PHY nodes for bcm7346
  MIPS: BMIPS: brcmstb: add SATA/PHY nodes for bcm7362

 .../devicetree/bindings/ata/brcm,sata-brcmstb.txt  |  4 +-
 .../bindings/phy/brcm,brcmstb-sata-phy.txt         |  1 +
 arch/mips/boot/dts/brcm/bcm7346.dtsi               | 40 +++++++++++++++
 arch/mips/boot/dts/brcm/bcm7362.dtsi               | 40 +++++++++++++++
 arch/mips/boot/dts/brcm/bcm7425.dtsi               | 40 +++++++++++++++
 arch/mips/boot/dts/brcm/bcm97346dbsmb.dts          |  8 +++
 arch/mips/boot/dts/brcm/bcm97362svmb.dts           |  8 +++
 drivers/ata/Kconfig                                |  2 +-
 drivers/ata/ahci_brcmstb.c                         | 58 +++++++++++++++++++++-
 drivers/phy/Kconfig                                |  4 +-
 drivers/phy/phy-brcmstb-sata.c                     | 47 ++++++++++++++----
 11 files changed, 236 insertions(+), 16 deletions(-)

-- 
2.6.2
