Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6IFBWd14953
	for linux-mips-outgoing; Wed, 18 Jul 2001 08:11:32 -0700
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6IFBOV14934;
	Wed, 18 Jul 2001 08:11:24 -0700
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 20933125BC; Wed, 18 Jul 2001 08:11:22 -0700 (PDT)
Date: Wed, 18 Jul 2001 08:11:22 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: Carsten Langgaard <carstenl@mips.com>
Cc: Jun Sun <jsun@mvista.com>, ralf@oss.sgi.com, vhouten@kpn.com,
   linux-mips@oss.sgi.com
Subject: Re: Updates on RedHat 7.1/mips
Message-ID: <20010718081122.A10848@lucon.org>
References: <3B4573B8.9F89022B@mips.com> <3B4635FB.1ED5D222@mvista.com> <3B4AE384.52049D47@mips.com> <20010710103121.L19026@lucon.org> <3B52CF68.4687EBCB@mips.com> <20010716142802.A2757@lucon.org> <3B548EF5.993C271E@mips.com> <20010717122902.B24048@lucon.org> <3B553710.8B7A4CDE@mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B553710.8B7A4CDE@mips.com>; from carstenl@mips.com on Wed, Jul 18, 2001 at 09:13:20AM +0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Jul 18, 2001 at 09:13:20AM +0200, Carsten Langgaard wrote:
> "H . J . Lu" wrote:
> 
> > On Tue, Jul 17, 2001 at 09:16:05PM +0200, Carsten Langgaard wrote:
> > > Could you add a Perl rpm to you distribution, this also seems to be needed to
> > > build the RPMs natively.
> >
> > Perl has to be built natively. I uploaded mysql-3.23.36-1.1.src.rpm,
> > perl-5.6.0-12.1.src.rpm, apache-1.3.19-5.src.rpm,
> > mod_perl-1.24_01-2.src.rpm, tcsh-6.10-5.src.rpm and
> > zsh-3.0.8-8.src.rpm. Just installed my RedHat 7.1. Then you can build
> > perl yourself. You may need to build/install the tcsh rpm first.
> 
> It look like there is a cross dependence, the build of tcsh failed with the
> following message:
> 
> /var/tmp/rpm-tmp.7250: /usr/bin/perl: No such file or directory
> error: Bad exit status from /var/tmp/rpm-tmp.7250 (%build)
> 
> So tcsh is needed to build perl and perl is needed to build tcsh :-(
> 

It is ok since the tcsh binary has been built. Just install it to
/bin/tcsh and build the perl rpm. You may have to

# rpm --nodeps --force --rebuild perl-xxx.src.rpm

You only have to do those the first time.



H.J.
