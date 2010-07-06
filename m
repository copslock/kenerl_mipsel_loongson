Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Jul 2010 03:22:58 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:45776 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491199Ab0GFBWx (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 6 Jul 2010 03:22:53 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id o661MmHW019043;
        Tue, 6 Jul 2010 02:22:49 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id o661MmrO019041;
        Tue, 6 Jul 2010 02:22:48 +0100
Date:   Tue, 6 Jul 2010 02:22:48 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Shinya Kuribayashi <skuribay@pobox.com>
Cc:     David VomLehn <dvomlehn@cisco.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: PowerTV: Use fls() carefully where static
 optimization is required
Message-ID: <20100706012247.GA15859@linux-mips.org>
References: <4C2755A3.3080600@pobox.com>
 <20100630220124.GA576@dvomlehn-lnx2.corp.sa.net>
 <4C2DF427.7080508@pobox.com>
 <20100702213219.GA390@dvomlehn-lnx2.corp.sa.net>
 <4C2F49D0.60200@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4C2F49D0.60200@pobox.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27328
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Jul 03, 2010 at 11:31:44PM +0900, Shinya Kuribayashi wrote:

> On 07/03/2010 06:32 AM, David VomLehn wrote:
> > Usually it's better to control things on a feature-by-feature basis rather
> > than rely on things like CPU model. This allows you to easily handle case
> > where, for example, you have a different CPU that normally doesn't have
> > a feature but a particular variant does have it. IIRC, the MIPS family has
> > examples of this. So, I think it's better to go with the:
> > 	__builtin_constant_p(cpu_has_clo_clz) && cpu_has_clo_clz
> > used in fls().
> 
> Ok, now I've come to the same conclusion.  Revised patch will be like
> this.  Malta is a development platform supporting various types of
> MIPS32/MIPS64 cores, hence use cpu_has_clo_clz directly.  The same goes
> to MIPSSim.  
> 
> Another concern is that, I'm not really sure whether cpu_has_clo_clz is
> acceptable or not for Malta (and MIPSSim).  Hopefully Ralf will help us
> make things in the right direction.

My grief with this patch at this moment is:

 o The suggestion of using __builtin_ffs or similar is nice but these
   functions appear to have introduced in GCC 3.4 but we unfortunately
   support GCC >= 3.2.
 o no Signed-off-by: line.  So can you sen me one?  Thanks

  Ralf
