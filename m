Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6OGV5223853
	for linux-mips-outgoing; Tue, 24 Jul 2001 09:31:05 -0700
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6OGUvO23846;
	Tue, 24 Jul 2001 09:30:57 -0700
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 6AD44125BA; Tue, 24 Jul 2001 09:30:56 -0700 (PDT)
Date: Tue, 24 Jul 2001 09:30:56 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: Ralf Baechle <ralf@oss.sgi.com>
Cc: Andre.Messerschmidt@infineon.com, linux-mips@oss.sgi.com
Subject: Re: GCC and Modules
Message-ID: <20010724093056.A21216@lucon.org>
References: <86048F07C015D311864100902760F1DDFF000E@dlfw003a.dus.infineon.com> <20010724084005.A20319@lucon.org> <20010724182057.D27225@bacchus.dhis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010724182057.D27225@bacchus.dhis.org>; from ralf@oss.sgi.com on Tue, Jul 24, 2001 at 06:20:57PM +0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Jul 24, 2001 at 06:20:57PM +0200, Ralf Baechle wrote:
> On Tue, Jul 24, 2001 at 08:40:05AM -0700, H . J . Lu wrote:
> 
> > > As I understand the current stable release of binutils and gcc is not able
> > > to compile functional modules. 
> > 
> > What are you talking about? My mips toolchain is as stable/good as the
> > x86 version for RedHat 7.1.
> 
> He's refering to the last official release of binutils which indeed wasn't
> usable for modutils.

What official release of binutils? Are we talking about the FSF
official release? Since when did Linux use those? They won't even
work right on Linux/x86. You should either use the Linux binutils
or try your luck with CVS.


H.J.
