Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Jun 2016 00:52:35 +0200 (CEST)
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34519 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27042677AbcFPWwdrU0I5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 17 Jun 2016 00:52:33 +0200
Received: by mail-pf0-f195.google.com with SMTP id 66so4808101pfy.1;
        Thu, 16 Jun 2016 15:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=0PpAI9dnbQqWC2mUQ38OL9LSYVn7XmuPcg0l+2izO9U=;
        b=FthdGsYk1MpKFv4Ogk+edRSovzpDg6dW+b+w6NPivVwPzvQj1Jqu85ET5Tsppg+RvO
         ZAvzeoqUi4KHW5bJW/hPxzNzCr5I81HNS/fsn3s+QWESDnorvCbGsZNuwSg1LYv0uZy/
         e4Rh2oSN1+D275jg98XxEa70bL/NqAdQpsgPAUkRaSb4yYeWxm1A4cw0Az4w0H+8rwU/
         PEbZQAf5i0vzG34AwRqi8ULLrBDYVi0ucvSZQ68Up34pN8R5tJn9F8uGrVTC4oIlCrTK
         aXWoQ7p9C7wAAU+1XF5E6JR4MkWzRb+cKYs2pgCK6hNLvQBzHN/P9v1EICql26ndESSE
         am0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0PpAI9dnbQqWC2mUQ38OL9LSYVn7XmuPcg0l+2izO9U=;
        b=dqsuBp+PJJSY8NEO05XfjK5A7+vtGh2ZByY5ECZB3dvzAbyV2BPEqZ17ACsAV2T9RF
         epmzYG45sgf1hSTpSMbF0EeiL5JKmKT5R6TCR4ee6Qcw6dGXCRE4hY7ZOiFB7cE2IjwT
         BmaV0sKSujb2/mnxV1W96Uc8opww28oN2fKOdOXNbRZQ0XUfXrJriVUW2COgEHFxr6mO
         oB9gOa0wcpGYCab59faPGqAU4Xwi7ztirQHoDvPByLKSFl1eNzmiVfGoFUW3m5pZcRYm
         k5xGSMsyc26IBzM8HFxa9gaOosnbHRUH5Oqoi+JSYjuDXjDbmNpz1cB5oHneku/Yzc+j
         I6jw==
X-Gm-Message-State: ALyK8tKzub+5j9lzxnJTCcyxCJ6HuLuQJUF0W2cG24coY5yfsV3yj6c1fuo2taThWP4N2g==
X-Received: by 10.98.47.129 with SMTP id v123mr7779697pfv.71.1466117547638;
        Thu, 16 Jun 2016 15:52:27 -0700 (PDT)
Received: from dl.caveonetworks.com ([50.233.148.158])
        by smtp.gmail.com with ESMTPSA id o64sm63059919pfb.76.2016.06.16.15.52.25
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 16 Jun 2016 15:52:26 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id u5GMqOkB018185;
        Thu, 16 Jun 2016 15:52:24 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id u5GMoWEo018053;
        Thu, 16 Jun 2016 15:50:32 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>, stable@vger.kernel.org
Subject: [PATCH] MIPS: Fix page table corruption on THP permission changes.
Date:   Thu, 16 Jun 2016 15:50:31 -0700
Message-Id: <1466117431-18020-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54084
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

From: David Daney <david.daney@cavium.com>

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
Cc: stable@vger.kernel.org
---
 arch/mips/include/asm/pgtable.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtable.h
index a6b611f..477b1b1 100644
--- a/arch/mips/include/asm/pgtable.h
+++ b/arch/mips/include/asm/pgtable.h
@@ -632,7 +632,7 @@ static inline struct page *pmd_page(pmd_t pmd)
 
 static inline pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
 {
-	pmd_val(pmd) = (pmd_val(pmd) & _PAGE_CHG_MASK) | pgprot_val(newprot);
+	pmd_val(pmd) = (pmd_val(pmd) & (_PAGE_CHG_MASK | _PAGE_HUGE)) | pgprot_val(newprot);
 	return pmd;
 }
 
-- 
1.7.11.7
