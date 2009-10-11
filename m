Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Oct 2009 08:07:46 +0200 (CEST)
Received: from dns1.mips.com ([63.167.95.197]:35208 "EHLO dns1.mips.com"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1491912AbZJKGHj (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 11 Oct 2009 08:07:39 +0200
Received: from MTVEXCHANGE.mips.com ([192.168.36.60])
	by dns1.mips.com (8.13.8/8.13.8) with ESMTP id n9B67VUo023999
	for <linux-mips@linux-mips.org>; Sat, 10 Oct 2009 23:07:32 -0700
Received: from [192.168.3.60] ([192.168.3.60]) by MTVEXCHANGE.mips.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 10 Oct 2009 23:07:31 -0700
Message-ID: <4AD17619.1000201@mips.com>
Date:	Sat, 10 Oct 2009 23:07:21 -0700
From:	Chris Dearman <chris@mips.com>
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
MIME-Version: 1.0
To:	linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH] Avoid potential hazard on Context register
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Oct 2009 06:07:31.0505 (UTC) FILETIME=[1E472210:01CA4A39]
Return-Path: <chris@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24219
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chris@mips.com
Precedence: bulk
X-list: linux-mips

set_saved_sp reads Context register. Avoid reading stale value from 
earlier incomplete write

Signed-off-by: Chris Dearman <chris@mips.com>
---

  arch/mips/kernel/head.S |    1 +
  1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/mips/kernel/head.S b/arch/mips/kernel/head.S
index 531ce7b..ea695d9 100644
--- a/arch/mips/kernel/head.S
+++ b/arch/mips/kernel/head.S
@@ -191,6 +191,7 @@ NESTED(kernel_entry, 16, sp)			# kernel entry point
  	/* Set the SP after an empty pt_regs.  */
  	PTR_LI		sp, _THREAD_SIZE - 32 - PT_SIZE
  	PTR_ADDU	sp, $28
+	back_to_back_c0_hazard
  	set_saved_sp	sp, t0, t1
  	PTR_SUBU	sp, 4 * SZREG		# init stack pointer
