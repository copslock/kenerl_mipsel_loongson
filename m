Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Jun 2005 13:59:06 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:27929 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8225804AbVFMM6u>; Mon, 13 Jun 2005 13:58:50 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.1/8.13.1) with ESMTP id j5DCuBD9024666;
	Mon, 13 Jun 2005 13:56:11 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j5DCuA15024665;
	Mon, 13 Jun 2005 13:56:10 +0100
Date:	Mon, 13 Jun 2005 13:56:10 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Dominic Sweetman <dom@mips.com>
Cc:	qemu-devel@nongnu.org, linux-mips@linux-mips.org,
	Jocelyn Mayer <l_indien@magic.fr>,
	Fabrice Bellard <fabrice@bellard.org>
Subject: Re: Qemu for MIPS
Message-ID: <20050613125610.GB4890@linux-mips.org>
References: <20050613105944.GA19704@linux-mips.org> <17069.29065.124810.728626@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17069.29065.124810.728626@gargle.gargle.HOWL>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8075
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jun 13, 2005 at 12:44:09PM +0100, Dominic Sweetman wrote:

> > Known bugs:
> > 
> >  o ll/sc don't use a ll_bit like the real hardware thus right now any atomic
> >    functions aren't really atomic.
> 
> I suppose you know that the CPUs all implement "break link on
> exception" by zeroing the link bit on an 'eret'?  That doesn't sound
> too hard...

It's not hard to add the llbit indeed - maybe I'm trying to hard to be
obscure use compatible.  Generally Qemu is trading the highest accuracy
of emulation for speed ...

> Arguably, an emulator should not provide the LLaddr register at all.
> It's optional and "only available for debug" - and probably such
> debugging is possible another way in an emulator.  Robust software
> shouldn't depend on assuming the contents make sense.

The only use I've seen for this register is having it being used as a
cp0 scratch register allowing to save the entire 31 GPRs.  Very old
Linux/MIPS used to do that but it doesn't match the reality of MIPS ABIs,
so I gave up on that very soon.  Like 11 years agp :)

> Not quite there yet... but well done, again.

  Ralf
