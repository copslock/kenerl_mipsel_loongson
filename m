Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6LJ36c29060
	for linux-mips-outgoing; Sat, 21 Jul 2001 12:03:06 -0700
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6LJ33V29057;
	Sat, 21 Jul 2001 12:03:03 -0700
Received: from lucon.org (lake.in.lucon.org [192.168.0.2])
	by ocean.lucon.org (Postfix) with ESMTP
	id D2B04125BA; Sat, 21 Jul 2001 12:03:02 -0700 (PDT)
Received: by lucon.org (Postfix, from userid 1000)
	id 5D081EC2D; Sat, 21 Jul 2001 12:03:02 -0700 (PDT)
Date: Sat, 21 Jul 2001 12:03:02 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: Ralf Baechle <ralf@oss.sgi.com>
Cc: Greg Satz <satz@ayrnetworks.com>, linux-mips@oss.sgi.com
Subject: Re: SHN_MIPS_SCOMMON
Message-ID: <20010721120302.A10173@lucon.org>
References: <20010721104144.A17894@lucon.org> <B77F222C.888C%satz@ayrnetworks.com> <20010721111315.A9479@lucon.org> <20010721205659.B25928@bacchus.dhis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010721205659.B25928@bacchus.dhis.org>; from ralf@oss.sgi.com on Sat, Jul 21, 2001 at 08:56:59PM +0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sat, Jul 21, 2001 at 08:56:59PM +0200, Ralf Baechle wrote:
> On Sat, Jul 21, 2001 at 11:13:16AM -0700, H . J . Lu wrote:
> 
> > On Sat, Jul 21, 2001 at 12:12:29PM -0600, Greg Satz wrote:
> > > The problem I ran into was making NFS as a kernel module. The resulting
> > > sunrpc.o module crashed when insmod was run over it. Ralf's fix that all
> > > compiles and links use -G 0 worked for me.
> > 
> > In that case, it is no linker bug. I believe -G 0 is required for
> > mips kernel modules.
> 
> Actually for all code; we don't support GP optimization in any of our code
> models.

Even for the user space code? Do you have a testcase to show what
should be the desired behavior? As I understand, the SHN_MIPS_SCOMMON
section only appears in the relocatable files. You won't see it in
executables nor DSOs. Are there any problems with SHN_MIPS_SCOMMON
in .o files? Can we always pass `-G 0' to the assemebler for Linux.


H.J.
