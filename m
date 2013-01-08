Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Jan 2013 13:55:29 +0100 (CET)
Received: from mms3.broadcom.com ([216.31.210.19]:4336 "EHLO mms3.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823089Ab3AHMywyf64I (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 8 Jan 2013 13:54:52 +0100
Received: from [10.9.200.133] by mms3.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Tue, 08 Jan 2013 04:49:26 -0800
X-Server-Uuid: B86B6450-0931-4310-942E-F00ED04CA7AF
Received: from mail-irva-13.broadcom.com (10.11.16.103) by
 IRVEXCHHUB02.corp.ad.broadcom.com (10.9.200.133) with Microsoft SMTP
 Server id 8.2.247.2; Tue, 8 Jan 2013 04:54:17 -0800
Received: from netl-snoppy.ban.broadcom.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 2019F40FE4; Tue, 8
 Jan 2013 04:54:27 -0800 (PST)
From:   "Jayachandran C" <jchandra@broadcom.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
cc:     "Jayachandran C" <jchandra@broadcom.com>
Subject: [RFC PATCH 0/3] Use scratch registers on XLR/XLS/XLP
Date:   Tue, 8 Jan 2013 18:26:26 +0530
Message-ID: <1357649789-3423-1-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
X-WSS-ID: 7CF2CA5C39W24205961-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-archive-position: 35395
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

This set of patches enable the use of scratch registers on XLR/XLS and XLP
(cop0 reg 22, sel 0-7) to optimize the genearted TLB handlers.

The current code assumes scratch is 31, which is fixed by the first patch.
The second patch enables use of a scratch register when it is available,
even on a 32-bit or non-r2 platform. The third patch is a cleanup to 
consolidate all the defines needed into one file, this patch does not
have any change in logic.

In the earlier scheme, if MIPS_PGD_C0_CONTEXT was defined, the CP0 CONTEXT
register or a scratch register would contain the current PGD, and the
XCONTEXT would contain the smp_processor_id shifted to index pointers.

In the new scheme, the behavior when MIPS_PGD_C0_CONTEXT is defined
remains the same.  But when it is not defined, we tries to allocate
a scratch register for the current pgd, the smp processor id remains
in CONTEXT.

The additional change is generate tlbmiss_handler_setup_pgd() function
that stores pgd even when MIPS_PGD_C0_CONTEXT is not defined.  This
function will save the PGD in pgd_current[] and also in the scratch
register if one has been allocated.

Comments/testing welcome.

Thanks,
JC.

Jayachandran C (3):
  MIPS: Allow platform specific scratch registers
  MIPS: mm: Use scratch for PGD when !CONFIG_MIPS_PGD_C0_CONTEXT
  MIPS: Move definition of SMP processor id register to header file

 arch/mips/include/asm/mmu_context.h |   26 ++---
 arch/mips/include/asm/stackframe.h  |   25 ++---
 arch/mips/include/asm/thread_info.h |   33 +++++-
 arch/mips/kernel/cpu-probe.c        |    1 +
 arch/mips/kernel/genex.S            |    1 -
 arch/mips/mm/tlbex.c                |  188 ++++++++++++++++++-----------------
 6 files changed, 146 insertions(+), 128 deletions(-)

-- 
1.7.9.5
