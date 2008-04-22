Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Apr 2008 19:27:44 +0100 (BST)
Received: from kirk.serum.com.pl ([213.77.9.205]:33779 "EHLO serum.com.pl")
	by ftp.linux-mips.org with ESMTP id S28579898AbYDVS1l (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 22 Apr 2008 19:27:41 +0100
Received: from serum.com.pl (IDENT:macro@localhost [127.0.0.1])
	by serum.com.pl (8.12.11/8.12.11) with ESMTP id m3MIRBQk026383;
	Tue, 22 Apr 2008 20:27:11 +0200
Received: from localhost (macro@localhost)
	by serum.com.pl (8.12.11/8.12.11/Submit) with ESMTP id m3MIQs2K026379;
	Tue, 22 Apr 2008 19:27:03 +0100
Date:	Tue, 22 Apr 2008 19:26:54 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Daniel Jacobowitz <dan@debian.org>
cc:	David Daney <ddaney@avtrex.com>, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org
Subject: Re: [Patch 6/6] Ptrace support for HARDWARE_WATCHPOINTS.
In-Reply-To: <20080422162343.GA14790@caradoc.them.org>
Message-ID: <Pine.LNX.4.55.0804221923010.23679@cliff.in.clinika.pl>
References: <480D2151.2020701@avtrex.com> <480D33EB.30808@avtrex.com>
 <20080422162343.GA14790@caradoc.them.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18994
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, 22 Apr 2008, Daniel Jacobowitz wrote:

> On Mon, Apr 21, 2008 at 05:40:11PM -0700, David Daney wrote:
> > +struct mips32_watch_regs {
> > +	unsigned int num_valid;
> > +	unsigned int reg_mask;
> > +	unsigned int irw_mask;
> > +	unsigned long watchlo[8];
> > +	unsigned int watchhi[8];
> > +};
> 
> Please do not use long in new ptrace interfaces.  Use either
> uint32_t or uint64_t as appropriate so that it doesn't depend
> on how the kernel or debugger was built.

 A minor nit from my side too -- since it is a new API it may be wise to
move wider structure members to the beginning not to waste gaps in memory
due to alignment.

  Maciej
