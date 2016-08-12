Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Aug 2016 04:09:54 +0200 (CEST)
Received: from mail-pa0-f66.google.com ([209.85.220.66]:36618 "EHLO
        mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990451AbcHLCJrkL6Sx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Aug 2016 04:09:47 +0200
Received: by mail-pa0-f66.google.com with SMTP id ez1so632025pab.3;
        Thu, 11 Aug 2016 19:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=K7F6zzVv6Ij737eNknJTysucYhybHKAbw7j7lSMfAfU=;
        b=oHLOE/Hal1gMrF+yT1/IGOw4sWFAmY8BSIHKpMg7w7yZB7CR4yA2AGhAy3tATH8Cxy
         BrbxMofnSZKaSMHj31C9AT5zaI50jQfZId+RkvDMZW7+oFFXhSS5cVu1vEMGu6AK/uIy
         JBvVu028mRC+RWwwPtdlcDMjhJRuApC2qeghvlcMlL7+mHHWQNN2tvIWHn/u91ECU1So
         tiIE9NPtrnZGqILk5nn1EvCW8vpr1GBwTXK6CYSfTcucJlC6cIXj/6nlvt2WxZCl6e+k
         jfbvAH6OPCbNZe5rVbL8kKLt3rL9nMI2wmGnEcB75JwDtCTIHENziJ9R33tzvDJ0kBSa
         zCUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=K7F6zzVv6Ij737eNknJTysucYhybHKAbw7j7lSMfAfU=;
        b=SfLDq8cTUBRRfUkpE75z2oT2Pq5VHSBmvs+EJFhAjww0NnpfQ59TzkkmsLj8udehXO
         2jEB7vq8o48bJti1dnSodWvEbWSEeUPn1ODs3x/src9vd/B4X/j+ioWV+JtMnCBrSjJL
         sWzejdU4U2H0Q61quMeuXL0tE/u/vXIFqbf6cuzp4BnTVpjN9akXS8bP3fsbmlMzhtQO
         iNXp1HJCBv8HursrPbBTxZ6qe9vv09/zalqtrD86sTWtnaxnBLqMosxXASN7lK6nn83F
         zCdcFrafN8UbJTdEym8K6KhdEC93wmz/OuZaUv0vU3TBMUp5Zqstdg3W1h+MDYEnJGPm
         vmug==
X-Gm-Message-State: AEkooutIOK8sMfRmePekII4Fql9OCSzJvV0N0pFX6WpwDcSuT7rgrxlaeCxeuChYwaGE6g==
X-Received: by 10.66.233.38 with SMTP id tt6mr22595664pac.99.1470967780980;
        Thu, 11 Aug 2016 19:09:40 -0700 (PDT)
Received: from localhost.localdomain ([125.130.116.2])
        by smtp.gmail.com with ESMTPSA id ao6sm8209846pac.8.2016.08.11.19.09.38
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 11 Aug 2016 19:09:40 -0700 (PDT)
From:   Jaedon Shin <jaedon.shin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Jonas Gorski <jonas.gorski@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        MIPS Mailing List <linux-mips@linux-mips.org>,
        Jaedon Shin <jaedon.shin@gmail.com>
Subject: [v2 0/5] Add device nodes for BCM7xxx SoCs
Date:   Fri, 12 Aug 2016 11:09:18 +0900
Message-Id: <20160812020923.3299-1-jaedon.shin@gmail.com>
X-Mailer: git-send-email 2.9.2
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54485
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
