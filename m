Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g78FfPRw018681
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 8 Aug 2002 08:41:25 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g78FfPKr018680
	for linux-mips-outgoing; Thu, 8 Aug 2002 08:41:25 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (shaft19-f135.dialo.tiscali.de [62.246.19.135])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g78FfHRw018671
	for <linux-mips@oss.sgi.com>; Thu, 8 Aug 2002 08:41:19 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g78FgkE27282;
	Thu, 8 Aug 2002 17:42:46 +0200
Date: Thu, 8 Aug 2002 17:42:46 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Carsten Langgaard <carstenl@mips.com>, linux-mips@oss.sgi.com
Subject: Re: memcpy.S patch in 64-bit
Message-ID: <20020808174246.A27274@dea.linux-mips.net>
References: <3D52711F.D5C6A8FC@mips.com> <Pine.GSO.3.96.1020808170518.13783D-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.3.96.1020808170518.13783D-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Thu, Aug 08, 2002 at 05:08:07PM +0200
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Aug 08, 2002 at 05:08:07PM +0200, Maciej W. Rozycki wrote:

> > The __copy_user function (in arch/mips64/lib/memcpy.S) calls __bzero.
> > We can't do that because __bzero might modify len, which we want to
> > return in case of an error.
> > The following patch take care of the problem.
> 
>  Hmm, how about simply cloning arch/mips/lib/memcpy.S?  It seems:
> 
> 1. Designed to work on mips64 as well.
> 
> 2. More up to date.
> 
> And it would ease maintenance. 

Right but Carsten's patch is already ready, so I'm going to use it
for now.

  Ralf
