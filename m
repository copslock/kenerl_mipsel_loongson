Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Feb 2018 23:11:35 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:39796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992828AbeBIWL0wV0TC (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 9 Feb 2018 23:11:26 +0100
Received: from localhost.localdomain (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9798C2173B;
        Fri,  9 Feb 2018 22:11:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9798C2173B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
From:   James Hogan <jhogan@kernel.org>
To:     linux-mips@linux-mips.org
Cc:     James Hogan <jhogan@kernel.org>,
        Marcin Nowakowski <marcin.nowakowski@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Paul Burton <paul.burton@mips.com>,
        linux-crypto@vger.kernel.org
Subject: [PATCH v3 0/3] MIPS CRC instruction support
Date:   Fri,  9 Feb 2018 22:11:04 +0000
Message-Id: <cover.a1aaa0593f5afd4b00e8131611adda3a02c060d1.1518214143.git-series.jhogan@kernel.org>
X-Mailer: git-send-email 2.13.6
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62480
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jhogan@kernel.org
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

MIPSr6 architecture introduces a new CRC32(C) instruction. The following
patches add a crypto acceleration module for crc32 and crc32c algorithms
using the new instructions.

Changes in v3:
 - Convert to using assembler macros to support CRC instructions on
   older toolchains, using the helpers merged for 4.16. This removes the
   need to hardcode either rt or rs (i.e. as $v0 (CRC_REGISTER) and
   $at), and drops the C "register" keywords sprinkled everywhere.
 - Minor whitespace rearrangement of _CRC32 macro.
 - Add SPDX-License-Identifier to crc32-mips.c and the crypo Makefile.
 - Update copyright from ImgTec to MIPS Tech, LLC.
 - Update imgtec.com email addresses to mips.com.
 - New patch 3 to enable crc32-mips module on r6 configs.

Changes in v2:
 - minor code refactoring as suggested by JamesH which produces
   a better assembly output for 32-bit builds

Cc: Marcin Nowakowski <marcin.nowakowski@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Paul Burton <paul.burton@mips.com>
Cc: linux-mips@linux-mips.org
Cc: linux-crypto@vger.kernel.org

James Hogan (1):
  MIPS: generic: Enable crc32-mips on r6 configs

Marcin Nowakowski (2):
  MIPS: Add crc instruction support flag to elf_hwcap
  MIPS: crypto: Add crc32 and crc32c hw accelerated module

 arch/mips/Kconfig                     |   4 +-
 arch/mips/Makefile                    |   3 +-
 arch/mips/configs/generic/32r6.config |   2 +-
 arch/mips/configs/generic/64r6.config |   2 +-
 arch/mips/crypto/Makefile             |   6 +-
 arch/mips/crypto/crc32-mips.c         | 346 +++++++++++++++++++++++++++-
 arch/mips/include/asm/mipsregs.h      |   1 +-
 arch/mips/include/uapi/asm/hwcap.h    |   1 +-
 arch/mips/kernel/cpu-probe.c          |   3 +-
 crypto/Kconfig                        |   9 +-
 10 files changed, 377 insertions(+)
 create mode 100644 arch/mips/crypto/Makefile
 create mode 100644 arch/mips/crypto/crc32-mips.c

base-commit: 791412dafbbfd860e78983d45cf71db603a82f67
-- 
git-series 0.9.1
