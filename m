Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Sep 2015 18:51:11 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:5644 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008168AbbIQQufh-ByP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Sep 2015 18:50:35 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 2A6B71F755377;
        Thu, 17 Sep 2015 17:50:27 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 17 Sep 2015 17:50:29 +0100
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Thu, 17 Sep 2015 17:50:28 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 0/2] Fix FTLB detection on R6
Date:   Thu, 17 Sep 2015 17:49:19 +0100
Message-ID: <1442508561-12260-1-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.6
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49230
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

These patches fix FTLB detection on R6 cores. Currently an FTLB will be
assumed to exist, so if not then the setting of the FTLB page size will
likely fail during boot.

The first patch adds cpu_has_ftlb, based on Config.MT (MMU type), which
distinguishes a traditional TLB from a VTLB+FTLB configuration.

The second patch fixes the probe logic to use cpu_has_ftlb for R6.

James Hogan (2):
  MIPS: cpu-features: Add cpu_has_ftlb
  MIPS: Fix FTLB detection for R6

 arch/mips/include/asm/cpu-features.h |  3 +++
 arch/mips/include/asm/cpu.h          |  1 +
 arch/mips/include/asm/mipsregs.h     |  2 ++
 arch/mips/kernel/cpu-probe.c         | 23 ++++++++++++++---------
 4 files changed, 20 insertions(+), 9 deletions(-)

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Markos Chandras <markos.chandras@imgtec.com>
Cc: linux-mips@linux-mips.org
-- 
2.4.6
