Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 23 Jun 2013 20:17:20 +0200 (CEST)
Received: from mms3.broadcom.com ([216.31.210.19]:1172 "EHLO mms3.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6816209Ab3FWSQhAAVLb (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 23 Jun 2013 20:16:37 +0200
Received: from [10.9.208.55] by mms3.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Sun, 23 Jun 2013 11:07:07 -0700
X-Server-Uuid: B86B6450-0931-4310-942E-F00ED04CA7AF
Received: from IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) by
 IRVEXCHCAS07.corp.ad.broadcom.com (10.9.208.55) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Sun, 23 Jun 2013 11:16:19 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) with Microsoft SMTP
 Server id 14.1.438.0; Sun, 23 Jun 2013 11:16:19 -0700
Received: from netl-snoppy.ban.broadcom.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 44C53F2D73; Sun, 23
 Jun 2013 11:16:18 -0700 (PDT)
From:   "Jayachandran C" <jchandra@broadcom.com>
To:     ralf@linux-mips.org, linux-mips@linux-mips.org
cc:     "Jayachandran C" <jchandra@broadcom.com>
Subject: [PATCH 0/3] Use scratch registers when MIPS_PGD_C0_CONTEXT is
 not set
Date:   Sun, 23 Jun 2013 23:46:18 +0530
Message-ID: <1372011381-18600-1-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
X-WSS-ID: 7DD9E6C12L837159471-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37107
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

This is the updated patchset that fixes issues reported during the last
merge to upstream-sfr.

The first patch is a new change that moves the TLB handlers from arrays
in .data to functions defined in tlb-funcs.S to fix the microMIPS issue
reported.
(http://www.linux-mips.org/archives/linux-mips/2013-06/msg00415.html)

The second patch has the changes to use scratch registers when
MIPS_PGD_C0_CONTEXT is not defined - this has not changed.

The third has a fix for the compile error  on IP27 platform.
(http://www.linux-mips.org/archives/linux-mips/2013-06/msg00399.html)

Jonas already has posted http://patchwork.linux-mips.org/patch/5539/ for
the other issue (crash on bcm63xx and mti platforms)

JC.

Jayachandran C (3):
  MIPS: Move generated code to .text for microMIPS
  MIPS: mm: Use scratch for PGD when !CONFIG_MIPS_PGD_C0_CONTEXT
  MIPS: Move definition of SMP processor id register to header file

 arch/mips/include/asm/mmu_context.h |   28 ++---
 arch/mips/include/asm/stackframe.h  |   24 +---
 arch/mips/include/asm/thread_info.h |   33 +++++-
 arch/mips/mm/Makefile               |    2 +-
 arch/mips/mm/tlb-funcs.S            |   37 ++++++
 arch/mips/mm/tlbex.c                |  224 ++++++++++++++++-------------------
 6 files changed, 187 insertions(+), 161 deletions(-)
 create mode 100644 arch/mips/mm/tlb-funcs.S

-- 
1.7.9.5
