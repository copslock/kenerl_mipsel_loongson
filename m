Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Sep 2017 00:38:41 +0200 (CEST)
Received: from www17.your-server.de ([213.133.104.17]:42920 "EHLO
        www17.your-server.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992933AbdITWidytg7g (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 21 Sep 2017 00:38:33 +0200
Received: from [95.222.26.195] (helo=olymp)
        by www17.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.85_2)
        (envelope-from <thomas@m3y3r.de>)
        id 1dundT-0004xy-UK; Thu, 21 Sep 2017 00:38:28 +0200
Subject: [PATCH 5/7] MIPS: Cocci spatch "vma_pages"
From:   Thomas Meyer <thomas@m3y3r.de>
To:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-ID: <1505946334393-199079578-5-diffsplit-thomas@m3y3r.de>
References: <1505946334393-568186305-0-diffsplit-thomas@m3y3r.de>
In-Reply-To: <1505946334393-568186305-0-diffsplit-thomas@m3y3r.de>
Date:   Thu, 21 Sep 2017 00:29:36 +0200
X-Mailer: Evolution 3.22.6-1 
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: thomas@m3y3r.de
X-Virus-Scanned: Clear (ClamAV 0.99.2/23857/Wed Sep 20 18:44:07 2017)
Return-Path: <thomas@m3y3r.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60097
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas@m3y3r.de
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

Use vma_pages function on vma object instead of explicit computation.
Found by coccinelle spatch "api/vma_pages.cocci"

Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
---

diff -u -p a/arch/mips/mm/dma-default.c b/arch/mips/mm/dma-default.c
--- a/arch/mips/mm/dma-default.c
+++ b/arch/mips/mm/dma-default.c
@@ -179,7 +179,7 @@ static int mips_dma_mmap(struct device *
 	void *cpu_addr, dma_addr_t dma_addr, size_t size,
 	unsigned long attrs)
 {
-	unsigned long user_count = (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
+	unsigned long user_count = vma_pages(vma);
 	unsigned long count = PAGE_ALIGN(size) >> PAGE_SHIFT;
 	unsigned long addr = (unsigned long)cpu_addr;
 	unsigned long off = vma->vm_pgoff;
