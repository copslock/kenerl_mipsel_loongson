Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Sep 2013 17:40:14 +0200 (CEST)
Received: from mga02.intel.com ([134.134.136.20]:30992 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6821390Ab3I0PkICyO8s (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 27 Sep 2013 17:40:08 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP; 27 Sep 2013 08:39:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,994,1371106800"; 
   d="scan'208";a="410458089"
Received: from tcpepper-desk.jf.intel.com ([10.7.197.221])
  by orsmga002.jf.intel.com with SMTP; 27 Sep 2013 08:39:51 -0700
Received: by tcpepper-desk.jf.intel.com (sSMTP sendmail emulation); Fri, 27 Sep 2013 08:39:52 -0700
From:   "Timothy Pepper" <timothy.c.pepper@linux.intel.com>
Date:   Fri, 27 Sep 2013 08:39:52 -0700
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-mm@kvack.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Russell King <linux@arm.linux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, Paul Mundt <lethal@linux-sh.org>,
        linux-sh@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        James Morris <james.l.morris@oracle.com>,
        Michel Lespinasse <walken@google.com>,
        Rik van Riel <riel@redhat.com>
Subject: Re: mm: insure topdown mmap chooses addresses above security minimum
Message-ID: <20130927153951.GA15257@tcpepper-desk.jf.intel.com>
References: <1380057811-5352-1-git-send-email-timothy.c.pepper@linux.intel.com>
 <20130925073048.GB27960@gmail.com>
 <20130925171243.GA7428@tcpepper-desk.jf.intel.com>
 <20130925174436.GA14037@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20130925174436.GA14037@gmail.com>
X-PGP-Key: http://vato.org/pubkey.asc
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <timothy.c.pepper@linux.intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38007
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: timothy.c.pepper@linux.intel.com
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

On Wed 25 Sep at 19:44:36 +0200 mingo@kernel.org said:
> 
> * Timothy Pepper <timothy.c.pepper@linux.intel.com> wrote:
> 
> > On Wed 25 Sep at 09:30:49 +0200 mingo@kernel.org said:
> > > >  	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
> > > >  	info.length = len;
> > > > -	info.low_limit = PAGE_SIZE;
> > > > +	info.low_limit = max(PAGE_SIZE, PAGE_ALIGN(mmap_min_addr));
> > > >  	info.high_limit = mm->mmap_base;
> > > >  	info.align_mask = filp ? get_align_mask() : 0;
> > > >  	info.align_offset = pgoff << PAGE_SHIFT;
> > > 
> > > There appears to be a lot of repetition in these methods - instead of 
> > > changing 6 places it would be more future-proof to first factor out the 
> > > common bits and then to apply the fix to the shared implementation.
> > 
> > Besides that existing redundancy in the multiple somewhat similar
> > arch_get_unmapped_area_topdown() functions, I was expecting people might
> > question the added redundancy of the six instances of:
> > 
> > 	max(PAGE_SIZE, PAGE_ALIGN(mmap_min_addr));
> 
> That redundancy would be automatically addressed by my suggestion.

Yes.

I'm looking at the cleanup and will post a bisectable series that
introduces a common helper, addes the calls to use that helper where
applicable (looks like it might be a few dozen per arch locations), and
then the single line change for the topdown case within the common helper
to do:

	info->low_limit = max(PAGE_SIZE, PAGE_ALIGN(mmap_min_addr));

-- 
Tim Pepper <timothy.c.pepper@linux.intel.com>
Intel Open Source Technology Center
