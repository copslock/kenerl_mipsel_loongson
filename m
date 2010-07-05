Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Jul 2010 16:08:21 +0200 (CEST)
Received: from arkanian.console-pimps.org ([212.110.184.194]:53330 "EHLO
        arkanian.console-pimps.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492106Ab0GEOIS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 5 Jul 2010 16:08:18 +0200
Received: by arkanian.console-pimps.org (Postfix, from userid 1000)
        id 065E148044; Mon,  5 Jul 2010 15:08:17 +0100 (BST)
Date:   Mon, 5 Jul 2010 15:08:16 +0100
From:   Matt Fleming <matt@console-pimps.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Adam Jiang <jiang.adam@gmail.com>
Subject: Re: How to detect STACKOVEFLOW on mips
Message-ID: <20100705140816.GB2968@console-pimps.org>
References: <AANLkTimL7YMyb2ahmTgl8dqV_DNfsROjDhLEDm4jyVWE@mail.gmail.com> <20100630145006.GA31938@linux-mips.org> <87zkycyyi2.fsf@linux-g6p1.site> <20100705105627.GA12699@linux-mips.org> <20100705130931.GA2968@console-pimps.org> <20100705133533.GA1262@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100705133533.GA1262@linux-mips.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <matt@console-pimps.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27322
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt@console-pimps.org
Precedence: bulk
X-list: linux-mips

On Mon, Jul 05, 2010 at 02:35:33PM +0100, Ralf Baechle wrote:
> On Mon, Jul 05, 2010 at 02:09:31PM +0100, Matt Fleming wrote:
> 
> > > Which often isn't so helpful.  The alarm gets triggered on the last stack
> > > pointer decrement but according to murphy the overflow has happened 10
> > > levels up in the callchain.
> > 
> > Last decrement? The alarm should be triggered the next time the
> > function in which the overflow occurs makes a function call. I don't
> > see how you could go down a level of the callchain and not trigger the
> > alarm if the overflow has happened?
> 
> guilt()
> {
> 	char array[6000];
> 
> 	blurb(&array);
> }
> 
> blurb(void *p)
> {
> 	frob(p);
> }
> 
> With the deep nesting of the current kernel there is a good chance a
> check in mcount will not be triggered in blurb() but possibly in frob
> or even further down the callchain.

Ah, I think I see what you mean. You're saying that you may not find
the culprit function using the massive amount of stack spac, which
eventually leads to the overflow? Yeah, that's a fair point. I think
if the mcount technique was used in conjunction with
CONFIG_DEBUG_STACK_USAGE it might be more helpful in that situation.
