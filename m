Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Dec 2002 00:20:21 +0000 (GMT)
Received: from p508B5DCD.dip.t-dialin.net ([IPv6:::ffff:80.139.93.205]:31915
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225291AbSLSAUU>; Thu, 19 Dec 2002 00:20:20 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id gBJ0KDZ07260;
	Thu, 19 Dec 2002 01:20:13 +0100
Date: Thu, 19 Dec 2002 01:20:13 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Juan Quintela <quintela@mandrakesoft.com>,
	linux mips mailing list <linux-mips@linux-mips.org>
Subject: Re: [PATCH]: fix compiler warnings in the math-emulator
Message-ID: <20021219012013.A6998@linux-mips.org>
References: <m2znr4p0e2.fsf@demo.mitica> <Pine.GSO.3.96.1021218173810.5977D-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.3.96.1021218173810.5977D-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Wed, Dec 18, 2002 at 05:43:34PM +0100
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 975
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Dec 18, 2002 at 05:43:34PM +0100, Maciej W. Rozycki wrote:

>  Is it needed?  The part that returns .mx should be optimized away by the
> compiler automagically if unused. 

Functionally these two patches are more or less equivalent but I think
Juan's patch is more readable.  Don't change the fact that the whole FP
emulator could need some heavy polishing ...

  Ralf
