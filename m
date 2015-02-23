Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Feb 2015 09:21:59 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:15188 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006904AbbBWIV5f0fVj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 23 Feb 2015 09:21:57 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id A955A2B67CA87
        for <linux-mips@linux-mips.org>; Mon, 23 Feb 2015 08:21:50 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 23 Feb 2015 08:21:52 +0000
Received: from mchandras-linux.le.imgtec.org (192.168.154.96) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Mon, 23 Feb 2015 08:21:51 +0000
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 0/2] EVA fixes
Date:   Mon, 23 Feb 2015 08:21:34 +0000
Message-ID: <1424679696-19696-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.3.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.96]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45887
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

These two patches fix unaligned accesses when EVA is enabled. The fixes
CC stable as well, because they need to be applied all the way back to
the 3.15 kernels where EVA was originally introduced.

Markos Chandras (2):
  MIPS: asm: asm-eva: Introduce kernel load/store variants
  MIPS: unaligned: Prevent EVA instructions on kernel unaligned accesses

 arch/mips/include/asm/asm-eva.h | 137 +++++++++++++++++++++-----------
 arch/mips/kernel/unaligned.c    | 170 ++++++++++++++++++++++------------------
 2 files changed, 186 insertions(+), 121 deletions(-)

-- 
2.3.0
