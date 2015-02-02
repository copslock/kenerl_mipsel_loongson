Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Feb 2015 12:45:49 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:63950 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012401AbbBBLpsIy94p (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 2 Feb 2015 12:45:48 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id CF9F1E3F8E4DA;
        Mon,  2 Feb 2015 11:45:35 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 2 Feb 2015 11:45:37 +0000
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Mon, 2 Feb 2015 11:45:36 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
CC:     <linux-kernel@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 0/3] Add MIPS CDMM bus support
Date:   Mon, 2 Feb 2015 11:45:07 +0000
Message-ID: <1422877510-29247-1-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.0.5
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45603
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

This patchset adds basic support for the MIPS Common Device Memory Map
Memory (CDMM) region in the form of a bus in the standard Linux device
model.

Since the CDMM region is a feature of the MIPS architecture (since
around MIPSr2) the first patch adds the necessary definitions and
probing to arch/mips.

The second patch adds the actual bus driver (see that patch for lots
more info). 

The final patch just enables CDMM to work on Malta.

Futher patches will follow soon to add TTY/Console/KGDB support for the
EJTAG Fast Debug Channel (FDC) device which is found in the CDMM region.

Changes in v2:
- Fix typo in definition of MIPS_CPU_CDMM, s/0ll/ull (Maciej).
- Fix some checkpatch errors.
- Correct CDMM name in various places. It is "Common Device Memory Map",
  rather than "Common Device Mapped Memory" (which for some reason had
  got stuck in my head).

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-mips@linux-mips.org

James Hogan (3):
  MIPS: Add arch CDMM definitions and probing
  MIPS: Add CDMM bus support
  MIPS: Malta: Implement mips_cdmm_phys_base()

 arch/mips/include/asm/cdmm.h         |  87 +++++
 arch/mips/include/asm/cpu-features.h |   4 +
 arch/mips/include/asm/cpu.h          |   1 +
 arch/mips/include/asm/mipsregs.h     |  11 +
 arch/mips/kernel/cpu-probe.c         |   2 +
 arch/mips/mti-malta/malta-memory.c   |   7 +
 drivers/bus/Kconfig                  |  13 +
 drivers/bus/Makefile                 |   1 +
 drivers/bus/mips_cdmm.c              | 711 +++++++++++++++++++++++++++++++++++
 include/linux/mod_devicetable.h      |   8 +
 scripts/mod/devicetable-offsets.c    |   3 +
 scripts/mod/file2alias.c             |  16 +
 12 files changed, 864 insertions(+)
 create mode 100644 arch/mips/include/asm/cdmm.h
 create mode 100644 drivers/bus/mips_cdmm.c

-- 
2.0.5
