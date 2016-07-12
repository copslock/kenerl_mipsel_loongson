Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Jul 2016 20:18:43 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:59586 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993518AbcGLSSghjWJj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 12 Jul 2016 20:18:36 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <steven.hill@cavium.com>)
        id 1bN276-0001eN-Ip; Tue, 12 Jul 2016 13:08:56 -0500
Subject: [PATCH V8 0/2] mmc: OCTEON: Add OCTEON MMC controller.
To:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@linux-mips.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>
From:   "Steven J. Hill" <steven.hill@cavium.com>
Message-ID: <5785346E.8020702@cavium.com>
Date:   Tue, 12 Jul 2016 13:18:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <steven.hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54299
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: steven.hill@cavium.com
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

The OCTEON MMC controller is currently found on cn61XX and cnf71XX
devices. Device parameters are configured from device tree data.

The MMC controller can be connected to up to 4 "slots" which may be
eMMC, MMC or SD card devices. As there is a single controller, each
available slot is represented as a child node of the controller.

This MMC driver is the product of previous versions and discussions
which can be found at the below URLs.

[V7] https://patchwork.linux-mips.org/patch/12566/
     https://patchwork.linux-mips.org/patch/12567/
[V6] https://patchwork.linux-mips.org/patch/12538/
     https://patchwork.linux-mips.org/patch/12539/
     https://patchwork.linux-mips.org/patch/12540/
[V5] https://patchwork.linux-mips.org/patch/12533/
[V4] https://patchwork.linux-mips.org/patch/9558/
[V3] https://patchwork.linux-mips.org/patch/9462/
[V2] https://patchwork.linux-mips.org/patch/9086/
[V1] https://patchwork.linux-mips.org/patch/9079/

Steven J. Hill (2):
  mmc: OCTEON: Add DT bindings for OCTEON MMC controller.
  mmc: OCTEON: Add host driver for OCTEON MMC controller.

 .../devicetree/bindings/mmc/octeon-mmc.txt         |   72 ++
 drivers/mmc/host/Kconfig                           |   10 +
 drivers/mmc/host/Makefile                          |    1 +
 drivers/mmc/host/octeon_mmc.c                      | 1331 ++++++++++++++++++++
 4 files changed, 1414 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/octeon-mmc.txt
 create mode 100644 drivers/mmc/host/octeon_mmc.c

-- 
1.9.1
