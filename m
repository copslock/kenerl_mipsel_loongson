Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Feb 2018 18:06:28 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.150.225]:41190 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991025AbeBZRGUms4qO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 26 Feb 2018 18:06:20 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx29.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Mon, 26 Feb 2018 17:06:12 +0000
Received: from mredfearn-linux.mipstec.com (192.168.155.41) by
 MIPSMAIL01.mipstec.com (10.20.43.31) with Microsoft SMTP Server (TLS) id
 14.3.361.1; Mon, 26 Feb 2018 09:03:00 -0800
From:   Matt Redfearn <matt.redfearn@mips.com>
To:     James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>, Paul Burton <paul.burton@mips.com>,
        "Matt Redfearn" <matt.redfearn@mips.com>,
        <linux-kernel@vger.kernel.org>,
        "Maciej W. Rozycki" <macro@mips.com>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH 0/4] MIPS: Introduce isa-rev.h to define MIPS_ISA_REV
Date:   Mon, 26 Feb 2018 17:02:41 +0000
Message-ID: <1519664565-10955-1-git-send-email-matt.redfearn@mips.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.155.41]
X-BESS-ID: 1519664770-637139-10619-123029-6
X-BESS-VER: 2018.2-r1802232356
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.190443
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Matt.Redfearn@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62715
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

There are multiple instances in the kernel where we need to include or
exclude particular instructions based on the ISA revision of the target
processor. For MIPS32 / MIPS64, the compiler exports a __mips_isa_rev
define. However, when targeting MIPS I - V, this define is absent. This
leads to each use of __mips_isa_rev having to check that it is defined
first. To simplify this, this series introduces the isa-rev.h header
which always exports MIPS_ISA_REV (the name is changed so as to avoid
confusion with the compiler builtin and to avoid accidentally using the
builtin). All uses of __mips_isa_rev are then replaced with the new
define, removing the check that it is defined.

Applies on v4.16-rc1


Matt Redfearn (4):
  MIPS: Introduce isa-rev.h to define MIPS_ISA_REV
  MIPS: cpu-features.h: Replace __mips_isa_rev with MIPS_ISA_REV
  MIPS: BPF: Replace __mips_isa_rev with MIPS_ISA_REV
  MIPS: VDSO: Replace __mips_isa_rev with MIPS_ISA_REV

 arch/mips/include/asm/cpu-features.h |  5 +++--
 arch/mips/include/asm/isa-rev.h      | 24 ++++++++++++++++++++++++
 arch/mips/net/bpf_jit_asm.S          |  9 +++++----
 arch/mips/vdso/elf.S                 | 10 ++++------
 4 files changed, 36 insertions(+), 12 deletions(-)
 create mode 100644 arch/mips/include/asm/isa-rev.h

-- 
2.7.4
