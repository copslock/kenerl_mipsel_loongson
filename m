Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Aug 2013 13:39:45 +0200 (CEST)
Received: from mms1.broadcom.com ([216.31.210.17]:4094 "EHLO mms1.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6820116Ab3HKLjlnj7xO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 11 Aug 2013 13:39:41 +0200
Received: from [10.9.208.57] by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Sun, 11 Aug 2013 04:35:34 -0700
X-Server-Uuid: 06151B78-6688-425E-9DE2-57CB27892261
Received: from IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) by
 IRVEXCHCAS08.corp.ad.broadcom.com (10.9.208.57) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Sun, 11 Aug 2013 04:39:25 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) with Microsoft SMTP
 Server id 14.1.438.0; Sun, 11 Aug 2013 04:39:25 -0700
Received: from netl-snoppy.ban.broadcom.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 7D632F2D72; Sun, 11
 Aug 2013 04:39:24 -0700 (PDT)
From:   "Jayachandran C" <jchandra@broadcom.com>
To:     ralf@linux-mips.org, linux-mips@linux-mips.org
cc:     "Jayachandran C" <jchandra@broadcom.com>
Subject: [PATCH 0/2] Use scratch register for PGD when
 MIPS_PGD_C0_CONTEXT is not set
Date:   Sun, 11 Aug 2013 17:10:15 +0530
Message-ID: <1376221217-9335-1-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
X-WSS-ID: 7E19A88C31W83127545-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37523
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

These are the two pending patches in this series. I have reordered the
changes so that the cleanup patch can be applied first.

The second patch has the changes to use scratch registers when
MIPS_PGD_C0_CONTEXT is not defined - this has not changed.

JC.

Jayachandran C (2):
  MIPS: Move definition of SMP processor id register to header file
  MIPS: mm: Use scratch for PGD when !CONFIG_MIPS_PGD_C0_CONTEXT

 arch/mips/include/asm/mmu_context.h |   22 ++----
 arch/mips/include/asm/stackframe.h  |   24 ++-----
 arch/mips/include/asm/thread_info.h |   33 ++++++++-
 arch/mips/mm/tlbex.c                |  136 +++++++++++++++--------------------
 4 files changed, 103 insertions(+), 112 deletions(-)

-- 
1.7.9.5
