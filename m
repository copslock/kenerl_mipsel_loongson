Received:  by oss.sgi.com id <S554113AbRAZVLr>;
	Fri, 26 Jan 2001 13:11:47 -0800
Received: from saturn.mikemac.com ([216.99.199.88]:9224 "EHLO
        saturn.mikemac.com") by oss.sgi.com with ESMTP id <S554110AbRAZVLh>;
	Fri, 26 Jan 2001 13:11:37 -0800
Received: from Saturn (localhost [127.0.0.1])
	by saturn.mikemac.com (8.9.3/8.9.3) with ESMTP id NAA13006;
	Fri, 26 Jan 2001 13:11:35 -0800
Message-Id: <200101262111.NAA13006@saturn.mikemac.com>
To:     Jun Sun <jsun@mvista.com>
cc:     linux-mips@oss.sgi.com
Subject: Re: Cross compiling RPMs 
In-Reply-To: Your message of "Fri, 26 Jan 2001 12:51:31 PST."
             <20010126125131.G9325@mvista.com> 
Date:   Fri, 26 Jan 2001 13:11:35 -0800
From:   Mike McDonald <mikemac@mikemac.com>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


>Date:   Fri, 26 Jan 2001 12:51:31 -0800
>From: Jun Sun <jsun@mvista.com>
>To: Florian Lohoff <flo@rfc822.org>
>Subject: Re: Cross compiling RPMs

>The "noarch" means the installed target is arch-independent.  The
>standard setup in mvista CDK is to let target boot from NFS root fs, 
>where NFS host can be linux/i386, Linux/ppc and Sun/Sparc (perhaps
>Win/i386 as well, I am not sure).  Those packages are meant to be 
>installed to all those hosts, and therefore "noarch" :-0.

 Hmm, I would have thought they should be designated for the type of
system they were instead to run on. The fast you're installing them
into an NFS root on some other machine shouldn't change that. Can't
any ole rpm be forced to install on some random NFS server? Then by
your reasoning, all rpms would be noarch, wouldn't they?

>Native compiling is easy.  Cross-compiling is cool. :-)
>
>Well, not exactly.  When you are dealing with head-less, disk-less 
>memory-scarce embedded devices with ad hoc run-time environments,
>cross-compiling is your only choice.
>
>Jun

  Precisely! In our case, we get drops from various contractors who
are doing developement/porting to a wide variety of platforms. (So far
we have i386, mipsel, arm, and sh3. No alpha or sparc yet.) We'll get
multiple drops from the contractors over time. We need to be able to
1) rebuild the binaries from the supplied sources (some vendors have
delivered binaries that did NOT come from the sources they claimed!),
2) build a test suite for that drop and 3) build an initial ramdisk,
bootable CD, or NFS root dir to test the drop. Building the test
environment will include some subset (usually a real small subset) of
the whole drop but we still need to be able to rebuild everything.
Most of these systems we're dealing with have no native compiling
capability, so cross compiling is the only choice. 

  And then sometimes we get tarballs instead of rpms, but that's a
different can of worms.

  Mike McDonald
  mikemac@mikemac.com
