Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Dec 2013 20:33:42 +0100 (CET)
Received: from mga09.intel.com ([134.134.136.24]:6059 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6816022Ab3L0TdigMXxK (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 27 Dec 2013 20:33:38 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP; 27 Dec 2013 11:29:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.95,562,1384329600"; 
   d="scan'208";a="458515073"
Received: from unknown (HELO rizzo.int.wil.cx) ([10.255.12.21])
  by orsmga002.jf.intel.com with ESMTP; 27 Dec 2013 11:33:31 -0800
Received: by rizzo.int.wil.cx (Postfix, from userid 1000)
        id 6C102172477; Fri, 27 Dec 2013 14:33:30 -0500 (EST)
Date:   Fri, 27 Dec 2013 14:33:30 -0500
From:   Matthew Wilcox <willy@linux.intel.com>
To:     John David Anglin <dave.anglin@bell.net>
Cc:     linux-mm@kvack.org, "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH] remap_file_pages needs to check for cache coherency
Message-ID: <20131227193330.GE4945@linux.intel.com>
References: <20131227180018.GC4945@linux.intel.com>
 <BLU0-SMTP17D26551261DF285A7E6F497CD0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BLU0-SMTP17D26551261DF285A7E6F497CD0@phx.gbl>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <willy@linux.intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38810
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: willy@linux.intel.com
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

On Fri, Dec 27, 2013 at 02:13:16PM -0500, John David Anglin wrote:
> On 27-Dec-13, at 1:00 PM, Matthew Wilcox wrote:
> 
> >+#ifdef __ARCH_FORCE_SHMLBA
> >+	/* Is the mapping cache-coherent? */
> >+	if ((pgoff ^ linear_page_index(vma, start)) &
> >+	    ((SHMLBA-1) >> PAGE_SHIFT))
> >+		goto out;
> >+#endif
> 
> 
> I think this will cause problems on PA-RISC.  The reason is we have
> an additional offset
> for mappings.  See get_offset() in sys_parisc.c.

I don't think it will cause any additional problems.  The test merely
asks "Is the offset to put at this address cache-coherent with the offset
that was at this address when the mmap was established?"

> SHMLBA is 4 MB on PA-RISC.  If we limit ourselves to aligned
> mappings, we run out of
> memory very quickly.  Even with our current implementation, we fail
> the perl locales test
> with locales-all installed.

I know the large SHMLBA is problematic for PA-RISC, but I don't think
there's a lot of code out there using remap_file_pages().  code.google.com
found almost nothing, and a regular google search found only a couple
of little toys.

Have you considered measuring SHMLBA on different CPU models and
reducing it at boot time?  I know that 4MB is the architectural guarantee
(actually, I seem to remember that 16MB was the architectural guarantee,
but jsm found some CPU architects who said it would enver exceed 4MB).
I bet some CPUs have considerably lower cache coherency limits.
