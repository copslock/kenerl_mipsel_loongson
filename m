Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Jul 2014 11:32:35 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:54418 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6819433AbaGNJccsVpDZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 14 Jul 2014 11:32:32 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id C5A1A6726B5CA
        for <linux-mips@linux-mips.org>; Mon, 14 Jul 2014 10:32:23 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 14 Jul 2014 10:32:25 +0100
Received: from pburton-laptop.home (192.168.79.188) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.195.1; Mon, 14 Jul
 2014 10:32:25 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 0/4] Memory Accessibility Attribute Register (MAAR) support
Date:   Mon, 14 Jul 2014 10:32:12 +0100
Message-ID: <1405330336-18167-1-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.0.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.79.188]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41177
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

This series introduces support for the Memory Accessibility Attribute
Registers introduced with MIPSr5. These registers control whether
speculative accesses are allowed to regions of memory. Allowing
speculative memory accesses is a requirement for current hardware MSA
implementations to be able to handle non-128b aligned vector loads &
stores, which are something userland may legitimately assume will work.

The series needs Markos' "MIPS: cpu-info: Change the cpu options
variable to unsigned long long" patch to be applied first.

Paul Burton (4):
  MIPS: define MAAR register accessors & bits
  MIPS: detect presence of MAARs
  MIPS: initialise MAARs
  MIPS: Malta: initialise MAARs

 arch/mips/include/asm/cpu-features.h |   3 +
 arch/mips/include/asm/cpu.h          |   1 +
 arch/mips/include/asm/maar.h         | 109 +++++++++++++++++++++++++++++++++++
 arch/mips/include/asm/mipsregs.h     |  12 ++++
 arch/mips/kernel/cpu-probe.c         |   2 +
 arch/mips/mm/init.c                  |  33 +++++++++++
 arch/mips/mti-malta/malta-memory.c   |  26 +++++++++
 7 files changed, 186 insertions(+)
 create mode 100644 arch/mips/include/asm/maar.h

-- 
2.0.1
