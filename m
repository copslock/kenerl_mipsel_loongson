Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Jun 2013 09:41:08 +0200 (CEST)
Received: from mms1.broadcom.com ([216.31.210.17]:4694 "EHLO mms1.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6817528Ab3FJHkDg2E0x (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 10 Jun 2013 09:40:03 +0200
Received: from [10.9.208.57] by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Mon, 10 Jun 2013 00:36:07 -0700
X-Server-Uuid: 06151B78-6688-425E-9DE2-57CB27892261
Received: from IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) by
 IRVEXCHCAS08.corp.ad.broadcom.com (10.9.208.57) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Mon, 10 Jun 2013 00:39:46 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) with Microsoft SMTP
 Server id 14.1.438.0; Mon, 10 Jun 2013 00:39:46 -0700
Received: from netl-snoppy.ban.broadcom.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 7A7BAF2D77; Mon, 10
 Jun 2013 00:39:45 -0700 (PDT)
From:   "Jayachandran C" <jchandra@broadcom.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
cc:     "Jayachandran C" <jchandra@broadcom.com>
Subject: [PATCH 00/11] Netlogic XLP updates for 3.11
Date:   Mon, 10 Jun 2013 13:10:59 +0530
Message-ID: <1370850070-5127-1-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
X-WSS-ID: 7DAB5E6D31W33902802-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36782
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

The major changes are: 
* Move cpu initialization and reset code to a separate file that can be
  used in the uniprocessor case.
* Move device tree code to a separate file

The rest are fixes and minor cleanups to the existing code.

Regards,
JC.

Jayachandran C (11):
  MIPS: Netlogic: Split XLP device tree code to dt.c
  MIPS: Netlogic: Split reset code out of smpboot.S
  MIPS: Netlogic: Initialization when !CONFIG_SMP
  MIPS: Netlogic: Add nlm_get_boot_data() helper
  MIPS: Netlogic: move cpu_ready array to boot area
  MIPS: Netlogic: use branch instead of jump
  MIPS: Netlogic: Fix sign extension in PIC write
  MIPS: Netlogic: wait for all hardware threads
  MIPS: Netlogic: Fixup memory regions for prefetch
  MIPS: Netlogic: Remove workarounds for early SoCs
  MIPS: Netlogic: Fix plat_irq_dispatch

 arch/mips/include/asm/netlogic/common.h      |   18 +-
 arch/mips/include/asm/netlogic/xlp-hal/pic.h |    2 +-
 arch/mips/include/asm/netlogic/xlp-hal/xlp.h |    1 +
 arch/mips/netlogic/common/Makefile           |    1 +
 arch/mips/netlogic/common/irq.c              |    7 +-
 arch/mips/netlogic/common/reset.S            |  230 ++++++++++++++++++++++++++
 arch/mips/netlogic/common/smp.c              |   18 +-
 arch/mips/netlogic/common/smpboot.S          |  194 +---------------------
 arch/mips/netlogic/xlp/Makefile              |    2 +-
 arch/mips/netlogic/xlp/dt.c                  |   99 +++++++++++
 arch/mips/netlogic/xlp/setup.c               |   95 +++--------
 arch/mips/netlogic/xlp/wakeup.c              |   26 ++-
 arch/mips/netlogic/xlr/setup.c               |    7 +
 arch/mips/netlogic/xlr/wakeup.c              |    3 +-
 14 files changed, 417 insertions(+), 286 deletions(-)
 create mode 100644 arch/mips/netlogic/common/reset.S
 create mode 100644 arch/mips/netlogic/xlp/dt.c

-- 
1.7.9.5
