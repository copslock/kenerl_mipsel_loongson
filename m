Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Nov 2002 16:47:14 +0100 (CET)
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:44524 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S1122118AbSKYPrO>; Mon, 25 Nov 2002 16:47:14 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id QAA13933;
	Mon, 25 Nov 2002 16:47:34 +0100 (MET)
Date: Mon, 25 Nov 2002 16:47:33 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@linux-mips.org>
cc: Daniel Jacobowitz <dan@debian.org>,
	atul srivastava <atulsrivastava9@rediffmail.com>,
	linux-mips@linux-mips.org
Subject: Re: watch exception only for kseg0 addresses..?
In-Reply-To: <20021125160800.A22590@linux-mips.org>
Message-ID: <Pine.GSO.3.96.1021125163423.8769I-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 715
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Mon, 25 Nov 2002, Ralf Baechle wrote:

> MIPS64 extends that to also support instruction address matches; the
> granularity can be set anywhere from 8 bytes to 4kB; in addition ASID
> matching and a global bit can be used for matching.  A MIPS64 CPU can
> support anywhere from 0 to 4 such watch registers.

 Actually up to eight -- for all dmfc0/dmtc0 3-bit "sel" values, if I read
it correctly.

> The global bit stuff would only be useful for in-kernel use, I think.  The
> ASID thing could be used to implement watchpoints for an entire process, not
> just per thread though I doubt there is much use for something like that.

 Well, there are two options only -- either use global matching or ASID
matching.  What else would you expect?  Do you mean lazy vs immediate
switching? 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
