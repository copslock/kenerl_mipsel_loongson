Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6IDT1i06301
	for linux-mips-outgoing; Wed, 18 Jul 2001 06:29:01 -0700
Received: from dea.waldorf-gmbh.de (u-132-20.karlsruhe.ipdial.viaginterkom.de [62.180.20.132])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6IDSuV06283
	for <linux-mips@oss.sgi.com>; Wed, 18 Jul 2001 06:28:56 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f6IDQVS01847;
	Wed, 18 Jul 2001 15:26:31 +0200
Date: Wed, 18 Jul 2001 15:26:31 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Carsten Langgaard <carstenl@mips.com>
Cc: "H . J . Lu" <hjl@lucon.org>, Jun Sun <jsun@mvista.com>, vhouten@kpn.com,
   linux-mips@oss.sgi.com
Subject: Re: Updates on RedHat 7.1/mips
Message-ID: <20010718152631.A1809@bacchus.dhis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Jul 18, 2001 at 09:13:20AM +0200, Carsten Langgaard wrote:

> It look like there is a cross dependence, the build of tcsh failed with the
> following message:
> 
> /var/tmp/rpm-tmp.7250: /usr/bin/perl: No such file or directory
> error: Bad exit status from /var/tmp/rpm-tmp.7250 (pbuild)
> 
> So tcsh is needed to build perl and perl is needed to build tcsh :-(

One of the reasons why I believe that the major Linux distributions are
fundamentally flawed - their build process doesn't account for such
dependencies.  Point for BSD.

The escape from this circular dependency is to build those packages manually
which may require cheating in the configure and build process a bit.  Or
install them from a binary package (which may require --nodeps and --force
to install).  General rule therefore should be to only do such distribution
package builds on systems which have a maximum installation.

  Ralf
