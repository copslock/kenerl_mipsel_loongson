Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Sep 2016 23:11:48 +0200 (CEST)
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:55968 "EHLO
        emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992029AbcIBVLlgLWNg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 Sep 2016 23:11:41 +0200
Received: from localhost.localdomain (85-76-72-196-nat.elisa-mobile.fi [85.76.72.196])
        by emh07.mail.saunalahti.fi (Postfix) with ESMTP id C50FB4086;
        Sat,  3 Sep 2016 00:11:40 +0300 (EEST)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 0/3] MIPS: OCTEON: Add support for D-Link DSR-500N router
Date:   Sat,  3 Sep 2016 00:11:33 +0300
Message-Id: <20160902211136.8610-1-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.9.2
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55026
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

Hi,

D-Link DSR-500N is close to 1000N and with small changes we
can support both.

A.

Aaro Koskinen (3):
  MIPS: OCTEON: split dlink_dsr-1000n.dts
  MIPS: OCTEON: add DTS for D-Link DSR-500N
  MIPS: OCTEON: fix PCI interrupt routing on D-Link DSR-500N

 .../boot/dts/cavium-octeon/dlink_dsr-1000n.dts     | 45 +----------------
 .../dts/cavium-octeon/dlink_dsr-500n-1000n.dtsi    | 58 ++++++++++++++++++++++
 .../mips/boot/dts/cavium-octeon/dlink_dsr-500n.dts | 42 ++++++++++++++++
 arch/mips/pci/pci-octeon.c                         |  2 +
 4 files changed, 103 insertions(+), 44 deletions(-)
 create mode 100644 arch/mips/boot/dts/cavium-octeon/dlink_dsr-500n-1000n.dtsi
 create mode 100644 arch/mips/boot/dts/cavium-octeon/dlink_dsr-500n.dts

-- 
2.9.2
