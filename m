Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Nov 2011 15:56:35 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:43078 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1904115Ab1KDO43 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 4 Nov 2011 15:56:29 +0100
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id pA4EuSec013503;
        Fri, 4 Nov 2011 14:56:28 GMT
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id pA4EuRfR013501;
        Fri, 4 Nov 2011 14:56:27 GMT
Date:   Fri, 4 Nov 2011 14:56:27 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     Hillf Danton <dhillf@gmail.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Keep TLB cache hot while flushing
Message-ID: <20111104145627.GA13043@linux-mips.org>
References: <CAJd=RBAQpea=wr2Nv6U1yRAH1bwaCvMxpnjfnKdhzAN3mtbK7A@mail.gmail.com>
 <4EAAD55D.4070106@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4EAAD55D.4070106@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 31383
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 3690

On Fri, Oct 28, 2011 at 09:16:29AM -0700, David Daney wrote:

> >If we only flush the TLB of the given huge page, the TLB cache remains hot for
> >the relevant mm as it is, and less will be refilled after flush, huge or not.
> >
> >As always all comments and ideas welcome.
> >
> 
> I haven't tested it, but it looks correct.  When I wrote the
> original flush_tlb_mm(), I was in a hurry and was more concerned
> about maintaining TLB consistency, rather than performance.

Yes, looks sane and like an obvious performance improvment.  but as always
with TLB stuff I'm paranoid so I've applied this to my 3.3 queue for it to
be tested well.

Hillf, do you have any benchmark numbers for this?

Thanks folks!

  Ralf
