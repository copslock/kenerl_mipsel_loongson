Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Jul 2010 15:36:07 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:48467 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491802Ab0GENfk (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 5 Jul 2010 15:35:40 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id o65DZYYk001340;
        Mon, 5 Jul 2010 14:35:35 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id o65DZXt9001338;
        Mon, 5 Jul 2010 14:35:33 +0100
Date:   Mon, 5 Jul 2010 14:35:33 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Matt Fleming <matt@console-pimps.org>
Cc:     linux-mips@linux-mips.org, Adam Jiang <jiang.adam@gmail.com>
Subject: Re: How to detect STACKOVEFLOW on mips
Message-ID: <20100705133533.GA1262@linux-mips.org>
References: <AANLkTimL7YMyb2ahmTgl8dqV_DNfsROjDhLEDm4jyVWE@mail.gmail.com>
 <20100630145006.GA31938@linux-mips.org>
 <87zkycyyi2.fsf@linux-g6p1.site>
 <20100705105627.GA12699@linux-mips.org>
 <20100705130931.GA2968@console-pimps.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100705130931.GA2968@console-pimps.org>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27321
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jul 05, 2010 at 02:09:31PM +0100, Matt Fleming wrote:

> > Which often isn't so helpful.  The alarm gets triggered on the last stack
> > pointer decrement but according to murphy the overflow has happened 10
> > levels up in the callchain.
> 
> Last decrement? The alarm should be triggered the next time the
> function in which the overflow occurs makes a function call. I don't
> see how you could go down a level of the callchain and not trigger the
> alarm if the overflow has happened?

guilt()
{
	char array[6000];

	blurb(&array);
}

blurb(void *p)
{
	frob(p);
}

With the deep nesting of the current kernel there is a good chance a
check in mcount will not be triggered in blurb() but possibly in frob
or even further down the callchain.

  Ralf
