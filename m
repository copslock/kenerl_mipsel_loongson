Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Aug 2016 04:52:55 +0200 (CEST)
Received: from mail-pa0-f66.google.com ([209.85.220.66]:33901 "EHLO
        mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990513AbcHSCwsR4Y8i (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 19 Aug 2016 04:52:48 +0200
Received: by mail-pa0-f66.google.com with SMTP id hh10so2692759pac.1;
        Thu, 18 Aug 2016 19:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=I05cAvYnQiTH+XEtDEWOCxRZktUA64wDvn+qyOnXwDc=;
        b=jqG+62PuFoEe6PTFE0Qgsq1ABCQdJXIPQHoHwwkvyUqXKjewvI5zw8/y3yJQSlk87B
         LHsIRYtU4Mytnbmk+gCFcIBBlJi4B3h3TqJcfdgU7vIPMSw2LnLjal8DR4OBhx4Er+fR
         e/cwY9hCZea8Lg7ZoC2L/OwxXpUI3Jhekqe+OGiYODDmXPfpvCe5hK1EieU4wF2HJkZf
         vMOgi60B7atzgRKuERft9WkNSxy289e0v23T92QOExFgnCTtm+TlgjiZWovXjC4EDnpv
         B7WqPr8CZ3vXTtot8Bc5JdZzTPHiCdj1OVscQOpAhgAGYZSWaHSdrBCy3bPYGiUY5n1z
         EeOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=I05cAvYnQiTH+XEtDEWOCxRZktUA64wDvn+qyOnXwDc=;
        b=dvRaIvD8NmdxsWyKVDbIqUPwrfCTo0e5hVw9b4G+GvlJIbsDPPmBuAI99qiARbwYbL
         QjjtyyEtlTdoHiM3n+I8xXvRlpTL7sCBP95ek5tz4vv43Pc/B6co1AdB30DxCBnxuRjY
         UsG0QdPAHb8meXwEuGLF2pbxd+gitDlHp9ffGmPPsp5Ih+74WlM+fLwp56JfGuQZFN6u
         W8uMgPdCvN2HnIKV9sFiz6oLMp01q1k41c/WMo6+IwOsJUI1vO42MzXzhiKWXy/rPsl4
         4jjA+LMhZAdY9MGDLLhz+T7ZpsYPemNG1MoO1TE4vFI+GGFLNueXBS0ti070QwHkWXD9
         k0oA==
X-Gm-Message-State: AEkoout/pktLUJGGDXecbNtpWEeJ6IdX9VrWsjdJgx5mS+AeorBS3ADBkLLphOR8iY6UXw==
X-Received: by 10.66.220.194 with SMTP id py2mr9410629pac.77.1471575161700;
        Thu, 18 Aug 2016 19:52:41 -0700 (PDT)
Received: from localhost.localdomain ([125.130.116.2])
        by smtp.gmail.com with ESMTPSA id 132sm1886744pfu.6.2016.08.18.19.52.38
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 18 Aug 2016 19:52:41 -0700 (PDT)
From:   Jaedon Shin <jaedon.shin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jonas Gorski <jonas.gorski@gmail.com>
Cc:     Kevin Cernekee <cernekee@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        MIPS Mailing List <linux-mips@linux-mips.org>,
        devicetree@vger.kernel.org, Jaedon Shin <jaedon.shin@gmail.com>
Subject: [v4 0/5] Add device nodes for BCM7xxx SoCs
Date:   Fri, 19 Aug 2016 11:52:25 +0900
Message-Id: <20160819025230.31882-1-jaedon.shin@gmail.com>
X-Mailer: git-send-email 2.9.3
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54669
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

Changes in v4:
- Fixed interrupt-controller@ at first.
- Fixed NAND properties for various boards.

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
 arch/mips/boot/dts/brcm/bcm97360svmb.dts           |   8 ++
 arch/mips/boot/dts/brcm/bcm97362svmb.dts           |  13 +++
 arch/mips/boot/dts/brcm/bcm97420c.dts              |   8 ++
 arch/mips/boot/dts/brcm/bcm97425svmb.dts           |  21 ++++
 arch/mips/boot/dts/brcm/bcm97435svmb.dts           |  21 ++++
 .../boot/dts/brcm/bcm97xxx-nand-cs1-bch24.dtsi     |  25 +++++
 .../mips/boot/dts/brcm/bcm97xxx-nand-cs1-bch4.dtsi |  25 +++++
 18 files changed, 775 insertions(+), 38 deletions(-)
 create mode 100644 arch/mips/boot/dts/brcm/bcm97xxx-nand-cs1-bch24.dtsi
 create mode 100644 arch/mips/boot/dts/brcm/bcm97xxx-nand-cs1-bch4.dtsi

-- 
2.9.3
