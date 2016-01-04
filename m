Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Jan 2016 21:29:30 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:18233 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009750AbcADU32vOAsQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 4 Jan 2016 21:29:28 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 89A9725F3142E;
        Mon,  4 Jan 2016 20:29:19 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Mon, 4 Jan 2016 20:29:22 +0000
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Mon, 4 Jan 2016 20:29:21 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <stable@vger.kernel.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Leonid Yegoshin <leonid.yegoshin@imgtec.com>,
        <linux-mips@linux-mips.org>
Subject: [PATCH backport v3.15..v4.1 0/2] MIPS: uaccess: EVA fixes
Date:   Mon, 4 Jan 2016 20:29:02 +0000
Message-ID: <1451939344-21557-1-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50879
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

These two backports fix bugs in the MIPS uaccess functions for MIPS
Enhanced Virtual Addressing (EVA), which were added in v3.15.

The upstream commits don't work directly when applied to kernels older
than v4.2 where the eva_kernel_access() function was introduced, so we
instead use segment_eq() directly, along with config_enabled(CONFIG_EVA)
where necessary to avoid module symbol errors.

James Hogan (2):
  MIPS: uaccess: Take EVA into account in __copy_from_user()
  MIPS: uaccess: Take EVA into account in [__]clear_user

 arch/mips/include/asm/uaccess.h | 44 +++++++++++++++++++++++++++++------------
 arch/mips/kernel/mips_ksyms.c   |  2 ++
 arch/mips/lib/memset.S          |  2 ++
 3 files changed, 35 insertions(+), 13 deletions(-)

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Markos Chandras <markos.chandras@imgtec.com>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: Leonid Yegoshin <leonid.yegoshin@imgtec.com>
Cc: linux-mips@linux-mips.org
-- 
2.4.10
