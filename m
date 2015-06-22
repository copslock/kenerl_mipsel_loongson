Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Jun 2015 13:21:30 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:21666 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006587AbbFVLV06qRg3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 22 Jun 2015 13:21:26 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id C4B4D5D0FEC70;
        Mon, 22 Jun 2015 12:21:18 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 22 Jun 2015 12:21:21 +0100
Received: from localhost (192.168.37.189) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Mon, 22 Jun
 2015 12:21:18 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        <linux-kernel@vger.kernel.org>, Jie Chen <chenj@lemote.com>,
        Huacai Chen <chenhc@lemote.com>,
        James Hogan <james.hogan@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        "Ralf Baechle" <ralf@linux-mips.org>,
        Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH v3 0/3] MSA unaligned memory access support
Date:   Mon, 22 Jun 2015 12:20:57 +0100
Message-ID: <1434972060-8865-1-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.4.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.37.189]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47997
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

This series supercedes the patch "MIPS: MSA: misaligned support"
previously submitted by Leonid, and pretty much rewrites the support for
emulating non-16byte-aligned MSA vector memory accesses introduced there.

The series applies atop v4.1.

Thanks,
    Paul

Leonid Yegoshin (2):
  MIPS: declare MSA MI10 instruction formats
  MIPS: MSA unaligned memory access support

Paul Burton (1):
  MIPS: introduce accessors for MSA vector registers

 arch/mips/include/asm/asmmacro.h  | 114 ++++++++++++++++++++++++++++++++++++++
 arch/mips/include/asm/msa.h       |  80 ++++++++++++++++++++++++++
 arch/mips/include/uapi/asm/inst.h |  31 ++++++++++-
 arch/mips/kernel/r4k_fpu.S        |  67 ++++++++++++++++++++++
 arch/mips/kernel/unaligned.c      |  72 ++++++++++++++++++++++++
 5 files changed, 363 insertions(+), 1 deletion(-)

-- 
2.4.2
