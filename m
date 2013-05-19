Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 19 May 2013 11:22:45 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:49192 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6835038Ab3ESJWndDJKA (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 19 May 2013 11:22:43 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r4J9MX3K005227;
        Sun, 19 May 2013 11:22:33 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r4J9MMFt005226;
        Sun, 19 May 2013 11:22:22 +0200
Date:   Sun, 19 May 2013 11:22:21 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney.cavm@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-ia64@vger.kernel.org,
        James Hogan <james.hogan@imgtec.com>,
        Michal Simek <monstr@monstr.eu>,
        microblaze-uclinux@itee.uq.edu.au,
        Chen Liqin <liqin.chen@sunplusct.com>,
        Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org,
        linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>,
        linux-arch@vger.kernel.org
Cc:     Sanjay Lal <sanjayl@kymasys.com>, linux-mips@linux-mips.org,
        kvm@vger.kernel.org, gleb@redhat.com, mtosatti@redhat.com
Subject: Re: [PATCH] KVM/MIPS32: Export min_low_pfn.
Message-ID: <20130519092221.GD24568@linux-mips.org>
References: <n>
 <1368824818-22503-1-git-send-email-sanjayl@kymasys.com>
 <5196A458.7080400@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5196A458.7080400@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36474
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

On Fri, May 17, 2013 at 02:42:48PM -0700, David Daney wrote:

> On 05/17/2013 02:06 PM, Sanjay Lal wrote:
> >The KVM module uses the standard MIPS cache management routines, which use min_low_pfn.
> >This creates and indirect dependency, requiring min_low_pfn to be exported.
> >
> >Signed-off-by: Sanjay Lal <sanjayl@kymasys.com>
> >---
> >  arch/mips/kernel/mips_ksyms.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> >diff --git a/arch/mips/kernel/mips_ksyms.c b/arch/mips/kernel/mips_ksyms.c
> >index 6e58e97..0299472 100644
> >--- a/arch/mips/kernel/mips_ksyms.c
> >+++ b/arch/mips/kernel/mips_ksyms.c
> >@@ -14,6 +14,7 @@
> >  #include <linux/mm.h>
> >  #include <asm/uaccess.h>
> >  #include <asm/ftrace.h>
> >+#include <linux/bootmem.h>
> >
> >  extern void *__bzero(void *__s, size_t __count);
> >  extern long __strncpy_from_user_nocheck_asm(char *__to,
> >@@ -60,3 +61,8 @@ EXPORT_SYMBOL(invalid_pte_table);
> >  /* _mcount is defined in arch/mips/kernel/mcount.S */
> >  EXPORT_SYMBOL(_mcount);
> >  #endif
> >+
> >+/* The KVM module uses the standard MIPS cache functions which use
> >+ * min_low_pfn, requiring it to be exported.

The comment is wrong.  min_low_pfn is being referenced by pfn_valid() which
is implemented (simplified for purposes of this discussion) like:

int pfn_valid(unsigned long pfn)
{
	return pfn >= min_low_pfn && pfn < max_mapnr;
}

> >+ */
> >+EXPORT_SYMBOL(min_low_pfn);
> 
> I think I asked this before, but I don't remember the answer:
> 
> Why not put EXPORT_SYMBOL(min_low_pfn) in mm/bootmem.c adjacent to
> where the symbol is defined?
> 
> Cluttering up the kernel with multiple architectures all doing
> architecture specific exports of the same symbol is not a clean way
> of doing things.
> 
> The second time something needs to be done, it should be factored
> out into common code.

pfn_valid() should return 1 if for the pfn passed as the argment a struct
page exists in mem_map[] - this only affects the flatmem case.  However
it is possible that min_low_pfn is bigger than ARCH_PFN_OFFSET in which
case pfn_valid might return 0 even though it should have returned 1.

So I fixed the issue like:

static inline int pfn_valid(unsigned long pfn)
{
	return pfn >= ARCH_PFN_OFFSET && pfn < max_mapnr;
}

frv, ia64, metag, microblaze, score and sh are also implementing pfn_valid
referencing min_low_pfn.

Time to move pfn_valid() to asm-generic, fix the min_low_pfn /
ARCH_PFN_OFFSET issue and while at it, harden it against multiple
evaluation of its arguments?

  Ralf
