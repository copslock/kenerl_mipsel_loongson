Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Apr 2016 11:07:45 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:48376 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27025228AbcDOJHnKX60c (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 Apr 2016 11:07:43 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email with ESMTPS id 156FFBEE96D46;
        Fri, 15 Apr 2016 10:07:35 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Fri, 15 Apr 2016 10:07:37 +0100
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Fri, 15 Apr 2016 10:07:36 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>, Paul Burton <paul.burton@imgtec.com>,
        "James Hogan" <james.hogan@imgtec.com>, <stable@vger.kernel.org>
Subject: [PATCH 0/4] MIPS: MSA fixes
Date:   Fri, 15 Apr 2016 10:07:22 +0100
Message-ID: <1460711246-4394-1-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52988
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

Here are some miscellaneous fixes for MSA (MIPS SIMD Architecture)
support:
1) Fix MSA build with recent toolchains
2) Fix 32-bit pointer additions on 64-bit with non-MSA capable
   toolchain.
3) Fix MSA + 64-bit + lockdep build due to large immediate offsets
4) Fix some MSA assembler warnings due to missing .set fp=64

James Hogan (3):
  MIPS: Fix MSA ld_*/st_* asm macros to use PTR_ADDU
  MIPS: Fix MSA assembly with big thread offsets
  MIPS: Fix MSA assembly warnings

Paul Burton (1):
  MIPS: Use copy_s.fmt rather than copy_u.fmt

 arch/mips/include/asm/asmmacro.h | 193 ++++++++++++++++++++++-----------------
 arch/mips/kernel/r4k_fpu.S       |  10 +-
 2 files changed, 113 insertions(+), 90 deletions(-)

Cc: Paul Burton <paul.burton@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: <stable@vger.kernel.org>
-- 
2.4.10
