Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Mar 2015 00:21:54 +0100 (CET)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:52978 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008081AbbCCXVhzTQE4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 4 Mar 2015 00:21:37 +0100
Received: from deadeye.wl.decadent.org.uk ([192.168.4.249] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <ben@decadent.org.uk>)
        id 1YSw83-0000ed-ME; Tue, 03 Mar 2015 23:21:31 +0000
Received: from ben by deadeye with local (Exim 4.84)
        (envelope-from <ben@decadent.org.uk>)
        id 1YSw7y-0006qh-DZ; Tue, 03 Mar 2015 23:21:26 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, linux-mips@linux-mips.org,
        "Leonid Yegoshin" <Leonid.Yegoshin@imgtec.com>,
        "David Daney" <david.daney@cavium.com>,
        "Ralf Baechle" <ralf@linux-mips.org>
Date:   Tue, 03 Mar 2015 22:11:28 +0000
Message-ID: <lsq.1425420688.25339415@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 12/24] MIPS: Fix C0_Pagegrain[IEC] support.
In-Reply-To: <lsq.1425420688.806916072@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.249
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46109
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ben@decadent.org.uk
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

3.2.68-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: David Daney <david.daney@cavium.com>

commit 9ead8632bbf454cfc709b6205dc9cd8582fb0d64 upstream.

The following commits:

  5890f70f15c52d (MIPS: Use dedicated exception handler if CPU supports RI/XI exceptions)
  6575b1d4173eae (MIPS: kernel: cpu-probe: Detect unique RI/XI exceptions)

break the kernel for *all* existing MIPS CPUs that implement the
CP0_PageGrain[IEC] bit.  They cause the TLB exception handlers to be
generated without the legacy execute-inhibit handling, but never set
the CP0_PageGrain[IEC] bit to activate the use of dedicated exception
vectors for execute-inhibit exceptions.  The result is that upon
detection of an execute-inhibit violation, we loop forever in the TLB
exception handlers instead of sending SIGSEGV to the task.

If we are generating TLB exception handlers expecting separate
vectors, we must also enable the CP0_PageGrain[IEC] feature.

The bug was introduced in kernel version 3.17.

Signed-off-by: David Daney <david.daney@cavium.com>
Cc: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: http://patchwork.linux-mips.org/patch/8880/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/mm/tlb-r4k.c | 2 ++
 1 file changed, 2 insertions(+)

--- a/arch/mips/mm/tlb-r4k.c
+++ b/arch/mips/mm/tlb-r4k.c
@@ -447,6 +447,8 @@ void __cpuinit tlb_init(void)
 #ifdef CONFIG_64BIT
 		pg |= PG_ELPA;
 #endif
+		if (cpu_has_rixiex)
+			pg |= PG_IEC;
 		write_c0_pagegrain(pg);
 	}
 
