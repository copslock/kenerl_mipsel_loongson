Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6HJvPm29577
	for linux-mips-outgoing; Tue, 17 Jul 2001 12:57:25 -0700
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6HJvOV29574
	for <linux-mips@oss.sgi.com>; Tue, 17 Jul 2001 12:57:24 -0700
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id DEA60125BC; Tue, 17 Jul 2001 12:57:18 -0700 (PDT)
Date: Tue, 17 Jul 2001 12:57:18 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: Daniel Jacobowitz <drow@mvista.com>
Cc: Jun Sun <jsun@mvista.com>, linux-mips@oss.sgi.com
Subject: Re: Updates on RedHat 7.1/mips
Message-ID: <20010717125718.A24725@lucon.org>
References: <3B4573B8.9F89022B@mips.com> <3B4635FB.1ED5D222@mvista.com> <3B4AE384.52049D47@mips.com> <20010710103121.L19026@lucon.org> <3B52CF68.4687EBCB@mips.com> <20010716142802.A2757@lucon.org> <3B548EF5.993C271E@mips.com> <20010717122902.B24048@lucon.org> <20010717125027.A22672@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010717125027.A22672@nevyn.them.org>; from drow@mvista.com on Tue, Jul 17, 2001 at 12:50:27PM -0700
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Jul 17, 2001 at 12:50:27PM -0700, Daniel Jacobowitz wrote:
> > 
> > Perl has to be built natively. I uploaded mysql-3.23.36-1.1.src.rpm,
> > perl-5.6.0-12.1.src.rpm, apache-1.3.19-5.src.rpm,
> > mod_perl-1.24_01-2.src.rpm, tcsh-6.10-5.src.rpm and
> > zsh-3.0.8-8.src.rpm. Just installed my RedHat 7.1. Then you can build
> > perl yourself. You may need to build/install the tcsh rpm first.
> 
> It's not yet available for MIPS (later this week), but MontaVista Journeyman
> contains the patches to cross-compile Perl.  It's not pretty, though.
> 

That is a reason why I didn't bother with cross-compile Perl :-). The
next thing on my todo list is to cross compile XFree86 :-(.


H.J.
