Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Jul 2016 18:00:52 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:49418 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992319AbcGYQAX4KCLE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 25 Jul 2016 18:00:23 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id E345242F2D5D6;
        Mon, 25 Jul 2016 17:00:03 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Mon, 25 Jul 2016 17:00:06 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-arch@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Russell King <linux@armlinux.org.uk>,
        Nathan Lynch <nathan_lynch@mentor.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        <linux-mips@linux-mips.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-s390@vger.kernel.org>,
        <user-mode-linux-devel@lists.sourceforge.net>
Subject: [PATCH 0/5] Define AT_VECTOR_SIZE_ARCH correctly
Date:   Mon, 25 Jul 2016 16:59:49 +0100
Message-ID: <1469462394-8970-1-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54368
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

Several architectures define ARCH_DLINFO to [sometimes] contain
NEW_AUX_ENT entries, but don't define AT_VECTOR_SIZE_ARCH with the
corresponding maximum number of NEW_AUX_ENT entries.

In practice this doesn't cause any problems as AT_VECTOR_SIZE_BASE
includes space for AT_BASE_PLATFORM which none of these arches use, but
nevertheless lets define it now and add the comment above ARCH_DLINFO as
found in several other architectures to remind future modifiers of
ARCH_DLINFO to keep AT_VECTOR_SIZE_ARCH up to date.

Arch maintainers, please take via your own trees if you're happy to do
so.

- I haven't included an update for x86/um as it doesn't follow the same
  pattern as other architectures so it is unclear to me whether it has
  the same issue.

- Build tested on MIPS, ARM & tile.

- Tested on MIPS.

James Hogan (5):
  MIPS: Define AT_VECTOR_SIZE_ARCH for ARCH_DLINFO
  ARM: Define AT_VECTOR_SIZE_ARCH for ARCH_DLINFO
  arm64: Define AT_VECTOR_SIZE_ARCH for ARCH_DLINFO
  s390: Define AT_VECTOR_SIZE_ARCH for ARCH_DLINFO
  tile: Define AT_VECTOR_SIZE_ARCH for ARCH_DLINFO

 arch/arm/include/asm/elf.h           | 1 +
 arch/arm/include/uapi/asm/auxvec.h   | 2 ++
 arch/arm64/include/asm/elf.h         | 1 +
 arch/arm64/include/uapi/asm/auxvec.h | 2 ++
 arch/mips/include/asm/elf.h          | 1 +
 arch/mips/include/uapi/asm/auxvec.h  | 2 ++
 arch/s390/include/asm/elf.h          | 1 +
 arch/s390/include/uapi/asm/auxvec.h  | 2 ++
 arch/tile/include/asm/elf.h          | 1 +
 arch/tile/include/uapi/asm/auxvec.h  | 2 ++
 10 files changed, 15 insertions(+)

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Nathan Lynch <nathan_lynch@mentor.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Chris Metcalf <cmetcalf@mellanox.com>
Cc: Jeff Dike <jdike@addtoit.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: linux-mips@linux-mips.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-s390@vger.kernel.org
Cc: user-mode-linux-devel@lists.sourceforge.net
-- 
2.4.10
