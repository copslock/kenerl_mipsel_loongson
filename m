Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Sep 2016 11:11:51 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:46596 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991759AbcI1JLTEwXaG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 28 Sep 2016 11:11:19 +0200
Received: from localhost (unknown [89.202.203.52])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id ADD4D8A6;
        Wed, 28 Sep 2016 09:11:12 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Hogan <james.hogan@imgtec.com>,
        Leonid Yegoshin <leonid.yegoshin@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.4 63/73] MIPS: vDSO: Fix Malta EVA mapping to vDSO page structs
Date:   Wed, 28 Sep 2016 11:05:33 +0200
Message-Id: <20160928090438.442889863@linuxfoundation.org>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20160928090434.509091655@linuxfoundation.org>
References: <20160928090434.509091655@linuxfoundation.org>
User-Agent: quilt/0.64
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55278
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Hogan <james.hogan@imgtec.com>

commit 554af0c396380baf416f54c439b99b495180b2f4 upstream.

The page structures associated with the vDSO pages in the kernel image
are calculated using virt_to_page(), which uses __pa() under the hood to
find the pfn associated with the virtual address. The vDSO data pointers
however point to kernel symbols, so __pa_symbol() should really be used
instead.

Since there is no equivalent to virt_to_page() which uses __pa_symbol(),
fix init_vdso_image() to work directly with pfns, calculated with
__phys_to_pfn(__pa_symbol(...)).

This issue broke the Malta Enhanced Virtual Addressing (EVA)
configuration which has a non-default implementation of __pa_symbol().
This is because it uses a physical alias so that the kernel executes
from KSeg0 (VA 0x80000000 -> PA 0x00000000), while RAM is provided to
the kernel in the KUSeg range (VA 0x00000000 -> PA 0x80000000) which
uses the same underlying RAM.

Since there are no page structures associated with the low physical
address region, some arbitrary kernel memory would be interpreted as a
page structure for the vDSO pages and badness ensues.

Fixes: ebb5e78cc634 ("MIPS: Initial implementation of a VDSO")
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Leonid Yegoshin <leonid.yegoshin@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/14229/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/vdso.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/arch/mips/kernel/vdso.c
+++ b/arch/mips/kernel/vdso.c
@@ -39,16 +39,16 @@ static struct vm_special_mapping vdso_vv
 static void __init init_vdso_image(struct mips_vdso_image *image)
 {
 	unsigned long num_pages, i;
+	unsigned long data_pfn;
 
 	BUG_ON(!PAGE_ALIGNED(image->data));
 	BUG_ON(!PAGE_ALIGNED(image->size));
 
 	num_pages = image->size / PAGE_SIZE;
 
-	for (i = 0; i < num_pages; i++) {
-		image->mapping.pages[i] =
-			virt_to_page(image->data + (i * PAGE_SIZE));
-	}
+	data_pfn = __phys_to_pfn(__pa_symbol(image->data));
+	for (i = 0; i < num_pages; i++)
+		image->mapping.pages[i] = pfn_to_page(data_pfn + i);
 }
 
 static int __init init_vdso(void)
