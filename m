Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Sep 2015 20:43:24 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:60953 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008792AbbIVSnXCHd3P (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Sep 2015 20:43:23 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 1A717331208F4;
        Tue, 22 Sep 2015 19:43:12 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 22 Sep 2015 19:43:15 +0100
Received: from localhost (192.168.159.189) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Tue, 22 Sep
 2015 19:43:15 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Joshua Kinard <kumba@gentoo.org>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        <linux-kernel@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>,
        "Markos Chandras" <markos.chandras@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 0/6] Support RIXI without fill bits
Date:   Tue, 22 Sep 2015 11:42:47 -0700
Message-ID: <1442947373-13345-1-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.5.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.189]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49317
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

This series fixes up the generated TLB exception handlers to take into
account cases where there are less fill bits in the Entry{Lo,Hi}
registers than there are software defined bits in a PTE. The most
notable case of this is when running a MIPS32 kernel on a MIPS64 system,
and given that RIXI is required on MIPSr6 support for it is required in
order to run MIPS32 kernels on MIPS64r6 CPUs.

Paul Burton (6):
  MIPS: tlbex: stop open-coding build_convert_pte_to_entrylo
  MIPS: tlbex: remove some RIXI redundancy
  MIPS: tlbex: share MIPS32 32 bit phys & MIPS64 64 bit phys code
  MIPS: tidy EntryLo bit definitions, add PFN
  MIPS: tlbex: avoid placing software PTE bits in Entry* PFN fields
  MIPS: allow RIXI for 32-bit kernels on MIPS64

 arch/mips/include/asm/cpu-features.h |  6 +--
 arch/mips/include/asm/mipsregs.h     | 12 ++---
 arch/mips/mm/tlbex.c                 | 89 ++++++++++++++++++++++--------------
 3 files changed, 59 insertions(+), 48 deletions(-)

-- 
2.5.3
