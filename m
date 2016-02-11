Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Feb 2016 20:37:22 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:46926 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006547AbcBKThTl3nga (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 11 Feb 2016 20:37:19 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 1B72DCC65C44A;
        Thu, 11 Feb 2016 19:37:11 +0000 (GMT)
Received: from [10.100.200.149] (10.100.200.149) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.266.1; Thu, 11 Feb 2016
 19:37:13 +0000
Date:   Thu, 11 Feb 2016 19:37:12 +0000
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Paul Burton <paul.burton@imgtec.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Joshua Kinard <kumba@gentoo.org>,
        <linux-kernel@vger.kernel.org>,
        =?ISO-8859-2?Q?Rafa=B3_Mi=B3ecki?= <zajec5@gmail.com>,
        James Hogan <james.hogan@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: Re: [PATCH] MIPS: tlb-r4k: panic if the MMU doesn't support
 PAGE_SIZE
In-Reply-To: <20160210221049.GA26712@NP-P-BURTON>
Message-ID: <alpine.DEB.2.00.1602111931450.15885@tp.orcam.me.uk>
References: <1436803964-29820-1-git-send-email-paul.burton@imgtec.com> <20160210221049.GA26712@NP-P-BURTON>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.100.200.149]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52020
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@imgtec.com
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

On Wed, 10 Feb 2016, Paul Burton wrote:

> > diff --git a/arch/mips/mm/tlb-r4k.c b/arch/mips/mm/tlb-r4k.c
> > index 08318ec..4330315 100644
> > --- a/arch/mips/mm/tlb-r4k.c
> > +++ b/arch/mips/mm/tlb-r4k.c
> > @@ -486,6 +487,10 @@ static void r4k_tlb_configure(void)
> >  	 *     be set to fixed-size pages.
> >  	 */
> >  	write_c0_pagemask(PM_DEFAULT_MASK);
> > +	back_to_back_c0_hazard();
> > +	if (read_c0_pagemask() != PM_DEFAULT_MASK)
> > +		panic("MMU doesn't support PAGE_SIZE=0x%lx", PAGE_SIZE);

 I think it would make sense to report here what the minimum/maximum page 
size actually supported is, so that the users know what there might be 
after.

  Maciej
