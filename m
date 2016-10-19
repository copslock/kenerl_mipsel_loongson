Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Oct 2016 09:32:10 +0200 (CEST)
Received: from mx2.suse.de ([195.135.220.15]:52717 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990519AbcJSHcEJjwOB (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 19 Oct 2016 09:32:04 +0200
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 621B2AC83;
        Wed, 19 Oct 2016 07:32:02 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 1ACA11E09E1; Wed, 19 Oct 2016 09:32:00 +0200 (CEST)
Date:   Wed, 19 Oct 2016 09:32:00 +0200
From:   Jan Kara <jack@suse.cz>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Rik van Riel <riel@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        adi-buildroot-devel@lists.sourceforge.net,
        ceph-devel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, kvm@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-cris-kernel@axis.com, linux-fbdev@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-mips@linux-mips.org, linux-rdma@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-sh@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        netdev@vger.kernel.org, sparclinux@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH 04/10] mm: replace get_user_pages_locked() write/force
 parameters with gup_flags
Message-ID: <20161019073200.GK29967@quack2.suse.cz>
References: <20161013002020.3062-1-lstoakes@gmail.com>
 <20161013002020.3062-5-lstoakes@gmail.com>
 <20161018125425.GD29967@quack2.suse.cz>
 <20161018135609.GA30025@lucifer>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161018135609.GA30025@lucifer>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <jack@suse.cz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55495
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jack@suse.cz
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

On Tue 18-10-16 14:56:09, Lorenzo Stoakes wrote:
> On Tue, Oct 18, 2016 at 02:54:25PM +0200, Jan Kara wrote:
> > > @@ -1282,7 +1282,7 @@ long get_user_pages(unsigned long start, unsigned long nr_pages,
> > >  			    int write, int force, struct page **pages,
> > >  			    struct vm_area_struct **vmas);
> > >  long get_user_pages_locked(unsigned long start, unsigned long nr_pages,
> > > -		    int write, int force, struct page **pages, int *locked);
> > > +		    unsigned int gup_flags, struct page **pages, int *locked);
> >
> > Hum, the prototype is inconsistent with e.g. __get_user_pages_unlocked()
> > where gup_flags come after **pages argument. Actually it makes more sense
> > to have it before **pages so that input arguments come first and output
> > arguments second but I don't care that much. But it definitely should be
> > consistent...
> 
> It was difficult to decide quite how to arrange parameters as there was
> inconsitency with regards to parameter ordering already - for example
> __get_user_pages() places its flags argument before pages whereas, as you note,
> __get_user_pages_unlocked() puts them afterwards.
> 
> I ended up compromising by trying to match the existing ordering of the function
> as much as I could by replacing write, force pairs with gup_flags in the same
> location (with the exception of get_user_pages_unlocked() which I felt should
> match __get_user_pages_unlocked() in signature) or if there was already a
> gup_flags parameter as in the case of __get_user_pages_unlocked() I simply
> removed the write, force pair and left the flags as the last parameter.
> 
> I am happy to rearrange parameters as needed, however I am not sure if it'd be
> worthwhile for me to do so (I am keen to try to avoid adding too much noise here
> :)
> 
> If we were to rearrange parameters for consistency I'd suggest adjusting
> __get_user_pages_unlocked() to put gup_flags before pages and do the same with
> get_user_pages_unlocked(), let me know what you think.

Yeah, ok. If the inconsistency is already there, just leave it for now.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
