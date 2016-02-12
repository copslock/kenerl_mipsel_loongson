Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Feb 2016 11:57:46 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:44022 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27012111AbcBLK5oZpC1t (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 12 Feb 2016 11:57:44 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u1CAvd23028606;
        Fri, 12 Feb 2016 11:57:39 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u1CAvasY028605;
        Fri, 12 Feb 2016 11:57:36 +0100
Date:   Fri, 12 Feb 2016 11:57:36 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Maciej W. Rozycki" <macro@imgtec.com>
Cc:     Paul Burton <paul.burton@imgtec.com>, linux-mips@linux-mips.org,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Joshua Kinard <kumba@gentoo.org>, linux-kernel@vger.kernel.org,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        James Hogan <james.hogan@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: Re: [PATCH] MIPS: tlb-r4k: panic if the MMU doesn't support PAGE_SIZE
Message-ID: <20160212105736.GA11854@linux-mips.org>
References: <1436803964-29820-1-git-send-email-paul.burton@imgtec.com>
 <20160210221049.GA26712@NP-P-BURTON>
 <alpine.DEB.2.00.1602111931450.15885@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1602111931450.15885@tp.orcam.me.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52022
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

On Thu, Feb 11, 2016 at 07:37:12PM +0000, Maciej W. Rozycki wrote:

> > > index 08318ec..4330315 100644
> > > --- a/arch/mips/mm/tlb-r4k.c
> > > +++ b/arch/mips/mm/tlb-r4k.c
> > > @@ -486,6 +487,10 @@ static void r4k_tlb_configure(void)
> > >  	 *     be set to fixed-size pages.
> > >  	 */
> > >  	write_c0_pagemask(PM_DEFAULT_MASK);
> > > +	back_to_back_c0_hazard();
> > > +	if (read_c0_pagemask() != PM_DEFAULT_MASK)
> > > +		panic("MMU doesn't support PAGE_SIZE=0x%lx", PAGE_SIZE);
> 
>  I think it would make sense to report here what the minimum/maximum page 
> size actually supported is, so that the users know what there might be 
> after.

This is a very unlikely error condition to be hit so I'd rather keep it
simple.  Even just BUG_ON() would suffice.

  Ralf
