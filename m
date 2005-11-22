Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Nov 2005 12:24:53 +0000 (GMT)
Received: from extgw-uk.mips.com ([62.254.210.129]:53532 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S3466290AbVKVMY3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 22 Nov 2005 12:24:29 +0000
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id jAMCR4wk009537;
	Tue, 22 Nov 2005 12:27:04 GMT
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id jAMCR38u009536;
	Tue, 22 Nov 2005 12:27:03 GMT
Date:	Tue, 22 Nov 2005 12:27:03 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Nigel Stephens <nigel@mips.com>,
	"Kevin D. Kissell" <kevink@mips.com>,
	"Knittel, Brian" <Brian.Knittel@powertv.com>,
	linux-mips@linux-mips.org
Subject: Re: Saving arguments on the stack
Message-ID: <20051122122703.GD2706@linux-mips.org>
References: <762C0A863A7674478671627FEAF5848105AF92D2@hqmail01.powertv.com> <4382DC76.60506@mips.com> <4382FF29.2020605@mips.com> <20051122112417.GB2706@linux-mips.org> <Pine.LNX.4.64N.0511221128150.14593@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0511221128150.14593@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9533
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Nov 22, 2005 at 11:39:28AM +0000, Maciej W. Rozycki wrote:

> > > 'Fraid not: the -g option only adds debug info to the object file, it 
> > > shouldn't alter the generated code. Using -O0 will certainly store 
> > > everything on the stack, but it also won't be "with otherwise optimized 
> > > code".
> > 
> > And the kernel won't build without optimization - but that's FAQ since
> > 10 years.
> 
>  Well, with "__attribute__((always_inline))" available and actually used 
> already, perhaps this requirement could be relaxed nowadays...

There were functions in the network stack that intensionally were
declared extern inline to make sure the compiler won't be able to outline
that function unnoticed.  I just grepped for it and can't find it
anymore, must be a relativly recent improvment.

We also rely on the compiler eleminating calls to certain functions
entirely, for example to __xchg_called_with_bad_pointer().

  Ralf
