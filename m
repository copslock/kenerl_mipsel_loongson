Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1CGtNp12219
	for linux-mips-outgoing; Tue, 12 Feb 2002 08:55:23 -0800
Received: from oval.algor.co.uk (root@oval.algor.co.uk [62.254.210.250])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1CGtB912215;
	Tue, 12 Feb 2002 08:55:11 -0800
Received: from gladsmuir.algor.co.uk.algor.co.uk (IDENT:dom@gladsmuir.algor.co.uk [192.168.5.75])
	by oval.algor.co.uk (8.11.6/8.10.1) with ESMTP id g1CFt5400907;
	Tue, 12 Feb 2002 15:55:07 GMT
From: Dominic Sweetman <dom@algor.co.uk>
MIME-Version: 1.0
Message-ID: <15465.15062.840707.525971@gladsmuir.algor.co.uk>
Date: Tue, 12 Feb 2002 15:55:02 +0000
To: linux-mips@oss.sgi.com
Cc: Johannes Stezenbach <js@convergence.de>, nigel@algor.co.uk,
   "Hartvig Ekner <hartvige@mips.com>
    \"Maciej W. Rozycki\"" <macro@ds2.pg.gda.pl>,
   Florian Lohoff <flo@rfc822.org>, Ralf Baechle <ralf@oss.sgi.com>
Subject: Re: gcc include strangeness
In-Reply-To: <20020211232001.G4623@dea.linux-mips.net>
References: <20020211142708.GA2577@convergence.de>
	<Pine.GSO.3.96.1020211155920.18917F-100000@delta.ds2.pg.gda.pl>
	<20020211162844.GD2918@convergence.de>
	<20020211232001.G4623@dea.linux-mips.net>
X-Mailer: VM 6.89 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
User-Agent: SEMI/1.13.7 (Awazu) CLIME/1.13.6 (=?ISO-2022-JP?B?GyRCQ2YbKEI=?=
 =?ISO-2022-JP?B?GyRCJU4+MRsoQg==?=) MULE XEmacs/21.1 (patch 14) (Cuyahoga
 Valley) (i386-redhat-linux)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by oss.sgi.com id g1CGtC912216
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


I've been keeping quiet through all this, but perhaps I should speak
up.

Algorithmics maintains a GNU toolchain for embedded systems and
supplies it bundled with support and a basic run-time system as our
product SDE-MIPS.

>From version 5.0 (just gone into beta) we are configuring and testing
the compiler/assembler/object tools for Linux use.  We always publish
the GNU sources used to build SDE-MIPS on our web-site, but we are
currently leaning towards going further and putting binary RPMs of the
Linux toolchain out for free download - so those of you who want can
just use it.

The upside of this is that we have the resource and skill (and it
looks like we'll be able to get enough support/development funding) to
maintain a Linux/MIPS compiler.  It would be a good thing for the
Linux/MIPS community if compiler bugs and shortcomings got fixed on a
fairly stable base, instead of relying on pick-your-version folklore.
We should also be able to get funding to do things like fixing support
for SGI n32/n64 code-generation conventions.

Our compiler already has support for pretty much every wrinkle
of any MIPS instruction set anywhere, and command-line-selectable
machine descriptions for many different MIPS pipelines.

The downside: our development process is not currently very
Linux-shaped.  We "release late, release rarely".  In providing a
stable compiler for embedded use we have found it easier to avoid the
bleeding edge of GCC.  We've found it necessary to make bold changes
in "machine-independent" code - GCC is a wonderful multi-target
compiler, but it's x86 (PPC a distant second) which is routinely
tested.  The leading edge is a fertile breeding ground of bugs for
minor architectures.

And more: our v5.0 compiler's ancestor was a 2.96 release from Cygnus'
internal development tree, provided to MIPS Technologies in the fall
of 2000.  We picked it up because it had work MIPS had already funded,
and some valuable multiple-issue machine description features which
didn't make it into 3.0.  But it has taken a long time to make sure
the new compiler is as well-tuned and reliable as the EGCS 1.1-based
compiler it replaced, and the 2.96-derived compiler is only now
shipping as part of a beta release.

So now we have numerous patches, many of them not in officially "MIPS
machine-dependent" code, against an 18-months old and slightly strange
version of GCC.  Nobody is currently doing the substantial work to
turn our changes into patches for GCC 3.x.

What I think we ought to do is to:

o Release the existing compiler for use among Linux/MIPS enthusiasts
  (we're hoping that some commercial developers will take support
  contracts, of course);

o Hope that many of you will use it and feed back bug reports, and
  that some of you will grab the sources and help track & fix them;

o Aim to make earlier and more frequent releases for adventurous Linux
  users (we will keep a slow-moving 'stable' release for those whose
  priority is elsewhere);

o Aim over the next couple of years - and with all the help we can get
  - to converge closer to the evolving GCC 3.x mainstream.

I guess the question for this list is: is anyone interested?

--
Dominic Sweetman
Algorithmics Ltd
The Fruit Farm, Ely Road, Chittering, CAMBS CB5 9PH, ENGLAND
phone +44 1223 706200/fax +44 1223 706250/direct +44 1223 706205
http://www.algor.co.uk
