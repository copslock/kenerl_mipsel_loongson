Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6I7Emj07860
	for linux-mips-outgoing; Wed, 18 Jul 2001 00:14:48 -0700
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6I7EhV07856;
	Wed, 18 Jul 2001 00:14:43 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id AAA19070;
	Wed, 18 Jul 2001 00:14:29 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id AAA15496;
	Wed, 18 Jul 2001 00:14:30 -0700 (PDT)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id f6I7DKa06857;
	Wed, 18 Jul 2001 09:13:21 +0200 (MEST)
Message-ID: <3B553710.8B7A4CDE@mips.com>
Date: Wed, 18 Jul 2001 09:13:20 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: "H . J . Lu" <hjl@lucon.org>
CC: Jun Sun <jsun@mvista.com>, ralf@oss.sgi.com, vhouten@kpn.com,
   linux-mips@oss.sgi.com
Subject: Re: Updates on RedHat 7.1/mips
References: <3B4573B8.9F89022B@mips.com> <3B4635FB.1ED5D222@mvista.com> <3B4AE384.52049D47@mips.com> <20010710103121.L19026@lucon.org> <3B52CF68.4687EBCB@mips.com> <20010716142802.A2757@lucon.org> <3B548EF5.993C271E@mips.com> <20010717122902.B24048@lucon.org>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

"H . J . Lu" wrote:

> On Tue, Jul 17, 2001 at 09:16:05PM +0200, Carsten Langgaard wrote:
> > Could you add a Perl rpm to you distribution, this also seems to be needed to
> > build the RPMs natively.
>
> Perl has to be built natively. I uploaded mysql-3.23.36-1.1.src.rpm,
> perl-5.6.0-12.1.src.rpm, apache-1.3.19-5.src.rpm,
> mod_perl-1.24_01-2.src.rpm, tcsh-6.10-5.src.rpm and
> zsh-3.0.8-8.src.rpm. Just installed my RedHat 7.1. Then you can build
> perl yourself. You may need to build/install the tcsh rpm first.

It look like there is a cross dependence, the build of tcsh failed with the
following message:

/var/tmp/rpm-tmp.7250: /usr/bin/perl: No such file or directory
error: Bad exit status from /var/tmp/rpm-tmp.7250 (%build)

So tcsh is needed to build perl and perl is needed to build tcsh :-(

>
> >
> > I also would like to do a cross build, but how do I do that ?
> > Do I have to change all the spec files, to set the target arch to MIPS, or is
> > there a easier and better way to do that ?
> > I guess if I just install the SRPMs and the cross toolchain, and try to build
> > out of that I will simply build for the build platform, which is i386.
>
> You need my patched `rpm' to do cross build. You also need some
> specicial set up. I am enclosng a message of mine. I will see if
> I can cleanup my cross build environment and upload it.
>
> H.J.
> -----
> > they work great! Thanks for all your hard work. Now, I would like
> > to be able to build some RPMs as well. I have never cross-built
> > RPMs before. I took the SRPMS for make and tried:
> >
> >    rpm -ba make.spec --target=mipsel
> >
> > This did not do anything and built nothing. Is there a FAQ that
> > I can read on cross building RPMS in addition to the documentation
> > on http://www.rpm.org/ ? Do you have any quick pointers? Thanks
> > again.
>
> Although my source rpms do support cross compile, FYI, all my
> mips/mipsel rpms are cross compiled from ia32 machines, the
> unpatched rpm, that is /bin/rpm, doesn't support cross compile.
> In my RedHat 7.1, there are i386 rpm binaries which support
> cross compile. I have a setup to cross build rpms to mips/mipsel.
> Make sure your rpm sees
>
> %__ar                   %{_target_prefix}-linux-ar
> %__as                   %{_target_prefix}-linux-as
> %__cc                   %{_target_prefix}-linux-gcc
> %__cxx                  %{_target_prefix}-linux-c++
> %__ld                   %{_target_prefix}-linux-ld
> %__nm                   %{_target_prefix}-linux-nm
> %__objcopy              %{_target_prefix}-linux-objcopy
> %__objdump              %{_target_prefix}-linux-objdump
> %__ranlib               %{_target_prefix}-linux-ranlib
> %__strip                %{_target_prefix}-linux-strip
>

How do I do that ?

>
> and do
>
> # rpm --target=mips --define '_target_prefix mips'
>
> or
>
> # rpm --target=mipsel --define '_target_prefix mipsel'
>
> BTW, you alao need to rebuild binutils with
>
> # rpm --define 'ENABLE_ALL_TARGETS 1' -ta binutils-2.11.90.0.23.tar.gz
>
> H.J.

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
