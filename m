Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Sep 2015 19:11:26 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:30615 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008787AbbIVRLYwRu7r (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Sep 2015 19:11:24 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 7DBD2D41C4D54;
        Tue, 22 Sep 2015 18:11:15 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 22 Sep 2015 18:11:19 +0100
Received: from localhost (192.168.159.189) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Tue, 22 Sep
 2015 18:11:18 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        <linux-kernel@vger.kernel.org>, Joe Perches <joe@perches.com>,
        Jaedon Shin <jaedon.shin@gmail.com>,
        "Maciej W. Rozycki" <macro@codesourcery.com>,
        James Hogan <james.hogan@imgtec.com>,
        David Daney <david.daney@cavium.com>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        James Cowgill <James.Cowgill@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 0/4] CM L2 prefetch support
Date:   Tue, 22 Sep 2015 10:10:52 -0700
Message-ID: <1442941856-31838-1-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.5.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.189]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49276
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


This series introduces support for enabling & disabling L2 cache
prefetch units found in systems with CM 2.5 & above (P5600 & I6400 in
terms of currently supported cores). They are enabled by default during
boot and entries are optionally added to DebugFS to enable or disable
prefetching.

Paul Burton (4):
  MIPS: Introduce API for enabling & disabling L2 prefetch
  MIPS: Enable L2 prefetching for CM >= 2.5
  MIPS: Declare mips_debugfs_dir in a header
  MIPS: Allow L2 prefetch to be configured via debugfs

 arch/mips/Kconfig.debug               | 10 +++++
 arch/mips/include/asm/bcache.h        | 27 ++++++++++++
 arch/mips/include/asm/debug.h         | 22 ++++++++++
 arch/mips/include/asm/mips-cm.h       | 17 ++++++++
 arch/mips/kernel/mips-r2-to-r6-emul.c |  2 +-
 arch/mips/kernel/segment.c            |  2 +-
 arch/mips/kernel/setup.c              |  1 +
 arch/mips/kernel/spinlock_test.c      |  4 +-
 arch/mips/kernel/unaligned.c          |  2 +-
 arch/mips/math-emu/me-debugfs.c       |  2 +-
 arch/mips/mm/Makefile                 |  1 +
 arch/mips/mm/sc-debugfs.c             | 81 +++++++++++++++++++++++++++++++++++
 arch/mips/mm/sc-mips.c                | 61 +++++++++++++++++++++++++-
 13 files changed, 224 insertions(+), 8 deletions(-)
 create mode 100644 arch/mips/include/asm/debug.h
 create mode 100644 arch/mips/mm/sc-debugfs.c

-- 
2.5.3
