Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g72AagRw030510
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 2 Aug 2002 03:36:42 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g72Aagiw030509
	for linux-mips-outgoing; Fri, 2 Aug 2002 03:36:42 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (shaft17-f126.dialo.tiscali.de [62.246.17.126])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g72AaaRw030500
	for <linux-mips@oss.sgi.com>; Fri, 2 Aug 2002 03:36:38 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g72Ac5a03412;
	Fri, 2 Aug 2002 12:38:05 +0200
Date: Fri, 2 Aug 2002 12:38:05 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Carsten Langgaard <carstenl@mips.com>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, linux-mips@fnet.fr,
   linux-mips@oss.sgi.com
Subject: Re: [update] [patch] linux: Cache coherency fixes
Message-ID: <20020802123805.A3329@dea.linux-mips.net>
References: <20020801152500.A31808@dea.linux-mips.net> <Pine.GSO.3.96.1020801173504.8256H-100000@delta.ds2.pg.gda.pl> <20020801184929.B22824@dea.linux-mips.net> <3D4A4191.DF5EFFC4@mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D4A4191.DF5EFFC4@mips.com>; from carstenl@mips.com on Fri, Aug 02, 2002 at 10:23:53AM +0200
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Aug 02, 2002 at 10:23:53AM +0200, Carsten Langgaard wrote:

> The Malta board is a system that both run coherent and non-coherent, so I
> would prefer, that we either make the coherency a configuration option or
> make it possible to determine at run time.

Definately the latter then.  The price to pay is small and I don't think
forcing the use to change the kernel when just changing CPU modules is
acceptable.

  Ralf
