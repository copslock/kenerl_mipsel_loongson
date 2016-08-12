Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Aug 2016 10:52:57 +0200 (CEST)
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34954 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992334AbcHLIwuPQuE- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Aug 2016 10:52:50 +0200
Received: by mail-pf0-f196.google.com with SMTP id h186so1211661pfg.2;
        Fri, 12 Aug 2016 01:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=jRrUFt8InVSCQWLeiLv1in8q8zD5whTTFGdsqn0VRUs=;
        b=nHBnlFV8vqpwGSthUtgkWxnf5hzlsBPYp7oWeUf+14z1tpx492r9VoVxOQPtEEapgg
         Z+o4h+1/onobpQlSEnhL/HnioRo5ja+0vk+W6U+Wu04/gLlJVRaKf2m2bFPR68lxc7Ww
         BSric4bzKb8JeMfqMgQM7DWNzvZvdVxHgWE4XWUDLFRlpyHs1UXPVZCrZ1LaVvAAgrRl
         n+pnscOOlnzXWky08Nt5/D0ArMG21GP3YJyJbpdtMCw3xwZrT3OgBSxKcANuqNnN16fJ
         XbalYayAnn+tx086Il7qIbA6JZyKids//kajWtJLFtowVKp/sRweR3XQZgYEGXP5Yg7h
         k0tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jRrUFt8InVSCQWLeiLv1in8q8zD5whTTFGdsqn0VRUs=;
        b=W+HVnd74jB9heezwduIUY/iF9DTETww3vWPISFCW6yuDBJ5B5jAp25XsypMETfQF/+
         meqozYqZ398f/c996blaIyVqQdG4gBTpNU23qjHENxX6ZvmqJ4C8sueGfFeyzUmCbKB8
         rRQxSgTHxYm+DxsfPs9NLvchf9bKkGnQ/i0UtoeCYf+pwEs4zxIy4bDUu/lgxbuTrPAl
         OeFa6HxEclo6fAEk93iDfiZB7bnjjwmrlI0bKqsp/BvkmYXTbq0zSeqgVLTdqy12GAqx
         djkJygsfV+zTmqtm5tj/BQ/jLoG3A1TBrV6TgCMx+jNbifkU3Gxc4yErEGGA5VmhYs2h
         f7kA==
X-Gm-Message-State: AEkoouuBZMnTBeNkJiSCNYKBP2lU5FhQzV7mZHk5iBkcwFCDMu0lhBm52C4e3kiMiYqrcw==
X-Received: by 10.98.13.84 with SMTP id v81mr25392912pfi.108.1470991964217;
        Fri, 12 Aug 2016 01:52:44 -0700 (PDT)
Received: from localhost.localdomain ([125.130.116.2])
        by smtp.gmail.com with ESMTPSA id ty6sm11024819pac.18.2016.08.12.01.52.41
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 12 Aug 2016 01:52:43 -0700 (PDT)
From:   Jaedon Shin <jaedon.shin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Jonas Gorski <jonas.gorski@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        MIPS Mailing List <linux-mips@linux-mips.org>,
        Jaedon Shin <jaedon.shin@gmail.com>
Subject: [v3 0/5] Add device nodes for BCM7xxx SoCs
Date:   Fri, 12 Aug 2016 17:52:26 +0900
Message-Id: <20160812085231.53290-1-jaedon.shin@gmail.com>
X-Mailer: git-send-email 2.9.2
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54495
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

This patch series adds support for Broadcom BCM7xxx MIPS based SoCs.

The NAND device nodes have common file including chip select, BCH
and partitions for the reference board with the same properties.

Changes in v3:
- Fixed incorrect interrupt number in aon_pm_l2_intc.

Changes in v2:
- Removed status properties in always enabled GPIO nodes.
- Removed NAND nodes for v3.3 brcmnand controller.
- Renamed interrupt-controller instead of lable string.
- Renamed bcm97xxx-nand-cs1-bch8.dtsi

Jaedon Shin (5):
  MIPS: BMIPS: Add support PWM device nodes
  MIPS: BMIPS: Add support GPIO device nodes
  MIPS: BMIPS: Add support SDHCI device nodes
  MIPS: BMIPS: Add support NAND device nodes
  MIPS: BMIPS: Use interrupt-controller node name

 arch/mips/boot/dts/brcm/bcm7125.dtsi               |  34 ++++++-
 arch/mips/boot/dts/brcm/bcm7346.dtsi               |  97 +++++++++++++++++-
 arch/mips/boot/dts/brcm/bcm7358.dtsi               |  89 ++++++++++++++++-
 arch/mips/boot/dts/brcm/bcm7360.dtsi               |  89 ++++++++++++++++-
 arch/mips/boot/dts/brcm/bcm7362.dtsi               |  89 ++++++++++++++++-
 arch/mips/boot/dts/brcm/bcm7420.dtsi               |  42 +++++++-
 arch/mips/boot/dts/brcm/bcm7425.dtsi               | 109 ++++++++++++++++++++-
 arch/mips/boot/dts/brcm/bcm7435.dtsi               | 109 ++++++++++++++++++++-
 arch/mips/boot/dts/brcm/bcm97125cbmb.dts           |   4 +
 arch/mips/boot/dts/brcm/bcm97346dbsmb.dts          |  17 ++++
 arch/mips/boot/dts/brcm/bcm97358svmb.dts           |  13 +++
 arch/mips/boot/dts/brcm/bcm97360svmb.dts           |  13 +++
 arch/mips/boot/dts/brcm/bcm97362svmb.dts           |  13 +++
 arch/mips/boot/dts/brcm/bcm97420c.dts              |   8 ++
 arch/mips/boot/dts/brcm/bcm97425svmb.dts           |  21 ++++
 arch/mips/boot/dts/brcm/bcm97435svmb.dts           |  21 ++++
 .../mips/boot/dts/brcm/bcm97xxx-nand-cs1-bch8.dtsi |  24 +++++
 17 files changed, 754 insertions(+), 38 deletions(-)
 create mode 100644 arch/mips/boot/dts/brcm/bcm97xxx-nand-cs1-bch8.dtsi

-- 
2.9.2
