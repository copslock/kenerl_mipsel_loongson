Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Nov 2010 05:26:15 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:49024 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492144Ab0KIEYU (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 9 Nov 2010 05:24:20 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id oA8Mi56i007023;
        Mon, 8 Nov 2010 22:44:06 GMT
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id oA8Mi4hn007021;
        Mon, 8 Nov 2010 22:44:04 GMT
Date:   Mon, 8 Nov 2010 22:44:04 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Jesper Juhl <jj@chaosbits.net>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS VPE support module: don't deref potentially null
 pbuffer and don't do pointless null check before vfree
Message-ID: <20101108224404.GA6689@linux-mips.org>
References: <alpine.LNX.2.00.1010301823350.1572@swampdragon.chaosbits.net>
 <20101107142933.GA7999@linux-mips.org>
 <alpine.LNX.2.00.1011071943460.26247@swampdragon.chaosbits.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1011071943460.26247@swampdragon.chaosbits.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28334
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Nov 07, 2010 at 07:48:25PM +0100, Jesper Juhl wrote:

> I've taken a second look. I still have no way at all to test this, so 
> please take a close look before potentially applying it, but how does this 
> look to you?

Testing is a little tricky - it requires a MIPS 34K processor in a
configuration with more than one VPE.

> Don't dereference pbuffer before ttesting it for null.
> Don't do pointless check of pointer passed to vfree for null as vfree does 
> this itself.

I've already checked in something based on your first patch with the
other changes I suggested added.

Thanks!

  Ralf
