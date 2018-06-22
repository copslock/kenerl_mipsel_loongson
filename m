Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Jun 2018 19:56:12 +0200 (CEST)
Received: from 9pmail.ess.barracuda.com ([64.235.154.210]:41228 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993852AbeFVR4Evts6O (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 Jun 2018 19:56:04 +0200
Received: from mipsdag01.mipstec.com (mail1.mips.com [12.201.5.31]) by mx1402.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=NO); Fri, 22 Jun 2018 17:55:56 +0000
Received: from mipsdag02.mipstec.com (10.20.40.47) by mipsdag01.mipstec.com
 (10.20.40.46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1415.2; Fri, 22
 Jun 2018 10:55:49 -0700
Received: from pburton-laptop.mipstec.com (10.20.2.29) by
 mipsdag02.mipstec.com (10.20.40.47) with Microsoft SMTP Server id 15.1.1415.2
 via Frontend Transport; Fri, 22 Jun 2018 10:55:49 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     <linux-mips@linux-mips.org>
CC:     Huacai Chen <chenhc@lemote.com>,
        Paul Burton <paul.burton@mips.com>,
        "Ralf Baechle" <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>
Subject: [PATCH 0/3] MIPS: Fix arch_trigger_cpumask_backtrace(), clean up output
Date:   Fri, 22 Jun 2018 10:55:44 -0700
Message-ID: <20180622175547.17716-1-paul.burton@mips.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-BESS-ID: 1529690136-321458-14409-5864-6
X-BESS-VER: 2018.7-r1806151722
X-BESS-Apparent-Source-IP: 12.201.5.31
X-BESS-Envelope-From: Paul.Burton@mips.com
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.194338
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-Orig-Rcpt: linux-mips@linux-mips.org,chenhc@lemote.com,ralf@linux-mips.org,jhogan@kernel.org
X-BESS-BRTS-Status: 1
Return-Path: <Paul.Burton@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64413
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@mips.com
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

This series switches MIPS to use the generic
nmi_trigger_cpumask_backtrace() infrastructure to back
arch_trigger_cpumask_backtrace(), switching from synchronous to
asynchronous IPIs in the process in order to resolve possible deadlock
conditions. With the generic infrastructure in use we start using the
__cpuidle annotation to clean up its output for idle CPUs.

Applies cleanly atop master as of 894b8c000ae6 ("Merge tag
'for_v4.18-rc2' of
git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs").

Thanks,
    Paul

Paul Burton (3):
  MIPS: Call dump_stack() from show_regs()
  MIPS: Use async IPIs for arch_trigger_cpumask_backtrace()
  MIPS: Annotate cpu_wait implementations with __cpuidle

 arch/mips/kernel/idle.c       | 12 +++++-----
 arch/mips/kernel/process.c    | 43 +++++++++++++++++++++++------------
 arch/mips/kernel/traps.c      |  1 +
 arch/mips/vr41xx/common/pmu.c |  3 ++-
 4 files changed, 38 insertions(+), 21 deletions(-)

-- 
2.17.1
