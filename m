Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Oct 2002 15:46:49 +0200 (CEST)
Received: from p508B64CB.dip.t-dialin.net ([80.139.100.203]:10120 "EHLO
	dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S1123897AbSJBNqs>; Wed, 2 Oct 2002 15:46:48 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g92Dkcn16948;
	Wed, 2 Oct 2002 15:46:38 +0200
Date: Wed, 2 Oct 2002 15:46:38 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Carsten Langgaard <carstenl@mips.com>, linux-mips@linux-mips.org
Subject: Re: 64-bit kernel patch.
Message-ID: <20021002154638.B16482@linux-mips.org>
References: <3D9AF333.BC304A34@mips.com> <Pine.GSO.3.96.1021002153025.8947A-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.3.96.1021002153025.8947A-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Wed, Oct 02, 2002 at 03:40:27PM +0200
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 334
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Oct 02, 2002 at 03:40:27PM +0200, Maciej W. Rozycki wrote:

>  As a side note -- arch/mips64/kernel/linux32.c is a huge collection of
> often unrelated functions.  It might be beneficial to split the file
> functionally, e.g. into fs32.c, net32.c, etc. or even with a finer grain,
> preferably in a subdirectory, e.g. arch/mips64/linux32/.  What do you
> think? 

Much of the code is so generic it almost deserves to live in a directory
even higher in the hierarchy.  If you look at the 32-bit compat code for
the various 64-bit architectures of Linux (in particular sparc64 and ia64),
it's a single huge cut'n'paste session.  Not much of that code is actually
architecture dependant.

  Ralf
