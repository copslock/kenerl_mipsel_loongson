Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8C9w4N04339
	for linux-mips-outgoing; Wed, 12 Sep 2001 02:58:04 -0700
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8C9vwe04336
	for <linux-mips@oss.sgi.com>; Wed, 12 Sep 2001 02:57:58 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id CAA25333;
	Wed, 12 Sep 2001 02:57:48 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id CAA20062;
	Wed, 12 Sep 2001 02:57:48 -0700 (PDT)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id f8C9vla01401;
	Wed, 12 Sep 2001 11:57:48 +0200 (MEST)
Message-ID: <3B9F319B.E87DC64B@mips.com>
Date: Wed, 12 Sep 2001 11:57:47 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: "H . J . Lu" <hjl@lucon.org>, linux-mips@oss.sgi.com
Subject: Re: Update for RedHat 7.1
References: <20010907230009.A1705@lucon.org> <3B9F21C9.985A1F0F@mips.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Carsten Langgaard wrote:

> I have installed your new set of RedHat7.1 RPMs, and tried to build Perl
> natively.
> But it fails with the following message:
>
> `sh  cflags libperl.a toke.o`  toke.c
>           CCCMD =  gcc -DPERL_CORE -c -fno-strict-aliasing
> -I/usr/local/include
> -O2
>
> Cannot allocate 2676168 bytes after allocating 3899765696 bytes
> make: *** [toke.o] Error 1
> error: Bad exit status from /var/tmp/rpm-tmp.43439 (%build)
>
> RPM build errors:
>     Bad exit status from /var/tmp/rpm-tmp.43439 (%build)
>

I tried to build perl again an now I get this message:

`sh  cflags libperl.a toke.o`  toke.c
          CCCMD =  gcc -DPERL_CORE -c -fno-strict-aliasing
-I/usr/local/include -O2
gcc: Internal error: Terminated (program cc1)
Please submit a full bug report.
See <URL:http://bugzilla.redhat.com/bugzilla/> for instructions.
make: *** [toke.o] Error 1
error: Bad exit status from /var/tmp/rpm-tmp.53242 (%build)

RPM build errors:
    Bad exit status from /var/tmp/rpm-tmp.53242 (%build)


>
> I have build perl natively with your pervious set of RedHat7.1 RPMs,
> without any problems.
>
> /Carsten
>
> "H . J . Lu" wrote:
>
> > I updated a few packages, fixed a linker bug and rebuilt everything.
> >
> > H.J.
> > ----
> > My mini-port of RedHat 7.1 is at
> >
> > ftp://oss.sgi.com/pub/linux/mips/redhat/7.1/
> >
> > you should be able to put a small RedHat 7.1 on the mips/mipsel box and
> > compile the rest of RedHat 7.1 yourselves.
> >
> > Here are something you should know:
> >
> > 1. The cross compiler hosted on RedHat 7.1/ia32 is provided as a
> > toolchain rpm. The binary rpms for the mips and mipsel cross compilers
> > are included. You will need glibc 2.2.3-11 or above to use those
> > rpms. The glibc x86 binary rpms under RPMS/i386 should be ok.
> > 2. You have to find a way to put those rpms on your machine. I use
> > network boot and NFS root to do it.
> > 3. install.tar.bz2 has some scripts to prepare NFS root and install
> > RedHat 7.1 on a hard drive.
> > 4. baseline.tar.bz2 contains the cross build tree.
> >
> > Thanks.
> >
> > H.J.
>
> --
> _    _ ____  ___   Carsten Langgaard  Mailto:carstenl@mips.com
> |\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
> | \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
>   TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
>                    Denmark            http://www.mips.com

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
