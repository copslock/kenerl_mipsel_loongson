Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6OEjMRw019984
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 24 Jul 2002 07:45:22 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6OEjMtU019983
	for linux-mips-outgoing; Wed, 24 Jul 2002 07:45:22 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (shaft17-f182.dialo.tiscali.de [62.246.17.182])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6OEjFRw019974
	for <linux-mips@oss.sgi.com>; Wed, 24 Jul 2002 07:45:17 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g6OEk2Y28316;
	Wed, 24 Jul 2002 16:46:02 +0200
Date: Wed, 24 Jul 2002 16:46:02 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Jun Sun <jsun@mvista.com>, linux-mips@oss.sgi.com
Subject: Re: [PATCH] make PIIX4 ide driver available for MIPS
Message-ID: <20020724164602.E28010@dea.linux-mips.net>
References: <3D3DF04E.7070401@mvista.com> <Pine.GSO.3.96.1020724164114.27732D-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.3.96.1020724164114.27732D-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Wed, Jul 24, 2002 at 04:43:39PM +0200
X-Accept-Language: de,en,fr
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Jul 24, 2002 at 04:43:39PM +0200, Maciej W. Rozycki wrote:

> > Malta uses this chip.  The native driver does provide significant gain in 
> > performance.  See attached bonnie++ test results.
> 
>  It's actually weird there are any CPU conditionals there at all.  The
> PIIX4 is a generic PCI-ISA bridge after all, so it can be used on any
> system equipped with a PCI bus.  DEC Alpha systems used to use Intel's
> bridges for EISA and ISA busses as well.

I bet it's historical reasons and the whole architecture conditional
plain should go away ...

  Ralf
