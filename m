Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1FGA6126302
	for linux-mips-outgoing; Fri, 15 Feb 2002 08:10:06 -0800
Received: from dea.linux-mips.net (a1as07-p91.stg.tli.de [195.252.188.91])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1FGA0926287
	for <linux-mips@oss.sgi.com>; Fri, 15 Feb 2002 08:10:00 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.1) id g1FF61R01153;
	Fri, 15 Feb 2002 16:06:01 +0100
Date: Fri, 15 Feb 2002 16:06:01 +0100
From: Ralf Baechle <ralf@oss.sgi.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Guido Guenther <agx@sigxcpu.org>, linux-mips@oss.sgi.com
Subject: Re: ip22 watchdog timer
Message-ID: <20020215160601.A845@dea.linux-mips.net>
References: <20020215152132.A602@dea.linux-mips.net> <Pine.GSO.3.96.1020215152948.29773L-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1020215152948.29773L-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Fri, Feb 15, 2002 at 03:41:49PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Feb 15, 2002 at 03:41:49PM +0100, Maciej W. Rozycki wrote:

> > How true.  MIME - broken solution for a broken design ;)  More serious,
> 
>  Why broken?  It's not broken for what it was invented to, i.e. for
> passing unsafe characters via SMTP.  Source patches do not qualify as
> containing such. 

The transition time from pre-MIME to MIME was pretty painful.  If you'd
have gone through the same pains that I did during the MIME introduction
you'd probably understand why I call it a broken fix for a broken system.
Fortunately now that the childhood problems have been solved MIME looks
alot saner but still I prefer plaintext for patches.

  Ralf
