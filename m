Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8EFOkT30515
	for linux-mips-outgoing; Fri, 14 Sep 2001 08:24:46 -0700
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8EFOge30512
	for <linux-mips@oss.sgi.com>; Fri, 14 Sep 2001 08:24:42 -0700
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id ED3AC125C3; Fri, 14 Sep 2001 08:24:41 -0700 (PDT)
Date: Fri, 14 Sep 2001 08:24:41 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: Carsten Langgaard <carstenl@mips.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: Update for RedHat 7.1
Message-ID: <20010914082441.A14362@lucon.org>
References: <20010907230009.A1705@lucon.org> <3BA0CB8D.ED5AB42B@mips.com> <20010913081450.B24910@lucon.org> <3BA1B747.834A875A@mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BA1B747.834A875A@mips.com>; from carstenl@mips.com on Fri, Sep 14, 2001 at 09:52:39AM +0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Sep 14, 2001 at 09:52:39AM +0200, Carsten Langgaard wrote:
> >
> > It may be the endian issue. Please recompile cracklib natively and let
> > me know if it fixes the problem for you.
> 
> I recompiled cracklib natively and yes it works, thanks a lot.
> Do you want the RPM binaries for your distribution ?
> 

I updated README. I will just tell big endian people to recompile those
rpms natively.

Thanks.


H.J.
----
My mini-port of RedHat 7.1 is at

ftp://oss.sgi.com/pub/linux/mips/redhat/7.1/

you should be able to put a small RedHat 7.1 on the mips/mipsel box and
compile the rest of RedHat 7.1 yourselves.

Here are something you should know:

1. The cross compiler hosted on RedHat 7.1/ia32 is provided as a
toolchain rpm. The binary rpms for the mips and mipsel cross compilers
are included. You will need glibc 2.2.3-11 or above to use those
rpms. The glibc x86 binary rpms under RPMS/i386 should be ok.
2. You have to find a way to put those rpms on your machine. I use
network boot and NFS root to do it.
3. install.tar.bz2 has some scripts to prepare NFS root and install
RedHat 7.1 on a hard drive.
4. baseline.tar.bz2 contains the cross build tree.
5. Since everything is cross compiled from x86, which is little endian,
many data files for mips, which is big endian, are either missing or
wrong. To get those data files for mips, you have to rebuild/install
the folowing rpms:

cracklib
glibc

natively on Linux/mips.

Thanks.


H.J.
