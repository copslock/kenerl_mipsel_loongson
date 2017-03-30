Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Mar 2017 20:38:25 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:59255 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992155AbdC3SiROmLWr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 Mar 2017 20:38:17 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 7DDE27F6FA87B;
        Thu, 30 Mar 2017 19:38:04 +0100 (IST)
Received: from localhost (10.20.1.33) by HHMAIL01.hh.imgtec.org (10.100.10.21)
 with Microsoft SMTP Server (TLS) id 14.3.294.0; Thu, 30 Mar 2017 19:38:07
 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 0/2] MIPS: module: Fixup error path & refactor
Date:   Thu, 30 Mar 2017 11:37:43 -0700
Message-ID: <20170330183746.25339-1-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.12.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.1.33]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57483
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

This short series fixes a memory leak in the error path of
apply_relocate(), and refactors the REL & RELA style reloc handling to
allow for the sharing of code between the two & the removal of a fair
amount of duplication.

Applies atop v4.11-rc4.


Paul Burton (2):
  MIPS: module: Ensure we always clean up r_mips_hi16_list
  MIPS: module: Unify rel & rela reloc handling

 arch/mips/include/asm/module.h |   8 +-
 arch/mips/kernel/Makefile      |   1 -
 arch/mips/kernel/module-rela.c | 202 -------------------------------------
 arch/mips/kernel/module.c      | 221 ++++++++++++++++++++++++++++++-----------
 4 files changed, 169 insertions(+), 263 deletions(-)
 delete mode 100644 arch/mips/kernel/module-rela.c

-- 
2.12.1
