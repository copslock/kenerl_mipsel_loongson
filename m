Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6HK1Lx29935
	for linux-mips-outgoing; Tue, 17 Jul 2001 13:01:21 -0700
Received: from deliverator.sgi.com (deliverator.sgi.com [204.94.214.10])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6HK1FV29903
	for <linux-mips@oss.sgi.com>; Tue, 17 Jul 2001 13:01:15 -0700
Received: from nevyn.them.org (gateway-1237.mvista.com [12.44.186.158]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id NAA03452
	for <linux-mips@oss.sgi.com>; Tue, 17 Jul 2001 13:01:00 -0700 (PDT)
	mail_from (drow@crack.them.org)
Received: from drow by nevyn.them.org with local (Exim 3.22 #1 (Debian))
	id 15MarT-0005vj-00; Tue, 17 Jul 2001 12:50:27 -0700
Date: Tue, 17 Jul 2001 12:50:27 -0700
From: Daniel Jacobowitz <drow@mvista.com>
To: "H . J . Lu" <hjl@lucon.org>
Cc: Jun Sun <jsun@mvista.com>, linux-mips@oss.sgi.com
Subject: Re: Updates on RedHat 7.1/mips
Message-ID: <20010717125027.A22672@nevyn.them.org>
References: <3B4573B8.9F89022B@mips.com> <3B4635FB.1ED5D222@mvista.com> <3B4AE384.52049D47@mips.com> <20010710103121.L19026@lucon.org> <3B52CF68.4687EBCB@mips.com> <20010716142802.A2757@lucon.org> <3B548EF5.993C271E@mips.com> <20010717122902.B24048@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <20010717122902.B24048@lucon.org>; from hjl@lucon.org on Tue, Jul 17, 2001 at 12:29:02PM -0700
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Jul 17, 2001 at 12:29:02PM -0700, H . J . Lu wrote:
> On Tue, Jul 17, 2001 at 09:16:05PM +0200, Carsten Langgaard wrote:
> > Could you add a Perl rpm to you distribution, this also seems to be needed to
> > build the RPMs natively.
> 
> Perl has to be built natively. I uploaded mysql-3.23.36-1.1.src.rpm,
> perl-5.6.0-12.1.src.rpm, apache-1.3.19-5.src.rpm,
> mod_perl-1.24_01-2.src.rpm, tcsh-6.10-5.src.rpm and
> zsh-3.0.8-8.src.rpm. Just installed my RedHat 7.1. Then you can build
> perl yourself. You may need to build/install the tcsh rpm first.

It's not yet available for MIPS (later this week), but MontaVista Journeyman
contains the patches to cross-compile Perl.  It's not pretty, though.

-- 
Daniel Jacobowitz                           Carnegie Mellon University
MontaVista Software                         Debian GNU/Linux Developer
