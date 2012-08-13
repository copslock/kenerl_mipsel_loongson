Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Aug 2012 21:07:27 +0200 (CEST)
Received: from shutemov.name ([176.9.204.213]:56789 "EHLO shutemov.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903532Ab2HMTHX (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 13 Aug 2012 21:07:23 +0200
Received: by shutemov.name (Postfix, from userid 1000)
        id 44D242F09E; Mon, 13 Aug 2012 22:07:43 +0300 (EEST)
Date:   Mon, 13 Aug 2012 22:07:43 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Borislav Petkov <bp@alien8.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Jan Beulich <JBeulich@suse.com>,
        Andi Kleen <ak@linux.intel.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Robert Richter <robert.richter@amd.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hugh Dickins <hughd@google.com>, Alex Shi <alex.shu@intel.com>,
        KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
        x86@kernel.org, linux-mm@kvack.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mips@linux-mips.org, Tim Chen <tim.c.chen@linux.intel.com>,
        linuxppc-dev@lists.ozlabs.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 4/6] x86: Add clear_page_nocache
Message-ID: <20120813190743.GA10584@shutemov.name>
References: <1344524583-1096-1-git-send-email-kirill.shutemov@linux.intel.com>
 <1344524583-1096-5-git-send-email-kirill.shutemov@linux.intel.com>
 <5023F1BC0200007800093EF0@nat28.tlf.novell.com>
 <20120813114334.GA21855@otc-wbsnb-06>
 <20120813170402.GB15530@x1.osrc.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20120813170402.GB15530@x1.osrc.amd.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 34133
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kirill@shutemov.name
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

On Mon, Aug 13, 2012 at 07:04:02PM +0200, Borislav Petkov wrote:
> On Mon, Aug 13, 2012 at 02:43:34PM +0300, Kirill A. Shutemov wrote:
> > $ cat test.c
> > #include <stdio.h>
> > #include <sys/mman.h>
> > 
> > #define SIZE 1024*1024*1024
> > 
> > void clear_page_nocache_sse2(void *page) __attribute__((regparm(1)));
> > 
> > int main(int argc, char** argv)
> > {
> >         char *p;
> >         unsigned long i, j;
> > 
> >         p = mmap(NULL, SIZE, PROT_WRITE|PROT_READ,
> >                         MAP_PRIVATE|MAP_ANONYMOUS|MAP_POPULATE, -1, 0);
> >         for(j = 0; j < 100; j++) {
> >                 for(i = 0; i < SIZE; i += 4096) {
> >                         clear_page_nocache_sse2(p + i);
> >                 }
> >         }
> > 
> >         return 0;
> > }
> > $ cat clear_page_nocache_unroll32.S
> > .globl clear_page_nocache_sse2
> > .align 4,0x90
> > clear_page_nocache_sse2:
> > .cfi_startproc
> >         mov    %eax,%edx
> >         xorl   %eax,%eax
> >         movl   $4096/32,%ecx
> >         .p2align 4
> > .Lloop_sse2:
> >         decl    %ecx
> > #define PUT(x) movnti %eax,x*4(%edx)
> >         PUT(0)
> >         PUT(1)
> >         PUT(2)
> >         PUT(3)
> >         PUT(4)
> >         PUT(5)
> >         PUT(6)
> >         PUT(7)
> > #undef PUT
> >         lea     32(%edx),%edx
> >         jnz     .Lloop_sse2
> >         nop
> >         ret
> > .cfi_endproc
> > .type clear_page_nocache_sse2, @function
> > .size clear_page_nocache_sse2, .-clear_page_nocache_sse2
> > $ cat clear_page_nocache_unroll64.S
> > .globl clear_page_nocache_sse2
> > .align 4,0x90
> > clear_page_nocache_sse2:
> > .cfi_startproc
> >         mov    %eax,%edx
> 
> This must still be the 32-bit version becaue it segfaults here.

Yes, it's test for 32-bit version.

-- 
 Kirill A. Shutemov
