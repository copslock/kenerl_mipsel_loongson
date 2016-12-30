Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Dec 2016 07:30:21 +0100 (CET)
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34805 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992157AbcL3GaOtF0Vt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 30 Dec 2016 07:30:14 +0100
Received: by mail-pg0-f67.google.com with SMTP id b1so21138756pgc.1;
        Thu, 29 Dec 2016 22:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=D6nL14U/Gi4AmnFzJFBTzjIalFhFFpPKOOGfmrmQ898=;
        b=VF4oSIKfzG6NYr/KN/q1vENz2AX3W64OKLa30eJiBMpMvERPu5eO4T2dWpNfiCsjRE
         dqyhJZ5kPeaOhF6dlNuSNbXnVNXXB12m/J8LHAmqTGfTS9xBTdyEOaQP+GMKhSoldWMq
         CfytHlldYW8JEJ6/UkpAGUnhK2YCRv9C3BfW3mJdj5dQK3PlSjmCFJYJQpQDO++y6HYG
         nPKOKjGs2QU9A1X39U/Ti9uIB4Pt8SzfTYpyoD0rr45fZaLsBh2I6o2fE7UbduI4xtjq
         arYi5VKgGgdvWLzNMkFS6X541gTsm8JevW9jq9emN3tbAH0Z0LVlLPMSQNsW+zHof9Gc
         H29Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=D6nL14U/Gi4AmnFzJFBTzjIalFhFFpPKOOGfmrmQ898=;
        b=eU61VKjRo0dBPyqyV90G1P75Pi44+ojAlGlEI8wepV+hN4c9cJZAfZqeyF45FgQ7AP
         TKwtHL/L02JdPWGd56eIWoOCXTtV1m4HxhBK/3+I5nXOGxaKgU4heHkew1lo+KUm2n5J
         orn/CtRLLUc4wbUGqmxT5/NR56edB3uAHPcojUDa6SoyEP5bppbKYLP8jqUT236zUT7D
         LvJZCsxkya5MOOr2T6MAMFVKZ7XFhtDdWtgVwAe8A0XaSvAK8gMmBEBG0RVSYa1C4wqA
         igu8ILS7fROQeTUZ7KQB6ua8oYRSwJfyRtajIOH0fGiwEVAakRG2RMiM1B9IcQ+tshGm
         8P2g==
X-Gm-Message-State: AIkVDXKGTeqvXrazYqeFDKdmK0dtuUAdlA9/633a/232bI1lq2Mprb8FahRSySw98ephHw==
X-Received: by 10.99.157.193 with SMTP id i184mr82689316pgd.148.1483079408909;
        Thu, 29 Dec 2016 22:30:08 -0800 (PST)
Received: from localhost.localdomain ([59.12.167.210])
        by smtp.gmail.com with ESMTPSA id p25sm109237199pfk.20.2016.12.29.22.30.05
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 29 Dec 2016 22:30:07 -0800 (PST)
From:   Jaedon Shin <jaedon.shin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Kevin Cernekee <cernekee@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        Jaedon Shin <jaedon.shin@gmail.com>
Subject: [v2 0/2] Add Broadcom STB SPI support
Date:   Fri, 30 Dec 2016 15:29:59 +0900
Message-Id: <20161230063001.944-1-jaedon.shin@gmail.com>
X-Mailer: git-send-email 2.11.0
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56131
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

This series adds dependency with BMIPS_GENERIC for Broadcom MIPS based SoCs
and device nodes.

As far as I know the boards are booting from NAND by default except BCM97358,
BCM97360 and BCM97425, and therefore the SPI nodes for boot (qspi) of the boards
are disabled.

Changes in v2:
- Use upg_clk instead of new spi_clk.

Jaedon Shin (2):
  spi: bcm-qspi: Enable the driver on BMIPS_GENERIC
  MIPS: BMIPS: Add support SPI device nodes

 arch/mips/boot/dts/brcm/bcm7125.dtsi      | 49 +++++++++++++++++++++++++++++--
 arch/mips/boot/dts/brcm/bcm7346.dtsi      | 43 +++++++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm7358.dtsi      | 43 +++++++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm7360.dtsi      | 43 +++++++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm7362.dtsi      | 43 +++++++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm7420.dtsi      | 49 +++++++++++++++++++++++++++++--
 arch/mips/boot/dts/brcm/bcm7425.dtsi      | 43 +++++++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm7435.dtsi      | 43 +++++++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm97125cbmb.dts  |  4 +++
 arch/mips/boot/dts/brcm/bcm97346dbsmb.dts |  4 +++
 arch/mips/boot/dts/brcm/bcm97358svmb.dts  | 36 +++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm97360svmb.dts  | 36 +++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm97362svmb.dts  |  4 +++
 arch/mips/boot/dts/brcm/bcm97420c.dts     |  4 +++
 arch/mips/boot/dts/brcm/bcm97425svmb.dts  | 36 +++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm97435svmb.dts  |  4 +++
 drivers/spi/Kconfig                       |  3 +-
 17 files changed, 480 insertions(+), 7 deletions(-)

-- 
2.11.0
