Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Dec 2002 23:50:07 +0000 (GMT)
Received: from p508B6DCE.dip.t-dialin.net ([IPv6:::ffff:80.139.109.206]:60569
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225304AbSLQXuH>; Tue, 17 Dec 2002 23:50:07 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id gBHNo2J01715;
	Wed, 18 Dec 2002 00:50:02 +0100
Date: Wed, 18 Dec 2002 00:50:02 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: linux-mips@linux-mips.org
Subject: Re: compute_return_epc
Message-ID: <20021218005002.A1532@linux-mips.org>
References: <20021217134333.A26119@linux-mips.org> <Pine.GSO.3.96.1021217145149.7289B-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.3.96.1021217145149.7289B-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Tue, Dec 17, 2002 at 02:54:45PM +0100
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 927
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Dec 17, 2002 at 02:54:45PM +0100, Maciej W. Rozycki wrote:

> > So I'd like to apply the following patch which limits the use of
> > compute_return_epc to those cases where we actually did some sort of
> > instruction emulation.  Comments?
> 
>  Ah, finally!  Thanks for offloading the task from me. ;-) 

Wonderful :-)

  Ralf
