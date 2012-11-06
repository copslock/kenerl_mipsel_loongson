Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Nov 2012 23:39:37 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:51479 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6826039Ab2KFWimZwr0Y (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 6 Nov 2012 23:38:42 +0100
Received: from akpm.mtv.corp.google.com (216-239-45-4.google.com [216.239.45.4])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E397126;
        Tue,  6 Nov 2012 22:38:35 +0000 (UTC)
Date:   Tue, 6 Nov 2012 14:38:35 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Michel Lespinasse <walken@google.com>
Cc:     Rik van Riel <riel@redhat.com>, Hugh Dickins <hughd@google.com>,
        linux-kernel@vger.kernel.org,
        Russell King <linux@arm.linux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Mundt <lethal@linux-sh.org>,
        "David S. Miller" <davem@davemloft.net>,
        Chris Metcalf <cmetcalf@tilera.com>, x86@kernel.org,
        William Irwin <wli@holomorphy.com>, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH 11/16] mm: use vm_unmapped_area() on arm architecture
Message-Id: <20121106143835.3e321da4.akpm@linux-foundation.org>
In-Reply-To: <1352155633-8648-12-git-send-email-walken@google.com>
References: <1352155633-8648-1-git-send-email-walken@google.com>
        <1352155633-8648-12-git-send-email-walken@google.com>
X-Mailer: Sylpheed 3.0.2 (GTK+ 2.20.1; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-archive-position: 34912
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: akpm@linux-foundation.org
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

On Mon,  5 Nov 2012 14:47:08 -0800
Michel Lespinasse <walken@google.com> wrote:

> Update the arm arch_get_unmapped_area[_topdown] functions to make
> use of vm_unmapped_area() instead of implementing a brute force search.

Again,

--- a/arch/arm/mm/mmap.c~mm-use-vm_unmapped_area-on-arm-architecture-fix
+++ a/arch/arm/mm/mmap.c
@@ -11,18 +11,6 @@
 #include <linux/random.h>
 #include <asm/cachetype.h>
 
-static inline unsigned long COLOUR_ALIGN_DOWN(unsigned long addr,
-					      unsigned long pgoff)
-{
-	unsigned long base = addr & ~(SHMLBA-1);
-	unsigned long off = (pgoff << PAGE_SHIFT) & (SHMLBA-1);
-
-	if (base + off <= addr)
-		return base + off;
-
-	return base - off;
-}
-
 #define COLOUR_ALIGN(addr,pgoff)		\
 	((((addr)+SHMLBA-1)&~(SHMLBA-1)) +	\
 	 (((pgoff)<<PAGE_SHIFT) & (SHMLBA-1)))
_
