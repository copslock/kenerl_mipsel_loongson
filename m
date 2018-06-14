Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Jun 2018 01:53:33 +0200 (CEST)
Received: from 9pmail.ess.barracuda.com ([64.235.154.211]:35868 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994672AbeFNXx0kjgNb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 Jun 2018 01:53:26 +0200
Received: from mipsdag01.mipstec.com (mail1.mips.com [12.201.5.31]) by mx1401.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=NO); Thu, 14 Jun 2018 23:52:55 +0000
Received: from mipsdag02.mipstec.com (10.20.40.47) by mipsdag01.mipstec.com
 (10.20.40.46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1415.2; Thu, 14
 Jun 2018 16:53:07 -0700
Received: from pburton-laptop.mipstec.com (10.20.2.29) by
 mipsdag02.mipstec.com (10.20.40.47) with Microsoft SMTP Server id 15.1.1415.2
 via Frontend Transport; Thu, 14 Jun 2018 16:53:07 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     <linux-mips@linux-mips.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        James Hogan <jhogan@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>
Subject: [PATCH 0/4] MIPS: Restartable sequences (rseq) support
Date:   Thu, 14 Jun 2018 16:52:06 -0700
Message-ID: <20180614235211.31357-1-paul.burton@mips.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-BESS-ID: 1529020375-321457-11388-11694-1
X-BESS-VER: 2018.7-r1806112253
X-BESS-Apparent-Source-IP: 12.201.5.31
X-BESS-Envelope-From: Paul.Burton@mips.com
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.194071
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-Orig-Rcpt: linux-mips@linux-mips.org,peterz@infradead.org,jhogan@kernel.org,linux-kernel@vger.kernel.org,mathieu.desnoyers@efficios.com,boqun.feng@gmail.com,paulmck@linux.vnet.ibm.com,ralf@linux-mips.org
X-BESS-BRTS-Status: 1
Return-Path: <Paul.Burton@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64272
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

This series implements MIPS support for restartable sequences, hooks up
the rseq syscall & implements MIPS support in the rseq selftests.

Applies atop Linus' master as of 2837461dbe6f ("Merge tag 'scsi-fixes'
of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi").

Thanks,
    Paul

Paul Burton (4):
  MIPS: Add support for restartable sequences
  MIPS: Add syscall detection for restartable sequences
  MIPS: Wire up the restartable sequences (rseq) syscall
  rseq/selftests: Implement MIPS support

 arch/mips/Kconfig                         |   1 +
 arch/mips/include/uapi/asm/unistd.h       |  15 +-
 arch/mips/kernel/entry.S                  |   8 +
 arch/mips/kernel/scall32-o32.S            |   1 +
 arch/mips/kernel/scall64-64.S             |   1 +
 arch/mips/kernel/scall64-n32.S            |   1 +
 arch/mips/kernel/scall64-o32.S            |   1 +
 arch/mips/kernel/signal.c                 |   3 +
 tools/testing/selftests/rseq/param_test.c |  24 +
 tools/testing/selftests/rseq/rseq-mips.h  | 725 ++++++++++++++++++++++
 tools/testing/selftests/rseq/rseq.h       |   2 +
 11 files changed, 776 insertions(+), 6 deletions(-)
 create mode 100644 tools/testing/selftests/rseq/rseq-mips.h

-- 
2.17.1
