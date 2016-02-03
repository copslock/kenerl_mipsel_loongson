Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Feb 2016 17:18:03 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:13709 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012294AbcBCQSCLEy5Q (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Feb 2016 17:18:02 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id 099A06CE73216;
        Wed,  3 Feb 2016 16:17:54 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Wed, 3 Feb 2016 16:17:56 +0000
Received: from localhost (10.100.200.164) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Wed, 3 Feb
 2016 16:17:55 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Joshua Kinard <kumba@gentoo.org>,
        "Maciej W. Rozycki" <macro@imgtec.com>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        <linux-kernel@vger.kernel.org>,
        "Maciej W. Rozycki" <macro@codesourcery.com>,
        James Hogan <james.hogan@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 0/3] Imagination Technologies MIPS M6250 CPU support
Date:   Wed, 3 Feb 2016 16:17:27 +0000
Message-ID: <1454516250-9395-1-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.7.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.164]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51700
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

This series adds support for probing the Imagination Technologies MIPS
M6250 CPU. This is a small, low power microprocessor implementing the
MIPS32r6 architecture. We already support everything required for it to
work, so this series simply adds the PRID & various switch cases then
matches the PRID during probe.

This applies atop v4.5-rc2 with the similar P6600 patch set applied
first. There is no real dependency between the two patch sets, just
overlap in the context of the changes.

Paul Burton (3):
  MIPS: Add M6250 PRID & cpu_type_enum values
  MIPS: Add M6250 cases to CPU switch statements
  MIPS: Probe the M6250 CPU

 arch/mips/include/asm/cpu-type.h | 4 ++++
 arch/mips/include/asm/cpu.h      | 3 ++-
 arch/mips/kernel/cpu-probe.c     | 4 ++++
 arch/mips/mm/c-r4k.c             | 1 +
 4 files changed, 11 insertions(+), 1 deletion(-)

-- 
2.7.0
