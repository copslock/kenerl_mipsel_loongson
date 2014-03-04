Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Mar 2014 14:35:07 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.89.28.115]:45738 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6816877AbaCDNfFt69It (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 Mar 2014 14:35:05 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 7A000B3A9C4CD
        for <linux-mips@linux-mips.org>; Tue,  4 Mar 2014 13:34:57 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Tue, 4 Mar 2014 13:34:59 +0000
Received: from mchandras-linux.le.imgtec.org (192.168.154.47) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Tue, 4 Mar 2014 13:34:58 +0000
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 0/3] Add support for the M5150 processor
Date:   Tue, 4 Mar 2014 13:34:41 +0000
Message-ID: <1393940084-29518-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.9.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.47]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39402
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

This patchset adds support for the recently announced M5150 processor
http://imgtec.com/mips/mips-series5-mclass-m51xx.asp?NewsID=804

This patchset is for the upstream-sfr/mips-for-linux-next tree

Leonid Yegoshin (3):
  MIPS: Add processor identifier for the M5150 processor
  MIPS: Add support for the M5150 processor
  MIPS: kernel: cpu-probe: Add support for probing M5150 cores

 arch/mips/include/asm/cpu-type.h     | 1 +
 arch/mips/include/asm/cpu.h          | 3 ++-
 arch/mips/kernel/cpu-probe.c         | 4 ++++
 arch/mips/kernel/idle.c              | 1 +
 arch/mips/mm/c-r4k.c                 | 1 +
 arch/mips/mm/tlbex.c                 | 1 +
 arch/mips/oprofile/common.c          | 1 +
 arch/mips/oprofile/op_model_mipsxx.c | 4 ++++
 8 files changed, 15 insertions(+), 1 deletion(-)

-- 
1.9.0
