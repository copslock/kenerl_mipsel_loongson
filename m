Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f57GSZK26559
	for linux-mips-outgoing; Thu, 7 Jun 2001 09:28:35 -0700
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f57GSYh26556
	for <linux-mips@oss.sgi.com>; Thu, 7 Jun 2001 09:28:34 -0700
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 59FBF125BA; Thu,  7 Jun 2001 09:28:28 -0700 (PDT)
Date: Thu, 7 Jun 2001 09:28:28 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: linux-mips@oss.sgi.com
Subject: Re: New toolchain for Linux/mips
Message-ID: <20010607092827.A13198@lucon.org>
References: <20010606131959.B25655@lucon.org> <Pine.GSO.3.96.1010607122650.4624A-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1010607122650.4624A-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Thu, Jun 07, 2001 at 12:32:27PM +0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Jun 07, 2001 at 12:32:27PM +0200, Maciej W. Rozycki wrote:
> On Wed, 6 Jun 2001, H . J . Lu wrote:
> 
> > As far as I can tell, all the currently available Linux/mips binutils
> > are broken. I am working on fixing it.
> 
>  That depends on how you define "broken".  All software has bugs.  What I
> currently use is sufficient to build working Linux 2.4.x, glibc 2.2.x as
> well as all programs I built up to date.  I haven't tried C++, I admit. 
> Libstdc++ of gcc 2.95.3 compiles fine, but I have not used it so far, so I
> have no idea if the binary works. 
> 
>  If you know of particular problems, you are welcomed to fix them, of
> course. 

See my post on the binutils mailing list. I have reason to believe
that it also misassembles the mips kernel with certain configuration.


H.J.
