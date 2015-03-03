Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Mar 2015 19:49:05 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:11686 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008044AbbCCStDmoUw7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 3 Mar 2015 19:49:03 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id CD906F8C0A7EA
        for <linux-mips@linux-mips.org>; Tue,  3 Mar 2015 18:48:54 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 3 Mar 2015 18:48:58 +0000
Received: from mchandras-linux.le.imgtec.org (192.168.154.96) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Tue, 3 Mar 2015 18:48:57 +0000
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 0/4] MIPS R6 fixes for 4.0
Date:   Tue, 3 Mar 2015 18:48:46 +0000
Message-ID: <1425408530-21613-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.96]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46102
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

A few R6 fixes for 4.0.

Please consider applying them in time for Linux 4.0

Markos Chandras (4):
  MIPS: asm: r4kcache: Use correct base register for MIPS R6 cache
    flushes
  MIPS: asm: spinlock: Fix addiu instruction for R10000_LLSC_WAR case
  MIPS: kernel: entry.S: Set correct ISA level for mips_ihb
  MIPS; asm: bitops: Add missing ISA levels for MIPS R6

 arch/mips/include/asm/bitops.h   |  3 ++
 arch/mips/include/asm/r4kcache.h | 88 ++++++++++++++++++++--------------------
 arch/mips/include/asm/spinlock.h |  2 +-
 arch/mips/kernel/entry.S         |  3 +-
 4 files changed, 50 insertions(+), 46 deletions(-)

-- 
2.3.1
