Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6GLSBk32215
	for linux-mips-outgoing; Mon, 16 Jul 2001 14:28:11 -0700
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6GLS3V32209;
	Mon, 16 Jul 2001 14:28:03 -0700
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 229C6125BC; Mon, 16 Jul 2001 14:28:02 -0700 (PDT)
Date: Mon, 16 Jul 2001 14:28:02 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: Carsten Langgaard <carstenl@mips.com>
Cc: Jun Sun <jsun@mvista.com>, ralf@oss.sgi.com, vhouten@kpn.com,
   linux-mips@oss.sgi.com
Subject: Updates on RedHat 7.1/mips
Message-ID: <20010716142802.A2757@lucon.org>
References: <3B4573B8.9F89022B@mips.com> <3B4635FB.1ED5D222@mvista.com> <3B4AE384.52049D47@mips.com> <20010710103121.L19026@lucon.org> <3B52CF68.4687EBCB@mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B52CF68.4687EBCB@mips.com>; from carstenl@mips.com on Mon, Jul 16, 2001 at 01:26:32PM +0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Jul 16, 2001 at 01:26:32PM +0200, Carsten Langgaard wrote:
> "H . J . Lu" wrote:
> > > Now I would like to try to install H.J. Lu's RedHat7.1 RPM packages.
> > > If I just do a:
> > >     rpm -Uvh --root /mnt/harddisk *.rpm
> >
> > Those rpms have to be installed in the right order. I have a set up
> > to do that. I will see what I can do.
> 
> Thanks, please do.

They are in install.tar.bz2 now.

> Another thing, I can see your distribution is lacking kernel header
> files, I guess they are needed to do a native compile of the source RPMs.

I added gdb and kernel-headers. I also updated gcc, glibc and binutils.
The toolchain rpms are updated.


H.J.
------
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

Thanks.


H.J.
