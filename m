Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Jul 2010 15:09:35 +0200 (CEST)
Received: from arkanian.console-pimps.org ([212.110.184.194]:34271 "EHLO
        arkanian.console-pimps.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492055Ab0GENJc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 5 Jul 2010 15:09:32 +0200
Received: by arkanian.console-pimps.org (Postfix, from userid 1000)
        id 97AB948044; Mon,  5 Jul 2010 14:09:31 +0100 (BST)
Date:   Mon, 5 Jul 2010 14:09:31 +0100
From:   Matt Fleming <matt@console-pimps.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Adam Jiang <jiang.adam@gmail.com>
Subject: Re: How to detect STACKOVEFLOW on mips
Message-ID: <20100705130931.GA2968@console-pimps.org>
References: <AANLkTimL7YMyb2ahmTgl8dqV_DNfsROjDhLEDm4jyVWE@mail.gmail.com> <20100630145006.GA31938@linux-mips.org> <87zkycyyi2.fsf@linux-g6p1.site> <20100705105627.GA12699@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100705105627.GA12699@linux-mips.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <matt@console-pimps.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27319
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt@console-pimps.org
Precedence: bulk
X-list: linux-mips

On Mon, Jul 05, 2010 at 11:56:27AM +0100, Ralf Baechle wrote:
> On Wed, Jun 30, 2010 at 10:57:41PM +0100, Matt Fleming wrote:
> 
> > On Wed, 30 Jun 2010 15:50:06 +0100, Ralf Baechle <ralf@linux-mips.org> wrote:
> > > 
> > > There used to be some code for other architectures that zeros the stack
> > > page and counts how much of that has been overwritten by the stack.  That
> > > was never ported to MIPS.
> > > 
> > > Another helper to find functions that do excessive static allocations is
> > > "make checkstack".
> > 
> > Both SH and sparc use the mcount function (enabled with the -pg switch
> > to gcc) to check the stack has not overflowed. The relevant code is in
> > arch/{sh,sparc}/lib/mcount.S. This checks the stack pointer value on
> > every function call. Yeah, it's heavy-weight, but an implementation for
> > MIPS should be able to catch almost the exact point at which stack
> > overflow occurs.
> 
> Which often isn't so helpful.  The alarm gets triggered on the last stack
> pointer decrement but according to murphy the overflow has happened 10
> levels up in the callchain.

Last decrement? The alarm should be triggered the next time the
function in which the overflow occurs makes a function call. I don't
see how you could go down a level of the callchain and not trigger the
alarm if the overflow has happened?
