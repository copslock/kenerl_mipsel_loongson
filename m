Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6LIx5228766
	for linux-mips-outgoing; Sat, 21 Jul 2001 11:59:05 -0700
Received: from dea.waldorf-gmbh.de (u-151-18.karlsruhe.ipdial.viaginterkom.de [62.180.18.151])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6LIvUV28705
	for <linux-mips@oss.sgi.com>; Sat, 21 Jul 2001 11:57:37 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f6LIuxG26582;
	Sat, 21 Jul 2001 20:56:59 +0200
Date: Sat, 21 Jul 2001 20:56:59 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: "H . J . Lu" <hjl@lucon.org>
Cc: Greg Satz <satz@ayrnetworks.com>, linux-mips@oss.sgi.com
Subject: Re: SHN_MIPS_SCOMMON
Message-ID: <20010721205659.B25928@bacchus.dhis.org>
References: <20010721104144.A17894@lucon.org> <B77F222C.888C%satz@ayrnetworks.com> <20010721111315.A9479@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010721111315.A9479@lucon.org>; from hjl@lucon.org on Sat, Jul 21, 2001 at 11:13:16AM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sat, Jul 21, 2001 at 11:13:16AM -0700, H . J . Lu wrote:

> On Sat, Jul 21, 2001 at 12:12:29PM -0600, Greg Satz wrote:
> > The problem I ran into was making NFS as a kernel module. The resulting
> > sunrpc.o module crashed when insmod was run over it. Ralf's fix that all
> > compiles and links use -G 0 worked for me.
> 
> In that case, it is no linker bug. I believe -G 0 is required for
> mips kernel modules.

Actually for all code; we don't support GP optimization in any of our code
models.

  Ralf
