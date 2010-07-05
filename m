Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Jul 2010 12:56:34 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:54263 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491775Ab0GEK4b (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 5 Jul 2010 12:56:31 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id o65AuSHd012989;
        Mon, 5 Jul 2010 11:56:28 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id o65AuRr8012987;
        Mon, 5 Jul 2010 11:56:27 +0100
Date:   Mon, 5 Jul 2010 11:56:27 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Matt Fleming <matt@console-pimps.org>
Cc:     linux-mips@linux-mips.org, Adam Jiang <jiang.adam@gmail.com>
Subject: Re: How to detect STACKOVEFLOW on mips
Message-ID: <20100705105627.GA12699@linux-mips.org>
References: <AANLkTimL7YMyb2ahmTgl8dqV_DNfsROjDhLEDm4jyVWE@mail.gmail.com>
 <20100630145006.GA31938@linux-mips.org>
 <87zkycyyi2.fsf@linux-g6p1.site>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zkycyyi2.fsf@linux-g6p1.site>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27314
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jun 30, 2010 at 10:57:41PM +0100, Matt Fleming wrote:

> On Wed, 30 Jun 2010 15:50:06 +0100, Ralf Baechle <ralf@linux-mips.org> wrote:
> > 
> > There used to be some code for other architectures that zeros the stack
> > page and counts how much of that has been overwritten by the stack.  That
> > was never ported to MIPS.
> > 
> > Another helper to find functions that do excessive static allocations is
> > "make checkstack".
> 
> Both SH and sparc use the mcount function (enabled with the -pg switch
> to gcc) to check the stack has not overflowed. The relevant code is in
> arch/{sh,sparc}/lib/mcount.S. This checks the stack pointer value on
> every function call. Yeah, it's heavy-weight, but an implementation for
> MIPS should be able to catch almost the exact point at which stack
> overflow occurs.

Which often isn't so helpful.  The alarm gets triggered on the last stack
pointer decrement but according to murphy the overflow has happened 10
levels up in the callchain.

  Ralf
