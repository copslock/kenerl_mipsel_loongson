Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Sep 2006 04:18:10 +0100 (BST)
Received: from web31506.mail.mud.yahoo.com ([68.142.198.135]:20391 "HELO
	web31506.mail.mud.yahoo.com") by ftp.linux-mips.org with SMTP
	id S20037478AbWI0DSH (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 27 Sep 2006 04:18:07 +0100
Received: (qmail 87248 invoked by uid 60001); 27 Sep 2006 03:18:01 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=JH1fB+687EcR+/LjOZhI1wphRJC5VCzwYinrEti7gFPf3dPe2T6axGhemiQ3bpeG/lp9rh+aIKbryRSau3SfloFjxnJisOvER7PXUoZocVxzoPf1VRkGSpyqea6LAIcoOIBU36MPOM6hrTGyabWV6N54UfFqnisM0f/z3/KFmag=  ;
Message-ID: <20060927031800.87246.qmail@web31506.mail.mud.yahoo.com>
Received: from [65.102.5.19] by web31506.mail.mud.yahoo.com via HTTP; Tue, 26 Sep 2006 20:18:00 PDT
Date:	Tue, 26 Sep 2006 20:18:00 -0700 (PDT)
From:	Jonathan Day <imipak@yahoo.com>
Subject: Re: How to work with Linux-Mips ?
To:	Peter Popov <ppopov@embeddedalley.com>,
	Franck <vagabon.xyz@gmail.com>
Cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
In-Reply-To: <4519859A.1090306@embeddedalley.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <imipak@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12690
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: imipak@yahoo.com
Precedence: bulk
X-list: linux-mips



--- Peter Popov <ppopov@embeddedalley.com> wrote:
> There is no such thing as a 10 sec patch review.
> Especially when it
> comes to patches that touch generic portions of the
> kernel.

That is extremely true. One has to only look at the
number of "Brown Paper Bag" releases, over the history
of Linux, to realize that even the intense reviews
that take place are sometimes not enough.

> MIPS Tech and linux-mips are separate entities.
> Personally I think MIPS
> Tech has done a great service to themselves, their
> customers, and the
> entire Linux MIPS community, by hiring Ralf to do
> new MIPS development
> and properly support new chips coming out.

Whilst I agree entirely, I think we need to put a
little more perspective on this. The Linux kernel is
big. Very, very big. By my estimate, it would take an
army of 10,000+ full-time software engineers skilled
in "Extreme Programming" and formal methods to be able
to verify something of the complexity and intricacy of
the Linux kernel within a single year, excluding any
changes made during that time, which will likely
replace so much of the code that the verification
won't tell you much anyway.

If every company and every University involved in
Linux - not just every consortium - were to
contribute, you might be able to amass that kind of
manpower. One full-time coder for the entire of the
MIPS side of the tree is valuable and it's doubtful
any branch could now survive long without at least
that, one person is simply not capable of replacing
ten thousand, no matter how brilliant they are.

This isn't to say MIPS Tech should necessarily throw
in more manpower, although I certainly wouldn't argue
with that. It's that there's simply no realistic way
to get enough manpower together to do code reviews in
the kind of timeframes that people are asking for.

Rather than curse out the absence of something that is
beyond any realistic reach, it might be good for
people to reflect on the sheer magnitude of what we do
have.

I'd also like to throw in one other thought - people
have patches and patch-sets on web pages that are
popular but don't get merged in for ages, or sometimes
at all. I know this as well as anyone can - I ran a
project for a while that did nothing but collect the
really significant patches and patchsets out there and
merge them into one gigantic megapatch. It was about
two-thirds the size of the kernel itself.

Even at that kind of size, there was probably as much
out there that I knew about but omitted as I included,
and very likely ten times as much as all that combined
that I never knew about at all.

Today, with far more developers, far more hardware,
far more gadgets and gizmos, vastly more R&D, and
infinitely more interest in Linux, the ratio of
included code to code "missing, presumed blogged" can
only be worse. The various development teams don't
scale nearly as well or as fast as the Internet.

On that basis, my guess is that there is probably
between 15-20 times as much interesting code out there
that has not been reviewed and included as there is
code in the whole of the Linux kernel as it currently
stands. If, as may well happen, interest goes through
another explosion before 2.8 gets out, then this could
easily double over the next three or four years.

Yes, I wish things moved faster. Yes, I wish there
were fewer problems with some of the boards I use. I
also wish I knew next week's lottery numbers. The odds
of me finding a valid solution to the third seems
infinitely more likely than anyone developing a
perfect, lightning-speed solution to the first two.


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
