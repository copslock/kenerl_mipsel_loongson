Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8DCgro05611
	for linux-mips-outgoing; Thu, 13 Sep 2001 05:42:53 -0700
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8DCgle05606
	for <linux-mips@oss.sgi.com>; Thu, 13 Sep 2001 05:42:47 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id FAA10107;
	Thu, 13 Sep 2001 05:41:50 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id FAA18617;
	Thu, 13 Sep 2001 05:41:48 -0700 (PDT)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id f8DCfka04732;
	Thu, 13 Sep 2001 14:41:47 +0200 (MEST)
Message-ID: <3BA0A98A.75DA372@mips.com>
Date: Thu, 13 Sep 2001 14:41:46 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Pete Popov <ppopov@pacbell.net>
CC: linux-mips@oss.sgi.com, "H . J . Lu" <hjl@lucon.org>
Subject: Re: Update for RedHat 7.1
References: <20010907230009.A1705@lucon.org> <3B9F21C9.985A1F0F@mips.com> <3B9F319B.E87DC64B@mips.com> <20010912094822.A4491@lucon.org> <3B9F9489.90608@pacbell.net> <3B9FBCB3.FDACFE3E@mips.com> <3B9FBE04.3010304@pacbell.net>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Pete Popov wrote:

> Carsten Langgaard wrote:
> > Pete Popov wrote:
> >
> >
> >>H . J . Lu wrote:
> >>
> >>>On Wed, Sep 12, 2001 at 11:57:47AM +0200, Carsten Langgaard wrote:
> >>>
> >>>
> >>>>Carsten Langgaard wrote:
> >>>>
> >>>>
> >>>>
> >>>>>I have installed your new set of RedHat7.1 RPMs, and tried to build Perl
> >>>>>natively.
> >>>>>But it fails with the following message:
> >>>>>
> >>>>>`sh  cflags libperl.a toke.o`  toke.c
> >>>>>         CCCMD =  gcc -DPERL_CORE -c -fno-strict-aliasing
> >>>>>-I/usr/local/include
> >>>>>-O2
> >>>>>
> >>>>>Cannot allocate 2676168 bytes after allocating 3899765696 bytes
> >>>>>make: *** [toke.o] Error 1
> >>>>>error: Bad exit status from /var/tmp/rpm-tmp.43439 (%build)
> >>>>>
> >>>>>RPM build errors:
> >>>>>   Bad exit status from /var/tmp/rpm-tmp.43439 (%build)
> >>>>>
> >>>>>
> >>>>>
> >>>>I tried to build perl again an now I get this message:
> >>>>
> >>>>`sh  cflags libperl.a toke.o`  toke.c
> >>>>         CCCMD =  gcc -DPERL_CORE -c -fno-strict-aliasing
> >>>>-I/usr/local/include -O2
> >>>>gcc: Internal error: Terminated (program cc1)
> >>>>Please submit a full bug report.
> >>>>See <URL:http://bugzilla.redhat.com/bugzilla/> for instructions.
> >>>>make: *** [toke.o] Error 1
> >>>>error: Bad exit status from /var/tmp/rpm-tmp.53242 (%build)
> >>>>
> >>>>RPM build errors:
> >>>>   Bad exit status from /var/tmp/rpm-tmp.53242 (%build)
> >>>>
> >>>>
> >>>>
> >>>It may be a kernel/hardware bug. I have no problem building perl
> >>>natively.
> >>>
> >>Carsten, what board/cpu are you using?
> >>
> >
> > On a Atlas board with a QED RM5261 CPU (little-endian).
> > The kernel is based on 2.4.3.
>
> I would try the exact same userland and kernel version on a different board,
> preferably with a different cpu.  Rebuild perl natively 10 times. If it works on
> the other board, there is a very good chance that this is a board or CPU
> problem. Native compiles seem to be very good for stressing the hardware.
>

Ok, I found the problem, it turn out that I only had 128K swap space, it should
have been 128M.
So after increasing my swap space, I was able to compile perl.

Thanks a lot.
/Carsten

>
> Pete

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
