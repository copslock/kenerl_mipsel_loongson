Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Apr 2003 15:26:17 +0100 (BST)
Received: from p508B74BA.dip.t-dialin.net ([IPv6:::ffff:80.139.116.186]:52374
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225264AbTDOO0Q>; Tue, 15 Apr 2003 15:26:16 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h3FEQAC08872;
	Tue, 15 Apr 2003 16:26:10 +0200
Date: Tue, 15 Apr 2003 16:26:10 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: linux-mips@linux-mips.org
Subject: Re: [patch] do_IRQ() and init_i8259_irqs() declarations
Message-ID: <20030415162610.A8778@linux-mips.org>
References: <Pine.GSO.3.96.1030415160755.13254G-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.3.96.1030415160755.13254G-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Tue, Apr 15, 2003 at 04:15:47PM +0200
Return-Path: <ralf@linux-mips.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2056
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Apr 15, 2003 at 04:15:47PM +0200, Maciej W. Rozycki wrote:

>  There is a number of private declarations of do_IRQ() and
> init_i8259_irqs() scattered through the code.  These for do_IRQ() often
> have a different "opinion" on how the function is interfaced... 
> 
>  The following patch puts public declarations in appropriate headers and
> converts users of these functions to get the prototypes from there
> instead.  It also removes various related unused declarations. 
> 
>  OK?

Yes, please.
