Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Jun 2003 22:45:53 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:48629 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225289AbTFMVpv>;
	Fri, 13 Jun 2003 22:45:51 +0100
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h5DLjkm14861;
	Fri, 13 Jun 2003 14:45:46 -0700
Date: Fri, 13 Jun 2003 14:45:46 -0700
From: Jun Sun <jsun@mvista.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Linux/MIPS Development <linux-mips@linux-mips.org>,
	jsun@mvista.com
Subject: Re: CVS Update@-mips.org: linux
Message-ID: <20030613144546.F14458@mvista.com>
References: <Pine.GSO.4.21.0306132052290.14094-100000@vervain.sonytel.be> <Pine.GSO.3.96.1030613221736.20506C-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1030613221736.20506C-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Fri, Jun 13, 2003 at 10:28:03PM +0200
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2627
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Fri, Jun 13, 2003 at 10:28:03PM +0200, Maciej W. Rozycki wrote:
> On Fri, 13 Jun 2003, Geert Uytterhoeven wrote:
> 
> > So in the future we may see something like this:
> > 
> >   arch/mips/chipset1/...
> >            /chipset2/...
> > 	   /...
> > 	   /board1/...
> > 	   /board2/...
> > 
> > where the board* directories contain the glue code for the specific boards?
> 
>  It looks as a good idea, although possibly an intermediate directory
> would be desireable not to clutter arch/mips too much.  E.g:
> 
>   arch/mips/platforms/platform1/...
>                      /platform2/...
>             ...
>   arch/mips/chipset/chipset1/...
>                    /chipset2/...
> 
> I assume by "chipset" you mean the lone system controller or host bridge. 
>

I agree.

Jun
