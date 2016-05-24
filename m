Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 May 2016 10:35:31 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:28786 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27029896AbcEXIf3voemX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 May 2016 10:35:29 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email with ESMTPS id 93FE4AE215651;
        Tue, 24 May 2016 09:35:21 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Tue, 24 May 2016 09:35:23 +0100
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Tue, 24 May 2016 09:35:23 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        <linux-mips@linux-mips.org>, <stable@vger.kernel.org>
Subject: [PATCH 0/2] MIPS: VDSO / microMIPS fixes
Date:   Tue, 24 May 2016 09:35:09 +0100
Message-ID: <1464078911-21468-1-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53631
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

These patches fix breakage on microMIPS kernels caused by commit
ebb5e78cc634 ("MIPS: Initial implementation of a VDSO") in v4.4.

The first patch drops stale microMIPS handling code when setting up
sigreturn which was causing serious breakage.

The second patch causes the VDSO to be built for microMIPS on microMIPS
kernels, which should avoid breakage on microMIPS only cores.

James Hogan (2):
  MIPS: Fix sigreturn via VDSO on microMIPS kernel
  MIPS: Build microMIPS VDSO for microMIPS kernels

 arch/mips/kernel/signal.c | 8 --------
 arch/mips/vdso/Makefile   | 1 +
 2 files changed, 1 insertion(+), 8 deletions(-)

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: linux-mips@linux-mips.org
Cc: <stable@vger.kernel.org>
-- 
2.4.10
