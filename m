Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g14JJDf26418
	for linux-mips-outgoing; Mon, 4 Feb 2002 11:19:13 -0800
Received: from dea.linux-mips.net (a1as18-p231.stg.tli.de [195.252.193.231])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g14JJ8A26331
	for <linux-mips@oss.sgi.com>; Mon, 4 Feb 2002 11:19:08 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.1) id g14H2w404022;
	Mon, 4 Feb 2002 18:02:58 +0100
Date: Mon, 4 Feb 2002 18:02:58 +0100
From: Ralf Baechle <ralf@oss.sgi.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Jason Gunthorpe <jgg@debian.org>, linux-mips@fnet.fr,
   linux-mips@oss.sgi.com
Subject: Re: [patch] linux 2.4.17: An mb() rework
Message-ID: <20020204180258.A6124@dea.linux-mips.net>
References: <Pine.LNX.3.96.1020130123109.11192A-100000@wakko.deltatee.com> <Pine.GSO.3.96.1020131115837.5578A-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1020131115837.5578A-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Thu, Jan 31, 2002 at 01:17:39PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Jan 31, 2002 at 01:17:39PM +0100, Maciej W. Rozycki wrote:

>  Certain DECstation models have a write-back buffer that needs to be
> handled explicitly.  For example rmb() is "1: bc0f 1b" for the R3220 WB
> chip.  Wmb() is null, certainly, as the buffer is strongly-ordered.  See
> arch/mips/dec/wbflush.c for details.

Just as an aside that isn't directly relevant to DECstations.  To date
all MIPS _processors_ are strongly ordered.  I now know of at least one
processor that implements a weakly ordered memory model, so the assumption
of a strongly ordered memory model has become void for large parts of the
kernel.  Even before that some systems had strongly ordered processors in
system environments that may reorder requests.

Bugs due to surprise memory reordering are entirely unfun to debug, so be
paranoid.  They're out there to get you ...

  Ralf
