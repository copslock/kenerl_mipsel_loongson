Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Jun 2014 11:39:15 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:28198 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6859939AbaFWJjNRmbDA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 23 Jun 2014 11:39:13 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 2FF28E580974F;
        Mon, 23 Jun 2014 10:39:04 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Mon, 23 Jun 2014 10:39:06 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.28) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Mon, 23 Jun 2014 10:39:05 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <dborkman@redhat.com>,
        "Alexei Starovoitov" <ast@plumgrid.com>, <netdev@vger.kernel.org>
Subject: [PATCH 00/17] Misc MIPS/BPF fixes for 3.16
Date:   Mon, 23 Jun 2014 10:38:43 +0100
Message-ID: <1403516340-22997-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.0.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.28]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40655
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

Here are some fixes for MIPS/BPF for 3.16. These fixes make
the bpf testsuite *almost* happy with only 2 tests (LD_IND_LL,
LD_IND_NET) failing at the moment. Since fixing the remaining tests
is not so trivial, it would be nice to have these fixes in 3.16 for now.

The patches are based on the upstream-sfr/mips-for-linux-next tree
because they depend on https://patchwork.linux-mips.org/patch/7099/

Markos Chandras (17):
  MIPS: uasm: Add s3s1s2 instruction builder
  MIPS: uasm: Add slt uasm instruction
  MIPS: mm: uasm: Fix lh micro-assembler instruction
  MIPS: bpf: Use the LO register to get division's quotient
  MIPS: bpf: Return error code if the offset is a negative number
  MIPS: bpf: Use 'andi' instead of 'and' for the VLAN cases
  MIPS: bpf: Add SEEN_SKB to flags when looking for the PKT_TYPE
  MIPS: bpf: Fix branch conditional for BPF_J{GT/GE} cases
  MIPS: bpf: Use correct mask for VLAN_TAG case
  MIPS: bpf: Fix return values for VLAN_TAG_PRESENT case
  MIPS: bpf: Use pr_debug instead of pr_warn for unhandled opcodes
  MIPS: bpf: Fix is_range() semantics
  MIPS: bpf: Drop update_on_xread and always initialize the X register
  MIPS: bpf: Prevent kernel fall over for >=32bit shifts
  MIPS: bpf: Fix PKT_TYPE case for big-endian cores
  MIPS: bpf: Use 32 or 64-bit load instruction to load an address to
    register
  MIPS: bpf: Fix stack space allocation for BPF memwords on MIPS64

 arch/mips/include/asm/uasm.h      |   4 ++
 arch/mips/include/uapi/asm/inst.h |   1 +
 arch/mips/mm/uasm-micromips.c     |   1 +
 arch/mips/mm/uasm-mips.c          |   3 +-
 arch/mips/mm/uasm.c               |  10 +++-
 arch/mips/net/bpf_jit.c           | 115 ++++++++++++++++++++++++--------------
 6 files changed, 90 insertions(+), 44 deletions(-)

-- 
2.0.0
