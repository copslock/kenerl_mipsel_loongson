Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Oct 2002 19:21:15 +0200 (CEST)
Received: from buserror-extern.convergence.de ([212.84.236.66]:55301 "EHLO
	hell") by linux-mips.org with ESMTP id <S1122978AbSJORVP>;
	Tue, 15 Oct 2002 19:21:15 +0200
Received: from js by hell with local (Exim 3.35 #1 (Debian))
	id 181VNU-0005Yg-00; Tue, 15 Oct 2002 19:21:08 +0200
Date: Tue, 15 Oct 2002 19:21:08 +0200
From: Johannes Stezenbach <js@convergence.de>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: "Kevin D. Kissell" <kevink@mips.com>, linux-mips@linux-mips.org
Subject: Re: Once again: test_and_set for CPUs w/o LL/SC
Message-ID: <20021015172108.GD21220@convergence.de>
Mail-Followup-To: Johannes Stezenbach <js@convergence.de>,
	"Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	"Kevin D. Kissell" <kevink@mips.com>, linux-mips@linux-mips.org
References: <20021007184344.GA17548@convergence.de> <Pine.GSO.3.96.1021015171817.16503B-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1021015171817.16503B-100000@delta.ds2.pg.gda.pl>
User-Agent: Mutt/1.4i
Return-Path: <js@convergence.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 441
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: js@convergence.de
Precedence: bulk
X-list: linux-mips

On Tue, Oct 15, 2002 at 05:36:29PM +0200, Maciej W. Rozycki wrote:
> On Mon, 7 Oct 2002, Johannes Stezenbach wrote:
> 
> > The question is how the glibc can detect if
> > a) the CPU does not have LL/SC
> > b) the kernel guarantees k1 != MAGIC
> 
>  Well, since the relevant code will mostly be inlined, you don't really
> need either as you can't select an alternative anyway.  The relevant
> variant will be selected at the build time as it's already being done for
> the ll/sc and sysmips() variants.  You may consider marking binaries as
> using your approach so that the kernel refuses to run them if unsupported,
> but for MIPS it isn't performed for any functionality so far, so you'd
> have to study how other ports do that and which way is most suitable. 

Well, in the (experimental) glibc-patch I posted here on
Fri, 19 Jul 2002 14:38:29 +0200 (Subject: LL/SC benchmarking),
I had some code that lets one chose the implementation
(sysmips vs. LL/SC vs. beql_k1) at run-time, based on the
existence of some "signaling" files. This was used for benchmarking.

The ability to choose the implementation at run time sacrifices
inlining, but has obvious performance benefits for the VR41XX-like
platforms. It's also not a special MIPS thing,
e.g. linuxthreads/sysdeps/<platform>/pt-machine.h has the
HAS_COMPARE_AND_SWAP / TEST_FOR_COMPARE_AND_SWAP hooks,
used by e.g. i386.

But all that is of interest only, if VR41XX-like platforms
would use a glibc from a binary distribution like RedHat or
Debian (I use Debian for development, but have a custom
compiled glibc for production use).
But it seems that this isn't the case?

> > I also want to know if there's public interest to get such
> > a change in the kernel. If yes, I will try to get a matching
> > patch into glibc. If no, I will just post the current patch I
> > use to the list for the hackers to pick up.
> 
>  Well, the kernel changes should be trivial, with no performance impact if
> written carefully, so they might get included even if only a few people
> are interested.  Send a proposal.

Yes, the kernel changes are not difficult. The difficulty was
to find out the minimal necessary changes.


Regards,
Johannes
