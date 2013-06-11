Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Jun 2013 17:41:04 +0200 (CEST)
Received: from mms2.broadcom.com ([216.31.210.18]:4863 "EHLO mms2.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6835168Ab3FKPk3T0run (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 11 Jun 2013 17:40:29 +0200
Received: from [10.9.208.57] by mms2.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Tue, 11 Jun 2013 08:34:30 -0700
X-Server-Uuid: 4500596E-606A-40F9-852D-14843D8201B2
Received: from IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) by
 IRVEXCHCAS08.corp.ad.broadcom.com (10.9.208.57) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Tue, 11 Jun 2013 08:40:12 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) with Microsoft SMTP
 Server id 14.1.438.0; Tue, 11 Jun 2013 08:40:12 -0700
Received: from netl-snoppy.ban.broadcom.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 9BF05F2D86; Tue, 11
 Jun 2013 08:40:08 -0700 (PDT)
From:   "Jayachandran C" <jchandra@broadcom.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
cc:     "Jayachandran C" <jchandra@broadcom.com>
Subject: [PATCH 0/4] Use scratch registers on XLR/XLS/XLP
Date:   Tue, 11 Jun 2013 21:11:34 +0530
Message-ID: <1370965298-29210-1-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
X-WSS-ID: 7DA99C0C1R029932295-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36832
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

This set of patches enable the use of scratch registers on XLR/XLS and XLP
(cop0 reg 22, sel 0-7) to optimize the generated TLB handlers.

The current code assumes scratch is 31, which is fixed by the first patch.
The second patch fixes a minor issue in checking if scratch is allocated.
The third patch enables use of a scratch register when it is available
even on a 32-bit or non-r2 platform. The fourth patch is a cleanup to 
consolidate all the defines needed into one file, this patch does not
have any change in logic.

In the earlier scheme, if MIPS_PGD_C0_CONTEXT was defined, the Context
register or a scratch register would contain the current PGD, and the
Xcontext would contain the smp_processor_id shifted to index pointers.

In the new scheme, the behavior when MIPS_PGD_C0_CONTEXT is defined
remains the same.  But when it is not defined, we still try to allocate
a scratch register for the current pgd and the smp processor id remains
in Context.

There is also an additional change is to generate the
tlbmiss_handler_setup_pgd() function even when MIPS_PGD_C0_CONTEXT is not
defined.  This function will save the PGD in pgd_current[] and also in
the scratch register if one has been allocated.

Comments/testing welcome.

Thanks,
JC.

Changes in v3:
* Add patch 2 - fix up  check for a valid scratch register

Changes in v2:
* Update macros in thread-info.h, remove __ASSEMBLY__ part
* add ASM_CPUID_MFC0 and UASM_i_CPUID_MFC0 which allows us to remove
  a lot of conditional compilation.
* make c0_kscratch a inline function and remove global variable

Jayachandran C (4):
  MIPS: Allow platform specific scratch registers
  MIPS: Fixup check for invalid scratch register
  MIPS: mm: Use scratch for PGD when !CONFIG_MIPS_PGD_C0_CONTEXT
  MIPS: Move definition of SMP processor id register to header file

 arch/mips/include/asm/mmu_context.h |   22 ++---
 arch/mips/include/asm/stackframe.h  |   24 ++---
 arch/mips/include/asm/thread_info.h |   30 +++++-
 arch/mips/kernel/cpu-probe.c        |    1 +
 arch/mips/mm/tlbex.c                |  186 +++++++++++++++++------------------
 5 files changed, 132 insertions(+), 131 deletions(-)

-- 
1.7.9.5
