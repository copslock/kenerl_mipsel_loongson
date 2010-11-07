Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 07 Nov 2010 15:29:40 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:46228 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491765Ab0KGO3h (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 7 Nov 2010 15:29:37 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id oA7ETY2h001591;
        Sun, 7 Nov 2010 14:29:34 GMT
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id oA7ETYiF001589;
        Sun, 7 Nov 2010 14:29:34 GMT
Date:   Sun, 7 Nov 2010 14:29:33 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Jesper Juhl <jj@chaosbits.net>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Check vmalloc return value in vpe_open
Message-ID: <20101107142933.GA7999@linux-mips.org>
References: <alpine.LNX.2.00.1010301823350.1572@swampdragon.chaosbits.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1010301823350.1572@swampdragon.chaosbits.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28318
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Oct 30, 2010 at 06:37:16PM +0200, Jesper Juhl wrote:

> I noticed that the return value of the 
> vmalloc() call in arch/mips/kernel/vpe.c::vpe_open() is not checked, so we 
> potentially store a null pointer in v->pbuffer. As far as I can tell this 
> will be a problem. However, I don't know the mips code at all, so there 
> may be something, somewhere where I did not look, that handles this in a 
> safe manner but I couldn't find it.
> 
> To me it looks like we should do what the patch below implements and check 
> for a null return and then return -ENOMEM in that case. Comments?

All users check if the buffer was successfully allocated so the code is
safe wrt. to that.

Doesn't mean that it's not a pukeogenic piece of code.  Look at the use of
v->pbuffer in vpe_release for example.  First use it the vmalloc'ed memory
then carefully check the pointer for being non-NULL before calling vfree.
If the pointer could actually be non-NULL that's too late and vfree does
that check itself anyway.  And more such gems, general uglyness and
freedom of concept.  It used to be even worse.

  Ralf
