Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6IFPOG16241
	for linux-mips-outgoing; Wed, 18 Jul 2001 08:25:24 -0700
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6IFPKV16237;
	Wed, 18 Jul 2001 08:25:20 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id IAA22108;
	Wed, 18 Jul 2001 08:25:05 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id IAA19776;
	Wed, 18 Jul 2001 08:25:05 -0700 (PDT)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id f6IFNua03029;
	Wed, 18 Jul 2001 17:23:56 +0200 (MEST)
Message-ID: <3B55AA0B.42D212E@mips.com>
Date: Wed, 18 Jul 2001 17:23:55 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: "H . J . Lu" <hjl@lucon.org>
CC: Jun Sun <jsun@mvista.com>, ralf@oss.sgi.com, vhouten@kpn.com,
   linux-mips@oss.sgi.com
Subject: Re: Updates on RedHat 7.1/mips
References: <3B4573B8.9F89022B@mips.com> <3B4635FB.1ED5D222@mvista.com> <3B4AE384.52049D47@mips.com> <20010710103121.L19026@lucon.org> <3B52CF68.4687EBCB@mips.com> <20010716142802.A2757@lucon.org> <3B548EF5.993C271E@mips.com> <20010717122902.B24048@lucon.org> <3B553710.8B7A4CDE@mips.com> <20010718081122.A10848@lucon.org>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

"H . J . Lu" wrote:

> On Wed, Jul 18, 2001 at 09:13:20AM +0200, Carsten Langgaard wrote:
> > "H . J . Lu" wrote:
> >
> > > On Tue, Jul 17, 2001 at 09:16:05PM +0200, Carsten Langgaard wrote:
> > > > Could you add a Perl rpm to you distribution, this also seems to be needed to
> > > > build the RPMs natively.
> > >
> > > Perl has to be built natively. I uploaded mysql-3.23.36-1.1.src.rpm,
> > > perl-5.6.0-12.1.src.rpm, apache-1.3.19-5.src.rpm,
> > > mod_perl-1.24_01-2.src.rpm, tcsh-6.10-5.src.rpm and
> > > zsh-3.0.8-8.src.rpm. Just installed my RedHat 7.1. Then you can build
> > > perl yourself. You may need to build/install the tcsh rpm first.
> >
> > It look like there is a cross dependence, the build of tcsh failed with the
> > following message:
> >
> > /var/tmp/rpm-tmp.7250: /usr/bin/perl: No such file or directory
> > error: Bad exit status from /var/tmp/rpm-tmp.7250 (%build)
> >
> > So tcsh is needed to build perl and perl is needed to build tcsh :-(
> >
>
> It is ok since the tcsh binary has been built. Just install it to
> /bin/tcsh and build the perl rpm. You may have to
>
> # rpm --nodeps --force --rebuild perl-xxx.src.rpm
>
> You only have to do those the first time.

I got through the tcsh and perl build, but now it fails on glibc.

make -s -j2 -C iconvdata others
make[2]: Entering directory `/usr/src/redhat/BUILD/glibc-2.2.3/iconvdata'
make[2]: warning: -jN forced in submake: disabling jobserver mode.
In file included from 8bit-gap.c:33,
                 from iso8859-15.c:28:
/usr/src/redhat/BUILD/glibc-2.2.3/build-mipsel-linux/iconvdata/iso8859-15.h:260:
numeric constant with no digits
/usr/src/redhat/BUILD/glibc-2.2.3/build-mipsel-linux/iconvdata/iso8859-15.h:260: parse
error before `nan'
/usr/src/redhat/BUILD/glibc-2.2.3/build-mipsel-linux/iconvdata/iso8859-15.h:260:
numeric constant with no digits
/usr/src/redhat/BUILD/glibc-2.2.3/build-mipsel-linux/iconvdata/iso8859-15.h:260: parse
error before `nan'
/usr/src/redhat/BUILD/glibc-2.2.3/build-mipsel-linux/iconvdata/iso8859-15.h:260: `nan'
undeclared here (not in a function)
/usr/src/redhat/BUILD/glibc-2.2.3/build-mipsel-linux/iconvdata/iso8859-15.h:260:
initializer element is not constant
/usr/src/redhat/BUILD/glibc-2.2.3/build-mipsel-linux/iconvdata/iso8859-15.h:260: (near
initialization for `from_idx[1].idx')
/usr/src/redhat/BUILD/glibc-2.2.3/build-mipsel-linux/iconvdata/iso8859-15.h:261: `nan'
undeclared here (not in a function)
/usr/src/redhat/BUILD/glibc-2.2.3/build-mipsel-linux/iconvdata/iso8859-15.h:261:
initializer element is not constant
/usr/src/redhat/BUILD/glibc-2.2.3/build-mipsel-linux/iconvdata/iso8859-15.h:261: (near
initialization for `from_idx[2].idx')
/usr/src/redhat/BUILD/glibc-2.2.3/build-mipsel-linux/iconvdata/iso8859-15.h:262: `nan'
undeclared here (not in a function)
/usr/src/redhat/BUILD/glibc-2.2.3/build-mipsel-linux/iconvdata/iso8859-15.h:262:
initializer element is not constant
/usr/src/redhat/BUILD/glibc-2.2.3/build-mipsel-linux/iconvdata/iso8859-15.h:262: (near
initialization for `from_idx[3].idx')
/usr/src/redhat/BUILD/glibc-2.2.3/build-mipsel-linux/iconvdata/iso8859-15.h:263: `nan'
undeclared here (not in a function)
/usr/src/redhat/BUILD/glibc-2.2.3/build-mipsel-linux/iconvdata/iso8859-15.h:263:
initializer element is not constant
/usr/src/redhat/BUILD/glibc-2.2.3/build-mipsel-linux/iconvdata/iso8859-15.h:263: (near
initialization for `from_idx[4].idx')
/usr/src/redhat/BUILD/glibc-2.2.3/build-mipsel-linux/iconvdata/iso8859-15.h:264: `nan'
undeclared here (not in a function)
/usr/src/redhat/BUILD/glibc-2.2.3/build-mipsel-linux/iconvdata/iso8859-15.h:264:
initializer element is not constant
/usr/src/redhat/BUILD/glibc-2.2.3/build-mipsel-linux/iconvdata/iso8859-15.h:264: (near
initialization for `from_idx[5].idx')
/usr/src/redhat/BUILD/glibc-2.2.3/build-mipsel-linux/iconvdata/iso8859-15.h:265: `nan'
undeclared here (not in a function)
/usr/src/redhat/BUILD/glibc-2.2.3/build-mipsel-linux/iconvdata/iso8859-15.h:265:
initializer element is not constant
/usr/src/redhat/BUILD/glibc-2.2.3/build-mipsel-linux/iconvdata/iso8859-15.h:265: (near
initialization for `from_idx[6].idx')
make[2]: ***
[/usr/src/redhat/BUILD/glibc-2.2.3/build-mipsel-linux/iconvdata/iso8859-15.os] Error 1

make[2]: *** Waiting for unfinished jobs....
make[2]: Leaving directory `/usr/src/redhat/BUILD/glibc-2.2.3/iconvdata'
make[1]: *** [iconvdata/others] Error 2
make[1]: Leaving directory `/usr/src/redhat/BUILD/glibc-2.2.3'
make: *** [all] Error 2
error: Bad exit status from /var/tmp/rpm-tmp.98017 (%build)


RPM build errors:
    Bad exit status from /var/tmp/rpm-tmp.98017 (%build)


>
> H.J.

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
