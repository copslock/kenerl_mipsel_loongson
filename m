Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Sep 2004 14:44:41 +0100 (BST)
Received: from quail.cita.utoronto.ca ([IPv6:::ffff:128.100.76.6]:28134 "EHLO
	localhost.localdomain") by linux-mips.org with ESMTP
	id <S8225216AbUIXNog>; Fri, 24 Sep 2004 14:44:36 +0100
Received: from cita.utoronto.ca (lemming.cita.utoronto.ca [128.100.76.53])
	by localhost.localdomain (8.12.11/8.12.11) with ESMTP id i8ODhYMb004377
	for <linux-mips@linux-mips.org>; Fri, 24 Sep 2004 09:43:34 -0400
Received: from lemming.cita.utoronto.ca (localhost [127.0.0.1])
	by cita.utoronto.ca (8.12.11/8.12.8) with ESMTP id i8ODhYHb029826
	for <linux-mips@linux-mips.org>; Fri, 24 Sep 2004 09:43:34 -0400
Received: (from rjh@localhost)
	by lemming.cita.utoronto.ca (8.12.11/8.12.11/Submit) id i8ODhYG3029825
	for linux-mips@linux-mips.org; Fri, 24 Sep 2004 09:43:34 -0400
Date: Fri, 24 Sep 2004 09:43:34 -0400
From: Robin Humble <rjh@cita.utoronto.ca>
To: linux-mips@linux-mips.org
Subject: Re: Kernel 2.6 for R4600 Indy
Message-ID: <20040924134334.GB27739@lemming.cita.utoronto.ca>
References: <4152D58B.608@longlandclan.hopto.org> <4152E4FC.8000408@gentoo.org> <41536765.9000304@longlandclan.hopto.org> <41541B8D.3060500@gentoo.org> <20040924131734.GC26710@lemming.cita.utoronto.ca> <415420D0.60102@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <415420D0.60102@gentoo.org>
User-Agent: Mutt/1.4.1i
Return-Path: <rjh@cita.utoronto.ca>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5887
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rjh@cita.utoronto.ca
Precedence: bulk
X-list: linux-mips

On Fri, Sep 24, 2004 at 09:27:44AM -0400, Stephen P. Becker wrote:
>Mostly, 64-bit binaries are much larger than 32-bit.  Consider that the 
>scsi controller in an Indy gets about 2mb/sec throughput MAX (on a good 

/usr/bin/e* on i386 vs x86_64 is 17432 vs 12440 kB => about 40% bigger.
so indeed that's a fair bit larger :-)

I didn't think it was quite as bad as 2MB/s though, maybe 4. I'll dig my
Indys out of storage and give them a whirl.

>day).  Also, Indys don't support a large enough memory configuration 
>that 64-bit would be worth it anyhow.

indeed they don't.
do you get access to more registers or more efficient instruction sets
like you do on x86_64?

>What you would *really* want on such a machine would be n32 userland. 
>You get full 64-bit instructions, but the binaries aren't huge.

fair enough.

cheers,
robin
