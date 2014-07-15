Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Jul 2014 15:10:16 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:20483 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6859971AbaGONKNcGtI3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 15 Jul 2014 15:10:13 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 15F5696594294
        for <linux-mips@linux-mips.org>; Tue, 15 Jul 2014 14:10:04 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Tue, 15 Jul
 2014 14:10:06 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (10.40.60.222) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 15 Jul 2014 14:10:06 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.67) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 15 Jul 2014 14:10:05 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 0/3] Use dedicated RI/XI exceptions for MIPSR5 cores
Date:   Tue, 15 Jul 2014 14:09:54 +0100
Message-ID: <1405429797-18281-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.0.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.67]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41192
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

Hi,

This patchset adds support for unique RI/XI exceptions. This feature has
been added in MIPSr5. Using this feature, we reduce the time it takes
to deal with a TLB exception caused by the RI/XI bits since the TLB load
handler is skipped and we use the tlb_do_page_failt_0 path directly.

This patch depends on the Hardware Page Table Walker (HTW) patchset
http://www.linux-mips.org/archives/linux-mips/2014-07/msg00195.html

Leonid Yegoshin (3):
  MIPS: Add new option for unique RI/XI exceptions
  MIPS: Use dedicated exception handler if CPU supports RI/XI exceptions
  MIPS: kernel: cpu-probe: Detect unique RI/XI exceptions

 arch/mips/include/asm/cpu-features.h | 3 +++
 arch/mips/include/asm/cpu.h          | 1 +
 arch/mips/include/asm/mipsregs.h     | 1 +
 arch/mips/kernel/cpu-probe.c         | 9 +++++++++
 arch/mips/kernel/traps.c             | 7 +++++++
 arch/mips/mm/tlbex.c                 | 4 ++--
 6 files changed, 23 insertions(+), 2 deletions(-)

-- 
2.0.0
