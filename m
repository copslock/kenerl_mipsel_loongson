Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Feb 2018 11:33:23 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.150.224]:58509 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994673AbeBTKdPQ1k6l (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Feb 2018 11:33:15 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx2.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Tue, 20 Feb 2018 10:32:58 +0000
Received: from mredfearn-linux.mipstec.com (10.150.130.83) by
 MIPSMAIL01.mipstec.com (10.20.43.31) with Microsoft SMTP Server (TLS) id
 14.3.361.1; Tue, 20 Feb 2018 02:32:36 -0800
From:   Matt Redfearn <matt.redfearn@mips.com>
To:     James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>,
        Matt Redfearn <matt.redfearn@mips.com>,
        "Ying Huang" <ying.huang@intel.com>,
        <linux-kernel@vger.kernel.org>, Paul Burton <paul.burton@mips.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Matija Glavinic Pecotic" <matija.glavinic-pecotic.ext@nokia.com>
Subject: [PATCH 0/2] MIPS: CONFIG_SMP_SINGLE_IPI
Date:   Tue, 20 Feb 2018 10:32:21 +0000
Message-ID: <1519122743-4847-1-git-send-email-matt.redfearn@mips.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
X-BESS-ID: 1519122775-298553-23098-37464-12
X-BESS-VER: 2018.2-r1802152108
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 1.64
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.190214
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
        0.01 SUBJ_ALL_CAPS          META: Subject is all capitals 
        1.62 SUBJ_ALL_CAPS_2        META:  
X-BESS-Outbound-Spam-Status: SCORE=1.64 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, SUBJ_ALL_CAPS, SUBJ_ALL_CAPS_2
X-BESS-BRTS-Status: 1
Return-Path: <Matt.Redfearn@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62640
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@mips.com
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

This series adds a configuration option to allow MIPS kernels using
CONFIG_GENERIC_IRQ_IPI to use only a single IPI per CPU rather than the
usual 2. This allows these kernels to boot on hardware with insufficient
interrupts for the usual 2 / CPU.

It may also prove more flexible in allowing greater numbers of IPI
functions to be delivered without using up additional per CPU
interrupts. For example this mechanism may be extended to address the
potential for deadlock in arch_trigger_cpumask_backtrace recently
pointed out by Huacai Chen.


Matt Redfearn (2):
  MIPS: SMP: Group CONFIG_GENERIC_IRQ_IPI together
  MIPS: SMP: Introduce CONFIG_SMP_SINGLE_IPI

 arch/mips/Kconfig      |  11 +++++
 arch/mips/kernel/smp.c | 106 +++++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 110 insertions(+), 7 deletions(-)

-- 
2.7.4
