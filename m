Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4V0LhQ24770
	for linux-mips-outgoing; Wed, 30 May 2001 17:21:43 -0700
Received: from gateway.total-knowledge.com (c1213523-b.smateo1.sfba.home.com [24.1.66.97])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f4V0Lbh24767
	for <linux-mips@oss.sgi.com>; Wed, 30 May 2001 17:21:37 -0700
Received: (qmail 5478 invoked by uid 502); 31 May 2001 00:21:36 -0000
Content-Type: text/plain;
  charset="koi8-u"
From: Ilya Volynets <ilya@theIlya.com>
Reply-To: ilya@theIlya.com
Organization: Total knowledge
To: Ian Thompson <iant@palmchip.com>
Subject: Re: ramdisk funkiness
Date: Wed, 30 May 2001 17:21:33 -0700
X-Mailer: KMail [version 1.2]
References: <3B157A53.5728029@palmchip.com> <01053016114302.00826@gateway> <3B158C4A.98CB5C26@palmchip.com>
In-Reply-To: <3B158C4A.98CB5C26@palmchip.com>
Cc: linux-mips@oss.sgi.com
MIME-Version: 1.0
Message-Id: <01053017213300.05410@gateway>
Content-Transfer-Encoding: 8bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Wednesday 30 May 2001 17:11, you wrote:
> Do I simply need to compile my kernel with ext2 support enabled, or do I
> need to somehow create a ramdisk image with that type of a format?
Yes, you need ramdisk with filesystem on it.

>  If
> you don't mind, could you explain a little about how I can go about
> pointing the kernel at a ramdisk image, assuming I don't have LILO to
> help me out?
LILO doesn't matter here, problem is that you don't have filesystem at all.
What good is linux kernel, if it can't run any programs?

In short to create ramdisk with filesystem on it, create file of needed size,
use mke2fs to make filesystem on it, then use loopback device to mount it,
and put files in there. Once you've done it, look at ramdisk HOWTO for
instructions on where to put resulting image. Bootdisk HOWTO might
also be helpfull. And YES, you will need to put ramdisk in ROM (unnless
you can download it from network, in which case you don't need ramdisk anyways
- -- use NFS).

BTW, it doesn't really have to be ext2fs, it could be any other fs (like ROMFS or RAMFS)
You just need support for it comiled into your kernel.

> thanks for your help!
>
> Ilya Volynets wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> >
> > At minimum you have to have ext2 fs on your ramdisk. init of some kind is
> > probably also something you want :)
> >
> > On Wednesday 30 May 2001 15:55, you wrote:
> > > Hi,
> > >
> > > I'm porting the 2.4 kernel to a custom board, and I'm running into some
> > > trouble while trying to mount the root filesystem.  There is no media
> > > (hard drives, cdrom drives, etc) attached to the system, but of course
> > > the kernel needs a root filesystem to boot.  So, I'm trying to create
> > > an empty ramdisk and have the kernel mount that as the root fs.  The
> > > kernel installs the ramdisk driver fine, but when it tries to open the
> > > ramdisk, I get this error message:
> > >
> > > RAMDISK driver initialized: 16 RAM disks of 128K size 1024 blocksize
> > > VFS: Cannot open root device "ram0" or 01:00
> > > Please append a correct "root=" boot option
> > > Kernel panic: VFS: Unable to mount root fs on 01:00
> > >
> > > Now for some possible complications: I'm not using LILO as of yet. 
> > > I've written a custom bootloader, and one of the arguments I pass to
> > > the kernel is "root=/dev/ram0" as it says to do in
> > > Documentation/initrd.txt.  So my question is: what other setup am I
> > > skipping?  I'd rather not have to store a ramdisk image in ROM, but I'm
> > > guessing I'll run into problems just creating an empty one.  What else
> > > do I need to do to get VFS to open the device correctly?
> > >
> > > Thanks,
> > > -ian
> > >
> > > --
> > > ----------------------------------------
> > > Ian Thompson           tel: 408.952.2023
> > > Firmware Engineer      fax: 408.570.0910
> > > Palmchip Corporation   www.palmchip.com
> >
> > -----BEGIN PGP SIGNATURE-----
> > Version: GnuPG v1.0.4 (GNU/Linux)
> > Comment: For info see http://www.gnupg.org
> >
> > iEYEARECAAYFAjsVfjIACgkQtKh84cA8u2ldHgCgt7l1wtJPlPQXh0dgCR6ctP9r
> > noUAoMRAbSqIjwoiU1jEz23vpOlgD0ZX
> > =GGkM
> > -----END PGP SIGNATURE-----
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjsVjpAACgkQtKh84cA8u2kLHgCffusU/629H1ChSPMvGGVlliuu
0pIAoMTgAL/suL87rW6q0NoaKrh7WRKk
=Cypj
-----END PGP SIGNATURE-----
