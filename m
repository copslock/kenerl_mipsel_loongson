Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Nov 2010 08:10:41 +0100 (CET)
Received: from mgw2.diku.dk ([130.225.96.92]:54286 "EHLO mgw2.diku.dk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492018Ab0KIHKc (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 9 Nov 2010 08:10:32 +0100
Received: from localhost (localhost [127.0.0.1])
        by mgw2.diku.dk (Postfix) with ESMTP id 1853A19BFE5;
        Tue,  9 Nov 2010 08:10:31 +0100 (CET)
Received: from mgw2.diku.dk ([127.0.0.1])
 by localhost (mgw2.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 04127-17; Tue,  9 Nov 2010 08:10:29 +0100 (CET)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
        by mgw2.diku.dk (Postfix) with ESMTP id E167E4DC00F;
        Tue,  9 Nov 2010 08:10:29 +0100 (CET)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
        by nhugin.diku.dk (Postfix) with ESMTP
        id 0842C6DF835; Tue,  9 Nov 2010 08:06:51 +0100 (CET)
Received: by ask.diku.dk (Postfix, from userid 3767)
        id C3BF02085D; Tue,  9 Nov 2010 08:10:29 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by ask.diku.dk (Postfix) with ESMTP id BA1202084B;
        Tue,  9 Nov 2010 08:10:29 +0100 (CET)
Date:   Tue, 9 Nov 2010 08:10:29 +0100 (CET)
From:   Julia Lawall <julia@diku.dk>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     kernel-janitors@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/14] arch/mips/pmc-sierra/yosemite/setup.c: delete double
 assignment
In-Reply-To: <20101109004808.GA10116@linux-mips.org>
Message-ID: <Pine.LNX.4.64.1011090809480.25928@ask.diku.dk>
References: <1288088743-3725-1-git-send-email-julia@diku.dk>
 <1288088743-3725-7-git-send-email-julia@diku.dk> <20101109004808.GA10116@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <julia@diku.dk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28337
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: julia@diku.dk
Precedence: bulk
X-list: linux-mips

On Tue, 9 Nov 2010, Ralf Baechle wrote:

> On Tue, Oct 26, 2010 at 12:25:35PM +0200, Julia Lawall wrote:
> > From: Julia Lawall <julia@diku.dk>
> > 
> > Delete successive assignments to the same location.
> 
> [...]
> 
> > This change also makes the variable cpu_clock_freq be not used in the
> > current file.  If this is the correct change to plat_time_init, then
> > perhaps the declaration of that variable should be moved elsewhere, or the
> > variable should be deleted completely.
> 
> The 2nd assignment is a temporary override for debugging purpose that is
> it's there intionsionally.

OK, thanks.  I indeed suspected that, but I thought it might be worthwhile 
to mention it, in case it had outlived its usefulness.

julia
