Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Oct 2002 17:36:11 +0200 (CEST)
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:23213 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S1122978AbSJOPgL>; Tue, 15 Oct 2002 17:36:11 +0200
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id RAA17792;
	Tue, 15 Oct 2002 17:36:30 +0200 (MET DST)
Date: Tue, 15 Oct 2002 17:36:29 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Johannes Stezenbach <js@convergence.de>
cc: "Kevin D. Kissell" <kevink@mips.com>, linux-mips@linux-mips.org
Subject: Re: Once again: test_and_set for CPUs w/o LL/SC
In-Reply-To: <20021007184344.GA17548@convergence.de>
Message-ID: <Pine.GSO.3.96.1021015171817.16503B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 439
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Mon, 7 Oct 2002, Johannes Stezenbach wrote:

> The question is how the glibc can detect if
> a) the CPU does not have LL/SC
> b) the kernel guarantees k1 != MAGIC

 Well, since the relevant code will mostly be inlined, you don't really
need either as you can't select an alternative anyway.  The relevant
variant will be selected at the build time as it's already being done for
the ll/sc and sysmips() variants.  You may consider marking binaries as
using your approach so that the kernel refuses to run them if unsupported,
but for MIPS it isn't performed for any functionality so far, so you'd
have to study how other ports do that and which way is most suitable. 

> I also want to know if there's public interest to get such
> a change in the kernel. If yes, I will try to get a matching
> patch into glibc. If no, I will just post the current patch I
> use to the list for the hackers to pick up.

 Well, the kernel changes should be trivial, with no performance impact if
written carefully, so they might get included even if only a few people
are interested.  Send a proposal.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
