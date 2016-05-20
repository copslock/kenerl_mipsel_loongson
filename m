Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 May 2016 15:13:15 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:57096 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27031698AbcETNNNEUpoY (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 20 May 2016 15:13:13 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u4KDDBvF003324;
        Fri, 20 May 2016 15:13:11 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u4KDDBb3003323;
        Fri, 20 May 2016 15:13:11 +0200
Date:   Fri, 20 May 2016 15:13:11 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Maciej W. Rozycki" <macro@imgtec.com>
Cc:     James Hogan <james.hogan@imgtec.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Fix write_gc0_* macros when writing zero
Message-ID: <20160520131310.GA13016@linux-mips.org>
References: <1463587478-5815-1-git-send-email-james.hogan@imgtec.com>
 <alpine.DEB.2.00.1605200848410.6794@tp.orcam.me.uk>
 <20160520081313.GX1124@jhogan-linux.le.imgtec.org>
 <alpine.DEB.2.00.1605200920370.6794@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1605200920370.6794@tp.orcam.me.uk>
User-Agent: Mutt/1.6.1 (2016-04-27)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53558
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

On Fri, May 20, 2016 at 09:31:15AM +0100, Maciej W. Rozycki wrote:

> On Fri, 20 May 2016, James Hogan wrote:
> 
> > >  NB `z' here is an "operand code" in GCC-speak.  There's a list of the 
> > > MIPS-specific ones in gcc/config/mips/mips.c above `mips_print_operand'.  
> > > There are a few generic operand codes as well, most notably `a' to print 
> > > an address, matching the `p' constraint.  I think it would be good to have 
> > > this all documented in the GCC manual sometime.
> > 
> > Thanks Maciej! To be honest I pretty much guessed at what they were
> > called. Good to see 'z' does do what I thought. I couldn't find any
> > documentation online for the MIPS specific operand codes, so having them
> > documented with GCC would be an excellent idea!
> 
>  Yeah, this stuff is a bit obscure (the other one being %-sequences for 
> the specs) and I always find myself chasing sources when I need any of 
> this.  Frankly by now I have already remembered roughly where to look for.
> 
>  Once tracked down however the description within sources is pretty good 
> actually, so please refer there for the time being.

Material for a wiki page?

  Ralf
