Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Mar 2013 17:25:54 +0100 (CET)
Received: from mms1.broadcom.com ([216.31.210.17]:4707 "EHLO mms1.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6826580Ab3CTQZseuBZc (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 20 Mar 2013 17:25:48 +0100
Received: from [10.9.208.57] by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Wed, 20 Mar 2013 09:22:50 -0700
X-Server-Uuid: 06151B78-6688-425E-9DE2-57CB27892261
Received: from IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) by
 IRVEXCHCAS08.corp.ad.broadcom.com (10.9.208.57) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Wed, 20 Mar 2013 09:25:35 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) with Microsoft SMTP
 Server id 14.1.438.0; Wed, 20 Mar 2013 09:25:35 -0700
Received: from netl-snoppy.ban.broadcom.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 91E3940FE4; Wed, 20
 Mar 2013 09:25:34 -0700 (PDT)
From:   "Jayachandran C" <jchandra@broadcom.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
cc:     "Jayachandran C" <jchandra@broadcom.com>
Subject: [PATCH v2 0/3] Use scratch registers on XLR/XLS/XLP
Date:   Wed, 20 Mar 2013 21:57:03 +0530
Message-ID: <cover.1363772750.git.jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
X-WSS-ID: 7D573DD02U81749430-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-archive-position: 35916
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
(cop0 reg 22, sel 0-7) to optimize the generated TLB handlers.

The current code assumes scratch is 31, which is fixed by the first patch.
The second patch enables use of a scratch register when it is available
even on a 32-bit or non-r2 platform. The third patch is a cleanup to 
consolidate all the defines needed into one file, this patch does not
have any change in logic.

In the earlier scheme, if MIPS_PGD_C0_CONTEXT was defined, the Context
register or a scratch register would contain the current PGD, and the
Xcontext would contain the smp_processor_id shifted to index pointers.

In the new scheme, the behavior when MIPS_PGD_C0_CONTEXT is defined
remains the same.  But when it is not defined, we still try to allocate
a scratch register for the current pgd. and the smp processor id remains
in Context.

There is also an additional change is to generate the
tlbmiss_handler_setup_pgd() function even when MIPS_PGD_C0_CONTEXT is not
defined.  This function will save the PGD in pgd_current[] and also in
the scratch register if one has been allocated.

Comments/testing welcome.

Thanks,
JC.

Changes in v2:
* Update macros in thread-info.h, remove __ASSEMBLY__ part
* add ASM_CPUID_MFC0 and UASM_i_CPUID_MFC0 which allows us to remove
  a lot of conditional compilation.
* make c0_kscratch a inline function and remove global variable


Jayachandran C (3):
  MIPS: Allow platform specific scratch registers
  MIPS: mm: Use scratch for PGD when !CONFIG_MIPS_PGD_C0_CONTEXT
  MIPS: Move definition of SMP processor id register to header file

 arch/mips/include/asm/mmu_context.h |   26 ++----
 arch/mips/include/asm/stackframe.h  |   26 ++----
 arch/mips/include/asm/thread_info.h |   30 +++++-
 arch/mips/kernel/cpu-probe.c        |    1 +
 arch/mips/mm/tlbex.c                |  176 +++++++++++++++++------------------
 5 files changed, 130 insertions(+), 129 deletions(-)

-- 
1.7.9.5
