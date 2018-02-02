Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Feb 2018 23:16:55 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:49528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994032AbeBBWPTZ66Mg (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 2 Feb 2018 23:15:19 +0100
Received: from localhost.localdomain (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07588217A3;
        Fri,  2 Feb 2018 22:15:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07588217A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
From:   James Hogan <jhogan@kernel.org>
To:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Cc:     Aleksandar Markovic <aleksandar.markovic@mips.com>,
        Goran Ferenc <goran.ferenc@mips.com>,
        Miodrag Dinic <miodrag.dinic@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Paul Burton <paul.burton@mips.com>
Subject: [PATCH 4/4] MIPS: generic: Don't claim PC parport/serio
Date:   Fri,  2 Feb 2018 22:14:12 +0000
Message-Id: <62d0928450232217dcb1979e9c56e02a275bdfd0.1517609353.git-series.jhogan@kernel.org>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <cover.fcf1b08ac94759a5cd4b4303f350734b68872619.1517609353.git-series.jhogan@kernel.org>
References: <cover.fcf1b08ac94759a5cd4b4303f350734b68872619.1517609353.git-series.jhogan@kernel.org>
In-Reply-To: <cover.fcf1b08ac94759a5cd4b4303f350734b68872619.1517609353.git-series.jhogan@kernel.org>
References: <cover.fcf1b08ac94759a5cd4b4303f350734b68872619.1517609353.git-series.jhogan@kernel.org>
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62431
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jhogan@kernel.org
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

None of the supported MIPS generic platforms can have the PC parallel
port or PC serial port (and we don't yet have to be concerned with
Malta which does), and enabling the PC serial driver will result in a
panic from i8042_flush during boot. Therefore conditionalise the MIPS
selection of ARCH_MIGHT_HAVE_PC_{PARPORT,SERIO} on !MIPS_GENERIC.

This particularly matters since commit f2d0b0d5c171 ("MIPS: ranchu: Add
Ranchu as a new generic-based board"), which adds a board fragment which
enables INPUT_KEYBOARD. That implicitly enables KEYBOARD_ATKBD which
then selects SERIO_I8042 if ARCH_MIGHT_HAVE_PC_SERIO.

We can always select it from specific platforms later.

Fixes: f2d0b0d5c171 ("MIPS: ranchu: Add Ranchu as a new generic-based board")
Signed-off-by: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Miodrag Dinic <miodrag.dinic@mips.com>
Cc: Goran Ferenc <goran.ferenc@mips.com>
Cc: Aleksandar Markovic <aleksandar.markovic@mips.com>
Cc: Paul Burton <paul.burton@mips.com>
Cc: linux-mips@linux-mips.org
---
Does anybody actually know which MIPS platforms can have these PC
devices?
---
 arch/mips/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index f83f51fc2f82..ee30596380fd 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -7,8 +7,8 @@ config MIPS
 	select ARCH_DISCARD_MEMBLOCK
 	select ARCH_HAS_ELF_RANDOMIZE
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
-	select ARCH_MIGHT_HAVE_PC_PARPORT
-	select ARCH_MIGHT_HAVE_PC_SERIO
+	select ARCH_MIGHT_HAVE_PC_PARPORT if !MIPS_GENERIC
+	select ARCH_MIGHT_HAVE_PC_SERIO if !MIPS_GENERIC
 	select ARCH_SUPPORTS_UPROBES
 	select ARCH_USE_BUILTIN_BSWAP
 	select ARCH_USE_CMPXCHG_LOCKREF if 64BIT
-- 
git-series 0.9.1
