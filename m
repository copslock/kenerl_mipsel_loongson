Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Sep 2002 16:02:07 +0200 (CEST)
Received: from alg133.algor.co.uk ([62.254.210.133]:46786 "EHLO
	oval.algor.co.uk") by linux-mips.org with ESMTP id <S1122960AbSIIOCH>;
	Mon, 9 Sep 2002 16:02:07 +0200
Received: from gladsmuir.algor.co.uk (pubfw.algor.co.uk [62.254.210.129])
	by oval.algor.co.uk (8.11.6/8.10.1) with ESMTP id g89E1ir21266;
	Mon, 9 Sep 2002 15:01:49 +0100 (BST)
From: Dominic Sweetman <dom@algor.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15740.43464.282405.987558@gladsmuir.algor.co.uk>
Date: Mon, 9 Sep 2002 15:01:44 +0100
To: Ralf Baechle <ralf@linux-mips.org>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	Daniel Jacobowitz <dan@debian.org>,
	"Kevin D. Kissell" <kevink@mips.com>,
	Tor Arntsen <tor@spacetec.no>,
	Carsten Langgaard <carstenl@mips.com>,
	linux-mips@linux-mips.org
Subject: Re: 64-bit and N32 kernel interfaces
In-Reply-To: <20020906121424.E2993@linux-mips.org>
References: <20020905142249.GA15843@nevyn.them.org>
	<Pine.GSO.3.96.1020905165445.7444D-100000@delta.ds2.pg.gda.pl>
	<20020906121424.E2993@linux-mips.org>
X-Mailer: VM 6.92 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Return-Path: <dom@algor.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 149
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dom@algor.co.uk
Precedence: bulk
X-list: linux-mips


Ralf Baechle (ralf@linux-mips.org) writes:

> In the SGI world o32 basically has been killed - there no more 32-bit
> processors shipped since many years.  So most SGI MIPS systems are
> running N32 code by standard and N64 is available as an option which only
> is used for the small number of applications that actually are going to
> gain from it.  O32 is deprecated; at this time it's just historical garbage.

True: but just to emphasise that's SGI.

There are still lots of 32-bit MIPS CPUs about (which can't run
n32/n64, of course) which may want to run Linux, and for now o32 is
all that is available to them.

Dominic
