Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Nov 2016 03:04:44 +0100 (CET)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37506 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992121AbcKNCEP3FHlO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 14 Nov 2016 03:04:15 +0100
Received: from [2a02:8011:400e:2:6f00:88c8:c921:d332] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1c66d0-0005f9-Bx; Mon, 14 Nov 2016 02:04:10 +0000
Received: from ben by deadeye with local (Exim 4.87)
        (envelope-from <ben@decadent.org.uk>)
        id 1c66cz-0000Gs-UX; Mon, 14 Nov 2016 02:04:09 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, linux-mips@linux-mips.org,
        "Aaro Koskinen" <aaro.koskinen@nokia.com>,
        "Ralf Baechle" <ralf@linux-mips.org>,
        "David Daney" <david.daney@cavium.com>
Date:   Mon, 14 Nov 2016 00:14:20 +0000
Message-ID: <lsq.1479082460.158968005@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 044/346] MIPS: Fix page table corruption on THP
 permission changes.
In-Reply-To: <lsq.1479082458.755945576@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55795
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

3.16.39-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: David Daney <david.daney@cavium.com>

commit acd168c0bf2ce709f056a6b1bf21634b1207d7a5 upstream.

When the core THP code is modifying the permissions of a huge page it
calls pmd_modify(), which unfortunately was clearing the _PAGE_HUGE bit
of the page table entry.  The result can be kernel messages like:

mm/memory.c:397: bad pmd 000000040080004d.
mm/memory.c:397: bad pmd 00000003ff00004d.
mm/memory.c:397: bad pmd 000000040100004d.

or:

------------[ cut here ]------------
WARNING: at mm/mmap.c:3200 exit_mmap+0x150/0x158()
Modules linked in: ipv6 at24 octeon3_ethernet octeon_srio_nexus m25p80
CPU: 12 PID: 1295 Comm: pmderr Not tainted 3.10.87-rt80-Cavium-Octeon #4
Stack : 0000000040808000 0000000014009ce1 0000000000400004 ffffffff81076ba0
          0000000000000000 0000000000000000 ffffffff85110000 0000000000000119
          0000000000000004 0000000000000000 0000000000000119 43617669756d2d4f
          0000000000000000 ffffffff850fda40 ffffffff85110000 0000000000000000
          0000000000000000 0000000000000009 ffffffff809207a0 0000000000000c80
          ffffffff80f1bf20 0000000000000001 000000ffeca36828 0000000000000001
          0000000000000000 0000000000000001 000000ffeca7e700 ffffffff80886924
          80000003fd7a0000 80000003fd7a39b0 80000003fdea8000 ffffffff80885780
          80000003fdea8000 ffffffff80f12218 000000000000000c 000000000000050f
          0000000000000000 ffffffff80865c4c 0000000000000000 0000000000000000
          ...
Call Trace:
[<ffffffff80865c4c>] show_stack+0x6c/0xf8
[<ffffffff80885780>] warn_slowpath_common+0x78/0xa8
[<ffffffff809207a0>] exit_mmap+0x150/0x158
[<ffffffff80882d44>] mmput+0x5c/0x110
[<ffffffff8088b450>] do_exit+0x230/0xa68
[<ffffffff8088be34>] do_group_exit+0x54/0x1d0
[<ffffffff8088bfc0>] __wake_up_parent+0x0/0x18

---[ end trace c7b38293191c57dc ]---
BUG: Bad rss-counter state mm:80000003fa168000 idx:1 val:1536

Fix by not clearing _PAGE_HUGE bit.

Signed-off-by: David Daney <david.daney@cavium.com>
Tested-by: Aaro Koskinen <aaro.koskinen@nokia.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/13687/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
[bwh: Backported to 3.16:
 - Adjust context
 - _PAGE_HUGE might not be defined]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/arch/mips/include/asm/pgtable.h
+++ b/arch/mips/include/asm/pgtable.h
@@ -572,7 +572,11 @@ static inline struct page *pmd_page(pmd_
 
 static inline pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
 {
-	pmd_val(pmd) = (pmd_val(pmd) & _PAGE_CHG_MASK) | pgprot_val(newprot);
+	pmd_val(pmd) = (pmd_val(pmd) & (_PAGE_CHG_MASK
+#ifdef _PAGE_HUGE
+					| _PAGE_HUGE
+#endif
+				)) | pgprot_val(newprot);
 	return pmd;
 }
 
