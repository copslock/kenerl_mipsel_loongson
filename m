Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5CGewb30455
	for linux-mips-outgoing; Tue, 12 Jun 2001 09:40:58 -0700
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5CGeuV30452;
	Tue, 12 Jun 2001 09:40:56 -0700
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id D932E125BA; Tue, 12 Jun 2001 09:40:55 -0700 (PDT)
Date: Tue, 12 Jun 2001 09:40:55 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: Ralf Baechle <ralf@oss.sgi.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: A new mips toolchain is available
Message-ID: <20010612094055.B20012@lucon.org>
References: <20010611210311.A8768@lucon.org> <20010612133925.B5106@bacchus.dhis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010612133925.B5106@bacchus.dhis.org>; from ralf@oss.sgi.com on Tue, Jun 12, 2001 at 01:39:25PM +0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Jun 12, 2001 at 01:39:25PM +0200, Ralf Baechle wrote:
> On Mon, Jun 11, 2001 at 09:03:11PM -0700, H . J . Lu wrote:
> 
> > I put my new mips toolchain at
> > 
> > http://ftp.kernel.org/pub/linux/devel/binutils/mips/
> > 
> > There are source rpms for RedHat 7.1. They may only be built correctly
> > with rpm, especially binutils. I can provide mips and mipsel binaries
> > rpms for them. But it will take at least a few days.
> > 
> > BTW, my toolchain is for the SVR4 MIPS ABI. I don't know how compatible
> > it is with the IRIX ABI. Old IRIX ABI binaries seem to run fine. But I
> > don't know abour the IRIX ABI DSOs.
> 
> No known issues except that modutils only works ok with SVR4 ABI flavoured
> binaries.

FYI, my glibc includes

        * sysdeps/mips/dl-machine.h (MAP_BASE_ADDR): Commented out.

        * sysdeps/mips/rtld-ldscript.in: Removed.
        * sysdeps/mips/rtld-parms: Likewise.
        * sysdeps/mips/mips64/rtld-parms: Likewise.
        * sysdeps/mips/mipsel/rtld-parms: Likewise.

As I mentioned before, the resulting glibc works fine with the IRIX ABI
executables. But I have no ideas about DSOs.


H.J.
