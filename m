Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Feb 2016 14:05:37 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:34526 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012624AbcBDNF3fUw0l (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Feb 2016 14:05:29 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id CEA50184FF6C0;
        Thu,  4 Feb 2016 13:05:19 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Thu, 4 Feb 2016 13:05:22 +0000
Received: from localhost (10.100.200.26) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Thu, 4 Feb
 2016 13:05:21 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Andrey Konovalov <adech.fo@gmail.com>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        "Andrey Ryabinin" <ryabinin.a.a@gmail.com>,
        Alex Smith <alex.smith@imgtec.com>,
        "Kees Cook" <keescook@chromium.org>,
        <linux-kernel@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        "Maciej W. Rozycki" <macro@imgtec.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 0/4] Support new MIPSr6 relocations
Date:   Thu, 4 Feb 2016 13:05:01 +0000
Message-ID: <1454591105-11841-1-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.7.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.26]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51770
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
  MIPS: Support R_MIPS_PC{21,26} rela-style relocs
  MIPS: Support R_MIPS_PC{16,21,26} rel-style relocs

Steven J. Hill (1):
  MIPS: module: Make consistent use of pr_*()

 arch/mips/include/asm/elf.h    |  5 +++
 arch/mips/kernel/module-rela.c | 75 +++++++++++++++++++++++++++++++++++-----
 arch/mips/kernel/module.c      | 77 +++++++++++++++++++++++++++++++++++++-----
 3 files changed, 140 insertions(+), 17 deletions(-)

-- 
2.7.0
