Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Mar 2015 15:55:04 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:38389 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007660AbbCIOzCXjqxh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 Mar 2015 15:55:02 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 3ADDB4113DFA8
        for <linux-mips@linux-mips.org>; Mon,  9 Mar 2015 14:54:54 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 9 Mar 2015 14:54:57 +0000
Received: from mchandras-linux.le.imgtec.org (192.168.154.96) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Mon, 9 Mar 2015 14:54:56 +0000
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH v2 0/4] EVA fixes
Date:   Mon, 9 Mar 2015 14:54:48 +0000
Message-ID: <1425912892-23133-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.96]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46287
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

These four patches fix unaligned accesses when EVA is enabled. The fixes
CC stable as well, because they need to be applied all the way back to
the 3.15 kernels where EVA was originally introduced.

Markos Chandras (4):
  MIPS: asm: asm-eva: Introduce kernel load/store variants
  MIPS: unaligned: Prevent EVA instructions on kernel unaligned accesses
  MIPS: unaligned: Surround load/store macros in do {} while statements
  MIPS: unaligned: Fix regular load/store instruction emulation for EVA

 arch/mips/include/asm/asm-eva.h | 137 ++++++++++------
 arch/mips/kernel/unaligned.c    | 340 +++++++++++++++++++++++++++-------------
 2 files changed, 324 insertions(+), 153 deletions(-)

-- 
2.3.1
