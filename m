Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Nov 2002 14:00:20 +0100 (MET)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:29904 "EHLO
	delta.ds2.pg.gda.pl") by ralf.linux-mips.org with ESMTP
	id <S870069AbSK2NAJ>; Fri, 29 Nov 2002 14:00:09 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id OAA26282;
	Fri, 29 Nov 2002 14:03:01 +0100 (MET)
Date: Fri, 29 Nov 2002 14:03:00 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@linux-mips.org>
cc: atul srivastava <atulsrivastava9@rediffmail.com>,
	linux-mips@linux-mips.org
Subject: Re: a quick question regarding CONFIG_MIPS_UNCACHED..
In-Reply-To: <20021129134230.A11704@linux-mips.org>
Message-ID: <Pine.GSO.3.96.1021129135000.24948B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 742
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Fri, 29 Nov 2002, Ralf Baechle wrote:

> It's been my observation that hardly any user is aware of these consquences
> nor is the Linux code making a good attempt at complying with all the
> additional restrictions of running uncached.  So in my oppinion
> CONFIG_MIPS_UNCACHED should go.  But I don't feel very strong about it so
> I'm going to wait for a few days so others have a chance to raise their
> voice.

 I completely agree with your points and I'm not fond of this option,
either.  I had a need to run uncached to debug a problem once and even
then it was on the R3k, so I had to set up things differently from what
that option does anyway.  I can't recall the details of the problem, but
coding hooks for an uncached setup took me maybe half an hour, so I don't
think that is a problem for anyone who really needs it.

 BTW, how do you know that ll/sc happens to work for uncached operation on
some processors?  Maybe it simply fails, but the result is subtle enough
not to be observed easily.  A failure may be masked by other factors, e.g. 
for the UP operation, there is normally no way for two parallel requests
for a spinlock to happen and an exception resets the LLbit regardless of
the caching attribute of the area involved.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
