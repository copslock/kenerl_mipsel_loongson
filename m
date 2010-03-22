Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Mar 2010 19:09:23 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:43562 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1492415Ab0CVSJT (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 22 Mar 2010 19:09:19 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o2MI9GM2014739;
        Mon, 22 Mar 2010 19:09:17 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o2MI9Gep014737;
        Mon, 22 Mar 2010 19:09:16 +0100
Date:   Mon, 22 Mar 2010 19:09:15 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] mips/mm: fix module support on SiByte
Message-ID: <20100322180915.GS4554@linux-mips.org>
References: <20100321110241.GA25569@Chamillionaire.breakpoint.cc>
 <20100322145918.GR4554@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100322145918.GR4554@linux-mips.org>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26291
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Mar 22, 2010 at 03:59:18PM +0100, Ralf Baechle wrote:

> > Since commit 656be92f aka "Load modules to CKSEG0 if
> > CONFIG_BUILD_ELF64=n" module support is broken on 64bit. Since then
> > modules arr loaded into 32bit compat adresses which are sign extended
> > 64bit addresses. The SiByte war handler was not updated and those
> > addresses were not recognized by the TLB hadling.
> > This patch fixes this by shifting away the upper bits including the R
> > and Fill bits. Now we compare VPN2 of C0_ENTRYHI against the matching
> > bits at C0_BADVADDR.
> 
> Good detective work but I'll check against the errata documents (which
> are non-public, sigh ...) before applying your patch.

The patch is wrong; it doesn't compare the region bits.

  Ralf
