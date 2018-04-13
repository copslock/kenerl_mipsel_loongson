Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Apr 2018 22:21:27 +0200 (CEST)
Received: from bombadil.infradead.org ([IPv6:2607:7c80:54:e::133]:36610 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993885AbeDMUVVIGzN1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 13 Apr 2018 22:21:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=rF70eO+AC+qHNSHLVvrUh1edH14m7X/avjRx8+wqxVg=; b=tHDwkyA8MaLiZFlQ7qKS1qQyW
        cWxCnONtbGtpKy/ccaz/IuVvgHhk2NUQOpn3bJCt/Bq6hK6qroLxLHkxByhZoXD5RuDy/krWsyb42
        j/C8cD2sp6Xk6QEn6pxTJDLYmL3qJSIW6J8Ij4HfA0fIh4gFFwhR0kHvBF0888VqQ6vLCxCu2s1mv
        UPMw+lflINX6dYMzTQoJ2tXWbLYlQpiAHoqIqLw/eKnKc/qtyTrLKlNH1wlNUOed13NVhL5uW5ibl
        SM4xFTlLNTuXkh9b0RWSL30+5K2ClMrv1NnS1bSPGfWrjjvyZGhrL6DF4J2KO8PG1Rtgjzmo0X3Gk
        mUZbU91bw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1f75C0-0002yn-EK; Fri, 13 Apr 2018 20:21:08 +0000
Date:   Fri, 13 Apr 2018 13:21:08 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-alpha@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 00/32] docs/vm: convert to ReST format
Message-ID: <20180413202108.GA30271@bombadil.infradead.org>
References: <1521660168-14372-1-git-send-email-rppt@linux.vnet.ibm.com>
 <20180329154607.3d8bda75@lwn.net>
 <20180401063857.GA3357@rapoport-lnx>
 <20180413135551.0e6d1b12@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180413135551.0e6d1b12@lwn.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Return-Path: <willy@infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63526
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

On Fri, Apr 13, 2018 at 01:55:51PM -0600, Jonathan Corbet wrote:
> > I believe that keeping the mm docs together will give better visibility of
> > what (little) mm documentation we have and will make the updates easier.
> > The documents that fit well into a certain topic could be linked there. For
> > instance:
> 
> ...but this sounds like just the opposite...?  
> 
> I've had this conversation with folks in a number of subsystems.
> Everybody wants to keep their documentation together in one place - it's
> easier for the developers after all.  But for the readers I think it's
> objectively worse.  It perpetuates the mess that Documentation/ is, and
> forces readers to go digging through all kinds of inappropriate material
> in the hope of finding something that tells them what they need to know.
> 
> So I would *really* like to split the documentation by audience, as has
> been done for a number of other kernel subsystems (and eventually all, I
> hope).
> 
> I can go ahead and apply the RST conversion, that seems like a step in
> the right direction regardless.  But I sure hope we don't really have to
> keep it as an unorganized jumble of stuff...

I've started on Documentation/core-api/memory.rst which covers just
memory allocation.  So far it has the Overview and GFP flags sections
written and an outline for 'The slab allocator', 'The page allocator',
'The vmalloc allocator' and 'The page_frag allocator'.  And typing this
up, I realise we need a 'The percpu allocator'.  I'm thinking that this
is *not* the right document for the DMA memory allocators (although it
should link to that documentation).

I suspect the existing Documentation/vm/ should probably stay as an
unorganised jumble of stuff.  Developers mostly talking to other MM
developers.  Stuff that people outside the MM fraternity should know
about needs to be centrally documented.  By all means convert it to
ReST ... I don't much care, and it may make it easier to steal bits
or link to it from the organised documentation.
