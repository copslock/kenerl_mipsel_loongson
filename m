Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Mar 2004 16:21:57 +0000 (GMT)
Received: from mx.mips.com ([IPv6:::ffff:206.31.31.226]:34485 "EHLO
	mx.mips.com") by linux-mips.org with ESMTP id <S8225419AbUCVQV4>;
	Mon, 22 Mar 2004 16:21:56 +0000
Received: from mercury.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.12.11/8.12.11) with ESMTP id i2MGAgB1018925;
	Mon, 22 Mar 2004 08:10:45 -0800 (PST)
Received: from gmu-linux (gmu-linux.mips.com [172.20.8.94])
	by mercury.mips.com (8.12.11/8.12.11) with ESMTP id i2MGIm7c022587;
	Mon, 22 Mar 2004 08:18:48 -0800 (PST)
Subject: Re: gcc support of mips32 release 2
From: Michael Uhler <uhler@mips.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Dominic Sweetman <dom@mips.com>,
	Eric Christopher <echristo@redhat.com>,
	Long Li <long21st@yahoo.com>, linux-mips@linux-mips.org,
	David Ung <davidu@mips.com>, Nigel Stephens <nigel@mips.com>
In-Reply-To: <Pine.LNX.4.55.0403221153280.6539@jurand.ds.pg.gda.pl>
References: <20040305075517.42647.qmail@web40404.mail.yahoo.com>
	<1078478086.4308.14.camel@dzur.sfbay.redhat.com>
	<16456.21112.570245.1011@arsenal.mips.com>
	<Pine.LNX.4.55.0403181404210.5750@jurand.ds.pg.gda.pl>
	<16473.44507.935886.271157@arsenal.mips.com>
	<Pine.LNX.4.55.0403181528130.5750@jurand.ds.pg.gda.pl>
	<16478.46344.410904.489262@doms-laptop.algor.co.uk> 
	<Pine.LNX.4.55.0403221153280.6539@jurand.ds.pg.gda.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-11) 
Date: 22 Mar 2004 08:19:38 -0800
Message-Id: <1079972378.9814.50.camel@gmu-linux>
Mime-Version: 1.0
X-Spam-Scan: SA 2.63
X-Scanned-By: MIMEDefang 2.39
Return-Path: <uhler@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4611
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: uhler@mips.com
Precedence: bulk
X-list: linux-mips

The real issue is one of strictly nested interrupts.  The lack of an
atomic di, in particular, works fine as long as all interrupts are
strictly nested in such a way that no interrupt code changes the
state of the IM bits between the read and write of the sequence.
While most operating systems appear to be strictly nested, there
are some very important kernels in embedded markets which are not
strictly nested.

When I added di (and, for symmetry, ei) to Release 2, I did so after
spending considerable time talking with these customers and was
convinced that it was important.

/gmu

On Mon, 2004-03-22 at 03:14, Maciej W. Rozycki wrote:

> > The 'di' is there to be atomic.  Such sequences are rare and code
> > compactness is not an issue.  As you probably heard before, the use of
> > a potentially-interruptible RMW sequence on the status register to
> > disable interrupts is potentially troublesome (most common OS' manage
> > themselves so it isn't an issue, but still...)
> 
>  Hmm, is the remaining minority of the OSes, that can't manage the
> sequence, important enough to add such an instruction?  The atomicity of
> this operation should only matter if interrupt handlers are expected to
> leave interrupts disabled upon an exit to the same context -- such a setup
> should be pretty rare.

-- 
Michael Uhler, Chief Technology Officer
MIPS Technologies, Inc.  Email: uhler@mips.com
1225 Charleston Road     Voice:  (650)567-5025  FAX:   (650)567-5225
Mountain View, CA 94043  Mobile: (650)868-6870  Admin: (650)567-5085
