Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Jun 2014 08:46:25 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:47666 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6817540AbaFDGqVoy5iZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 4 Jun 2014 08:46:21 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id s546k5jD016729;
        Wed, 4 Jun 2014 08:46:05 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id s546k105016728;
        Wed, 4 Jun 2014 08:46:01 +0200
Date:   Wed, 4 Jun 2014 08:46:01 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     Huacai Chen <chenhc@lemote.com>, John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
Subject: Re: [PATCH V2 4/8] MIPS: Add NUMA support for Loongson-3
Message-ID: <20140604064601.GU5157@linux-mips.org>
References: <1397348662-22502-1-git-send-email-chenhc@lemote.com>
 <1397348662-22502-5-git-send-email-chenhc@lemote.com>
 <20140603224739.GU17197@linux-mips.org>
 <538E5EA8.8010907@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <538E5EA8.8010907@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40428
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Tue, Jun 03, 2014 at 04:47:52PM -0700, David Daney wrote:

> On 06/03/2014 03:47 PM, Ralf Baechle wrote:
> [...]
> >>--- a/arch/mips/include/asm/addrspace.h
> >>+++ b/arch/mips/include/asm/addrspace.h
> >>@@ -51,8 +51,14 @@
> >>   * Returns the physical address of a CKSEGx / XKPHYS address
> >>   */
> >>  #define CPHYSADDR(a)		((_ACAST32_(a)) & 0x1fffffff)
> >>+
> >>+#ifndef CONFIG_NUMA
> >>  #define XPHYSADDR(a)		((_ACAST64_(a)) &			\
> >>  				 _CONST64_(0x000000ffffffffff))
> >>+#else
> >>+#define XPHYSADDR(a)		((_ACAST64_(a)) &			\
> >>+				 _CONST64_(0x0000ffffffffffff))
> >>+#endif
> >
> >The mask in XPHYSADDR is a function of the processor architecture, not
> >imlementation, not NUMA.  The latest version of the MIPS architecture
> >permits PABITS to be as large as 49 bits, so the mask should be
> >0x0001ffffffffffff.  Always.
> >
> >>diff --git a/arch/mips/include/asm/sparsemem.h b/arch/mips/include/asm/sparsemem.h
> >>index d2da53c..c001a90 100644
> >>--- a/arch/mips/include/asm/sparsemem.h
> >>+++ b/arch/mips/include/asm/sparsemem.h
> >>@@ -11,7 +11,12 @@
> >>  #else
> >>  # define SECTION_SIZE_BITS	28
> >>  #endif
> >>+
> >>+#ifdef CONFIG_NUMA
> >>+#define MAX_PHYSMEM_BITS	48
> >>+#else
> >>  #define MAX_PHYSMEM_BITS	35
> >>+#endif
> >
> >Essentially the same comment as for XPHYSADDR above.
> 
> Are you saying to change it to 49 unconditionally for all configurations?
> 
> That would work for OCTEON too, where we have had to increase it to 42.
> 
> What are the implications for kernel data structures if this is set
> many orders of magnitude greater than the actual number of bits used
> on a system?

Shouldn't make a significant difference; the value is used to compute certain
limits in sparse.c and a bitmap in zsmalloc.c which is used only when
CONFIG_ZSMALLOC is enabled.

A more important value which I haven't noticed the Looongson patches to
modify is SECTION_SIZE_BITS in <asm/sparsemem.h>:

#if defined(CONFIG_MIPS_HUGE_TLB_SUPPORT) && defined(CONFIG_PAGE_SIZE_64KB)
# define SECTION_SIZE_BITS      29
#else
# define SECTION_SIZE_BITS      28
#endif

Don't ask me why its definition depends on MIPS_HUGE_TLB_SUPPORT and
PAGE_SIZE_64KB - the value describes the larges chunk of contiguous
memory (that is for example memory per node) and that doesn't depend
on these CONFIG_* symbols.

  Ralf
