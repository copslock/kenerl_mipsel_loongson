Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8I7jp624462
	for linux-mips-outgoing; Tue, 18 Sep 2001 00:45:51 -0700
Received: from neurosis.mit.edu (NEUROSIS.MIT.EDU [18.243.0.82])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8I7jme24459
	for <linux-mips@oss.sgi.com>; Tue, 18 Sep 2001 00:45:48 -0700
Received: (from jim@localhost)
	by neurosis.mit.edu (8.11.4/8.11.4) id f8I7jk306906;
	Tue, 18 Sep 2001 03:45:46 -0400
Date: Tue, 18 Sep 2001 03:45:46 -0400
From: Jim Paris <jim@jtan.com>
To: Pete Popov <ppopov@pacbell.net>
Cc: linux-mips@oss.sgi.com
Subject: Re: pcmcia (again)
Message-ID: <20010918034546.A6886@neurosis.mit.edu>
Reply-To: jim@jtan.com
References: <20010917001922.A28670@neurosis.mit.edu> <3BA588AD.3070402@pacbell.net> <20010917123106.A396@neurosis.mit.edu> <3BA6C6FA.7070309@pacbell.net> <20010918024814.A6517@neurosis.mit.edu> <3BA6F284.50506@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BA6F284.50506@pacbell.net>; from ppopov@pacbell.net on Tue, Sep 18, 2001 at 12:06:44AM -0700
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> Good to hear that you found the problems.  If your patch to use
> isa_slot_offset doesn't get accepted, you might want to try to
> figure out if there's any way to limit your changes to your board's
> specific files. That way you won't have to carry patches around from
> one kernel version to another. I think this is now the second mips
> board with pcmcia support.

My architecture is only superficially supported by the current
Linux-MIPS cvs, so coming up with a patch for that would be a bit
difficult right now.  (the current CVS appears to have some basic
support for the vr41xx processor, but that's it).  The codebase I'm
working with right now is a terrible mix of the (outdated) linux-vr
and (current) linux-MIPS trees, which means that I'm already going to
have big issues if I ever want to upgrade versions or whatnot.

I guess my current plan is to keep hacking until I get a system that
works acceptably well, and then start submitting small patches to the
linux-MIPS tree to try to incorporate all of the linux-vr-specific
stuff, which would hopefully eliminate the need for the linux-VR
tree (which is not being actively maintained anyway).

> BTW, I have a LE ramdisk which runs linuxrc, loads pcmcia drivers,
> starts cardmgr, and exits. The kernel then mounts the real root fs
> which is /dev/hda1 in my case (pcmcia ata card).  Let me know if you
> need it.

I currently have my PCMCIA drivers built into the kernel; the
kernel-based card services stuff seems to work just fine in
my case, so I don't need an initrd.  Having never dealt directly with
PCMCIA under Linux before, I didn't find this strange, but it seems
that other people find a cardmgr-free PCMCIA setup a bit strange. :)

-jim
