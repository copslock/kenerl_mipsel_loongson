Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 24 Oct 2010 04:40:19 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:46922 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490946Ab0JXCkP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 24 Oct 2010 04:40:15 +0200
Date:   Sun, 24 Oct 2010 03:40:15 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Kevin Cernekee <cernekee@gmail.com>
cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 8/9] MIPS: Honor L2 bypass bit
In-Reply-To: <AANLkTinJ4wU30AaBhcvJRLZ_iw-eo9tEkds8QA1S=Nqw@mail.gmail.com>
Message-ID: <alpine.LFD.2.00.1010240325170.15889@eddie.linux-mips.org>
References: <74b5d3ba9506b2e6d885546bd6dcdaec@localhost>        <20101021125809.GA15031@linux-mips.org> <AANLkTinJ4wU30AaBhcvJRLZ_iw-eo9tEkds8QA1S=Nqw@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28214
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 21 Oct 2010, Kevin Cernekee wrote:

> FWIW, I did check the software user's manual for each of the four
> processors in the list and verified that L2B is at CONFIG2 bit 12.  It
> would be very rude for an L2 designer to redefine those bits in
> defiance of the SUM, no?

 To err is human -- people do all kinds of weird stuff, not necessarily on 
purpose.  I think it should be safe to assume the bit is used properly 
until proved otherwise.

> I also rechecked 24KE just now, and found that L2B is defined in the
> latest rev of the SUM, but in my local copy (Revision 01.02) bit 12 is
> the MSB of SS instead.  Hmmm.

 Clearly a documentation bug -- notice how the width of the field 
disagress with the bit indices quoted.

  Maciej
