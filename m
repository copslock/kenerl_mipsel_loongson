Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Nov 2012 23:49:57 +0100 (CET)
Received: from mail-da0-f49.google.com ([209.85.210.49]:35354 "EHLO
        mail-da0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825985Ab2KEWroquIuZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 5 Nov 2012 23:47:44 +0100
Received: by mail-da0-f49.google.com with SMTP id q27so2653752daj.36
        for <linux-mips@linux-mips.org>; Mon, 05 Nov 2012 14:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=MmZBvAZ8R6CEAUMH2jIGq9KZ0gS9h9ZgLFITMeaJ3lI=;
        b=knaWkilGY9qla69FBMidzUkpi8P8gOP7wiFkSK0gfFWK+C/yM85qYLkJqe0ys8PG7u
         I+Mk1o0B/jH0/AT4HKYkN12ZtO75eYAEX8OPOlwOoYtBvZwkCQrHDV4yRtlAUvDu40s2
         9WB2gQVSYQfc17xbKKgc5dWRkhwKHgwzuWEB6KRAGgExsK/cHMnK+4estLn7bE37PLsq
         6/t6D2O/iKZ/7E/emJnj09ZRNL9xu6LCx9jYGHL3ibVDv0nfoGkVfa0H2CTb4ift4NGC
         o3x5YDQQOmchJ/72FyH2e6X5VNl9Eac+KovaZQR/DI1QCeVq5m+A8g76PfigE0dP7oJz
         0ucQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=MmZBvAZ8R6CEAUMH2jIGq9KZ0gS9h9ZgLFITMeaJ3lI=;
        b=ZqkXzI33YxrP/H1odE6HLTYR8pv0ttBsJ/x/+IcpQ3zeAuRDZqNrbgxDjv6C9+zfZG
         DrtmApcZ56so9kuDQbWu0eMUvBTSwZ4fItXP+oV2QLRQO8aVsIRhzggFf7f5YjhPg+IH
         XnmsJsSMZx0GKMyxCOGBx6DBjK3FDuvYvKkbKHW3D4t6quymtM/OMl1U5vmCCVy4V7s0
         tVmMi2VI96lc9su9ASB5g5H2WdK7IjDnNWFDjohxRyPvw0F3t7VGlVkX14VF8W6PyXwV
         IuvrcB8AaEVzN8lnlPovbk3qBqPU/c07akiS5v5dmiFw2Fk1gFXK+J4XHMZ42J/4xG4+
         IbNw==
Received: by 10.68.234.229 with SMTP id uh5mr34387780pbc.123.1352155658296;
        Mon, 05 Nov 2012 14:47:38 -0800 (PST)
Received: from studio.mtv.corp.google.com (studio.mtv.corp.google.com [172.17.131.106])
        by mx.google.com with ESMTPS id jx4sm11201653pbc.27.2012.11.05.14.47.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 05 Nov 2012 14:47:37 -0800 (PST)
From:   Michel Lespinasse <walken@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Rik van Riel <riel@redhat.com>,
        Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
        Russell King <linux@arm.linux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Mundt <lethal@linux-sh.org>,
        "David S. Miller" <davem@davemloft.net>,
        Chris Metcalf <cmetcalf@tilera.com>, x86@kernel.org,
        William Irwin <wli@holomorphy.com>
Cc:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@linux-mips.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, Rik van Riel <riel@surriel.com>
Subject: [PATCH 04/16] mm: rearrange vm_area_struct for fewer cache misses
Date:   Mon,  5 Nov 2012 14:47:01 -0800
Message-Id: <1352155633-8648-5-git-send-email-walken@google.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1352155633-8648-1-git-send-email-walken@google.com>
References: <1352155633-8648-1-git-send-email-walken@google.com>
X-Gm-Message-State: ALoCoQmBPXNwrk0J2/PDyYK4D6AgXnSUMNLNfJ6WsWI/2pTzddoSX1Y+UKmnUpt3+icJ9zoUsXvACBwg3ZelFtkDQZweIOdFLBBLvMk9oEHwbb+iyyYjQnCIP/OoRWP6ZFklSLGpVXDGwzok1/B2+K0kdiDtf3Is7KDBoa0PvJ3EOuit5HbBikMF5gjld0Aju5JedwsftMMc8pAR2g2cY8P5ZUUXh2E6uw==
X-archive-position: 34877
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: walken@google.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

From: Rik van Riel <riel@surriel.com>

The kernel walks the VMA rbtree in various places, including
the page fault path.  However, the vm_rb node spanned two
cache lines, on 64 bit systems with 64 byte cache lines (most
x86 systems).

Rearrange vm_area_struct a little, so all the information we
need to do a VMA tree walk is in the first cache line.

Signed-off-by: Michel Lespinasse <walken@google.com>
Signed-off-by: Rik van Riel <riel@redhat.com>

---
 include/linux/mm_types.h |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 94fa52b28ee8..528da4abf8ee 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -224,7 +224,8 @@ struct vm_region {
  * library, the executable area etc).
  */
 struct vm_area_struct {
-	struct mm_struct * vm_mm;	/* The address space we belong to. */
+	/* The first cache line has the info for VMA tree walking. */
+
 	unsigned long vm_start;		/* Our start address within vm_mm. */
 	unsigned long vm_end;		/* The first byte after our end address
 					   within vm_mm. */
@@ -232,9 +233,6 @@ struct vm_area_struct {
 	/* linked list of VM areas per task, sorted by address */
 	struct vm_area_struct *vm_next, *vm_prev;
 
-	pgprot_t vm_page_prot;		/* Access permissions of this VMA. */
-	unsigned long vm_flags;		/* Flags, see mm.h. */
-
 	struct rb_node vm_rb;
 
 	/*
@@ -245,6 +243,12 @@ struct vm_area_struct {
 	 */
 	unsigned long rb_subtree_gap;
 
+	/* Second cache line starts here. */
+
+	struct mm_struct * vm_mm;	/* The address space we belong to. */
+	pgprot_t vm_page_prot;		/* Access permissions of this VMA. */
+	unsigned long vm_flags;		/* Flags, see mm.h. */
+
 	/*
 	 * For areas with an address space and backing store,
 	 * linkage into the address_space->i_mmap interval tree, or
-- 
1.7.7.3
