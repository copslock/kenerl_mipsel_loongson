Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Jun 2017 18:13:24 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:34486 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992110AbdFFQNSH92X3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 6 Jun 2017 18:13:18 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 1531CDC476AFD;
        Tue,  6 Jun 2017 17:13:08 +0100 (IST)
Received: from [10.20.78.137] (10.20.78.137) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.294.0; Tue, 6 Jun 2017
 17:13:11 +0100
Date:   Tue, 6 Jun 2017 17:13:01 +0100
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>,
        <linux-mips@linux-mips.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH 5/9] MIPS: Rename `sigill_r6' to `sigill_r2r6' in
 `__compute_return_epc_for_insn'
In-Reply-To: <20170606060643.GA25486@kroah.com>
Message-ID: <alpine.DEB.2.00.1706061658310.21750@tp.orcam.me.uk>
References: <alpine.DEB.2.00.1706040314270.10864@tp.orcam.me.uk> <alpine.DEB.2.00.1706051739400.21750@tp.orcam.me.uk> <20170606060643.GA25486@kroah.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.137]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58260
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

Hi Greg,

> > Cc: stable@vger.kernel.org # 3.19+
> > Signed-off-by: Maciej W. Rozycki <macro@imgtec.com>
> > ---
> >  Not a fix by itself, but needed for the next 2 changes.
> 
> And why isn't that info in the changelog text?  I know I will not take
> patches without any changelog text, I don't know of other maintainers
> are more "lax" about that :)

 Umm, I didn't know about your rule and thought the change along with its 
heading speaks for itself.  Sorry about that.  On second thoughts I agree 
a proper justification is due even for such a mechanical change.

 Obviously the quoted explanatory sentence as it stands would qualify as 
clutter if recorded in GIT for posterity, i.e. what would be its value for 
someone examining past changes say 10 years from now?  I'll think of 
something more suitable then and repost the series in a few days' time in 
case someone has further comments I'll take into account about any of 
these changes, so as to minimise noise (which has become hard to deal with 
already).  Ralf seems to have vanished recently, so I guess it'll take a 
bit for these changes to move forward anyway.

 Thanks for your feedback, always appreciated.

  Maciej
