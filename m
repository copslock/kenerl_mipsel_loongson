Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Dec 2017 17:14:19 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:35450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990487AbdLKQNcGzddu (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 11 Dec 2017 17:13:32 +0100
Received: from localhost.localdomain (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 084B02192C;
        Mon, 11 Dec 2017 16:13:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 084B02192C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
From:   James Hogan <jhogan@kernel.org>
To:     linux-mips@linux-mips.org
Cc:     James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "Maciej W . Rozycki" <macro@mips.com>
Subject: [PATCH 2/2] MIPS: mipsregs.h: Make read_c0_prid use const accessor
Date:   Mon, 11 Dec 2017 16:13:15 +0000
Message-Id: <61155fbce2529873dbfba644b6e1fd8ba4eb3a6e.1513004494.git-series.jhogan@kernel.org>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <cover.a0a46ee9377083562543020efa89accdc3760bbe.1513004494.git-series.jhogan@kernel.org>
References: <cover.a0a46ee9377083562543020efa89accdc3760bbe.1513004494.git-series.jhogan@kernel.org>
In-Reply-To: <cover.a0a46ee9377083562543020efa89accdc3760bbe.1513004494.git-series.jhogan@kernel.org>
References: <cover.a0a46ee9377083562543020efa89accdc3760bbe.1513004494.git-series.jhogan@kernel.org>
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61420
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

Make read_c0_prid() use the new constant accessor macros so that it can
potentially be optimised or removed by the compiler. This is
particularly important under virtualisation, where even with hardware
assisted virtualisation (VZ), access to the PRid register may need to be
emulated by the hypervisor.

In particular this helps eliminate the read of the PRid register in the
rather frequently called add_interrupt_randomness() (which calls into
arch/mips/include/asm/timex.h) when the prid is unused but the read
can't be removed due to the inline asm being marked __volatile__.

Reported-by: Yann LeDu <Yann.LeDu@imgtec.com>
Signed-off-by: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Maciej W. Rozycki <macro@mips.com>
Cc: linux-mips@linux-mips.org
---
 arch/mips/include/asm/mipsregs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index 74c931104714..aa6e36259297 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -1558,7 +1558,7 @@ do {									\
 #define read_c0_epc()		__read_ulong_c0_register($14, 0)
 #define write_c0_epc(val)	__write_ulong_c0_register($14, 0, val)
 
-#define read_c0_prid()		__read_32bit_c0_register($15, 0)
+#define read_c0_prid()		__read_const_32bit_c0_register($15, 0)
 
 #define read_c0_cmgcrbase()	__read_ulong_c0_register($15, 3)
 
-- 
git-series 0.9.1
