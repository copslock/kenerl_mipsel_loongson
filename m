Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Aug 2015 00:43:10 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:57235 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010959AbbHEWnIWPmJ8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Aug 2015 00:43:08 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 2C1F0324F1D86;
        Wed,  5 Aug 2015 23:42:57 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 5 Aug 2015 23:43:01 +0100
Received: from localhost (192.168.159.103) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Wed, 5 Aug
 2015 23:43:00 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        <linux-kernel@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 0/6] MIPS CPS SMP fixes, debug & cleanups
Date:   Wed, 5 Aug 2015 15:42:34 -0700
Message-ID: <1438814560-19821-1-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.5.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.103]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48619
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

This series fixes a few issues with the MIPS Coherent Processing System
SMP implementation, provides some extra capabilities with regards to
debug and does a little spring cleaning. A couple of the issues fixed
were introduced in v4.1-rc1 and (spuriously) marked for stable backports
as far as v3.16, so the fixes in this series are marked likewise.

Applies atop v4.2-rc5.

Paul Burton (6):
  MIPS: CPS: use 32b accesses to GCRs
  MIPS: CPS: stop dangling delay slot from has_mt
  MIPS: CPS: don't include MT code in non-MT kernels
  MIPS: CPS: #ifdef on CONFIG_MIPS_MT_SMP rather than CONFIG_MIPS_MT
  MIPS: CONFIG_MIPS_MT_SMP should depend upon CPU_MIPSR2
  MIPS: CPS: drop .set mips64r2 directives

 arch/mips/Kconfig          |  2 +-
 arch/mips/kernel/cps-vec.S | 18 +++++++++---------
 2 files changed, 10 insertions(+), 10 deletions(-)

-- 
2.5.0
