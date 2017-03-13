Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Mar 2017 16:36:57 +0100 (CET)
Received: from mx2.rt-rk.com ([89.216.37.149]:37184 "EHLO mail.rt-rk.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993968AbdCMPgsmNfzT (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 13 Mar 2017 16:36:48 +0100
Received: from localhost (localhost [127.0.0.1])
        by mail.rt-rk.com (Postfix) with ESMTP id C53C51A463F;
        Mon, 13 Mar 2017 16:36:42 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw197-lin.domain.local (rtrkw197-lin.domain.local [10.10.13.80])
        by mail.rt-rk.com (Postfix) with ESMTPSA id A91901A4556;
        Mon, 13 Mar 2017 16:36:42 +0100 (CET)
From:   Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To:     linux-mips@linux-mips.org, james.hogan@imgtec.com,
        paul.burton@imgtec.com
Cc:     leonid.yegoshin@imgtec.com, douglas.leung@imgtec.com,
        aleksandar.markovic@imgtec.com, petar.jovanovic@imgtec.com,
        miodrag.dinic@imgtec.com, goran.ferenc@imgtec.com
Subject: [PATCH 0/3] MIPS: Fix some R2/FP emulation issues 
Date:   Mon, 13 Mar 2017 16:36:34 +0100
Message-Id: <1489419397-25291-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
Return-Path: <aleksandar.markovic@rt-rk.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57154
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aleksandar.markovic@rt-rk.com
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

From: Aleksandar Markovic <aleksandar.markovic@imgtec.com>

Fix handful of MIPS R2/FP emulation problems that are noticed while
developing and testing Android emulator for Mips.

Aleksandar Markovic (1):
  MIPS: r2-on-r6-emu: Clear BLTZALL and BGEZALL debugfs counters

Douglas Leung (1):
  MIPS: math-emu: Fix BC1EQZ and BC1NEZ condition handling

Leonid Yegoshin (1):
  MIPS: r2-on-r6-emu: Fix BLEZL and BGTZL identification

 arch/mips/kernel/mips-r2-to-r6-emul.c | 16 ++++++++++++++--
 arch/mips/math-emu/cp1emu.c           | 10 ++++++----
 2 files changed, 20 insertions(+), 6 deletions(-)

-- 
2.7.4
