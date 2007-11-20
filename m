Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Nov 2007 11:39:35 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:32977 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20029049AbXKTLjd (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 20 Nov 2007 11:39:33 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id lAKBdWA2012585;
	Tue, 20 Nov 2007 11:39:32 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id lAKBdVZt012584;
	Tue, 20 Nov 2007 11:39:31 GMT
Date:	Tue, 20 Nov 2007 11:39:31 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Markus Gothe <markus.gothe@27m.se>
Cc:	Florian Lohoff <flo@rfc822.org>, linux-mips@linux-mips.org
Subject: Re: [SPAM] Re: IP22 64Bit arcboot - current git crashes on 3
	machines at different points
Message-ID: <20071120113931.GA12018@linux-mips.org>
References: <20071119160954.GA12244@paradigm.rfc822.org> <20071119193137.GA27317@linux-mips.org> <775F4404-2D0A-4E65-9401-E2193B96DBDC@27m.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <775F4404-2D0A-4E65-9401-E2193B96DBDC@27m.se>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17548
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Nov 20, 2007 at 03:49:07AM +0100, Markus Gothe wrote:

> Afaik R4x00 is just semi-64bit in contrast to the R5K, which derives from 
> the R10K.

Total rubbish.  The R4x00 family hardly is a family but just happens to
have similar type numbers.

  o R4000/R4400 are very close related, 64-bit databus
  o R4100, R4200, R4300 series only have 32-bit databus and are low end
    embedded stuff.  All these have 32-bit external busses only.
  o R4600 was designed by Qed shortly after the R4000 was developed by
    MIPS.  It has a much shorted pipeline, consumes less power and performs
    better except for the most heavy FP apps.  The R4700 is a slightly
    improved version of the R4600 and catches up on FP too but was rarely
    used.
  o R5000 has alot of similarities to the R4600/R4700 and was also designed
    by QED.  Not sure if it really should be considered a derivate of these.
    The RM7000 and RM9000 family eventually continued this line of evolution.
  o R10000 is a no-prisoners-taken from scratch OOO CPU design released in
    '94 and to become SGI's highend processor.  The architecture is
    aggressive to the point where it even today looks complex - but that
    also means that the R10000 implementation have hardly any similarity
    with their predecessors.   The R12000 is a slightly beefed up shrink of
    the R10000, the R14000 is the same to the R12000 and the R16000 is one
    more shrink.  Conventional wisdom is that the 2nd shrink already going
    to return diminishing returns but it seems to have worked for SGI.

And of course all these are are MIPS III/MIPS IV processors, so modulo
bugs and sanity fully 64-bit software capable.

  Ralf
