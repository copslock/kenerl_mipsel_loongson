Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Dec 2016 03:00:02 +0100 (CET)
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34345 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994629AbcL0B74Gi1x9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 27 Dec 2016 02:59:56 +0100
Received: by mail-pg0-f66.google.com with SMTP id b1so10792646pgc.1;
        Mon, 26 Dec 2016 17:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=CglmadEUYuuZonLjm+AaCmBnrRsLXQXIZSLbwvyyRZQ=;
        b=Yldq3EYQXbcH8mv6wyuOcbGrMcsvhtjMcCo2ezimvylla0xASf3vw6lz3WZddHanvq
         maB51/WPeWxFrwuRUGiOAqwkYC0t2HI8Xpvbdvgs8bfIZ/xz++POpr2a7nArjQ51eIjp
         z0Px6T/uXV+T5+YexXkVm1oupw7irwtq8Aj36awCtjv/OKboRiq/cFeRORHVj6p0Uorr
         /LhtmgeVZmDrAzDpw50tjZ73NCVnlbKgDtS0nLw0m+eG9IrsP5XHudkOM2SiOH9vZL9H
         tbV3B0cyOh+yDlnKZ0kMtFPMIzXb3MmXfVAOP3is9/lzgPbbuVM8Nmc0fsYvCpR1QYnj
         GWJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CglmadEUYuuZonLjm+AaCmBnrRsLXQXIZSLbwvyyRZQ=;
        b=YF+tNkTYHKj8YglDJCkRGZo+YgjCBT8Cfd1mFEi05gnssPxpLN37DvvFvwoGRBxNXu
         fPz2yrIGOYBMyf4kpGEAynmM4ecvx14F+HJ3+Hqy4Qk5BkLixkPpAFi06Ssy92Ag7w+x
         b1ymj9rvvUZeElkCZYaap0lMQYE0fDxGMDVpOK0t4EtR15+/vTCl0S6VuL6WI3kc9OjW
         QIWOq07kmGWlo9D3NK6Wqmjyn+yYM8iESAA/NOW/uhgAB7GWCZJTABNlChrR751YHupy
         TeSeEAak/7TVQuagwQbh+uNSfIsJjbHNGym3K88vvuEF1ml9axCFfVruFcxiA4HPutG3
         O1dw==
X-Gm-Message-State: AIkVDXKv8wFNcfPqHK76Pwbd5wWnLMUPNsJQ+HULgdz6dE3MPvEIZQqlKu0W0hGKf9gMAw==
X-Received: by 10.84.137.169 with SMTP id 38mr61969765pln.128.1482803989984;
        Mon, 26 Dec 2016 17:59:49 -0800 (PST)
Received: from localhost.localdomain ([125.130.116.2])
        by smtp.gmail.com with ESMTPSA id q5sm9238749pgf.45.2016.12.26.17.59.47
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 26 Dec 2016 17:59:49 -0800 (PST)
From:   Jaedon Shin <jaedon.shin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     Kevin Cernekee <cernekee@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, Jaedon Shin <jaedon.shin@gmail.com>
Subject: [PATCH 0/2] Add Broadcom STB SPI support
Date:   Tue, 27 Dec 2016 10:59:21 +0900
Message-Id: <20161227015923.882-1-jaedon.shin@gmail.com>
X-Mailer: git-send-email 2.11.0
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56123
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

Jaedon Shin (2):
  spi: bcm-qspi: Enable the driver on BMIPS_GENERIC
  MIPS: BMIPS: Add support SPI device nodes

 arch/mips/boot/dts/brcm/bcm7125.dtsi      | 55 +++++++++++++++++++++++++++++--
 arch/mips/boot/dts/brcm/bcm7346.dtsi      | 49 +++++++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm7358.dtsi      | 49 +++++++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm7360.dtsi      | 49 +++++++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm7362.dtsi      | 49 +++++++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm7420.dtsi      | 55 +++++++++++++++++++++++++++++--
 arch/mips/boot/dts/brcm/bcm7425.dtsi      | 49 +++++++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm7435.dtsi      | 49 +++++++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm97125cbmb.dts  |  4 +++
 arch/mips/boot/dts/brcm/bcm97346dbsmb.dts |  4 +++
 arch/mips/boot/dts/brcm/bcm97358svmb.dts  | 36 ++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm97360svmb.dts  | 36 ++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm97362svmb.dts  |  4 +++
 arch/mips/boot/dts/brcm/bcm97420c.dts     |  4 +++
 arch/mips/boot/dts/brcm/bcm97425svmb.dts  | 36 ++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm97435svmb.dts  |  4 +++
 drivers/spi/Kconfig                       |  3 +-
 17 files changed, 528 insertions(+), 7 deletions(-)

-- 
2.11.0
