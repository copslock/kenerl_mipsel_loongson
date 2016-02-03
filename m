Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Feb 2016 04:45:09 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:2692 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006537AbcBCDpHzpahQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Feb 2016 04:45:07 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id BA8768DF2DE71;
        Wed,  3 Feb 2016 03:45:01 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Wed, 3 Feb 2016 03:45:02 +0000
Received: from localhost (10.100.200.215) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Wed, 3 Feb
 2016 03:45:01 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Andrey Konovalov <adech.fo@gmail.com>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        "Andrey Ryabinin" <ryabinin.a.a@gmail.com>,
        Alex Smith <alex.smith@imgtec.com>,
        Kees Cook <keescook@chromium.org>,
        <linux-kernel@vger.kernel.org>,
        "James Hogan" <james.hogan@imgtec.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Markos Chandras <markos.chandras@imgtec.com>,
        "Maciej W. Rozycki" <macro@imgtec.com>
Subject: [PATCH 0/5] Support new MIPSr6 relocations
Date:   Wed, 3 Feb 2016 03:44:40 +0000
Message-ID: <1454471085-20963-1-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.7.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.215]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51649
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

MIPSr6 introduced a few new relocations that may be present in loadable
kernel modules. This series introduces support for them in both their
rel & rela forms for MIPS32 & MIPS64 kernels respectively, and ensures
that any future missing relocs cause module loading to fail gracefully.

Paul Burton (3):
  MIPS: Bail on unsupported module relocs
  MIPS: Support R_MIPS_PC16 rel-style reloc
  MIPS: Implement MIPSr6 R_MIPS_PC2x rel-style relocs

Steven J. Hill (2):
  MIPS: module-rela: Make consistent use of pr_*()
  MIPS: Add support for 64-bit R6 ELF relocations

 arch/mips/include/asm/elf.h    |  5 +++
 arch/mips/kernel/module-rela.c | 96 ++++++++++++++++++++++++++++++++++++++----
 arch/mips/kernel/module.c      | 85 +++++++++++++++++++++++++++++++++++--
 3 files changed, 173 insertions(+), 13 deletions(-)

-- 
2.7.0
