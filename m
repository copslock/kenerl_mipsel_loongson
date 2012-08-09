Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Aug 2012 17:22:20 +0200 (CEST)
Received: from nat28.tlf.novell.com ([130.57.49.28]:43894 "EHLO
        nat28.tlf.novell.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903682Ab2HIPWQ convert rfc822-to-8bit (ORCPT
        <rfc822;groupwise-linux-mips@linux-mips.org:12:1>);
        Thu, 9 Aug 2012 17:22:16 +0200
Received: from EMEA1-MTA by nat28.tlf.novell.com
        with Novell_GroupWise; Thu, 09 Aug 2012 16:22:07 +0100
Message-Id: <5023F1BC0200007800093EF0@nat28.tlf.novell.com>
X-Mailer: Novell GroupWise Internet Agent 12.0.0 
Date:   Thu, 09 Aug 2012 16:22:04 +0100
From:   "Jan Beulich" <JBeulich@suse.com>
To:     "Andi Kleen" <ak@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     "Andy Lutomirski" <luto@amacapital.net>,
        "Robert Richter" <robert.richter@amd.com>,
        "Johannes Weiner" <hannes@cmpxchg.org>,
        "Hugh Dickins" <hughd@google.com>, "Alex Shi" <alex.shu@intel.com>,
        "KAMEZAWA Hiroyuki" <kamezawa.hiroyu@jp.fujitsu.com>,
        <x86@kernel.org>, <linux-mm@kvack.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        <linux-mips@linux-mips.org>,
        "Tim Chen" <tim.c.chen@linux.intel.com>,
        <linuxppc-dev@lists.ozlabs.org>,
        "Andrea Arcangeli" <aarcange@redhat.com>,
        "Ingo Molnar" <mingo@redhat.com>, "Mel Gorman" <mgorman@suse.de>,
        <linux-kernel@vger.kernel.org>, <linux-sh@vger.kernel.org>,
        <sparclinux@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 4/6] x86: Add clear_page_nocache
References: <1344524583-1096-1-git-send-email-kirill.shutemov@linux.intel.com>
 <1344524583-1096-5-git-send-email-kirill.shutemov@linux.intel.com>
In-Reply-To: <1344524583-1096-5-git-send-email-kirill.shutemov@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
X-archive-position: 34082
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: JBeulich@suse.com
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

>>> On 09.08.12 at 17:03, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com> wrote:
> From: Andi Kleen <ak@linux.intel.com>
> 
> Add a cache avoiding version of clear_page. Straight forward integer variant
> of the existing 64bit clear_page, for both 32bit and 64bit.

While on 64-bit this is fine, I fail to see how you avoid using the
SSE2 instruction on non-SSE2 systems.

> Also add the necessary glue for highmem including a layer that non cache
> coherent architectures that use the virtual address for flushing can
> hook in. This is not needed on x86 of course.
> 
> If an architecture wants to provide cache avoiding version of clear_page
> it should to define ARCH_HAS_USER_NOCACHE to 1 and implement
> clear_page_nocache() and clear_user_highpage_nocache().
> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  arch/x86/include/asm/page.h          |    2 ++
>  arch/x86/include/asm/string_32.h     |    5 +++++
>  arch/x86/include/asm/string_64.h     |    5 +++++
>  arch/x86/lib/Makefile                |    1 +
>  arch/x86/lib/clear_page_nocache_32.S |   30 ++++++++++++++++++++++++++++++
>  arch/x86/lib/clear_page_nocache_64.S |   29 +++++++++++++++++++++++++++++

Couldn't this more reasonably go into clear_page_{32,64}.S?

>  arch/x86/mm/fault.c                  |    7 +++++++
>  7 files changed, 79 insertions(+), 0 deletions(-)
>  create mode 100644 arch/x86/lib/clear_page_nocache_32.S
>  create mode 100644 arch/x86/lib/clear_page_nocache_64.S
>...
>--- /dev/null
>+++ b/arch/x86/lib/clear_page_nocache_32.S
>@@ -0,0 +1,30 @@
>+#include <linux/linkage.h>
>+#include <asm/dwarf2.h>
>+
>+/*
>+ * Zero a page avoiding the caches
>+ * rdi	page

Wrong comment.

>+ */
>+ENTRY(clear_page_nocache)
>+	CFI_STARTPROC
>+	mov    %eax,%edi

You need to pick a different register here (e.g. %edx), since
%edi has to be preserved by all functions called from C.

>+	xorl   %eax,%eax
>+	movl   $4096/64,%ecx
>+	.p2align 4
>+.Lloop:
>+	decl	%ecx
>+#define PUT(x) movnti %eax,x*8(%edi) ; movnti %eax,x*8+4(%edi)

Is doing twice as much unrolling as on 64-bit really worth it?

Jan
