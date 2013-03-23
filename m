Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 Mar 2013 19:26:30 +0100 (CET)
Received: from mms1.broadcom.com ([216.31.210.17]:2482 "EHLO mms1.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6834828Ab3CWS02hZ5M4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 23 Mar 2013 19:26:28 +0100
Received: from [10.9.208.53] by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Sat, 23 Mar 2013 11:23:24 -0700
X-Server-Uuid: 06151B78-6688-425E-9DE2-57CB27892261
Received: from IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) by
 IRVEXCHCAS06.corp.ad.broadcom.com (10.9.208.53) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Sat, 23 Mar 2013 11:26:10 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) with Microsoft SMTP
 Server id 14.1.438.0; Sat, 23 Mar 2013 11:26:10 -0700
Received: from netl-snoppy.ban.broadcom.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id B92653928A; Sat, 23
 Mar 2013 11:26:09 -0700 (PDT)
From:   "Jayachandran C" <jchandra@broadcom.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
cc:     "Jayachandran C" <jchandra@broadcom.com>
Subject: [PATCH 0/9] Netlogic updates for 3.10
Date:   Sat, 23 Mar 2013 23:57:52 +0530
Message-ID: <cover.1364056573.git.jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
X-WSS-ID: 7D532C962U83293277-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-archive-position: 35951
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
Return-Path: <linux-mips-bounce@linux-mips.org>

The main changes are to add 32-bit support and to provide a way to
build in multiple device trees (one for each major variant of XLP).
The rest are cleanups and fixes.

JC.

Jayachandran C (9):
  MIPS: Netlogic: Optimize and fix write_c0_eimr()
  MIPS: Netlogic: Remove unused EIMR/EIRR functions
  MIPS: Netlogic: print cpumask with cpumask_scnprintf
  MIPS: Netlogic: Avoid using fixed PIC IRT index
  MIPS: Netlogic: Add 32-bit support for XLP
  MIPS: Netlogic: Remove unused code
  MIPS: Netlogic: Support for multiple built-in device trees
  MIPS: Netlogic: Merge platform usb.h to usb-init.c
  MIPS: Netlogic: Fix oprofile compile on XLR uniprocessor

 arch/mips/include/asm/netlogic/haldefs.h     |   92 ++++++++++---------
 arch/mips/include/asm/netlogic/mips-extns.h  |   20 ++---
 arch/mips/include/asm/netlogic/xlp-hal/pic.h |   53 -----------
 arch/mips/include/asm/netlogic/xlp-hal/usb.h |   64 -------------
 arch/mips/netlogic/Kconfig                   |   17 +++-
 arch/mips/netlogic/common/smp.c              |   21 +++--
 arch/mips/netlogic/dts/Makefile              |    1 +
 arch/mips/netlogic/dts/xlp_evp.dts           |    2 +-
 arch/mips/netlogic/dts/xlp_svp.dts           |  124 ++++++++++++++++++++++++++
 arch/mips/netlogic/xlp/nlm_hal.c             |   62 ++++++++-----
 arch/mips/netlogic/xlp/setup.c               |   22 ++++-
 arch/mips/netlogic/xlp/usb-init.c            |   49 +++++++---
 arch/mips/oprofile/op_model_mipsxx.c         |    2 +-
 13 files changed, 303 insertions(+), 226 deletions(-)
 delete mode 100644 arch/mips/include/asm/netlogic/xlp-hal/usb.h
 create mode 100644 arch/mips/netlogic/dts/xlp_svp.dts

-- 
1.7.9.5
