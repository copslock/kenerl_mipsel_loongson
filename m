Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6HJTEj28807
	for linux-mips-outgoing; Tue, 17 Jul 2001 12:29:14 -0700
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6HJT9V28803;
	Tue, 17 Jul 2001 12:29:10 -0700
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id B6EB9125BE; Tue, 17 Jul 2001 12:29:02 -0700 (PDT)
Date: Tue, 17 Jul 2001 12:29:02 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: Carsten Langgaard <carstenl@mips.com>
Cc: Jun Sun <jsun@mvista.com>, ralf@oss.sgi.com, vhouten@kpn.com,
   linux-mips@oss.sgi.com
Subject: Re: Updates on RedHat 7.1/mips
Message-ID: <20010717122902.B24048@lucon.org>
References: <3B4573B8.9F89022B@mips.com> <3B4635FB.1ED5D222@mvista.com> <3B4AE384.52049D47@mips.com> <20010710103121.L19026@lucon.org> <3B52CF68.4687EBCB@mips.com> <20010716142802.A2757@lucon.org> <3B548EF5.993C271E@mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B548EF5.993C271E@mips.com>; from carstenl@mips.com on Tue, Jul 17, 2001 at 09:16:05PM +0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Jul 17, 2001 at 09:16:05PM +0200, Carsten Langgaard wrote:
> Could you add a Perl rpm to you distribution, this also seems to be needed to
> build the RPMs natively.

Perl has to be built natively. I uploaded mysql-3.23.36-1.1.src.rpm,
perl-5.6.0-12.1.src.rpm, apache-1.3.19-5.src.rpm,
mod_perl-1.24_01-2.src.rpm, tcsh-6.10-5.src.rpm and
zsh-3.0.8-8.src.rpm. Just installed my RedHat 7.1. Then you can build
perl yourself. You may need to build/install the tcsh rpm first.

> 
> I also would like to do a cross build, but how do I do that ?
> Do I have to change all the spec files, to set the target arch to MIPS, or is
> there a easier and better way to do that ?
> I guess if I just install the SRPMs and the cross toolchain, and try to build
> out of that I will simply build for the build platform, which is i386.

You need my patched `rpm' to do cross build. You also need some
specicial set up. I am enclosng a message of mine. I will see if
I can cleanup my cross build environment and upload it.


H.J.
-----
> they work great! Thanks for all your hard work. Now, I would like
> to be able to build some RPMs as well. I have never cross-built
> RPMs before. I took the SRPMS for make and tried:
> 
>    rpm -ba make.spec --target=mipsel
> 
> This did not do anything and built nothing. Is there a FAQ that
> I can read on cross building RPMS in addition to the documentation
> on http://www.rpm.org/ ? Do you have any quick pointers? Thanks
> again.

Although my source rpms do support cross compile, FYI, all my
mips/mipsel rpms are cross compiled from ia32 machines, the
unpatched rpm, that is /bin/rpm, doesn't support cross compile.
In my RedHat 7.1, there are i386 rpm binaries which support
cross compile. I have a setup to cross build rpms to mips/mipsel.
Make sure your rpm sees

%__ar                   %{_target_prefix}-linux-ar
%__as                   %{_target_prefix}-linux-as
%__cc                   %{_target_prefix}-linux-gcc
%__cxx                  %{_target_prefix}-linux-c++
%__ld                   %{_target_prefix}-linux-ld
%__nm                   %{_target_prefix}-linux-nm
%__objcopy              %{_target_prefix}-linux-objcopy
%__objdump              %{_target_prefix}-linux-objdump
%__ranlib               %{_target_prefix}-linux-ranlib
%__strip                %{_target_prefix}-linux-strip

and do

# rpm --target=mips --define '_target_prefix mips'

or

# rpm --target=mipsel --define '_target_prefix mipsel'

BTW, you alao need to rebuild binutils with

# rpm --define 'ENABLE_ALL_TARGETS 1' -ta binutils-2.11.90.0.23.tar.gz


H.J.
