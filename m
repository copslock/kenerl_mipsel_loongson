Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6IGx2k20546
	for linux-mips-outgoing; Wed, 18 Jul 2001 09:59:02 -0700
Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6IGwwV20543;
	Wed, 18 Jul 2001 09:58:58 -0700
Received: from nevyn.them.org (gateway-1237.mvista.com [12.44.186.158]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id JAA03059; Wed, 18 Jul 2001 09:58:42 -0700 (PDT)
	mail_from (drow@crack.them.org)
Received: from drow by nevyn.them.org with local (Exim 3.22 #1 (Debian))
	id 15MuV8-0006SM-00; Wed, 18 Jul 2001 09:48:42 -0700
Date: Wed, 18 Jul 2001 09:48:42 -0700
From: Daniel Jacobowitz <drow@mvista.com>
To: Ralf Baechle <ralf@oss.sgi.com>
Cc: Carsten Langgaard <carstenl@mips.com>, linux-mips@oss.sgi.com
Subject: Re: Updates on RedHat 7.1/mips
Message-ID: <20010718094841.A24612@nevyn.them.org>
References: <20010718152631.A1809@bacchus.dhis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <20010718152631.A1809@bacchus.dhis.org>; from ralf@oss.sgi.com on Wed, Jul 18, 2001 at 03:26:31PM +0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Jul 18, 2001 at 03:26:31PM +0200, Ralf Baechle wrote:
> On Wed, Jul 18, 2001 at 09:13:20AM +0200, Carsten Langgaard wrote:
> 
> > It look like there is a cross dependence, the build of tcsh failed with the
> > following message:
> > 
> > /var/tmp/rpm-tmp.7250: /usr/bin/perl: No such file or directory
> > error: Bad exit status from /var/tmp/rpm-tmp.7250 (pbuild)
> > 
> > So tcsh is needed to build perl and perl is needed to build tcsh :-(
> 
> One of the reasons why I believe that the major Linux distributions are
> fundamentally flawed - their build process doesn't account for such
> dependencies.  Point for BSD.

Debian has been going to great lengths to fix this.  We're a great deal
of the way along, too - to the point where bringing up our complete
hppa and ia64 distributions (with the exception of a few
platform-specific tool bugs and some gcc-3.0 incompatibilities) was
really relatively painless for the vast majority of packages.  Only a
tiny subset of packages are assumed installed at build time if they
aren't explicitly listed.

> The escape from this circular dependency is to build those packages manually
> which may require cheating in the configure and build process a bit.  Or
> install them from a binary package (which may require --nodeps and --force
> to install).  General rule therefore should be to only do such distribution
> package builds on systems which have a maximum installation.

Although I'm pretty sure that Debian's Perl package builds without the
use of tcsh... I've no idea where this is coming from.

-- 
Daniel Jacobowitz                           Carnegie Mellon University
MontaVista Software                         Debian GNU/Linux Developer
