Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Sep 2017 14:18:53 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:65463 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992143AbdI0MSrWEa3J (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 Sep 2017 14:18:47 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 8377F9A8FC17C;
        Wed, 27 Sep 2017 13:18:36 +0100 (IST)
Received: from WR-NOWAKOWSKI.kl.imgtec.org (10.80.2.5) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.361.1; Wed, 27 Sep 2017 13:18:39 +0100
From:   Marcin Nowakowski <marcin.nowakowski@imgtec.com>
To:     Linux MIPS Mailing List <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Subject: [PATCH 0/2] MIPS CRC instruction support 
Date:   Wed, 27 Sep 2017 14:18:34 +0200
Message-ID: <1506514716-29470-1-git-send-email-marcin.nowakowski@imgtec.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.2.5]
Return-Path: <Marcin.Nowakowski@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60173
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marcin.nowakowski@imgtec.com
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

MIPSr6 architecture introduces a new CRC32(C) instruction.
The following patches add a crypto acceleration module for
crc32 and crc32c algorithms using the new instructions.

Marcin Nowakowski (2):
  MIPS: add crc instruction support flag to elf_hwcap
  MIPS: crypto: Add crc32 and crc32c hw accelerated module

 arch/mips/Kconfig                  |   4 +
 arch/mips/Makefile                 |   3 +
 arch/mips/crypto/Makefile          |   5 +
 arch/mips/crypto/crc32-mips.c      | 361 +++++++++++++++++++++++++++++++++++++
 arch/mips/include/asm/mipsregs.h   |   1 +
 arch/mips/include/uapi/asm/hwcap.h |   1 +
 arch/mips/kernel/cpu-probe.c       |   3 +
 crypto/Kconfig                     |   9 +
 8 files changed, 387 insertions(+)
 create mode 100644 arch/mips/crypto/Makefile
 create mode 100644 arch/mips/crypto/crc32-mips.c

-- 
2.7.4
