Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Aug 2013 11:14:45 +0200 (CEST)
Received: from mms1.broadcom.com ([216.31.210.17]:1124 "EHLO mms1.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6816384Ab3HKJNaAy9wj (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 11 Aug 2013 11:13:30 +0200
Received: from [10.9.208.53] by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Sun, 11 Aug 2013 02:09:17 -0700
X-Server-Uuid: 06151B78-6688-425E-9DE2-57CB27892261
Received: from IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) by
 IRVEXCHCAS06.corp.ad.broadcom.com (10.9.208.53) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Sun, 11 Aug 2013 02:13:08 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) with Microsoft SMTP
 Server id 14.1.438.0; Sun, 11 Aug 2013 02:13:08 -0700
Received: from netl-snoppy.ban.broadcom.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 73E12F2D72; Sun, 11
 Aug 2013 02:13:07 -0700 (PDT)
From:   "Jayachandran C" <jchandra@broadcom.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
cc:     "Jayachandran C" <jchandra@broadcom.com>
Subject: [PATCH 00/10] Netlogic updates for 3.12
Date:   Sun, 11 Aug 2013 14:43:50 +0530
Message-ID: <1376212440-21038-1-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
X-WSS-ID: 7E198B3731W83115087-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37513
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jchandra@broadcom.com
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

The main update is adding support for XLP 2XX SoCs
https://www.broadcom.com/products/Processors/Data-Center/XLP200-Series

The first few patches are minor updates.

JC.

Ganesan Ramalingam (4):
  MIPS: Netlogic: XLP2XX CPU and PIC frequency
  MIPS: Netlogic: XLP2xx update for I2C controller
  MIPS: Netlogic: Add support for USB on XLP2xx
  MIPS: Netlogic: built-in DTB for XLP2xx SoC boards

Jayachandran C (6):
  MIPS: Netlogic: Read memory from DRAM BARs
  MIPS: Netlogic: Remove memory section from built-in DT
  MIPS: Netlogic: Fix DT flash size parameter
  MIPS: Netlogic: Add support for XLP2XX
  MIPS: Netlogic: Call xlp_mmu_init on all threads
  MIPS: Netlogic: Core wakeup changes for XLP2XX

 arch/mips/include/asm/cpu.h                     |    1 +
 arch/mips/include/asm/netlogic/xlp-hal/bridge.h |    4 +
 arch/mips/include/asm/netlogic/xlp-hal/iomap.h  |   10 +
 arch/mips/include/asm/netlogic/xlp-hal/pic.h    |    5 +-
 arch/mips/include/asm/netlogic/xlp-hal/sys.h    |   31 +++
 arch/mips/include/asm/netlogic/xlp-hal/xlp.h    |   17 ++
 arch/mips/include/asm/netlogic/xlr/pic.h        |    2 +
 arch/mips/kernel/cpu-probe.c                    |    5 +
 arch/mips/netlogic/Kconfig                      |    9 +
 arch/mips/netlogic/common/smp.c                 |    4 +-
 arch/mips/netlogic/common/time.c                |    3 +-
 arch/mips/netlogic/dts/Makefile                 |    1 +
 arch/mips/netlogic/dts/xlp_evp.dts              |    9 +-
 arch/mips/netlogic/dts/xlp_fvp.dts              |  118 +++++++++++
 arch/mips/netlogic/dts/xlp_svp.dts              |    9 +-
 arch/mips/netlogic/xlp/Makefile                 |    1 +
 arch/mips/netlogic/xlp/dt.c                     |    8 +-
 arch/mips/netlogic/xlp/nlm_hal.c                |  237 +++++++++++++++++++----
 arch/mips/netlogic/xlp/setup.c                  |   50 ++++-
 arch/mips/netlogic/xlp/usb-init-xlp2.c          |  218 +++++++++++++++++++++
 arch/mips/netlogic/xlp/usb-init.c               |    3 +
 arch/mips/netlogic/xlp/wakeup.c                 |   10 +-
 22 files changed, 686 insertions(+), 69 deletions(-)
 create mode 100644 arch/mips/netlogic/dts/xlp_fvp.dts
 create mode 100644 arch/mips/netlogic/xlp/usb-init-xlp2.c

-- 
1.7.9.5
