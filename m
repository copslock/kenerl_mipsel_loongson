Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1FFPd622962
	for linux-mips-outgoing; Fri, 15 Feb 2002 07:25:39 -0800
Received: from dea.linux-mips.net (a1as07-p91.stg.tli.de [195.252.188.91])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1FFPZ922959
	for <linux-mips@oss.sgi.com>; Fri, 15 Feb 2002 07:25:35 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.1) id g1FELWU00640;
	Fri, 15 Feb 2002 15:21:32 +0100
Date: Fri, 15 Feb 2002 15:21:32 +0100
From: Ralf Baechle <ralf@oss.sgi.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Guido Guenther <agx@sigxcpu.org>, linux-mips@oss.sgi.com
Subject: Re: ip22 watchdog timer
Message-ID: <20020215152132.A602@dea.linux-mips.net>
References: <20020215130613.A301@gandalf.physik.uni-konstanz.de> <Pine.GSO.3.96.1020215150825.29773K-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1020215150825.29773K-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Fri, Feb 15, 2002 at 03:17:17PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Feb 15, 2002 at 03:17:17PM +0100, Maciej W. Rozycki wrote:

>  This looks suspicious.  Haven't you meant "dep_tristate"?  Especially as
> indydog.c doesn't seem to make any effort to validate it's running on the
> system it thinks it is before poking random memory locations.  It won't
> probably even compile for a non-MIPS kernel.
> 
>  BTW, why do people insist on sending patches as attachments -- it makes
> commenting them helly twisted, sigh... 

How true.  MIME - broken solution for a broken design ;)  More serious,
MIME makes sense when using a MUA that garbles patches like Netscape or
certain versions of Pine.

  Ralf  (Prolly still be using Mutt + vi in 5 years ...)
