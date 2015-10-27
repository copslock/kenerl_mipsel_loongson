Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Oct 2015 07:48:42 +0100 (CET)
Received: from mail-pa0-f50.google.com ([209.85.220.50]:36863 "EHLO
        mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011507AbbJ0Gskj5ZX9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 27 Oct 2015 07:48:40 +0100
Received: by pacfv9 with SMTP id fv9so222577898pac.3;
        Mon, 26 Oct 2015 23:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=29FYGpoAXF+UkT2r9bc3yvc5b9/PJCIYwiZ4cVJW2I0=;
        b=esrO99suhajJ0rpP3FuBOjiWvrGJVF6ZbGu0pZRNV7W0qYSfSWECFPFyopFA1r5upM
         lp22fOQ3iJlqzjHkWbSCtsqRkCjg8AWb4xM6zUQMmd48htBB3b3g09bSnK+A2dzZNPtt
         A8O2qwT1SHbGxvQw0LBLJXPx+p4UkHwKmWaliUqhPi1brUGEQ7uINtfvqDSN5MJO0PWY
         bgSSwX5Oew3nJam1m9DlIVfNuEYl8am5NV1aZiRCg1Dr0HatH7OkjjF6c1jE5DkgC2Wk
         yw0JUx/ddYb3pk+lGo9lKRhW8odqgymJ2z9tNGx+B5qKIv/u9KcIZT+BKD91iCszBpK2
         Ze1A==
X-Received: by 10.68.228.3 with SMTP id se3mr20081349pbc.114.1445928514411;
        Mon, 26 Oct 2015 23:48:34 -0700 (PDT)
Received: from praha.local.private ([211.255.134.165])
        by smtp.gmail.com with ESMTPSA id tt7sm1564458pab.45.2015.10.26.23.48.30
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 26 Oct 2015 23:48:33 -0700 (PDT)
From:   Jaedon Shin <jaedon.shin@gmail.com>
To:     Brian Norris <computersforpeace@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Dragan Stancevic <dragan.stancevic@gmail.com>,
        linux-ide@vger.kernel.org, Linux-MIPS <linux-mips@linux-mips.org>,
        devicetree@vger.kernel.org, Jaedon Shin <jaedon.shin@gmail.com>
Subject: [v2 00/10] add support SATA for BMIPS_GENERIC
Date:   Tue, 27 Oct 2015 15:48:01 +0900
Message-Id: <1445928491-7320-1-git-send-email-jaedon.shin@gmail.com>
X-Mailer: git-send-email 2.6.2
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49704
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

Ralf,
I request you to drop already submitted patches for NAND deivce nodes.
They are merge conflict with these.
http://patchwork.linux-mips.org/patch/10577/
http://patchwork.linux-mips.org/patch/10578/
http://patchwork.linux-mips.org/patch/10579/
http://patchwork.linux-mips.org/patch/10580/

Changes in v2:
- Adds quick for ncq
- Adds quick for phy interface control
- Remove unused definitions in ahci_brcmstb
- Combines compatible string

Jaedon Shin (10):
  ata: ahci_brcmstb: add quick for broken ncq
  ata: ahci_brcmstb: add support MIPS-based platforms
  ata: ahci_brcmstb: add quick for broken phy
  ata: ahci_brcmstb: remove unused definitions
  phy: phy_brcmstb_sata: remove duplicate definitions
  phy: phy_brcmstb_sata: add data for phy version
  phy: phy_brcmstb_sata: add support MIPS-based platforms
  MIPS: BMIPS: brcmstb: add SATA/PHY nodes for bcm7425
  MIPS: BMIPS: brcmstb: add SATA/PHY nodes for bcm7346
  MIPS: BMIPS: brcmstb: add SATA/PHY nodes for bcm7362

 .../devicetree/bindings/ata/brcm,sata-brcmstb.txt  |  8 +++-
 .../bindings/phy/brcm,brcmstb-sata-phy.txt         |  1 +
 arch/mips/boot/dts/brcm/bcm7346.dtsi               | 42 +++++++++++++++++
 arch/mips/boot/dts/brcm/bcm7362.dtsi               | 42 +++++++++++++++++
 arch/mips/boot/dts/brcm/bcm7425.dtsi               | 42 +++++++++++++++++
 arch/mips/boot/dts/brcm/bcm97346dbsmb.dts          |  8 ++++
 arch/mips/boot/dts/brcm/bcm97362svmb.dts           |  8 ++++
 drivers/ata/Kconfig                                |  2 +-
 drivers/ata/ahci_brcmstb.c                         | 55 +++++++++++++++++++++-
 drivers/phy/Kconfig                                |  4 +-
 drivers/phy/phy-brcmstb-sata.c                     | 47 ++++++++++++++----
 11 files changed, 242 insertions(+), 17 deletions(-)

-- 
2.6.2
