Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Mar 2017 17:14:42 +0100 (CET)
Received: from bombadil.infradead.org ([65.50.211.133]:43061 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992227AbdCXQNlwu77A (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 24 Mar 2017 17:13:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hIaD524xs3Qn/3Ay5JbEDOGIIDvUrEHXnjPPpXfuEk4=; b=Qg7GSAMp2m8G2uhmZQuXAUrbH
        gDWARADqKzDYia+LS3+2l8wIojVoqVFaSf69zWrIeE9tYgGHTQ8ETuqnZvg7ofs249WzBXUyIELlf
        /xGVuk/l8j08fxPyNWMkvo6tFuWrFLpo9jkf/+Kr0zPUlSPHRegXOHhSi1sti/95bhE7DHN1qO/P4
        9nfhQXLdDoQ8Zf3ahnWH6SW4FuQwRt5Xqhpr8o0hhJD/jUQQ9ksJQYUUSm3VXwQFfxlK6gV6eiSAT
        qs5e0ae5yIZ5Y+lWvvDvt3nDG8ldhZ5bnHuS9/7t1p+G75QQ2zX+VjIA/8spy4LGTKigiuKvxwWea
        ai6v36dew==;
Received: from willy by bombadil.infradead.org with local (Exim 4.87 #1 (Red Hat Linux))
        id 1crRqK-0004uq-BV; Fri, 24 Mar 2017 16:13:36 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-fbdev@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        x86@kernel.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        Minchan Kim <minchan@kernel.org>,
        Matthew Wilcox <mawilcox@microsoft.com>
Subject: [PATCH v3 0/7] Add memsetN functions
Date:   Fri, 24 Mar 2017 09:13:11 -0700
Message-Id: <20170324161318.18718-1-willy@infradead.org>
X-Mailer: git-send-email 2.9.3
Return-Path: <willy@infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57437
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: willy@infradead.org
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

From: Matthew Wilcox <mawilcox@microsoft.com>

zram was recently enhanced to support compressing pages with a repeating
pattern up to the size of an unsigned long.  As part of the discussion,
we noted it would be nice if architectures had optimised routines
to fill regions of memory with patterns larger than those contained
in a single byte.  Our suspicions were right; the x86 version offers
approximately a 7% performance improvement over the C implementation.

The generic memfill() function is part of Lars Wirzenius' publib,
but it doesn't offer the most convenient interface.  I chose to add
five more-specific functions as part of this patchset -- memset16(),
memset32(), memset64(), memset_l() (long) and memset_p() (pointer).

It would be nice to have some more architectures implement optimised
memsetN calls.  It would also be nice to find more places in the kernel
which could benefit from calling these functions.  Maybe a coccinelle
script could be written to find such places?  We're looking for loops
over an array where the value being stored into the array does not depend
on the iteration variable.

Since v1 of the patchset, I stumbled on Alpha's memsetw() which
caused me to add memset16() to complete the set.  I removed the
'__HAVE_ARCH_MEMSET_PLUS' preprocessor symbol in favour of separate
MEMSET16 MEMSET32 and MEMSET64 symbols.  I also reviewed the scr_mem*w()
usages across the different architectures and implemented some obvious
missing optimisations.  Alpha is still missing scr_memmovew() as it
would be non-trivial to write.

Russell's review on patch 2 only applies to the memset32/memset64
implementation.  The memset16 is unreviewed (and, indeed, untested)
to date.

Matthew Wilcox (7):
  Add multibyte memset functions
  ARM: Implement memset16, memset32 & memset64
  x86: Implement memset16, memset32 & memset64
  alpha: Add support for memset16
  zram: Convert to using memset_l
  sym53c8xx_2: Convert to use memset32
  vga: Optimise console scrolling

 arch/alpha/include/asm/string.h     | 15 ++++----
 arch/alpha/include/asm/vga.h        |  2 +-
 arch/alpha/lib/memset.S             | 10 +++---
 arch/arm/include/asm/string.h       | 21 ++++++++++++
 arch/arm/kernel/armksyms.c          |  3 ++
 arch/arm/lib/memset.S               | 44 +++++++++++++++++++-----
 arch/mips/include/asm/vga.h         |  6 ++++
 arch/powerpc/include/asm/vga.h      |  8 +++++
 arch/sparc/include/asm/vga.h        | 24 +++++++++++++
 arch/x86/include/asm/string_32.h    | 24 +++++++++++++
 arch/x86/include/asm/string_64.h    | 36 ++++++++++++++++++++
 drivers/block/zram/zram_drv.c       | 15 ++------
 drivers/scsi/sym53c8xx_2/sym_hipd.c | 11 ++----
 include/linux/string.h              | 30 ++++++++++++++++
 include/linux/vt_buffer.h           | 12 +++++++
 lib/string.c                        | 68 +++++++++++++++++++++++++++++++++++++
 16 files changed, 287 insertions(+), 42 deletions(-)

-- 
2.11.0
