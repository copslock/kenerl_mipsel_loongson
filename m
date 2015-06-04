Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Jun 2015 12:56:32 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:27390 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007193AbbFDK4bRFicN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Jun 2015 12:56:31 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 088CE417692DE;
        Thu,  4 Jun 2015 11:56:23 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 4 Jun 2015 11:56:25 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.48) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Thu, 4 Jun 2015 11:56:24 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>,
        <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@plumgrid.com>,
        Daniel Borkmann <dborkman@redhat.com>,
        "Hannes Frederic Sowa" <hannes@stressinduktion.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/6] MIPS/BPF fixes for 4.3
Date:   Thu, 4 Jun 2015 11:56:10 +0100
Message-ID: <1433415376-20952-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.4.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.48]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47849
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

Hi,

Here are some fixes for MIPS/BPF. The first 5 patches do some cleanup
and lay the groundwork for the final one which introduces assembly helpers
for MIPS and MIPS64. The goal is to speed up certain operations that do
not need to go through the common C functions. This also makes the test_bpf
testsuite happy with all 60 tests passing. This is based in 4.1-rc6.

The patchset is also available in my git tree.

https://github.com/hwoarang/linux/tree/4.3-bpf

The last patch also contains performance results along with the relevant
scripts and data used for the analysis.

Markos Chandras (6):
  MIPS: net: BPF: Free up some callee-saved registers
  MIPS: net: BPF: Replace RSIZE with SZREG
  MIPS: net: BPF: Fix stack pointer allocation
  MIPS: net: BPF: Move register definition to the BPF header
  MIPS: net: BPF: Use BPF register names to describe the ABI
  MIPS: net: BPF: Introduce BPF ASM helpers

 arch/mips/net/Makefile      |   2 +-
 arch/mips/net/bpf_jit.c     | 268 ++++++++++++--------------------------------
 arch/mips/net/bpf_jit.h     |  42 ++++++-
 arch/mips/net/bpf_jit_asm.S | 238 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 350 insertions(+), 200 deletions(-)
 create mode 100644 arch/mips/net/bpf_jit_asm.S

-- 
2.4.2
