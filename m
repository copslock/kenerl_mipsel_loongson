Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Mar 2013 17:23:43 +0100 (CET)
Received: from mms1.broadcom.com ([216.31.210.17]:1548 "EHLO mms1.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823037Ab3CVQXg4dWR6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 22 Mar 2013 17:23:36 +0100
Received: from [10.9.208.57] by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Fri, 22 Mar 2013 09:20:32 -0700
X-Server-Uuid: 06151B78-6688-425E-9DE2-57CB27892261
Received: from IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) by
 IRVEXCHCAS08.corp.ad.broadcom.com (10.9.208.57) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Fri, 22 Mar 2013 09:23:18 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) with Microsoft SMTP
 Server id 14.1.438.0; Fri, 22 Mar 2013 09:23:18 -0700
Received: from netl-snoppy.ban.broadcom.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 410F23928A; Fri, 22
 Mar 2013 09:23:17 -0700 (PDT)
From:   "Jayachandran C" <jchandra@broadcom.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        ddaney.cavm@gmail.com
cc:     "Jayachandran C" <jchandra@broadcom.com>
Subject: [RFC PATCH 0/5] Cop2 save/restore for XLR/XLP
Date:   Fri, 22 Mar 2013 21:54:57 +0530
Message-ID: <cover.1363966534.git.jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
X-WSS-ID: 7D525B5A2U82605581-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-archive-position: 35939
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

This patchset is to generalize the COP2 save/restore implemented for
Octeon and use it for Netlogic XLR/XLP.

Patch 1 and 2 of the series affects the Octeon platform as well, so please
let me know if there are any suggestions/comments.

Thanks,
JC.

Jayachandran C (5):
  MIPS: Move cop2 save/restore to switch_to()
  MIPS: Allow kernel to use coprocessor 2
  MIPS: Netlogic: Fix nlm_read_c2_status() definition
  MIPS: Netlogic: rename nlm_cop2_save/restore
  MIPS: Netlogic: COP2 save/restore code

 arch/mips/include/asm/cop2.h             |   29 ++++++++
 arch/mips/include/asm/netlogic/xlr/fmn.h |   13 ++--
 arch/mips/include/asm/processor.h        |   30 +++++---
 arch/mips/include/asm/switch_to.h        |   19 ++++-
 arch/mips/kernel/octeon_switch.S         |   27 -------
 arch/mips/kernel/traps.c                 |   15 ++--
 arch/mips/netlogic/common/Makefile       |    1 +
 arch/mips/netlogic/common/cop2-ex.c      |  113 ++++++++++++++++++++++++++++++
 arch/mips/netlogic/xlr/fmn.c             |   18 ++---
 9 files changed, 202 insertions(+), 63 deletions(-)
 create mode 100644 arch/mips/netlogic/common/cop2-ex.c

-- 
1.7.9.5
