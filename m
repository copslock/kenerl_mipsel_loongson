Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Apr 2014 13:47:16 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.89.28.115]:33916 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6820489AbaDHLrNzz4Bw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Apr 2014 13:47:13 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 3EFF7AB801DB8
        for <linux-mips@linux-mips.org>; Tue,  8 Apr 2014 12:47:02 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (192.168.5.97) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.181.6; Tue, 8 Apr
 2014 12:47:03 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (192.168.5.97) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Tue, 8 Apr 2014 12:47:03 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.89) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Tue, 8 Apr 2014 12:47:03 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 00/14] Initial BPF-JIT support for MIPS
Date:   Tue, 8 Apr 2014 12:47:01 +0100
Message-ID: <1396957635-27071-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.89]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39707
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

This adds support for BPF-JIT for MIPS. Tested on mips32 LE/BE and mips64 BE
with a few networking tools such as tcpdump and dhcp but not all opcodes have
been tested as far as I can tell. There are a few optimizations left to be made
(fastpath for load operations instead of calling the helper functions) but
these can be added later on. If someone has complex network setups in place and
would like to give it a try, that would be much appreciated.

This patchset is for the upstream-sfr/mips-for-linux-next tree

Markos Chandras (14):
  MIPS: uasm: Add u3u2u1 instruction builders
  MIPS: uasm: Add u2u1 instruction builders
  MIPS: uasm: Add sllv uasm instruction
  MIPS: uasm: Add srlv uasm instruction
  MIPS: uasm: Add divu uasm instruction
  MIPS: uasm: Add mfhi uasm instruction
  MIPS: uasm: Add jalr uasm instruction
  MIPS: uasm: Add sltiu uasm instruction
  MIPS: uasm: Add sltu uasm instruction
  MIPS: uasm: Add wsbh uasm instruction
  MIPS: uasm: Add lh uam instruction
  MIPS: uasm: Add mul uasm instruction
  MIPS: net: Add BPF JIT
  MIPS: Enable the BPF_JIT symbol for MIPS

 arch/mips/Kbuild                  |    1 +
 arch/mips/Kconfig                 |    1 +
 arch/mips/include/asm/uasm.h      |   16 +
 arch/mips/include/uapi/asm/inst.h |   17 +
 arch/mips/mm/uasm-micromips.c     |   10 +
 arch/mips/mm/uasm-mips.c          |   10 +
 arch/mips/mm/uasm.c               |   39 +-
 arch/mips/net/Makefile            |    3 +
 arch/mips/net/bpf_jit.c           | 1327 +++++++++++++++++++++++++++++++++++++
 arch/mips/net/bpf_jit.h           |   45 ++
 10 files changed, 1462 insertions(+), 7 deletions(-)
 create mode 100644 arch/mips/net/Makefile
 create mode 100644 arch/mips/net/bpf_jit.c
 create mode 100644 arch/mips/net/bpf_jit.h

-- 
1.9.1
