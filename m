Received:  by oss.sgi.com id <S554126AbRA0Ab3>;
	Fri, 26 Jan 2001 16:31:29 -0800
Received: from gateway-1237.mvista.com ([12.44.186.158]:12798 "EHLO
        hermes.mvista.com") by oss.sgi.com with ESMTP id <S554123AbRA0AbJ>;
	Fri, 26 Jan 2001 16:31:09 -0800
Received: from mvista.com (IDENT:ppopov@zeus.mvista.com [10.0.0.112])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f0R0RsI09876;
	Fri, 26 Jan 2001 16:27:54 -0800
Message-ID: <3A7216DC.98EF9C1C@mvista.com>
Date:   Fri, 26 Jan 2001 16:31:24 -0800
From:   Pete Popov <ppopov@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.17 i586)
X-Accept-Language: bg, en
MIME-Version: 1.0
To:     Mike McDonald <mikemac@mikemac.com>
CC:     linux-mips@oss.sgi.com
Subject: Re: Cross compiling RPMs
References: <200101262111.NAA13006@saturn.mikemac.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Mike,

> >The "noarch" means the installed target is arch-independent.  The
> >standard setup in mvista CDK is to let target boot from NFS root fs,
> >where NFS host can be linux/i386, Linux/ppc and Sun/Sparc (perhaps
> >Win/i386 as well, I am not sure).  Those packages are meant to be
> >installed to all those hosts, and therefore "noarch" :-0.
> 
>  Hmm, I would have thought they should be designated for the type of
> system they were instead to run on. The fast you're installing them
> into an NFS root on some other machine shouldn't change that. Can't
> any ole rpm be forced to install on some random NFS server? Then by
> your reasoning, all rpms would be noarch, wouldn't they?
> 
> >Native compiling is easy.  Cross-compiling is cool. :-)
> >
> >Well, not exactly.  When you are dealing with head-less, disk-less
> >memory-scarce embedded devices with ad hoc run-time environments,
> >cross-compiling is your only choice.
> >
> >Jun
> 
>   Precisely! In our case, we get drops from various contractors who
> are doing developement/porting to a wide variety of platforms. (So far
> we have i386, mipsel, arm, and sh3. No alpha or sparc yet.) We'll get
> multiple drops from the contractors over time. We need to be able to
> 1) rebuild the binaries from the supplied sources (some vendors have
> delivered binaries that did NOT come from the sources they claimed!),
> 2) build a test suite for that drop and 3) build an initial ramdisk,
> bootable CD, or NFS root dir to test the drop. Building the test
> environment will include some subset (usually a real small subset) of
> the whole drop but we still need to be able to rebuild everything.
> Most of these systems we're dealing with have no native compiling
> capability, so cross compiling is the only choice.

Here's the recipe for rebuilding all packages from our (MontaVista)
SRPMs:

from ftp.mvista.com:

* download
/pub/CDK/1.2/Latest/MIPS/common/hhl-rpmconfig-0.16-1.noarch.rpm

Install that package. It will go in /opt/hardhat/xxxx

Read carefully /opt/hardhat/config/rpm/README.  That README has all the
info you need to:

* setup your macros files
* download all the tools and SRPMS from the ftp site
* rebuild all of the packages we support, including glibc (glibc is the
only one you have to rebuild as root user)

You can rebuild any package for any of the architectures we support by
doing something like this:

rpm -ba --target=mips_fp_le-linux hhl-glibc.spec

You should be able to setup the environment and start rebuilding
packages within a couple of hours. 

Pete
