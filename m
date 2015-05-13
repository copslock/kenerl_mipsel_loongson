Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 May 2015 12:52:53 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:19923 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013291AbbEMKwLp4-Ye (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 13 May 2015 12:52:11 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 4E3F7F9C981EC;
        Wed, 13 May 2015 11:52:05 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 13 May 2015 11:51:02 +0100
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Wed, 13 May 2015 11:51:01 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 0/9] MIPS: dump_tlb improvements
Date:   Wed, 13 May 2015 11:50:46 +0100
Message-ID: <1431514255-3030-1-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.3.6
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47365
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

This patchset improves dump_tlb.c to use proper hazard macros (for which
new macros are added for tlb reads), and to take into account the global
bit, the EHINV invalid bit, RI & XI bits, and XPA.

Patch 1 also adds a MIPS specific SysRq operation ('x') to dump the TLBs
on running CPUs. This is mainly for debug purposes, however I've
included it for completeness as an RFC patch, in case others find it
helpful.

Patches 2 & 3 add and make use of tlbr related hazard macros (which are
technically distinct, though identically implemented, to tlbw hazards).

Patches 4-6 improve the TLB entry matching so as to more closely match
which entries hardware treats as matching (taking the global and EHINV
bits into account).

Patches 7-8 improve the TLB printing to handle RI & XI bits (which show
up in the physical address at the moment), and XPA (where the top of the
physical address needs to be read from EntryLo registers with mfhc0).

Finally patch 9 is a trivial correction in a comment, that I noticed
while grepping around for XPA bits.

James Hogan (9):
  MIPS: Add SysRq operation to dump TLBs on all CPUs
  MIPS: hazards: Add hazard macros for tlb read
  MIPS: dump_tlb: Use tlbr hazard macros
  MIPS: dump_tlb: Refactor TLB matching
  MIPS: dump_tlb: Take global bit into account
  MIPS: dump_tlb: Take EHINV bit into account
  MIPS: dump_tlb: Take RI/XI bits into account
  MIPS: dump_tlb: Take XPA into account
  MIPS: tlb-r4k: Fix PG_ELPA comment

 arch/mips/include/asm/hazards.h  |  52 ++++++++++++++++++++
 arch/mips/include/asm/mipsregs.h |  11 +++++
 arch/mips/kernel/Makefile        |   1 +
 arch/mips/kernel/sysrq.c         |  77 +++++++++++++++++++++++++++++
 arch/mips/lib/dump_tlb.c         | 103 ++++++++++++++++++++++++---------------
 arch/mips/mm/tlb-r4k.c           |   2 +-
 drivers/tty/sysrq.c              |   1 +
 7 files changed, 207 insertions(+), 40 deletions(-)
 create mode 100644 arch/mips/kernel/sysrq.c

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Steven J. Hill <Steven.Hill@imgtec.com>
Cc: David Daney <ddaney@caviumnetworks.com>
Cc: linux-mips@linux-mips.org
-- 
2.3.6
