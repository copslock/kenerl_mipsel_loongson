Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Dec 2002 16:49:22 +0000 (GMT)
Received: from gateway-1237.mvista.com ([12.44.186.158]:31996 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225237AbSLKQtW>;
	Wed, 11 Dec 2002 16:49:22 +0000
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id gBBGnEE06766;
	Wed, 11 Dec 2002 08:49:14 -0800
Date: Wed, 11 Dec 2002 08:49:14 -0800
From: Jun Sun <jsun@mvista.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: linux-mips@linux-mips.org, jsun@mvista.com
Subject: Re: IDE module problem
Message-ID: <20021211084914.A6755@mvista.com>
References: <20021209115842.Q8642@mvista.com> <Pine.GSO.3.96.1021211141709.22157A-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1021211141709.22157A-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Wed, Dec 11, 2002 at 02:21:48PM +0100
Return-Path: <jsun@orion.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 856
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Wed, Dec 11, 2002 at 02:21:48PM +0100, Maciej W. Rozycki wrote:
> On Mon, 9 Dec 2002, Jun Sun wrote:
> 
> > If you configure IDE support as a module (CONFIG_IDE), you
> > will soon find that ide-std.o and ide-no.o are missing.
> > This is because arch/mips/lib/Makefile says:
> > 
> > obj-$(CONFIG_IDE)               += ide-std.o ide-no.o
> [...]
> > 3) use some smart trick in Makefile so that we include those
> > two files only if CONFIG_IDE is 'y' or 'm'.  (How?)
> 
>  obj-$(CONFIG_IDE_MODULE)
>

This does not work.  Apparently, CONFIG_IDE_MODULE is not created 
for makefile part.

Jun
