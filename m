Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 01 Aug 2015 14:03:42 +0200 (CEST)
Received: from mail-gw2-out.broadcom.com ([216.31.210.63]:38797 "EHLO
        mail-gw2-out.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010828AbbHAMDlBeoAt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 1 Aug 2015 14:03:41 +0200
X-IronPort-AV: E=Sophos;i="5.15,591,1432623600"; 
   d="scan'208";a="71359081"
Received: from irvexchcas08.broadcom.com (HELO IRVEXCHCAS08.corp.ad.broadcom.com) ([10.9.208.57])
  by mail-gw2-out.broadcom.com with ESMTP; 01 Aug 2015 05:22:50 -0700
Received: from IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) by
 IRVEXCHCAS08.corp.ad.broadcom.com (10.9.208.57) with Microsoft SMTP Server
 (TLS) id 14.3.235.1; Sat, 1 Aug 2015 05:03:32 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) with Microsoft SMTP Server id
 14.3.235.1; Sat, 1 Aug 2015 05:03:31 -0700
Received: from netl-snoppy.ban.broadcom.com (unknown [10.132.128.129])  by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 75F9340FE5;  Sat,  1 Aug
 2015 05:01:16 -0700 (PDT)
From:   Jayachandran C <jchandra@broadcom.com>
To:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>
CC:     Jayachandran C <jchandra@broadcom.com>
Subject: [PATCH 0/4] Netlogic updates for 4.3
Date:   Sat, 1 Aug 2015 17:44:19 +0530
Message-ID: <1438431263-12427-1-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48521
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

Some updates and fixes for the netlogic platform. The first patch
is to update interrupt controller code to use chip_data. Other minor
patches are to update dts files to use the GPIO controller (which
now upstream) and to add NAND interrupt mapping.

JC.

Kamlakant Patel (3):
  MIPS: Netlogic: Use chip_data for irq_chip methods
  MIPS: Netlogic: add device tree entry for XLP GPIO
  MIPS: Netlogic: enable ARCH_REQUIRE_GPIOLIB for XLP platform

Subhendu Sekhar Behera (1):
  MIPS: Netlogic: NAND IRQ mapping

 arch/mips/Kconfig                       |  1 +
 arch/mips/boot/dts/netlogic/xlp_evp.dts | 12 ++++++++++++
 arch/mips/boot/dts/netlogic/xlp_fvp.dts | 12 ++++++++++++
 arch/mips/boot/dts/netlogic/xlp_gvp.dts | 11 +++++++++++
 arch/mips/boot/dts/netlogic/xlp_rvp.dts | 11 +++++++++++
 arch/mips/boot/dts/netlogic/xlp_svp.dts | 12 ++++++++++++
 arch/mips/netlogic/common/irq.c         | 12 ++++++------
 arch/mips/netlogic/xlp/nlm_hal.c        |  2 ++
 arch/mips/pci/msi-xlp.c                 | 20 ++++++++++----------
 9 files changed, 77 insertions(+), 16 deletions(-)

-- 
1.9.1
