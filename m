Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8HGVMk07991
	for linux-mips-outgoing; Mon, 17 Sep 2001 09:31:22 -0700
Received: from neurosis.mit.edu (NEUROSIS.MIT.EDU [18.243.0.82])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8HGVHe07988
	for <linux-mips@oss.sgi.com>; Mon, 17 Sep 2001 09:31:17 -0700
Received: (from jim@localhost)
	by neurosis.mit.edu (8.11.4/8.11.4) id f8HGV6200503;
	Mon, 17 Sep 2001 12:31:06 -0400
Date: Mon, 17 Sep 2001 12:31:06 -0400
From: Jim Paris <jim@jtan.com>
To: Pete Popov <ppopov@pacbell.net>
Cc: linux-mips@oss.sgi.com
Subject: Re: pcmcia (again)
Message-ID: <20010917123106.A396@neurosis.mit.edu>
Reply-To: jim@jtan.com
References: <20010917001922.A28670@neurosis.mit.edu> <3BA588AD.3070402@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BA588AD.3070402@pacbell.net>; from ppopov@pacbell.net on Sun, Sep 16, 2001 at 10:22:53PM -0700
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Thanks for your reply.

> If your pcmcia
> controller is not one of the ones that linux already supports (ie,
> no socket driver for it), you might encounter problems beyond just
> the ones you describe above.

My PCMCIA controller is an i82365-compatible VG-469.  The driver for
that works; there are some linux-vr specific modifications to it that
allow it to work with remapped interrupts.

The I/O port mapping also seems to work fine, as the controller is
detected and it has no trouble seeing when cards are inserted.

The problem comes in with cs.c; it doesn't seem to know about the
ISA memory remapping:

cs: IO port probe 0x0100-0x04ff: excluding 0x100-0x107
initializing socket 0
cs: memory probe 0x0d0000-0x0dffff: excluding 0xd0000-0xdffff
cs: memory probe 0x0c0000-0x0cffff: excluding 0xc0000-0xcffff
cs: unable to map card memory!
cs: unable to map card memory!
initializing socket 1
cs: unable to map card memory!
cs: unable to map card memory!

And, from my inspection of the code, this seems to be caused by the
fact that it assumes that if it's ISA, the memory is mapped to
absolute address 0; rsrc_mgr.c excludes those memory regions and fails
to find available ISA memory space because the kernel already has
0x000000-0xffffff allocated to system RAM.

Am I misunderstanding something here?  Is there some simple way to get
the PCMCIA driver to use isa_slot_offset when checking and
requesting memory regions?  I tried adding that offset to the
check_mem_resource, request_mem_region, and release_mem_region calls,
and changing all of the readx/writex() calls to isa_readx/isa_writex(),
but things still don't work right.

thanks,
-jim
