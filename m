Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6HJFI928506
	for linux-mips-outgoing; Tue, 17 Jul 2001 12:15:18 -0700
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6HJFDV28502;
	Tue, 17 Jul 2001 12:15:14 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id MAA12245;
	Tue, 17 Jul 2001 12:15:01 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id MAA03708;
	Tue, 17 Jul 2001 12:14:59 -0700 (PDT)
Received: from mips.com (coppccl [172.17.27.2])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id f6HJDpa16789;
	Tue, 17 Jul 2001 21:13:52 +0200 (MEST)
Message-ID: <3B548EF5.993C271E@mips.com>
Date: Tue, 17 Jul 2001 21:16:05 +0200
From: Carsten Langgaard <carstenl@mips.com>
Organization: MIPS Technologies
X-Mailer: Mozilla 4.76 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: "H . J . Lu" <hjl@lucon.org>
CC: Jun Sun <jsun@mvista.com>, ralf@oss.sgi.com, vhouten@kpn.com,
   linux-mips@oss.sgi.com
Subject: Re: Updates on RedHat 7.1/mips
References: <3B4573B8.9F89022B@mips.com> <3B4635FB.1ED5D222@mvista.com> <3B4AE384.52049D47@mips.com> <20010710103121.L19026@lucon.org> <3B52CF68.4687EBCB@mips.com> <20010716142802.A2757@lucon.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

"H . J . Lu" wrote:

> On Mon, Jul 16, 2001 at 01:26:32PM +0200, Carsten Langgaard wrote:
> > "H . J . Lu" wrote:
> > > > Now I would like to try to install H.J. Lu's RedHat7.1 RPM packages.
> > > > If I just do a:
> > > >     rpm -Uvh --root /mnt/harddisk *.rpm
> > >
> > > Those rpms have to be installed in the right order. I have a set up
> > > to do that. I will see what I can do.
> >
> > Thanks, please do.
>
> They are in install.tar.bz2 now.

Thanks a lot, that look like something we have been needing for a long time

> > Another thing, I can see your distribution is lacking kernel header
> > files, I guess they are needed to do a native compile of the source RPMs.
>
> I added gdb and kernel-headers. I also updated gcc, glibc and binutils.
> The toolchain rpms are updated.

Now that I'm at it :-)
Could you add a Perl rpm to you distribution, this also seems to be needed to
build the RPMs natively.

I also would like to do a cross build, but how do I do that ?
Do I have to change all the spec files, to set the target arch to MIPS, or is
there a easier and better way to do that ?
I guess if I just install the SRPMs and the cross toolchain, and try to build
out of that I will simply build for the build platform, which is i386.

>
>
> H.J.
> ------
> My mini-port of RedHat 7.1 is at
>
> ftp://oss.sgi.com/pub/linux/mips/redhat/7.1/
>
> you should be able to put a small RedHat 7.1 on the mips/mipsel box and
> compile the rest of RedHat 7.1 yourselves.
>
> Here are something you should know:
>
> 1. The cross compiler hosted on RedHat 7.1/ia32 is provided as a
> toolchain rpm. The binary rpms for the mips and mipsel cross compilers
> are included. You will need glibc 2.2.3-11 or above to use those
> rpms. The glibc x86 binary rpms under RPMS/i386 should be ok.
> 2. You have to find a way to put those rpms on your machine. I use
> network boot and NFS root to do it.
> 3. install.tar.bz2 has some scripts to prepare NFS root and install
> RedHat 7.1 on a hard drive.
>
> Thanks.
>
> H.J.
