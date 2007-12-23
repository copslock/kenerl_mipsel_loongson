Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 23 Dec 2007 09:40:44 +0000 (GMT)
Received: from mk-outboundfilter-4.mail.uk.tiscali.com ([212.74.114.32]:45336
	"EHLO mk-outboundfilter-4.mail.uk.tiscali.com") by ftp.linux-mips.org
	with ESMTP id S20025429AbXLWJke (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 23 Dec 2007 09:40:34 +0000
X-Trace: 3224809/mk-outboundfilter-2.mail.uk.tiscali.com/F2S/$MX-ACCEPTED/nildram-infrastructure/195.149.33.74
X-SBRS:	None
X-RemoteIP: 195.149.33.74
X-IP-MAIL-FROM:	rsandifo@nildram.co.uk
X-IP-BHB: Once
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ah4FAAq7bUfDlSFK/2dsb2JhbACBV5AFl1I
Received: from smtp.nildram.co.uk ([195.149.33.74])
  by smtp.f2s.tiscali.co.uk with ESMTP; 23 Dec 2007 09:39:28 +0000
Received: from firetop.home (85-211-134-127.dyn.gotadsl.co.uk [85.211.134.127])
	by smtp.nildram.co.uk (Postfix) with ESMTP id 331922DC03B;
	Sun, 23 Dec 2007 09:39:27 +0000 (GMT)
Received: from richard by firetop.home with local (Exim 4.63)
	(envelope-from <rsandifo@nildram.co.uk>)
	id 1J6NIu-00018o-7I; Sun, 23 Dec 2007 09:39:28 +0000
From:	Richard Sandiford <rsandifo@nildram.co.uk>
To:	peter fuerst <post@pfrst.de>
Mail-Followup-To: peter fuerst <post@pfrst.de>,Ralf Baechle <ralf@linux-mips.org>,  Thomas Bogendoerfer <tsbogend@alpha.franken.de>,  Kumba <kumba@gentoo.org>,  linux-mips@linux-mips.org, rsandifo@nildram.co.uk
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Kumba <kumba@gentoo.org>, linux-mips@linux-mips.org
Subject: Re: [UPDATED PATCH] IP28 support
References: <Pine.LNX.4.58.0712230242590.215@Indigo2.Peter>
Date:	Sun, 23 Dec 2007 09:39:28 +0000
In-Reply-To: <Pine.LNX.4.58.0712230242590.215@Indigo2.Peter> (peter fuerst's
	message of "Sun\, 23 Dec 2007 02\:44\:01 +0100 \(CET\)")
Message-ID: <871w9d7nsf.fsf@firetop.home>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <rsandifo@nildram.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17870
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rsandifo@nildram.co.uk
Precedence: bulk
X-list: linux-mips

peter fuerst <post@pfrst.de> writes:
>> compile-time base+offset addresses.  And as I said, the compiler is
>> free to make up accesses that aren't in fact valid for cases where
>> the access isn't made.  E.g. if you had a loop with a stride of 128,
>> the compiler could unroll the loop as many times as it likes.  Some
>> of the unrolled iterations might access areas outside the stack frame.
>
> You mean, the compiler would generate $sp+const_int accesses here, whose
> validity is not known at compile-time - similar to foo() above ?

Right.

>> I think you're missing my point.  If you access an I/O-mapped device
>> through KSEG2 or an uncached XKPHYS address, is it not also physically
>> possible (though clearly unwise) to access it through KSEG0 or a cached
>> XKPHYS address too?  So can you guarantee that every const_int cached
>> address in a multi-platform kernel is not I/O-mapped on any of the r10k
>> platforms?  Or can you guarantee that the compiler will not manufacture
>> such an address from an otherwise harmless address?
> Hmm, it's not quite clear, how it could be manufactured.

Similar to the above really, for combinations of suitably bizarre input
code and compiler behaviour.  Again, the problem isn't that such a thing
is _likely_ to happen, just that it wouldn't be wrong for it to happen in
non-r10k situations (and thus not likely to be treated as a "wrong-code"
bug by gcc developers).

>>                                                     Again, the key thing
>> is to think about what the compiler can validly do on non-r10k platforms,
>> however silly it might seem, and then make sure the workarounds cope
>> with it.
>
> Do you think of accesses that essentially look like this ?
>
>   if (machine_x)
>      *uncached(const_addr) = val;
>   else
>      *cached(const_addr) = val;

Well, more generally, I was thinking of something like:


    if (machine_x)
      *cached(const_addr1) = ...;
    else
      ...blah...

where const_addr1 might be harmful if !machine_x.

> Fortunately (at least? even?) on IP28 cached access (hence a block read
> request) to an I/O-device address is a non-issue. In this respect the
> hardware design seems to follow the recommendations from the R10000 manual
> (NACK from external agent?):
> - if such an access graduates (i.e. a "real" access), a bus-error will occur.
> - if not (i.e. mis-speculated), nothing happens.

Ah, OK.  That's what I was missing, thanks.  (I suspect you and Ralf
have explained that to me before, but it hadn't sunk in.  Sorry!)

> However, i don't yet know, how O2 behaves, or, if there exists any other
> R10k-machine, which would need the software-workaround.

OK.

In that case, for the IP28 at least, I think the only issue with excluding
cachable const_int addresses is that the compiler might somehow conspire to
create an address that turns out to be, for some runs at least, an address
in a DMA buffer.

> Well, the option spec could be as listed above. With "store" as default
> for an empty option-string ("none" as default if the option isn't given
> at all).

Sounds good.

Thanks, it seems we have a plan ;)

Richard
