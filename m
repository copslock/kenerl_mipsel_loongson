Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Mar 2006 12:24:25 +0000 (GMT)
Received: from 202-47-55-78.adsl.gil.com.au ([202.47.55.78]:37859 "EHLO
	longlandclan.hopto.org") by ftp.linux-mips.org with ESMTP
	id S8133371AbWCFMYD (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 6 Mar 2006 12:24:03 +0000
Received: (qmail 7240 invoked from network); 6 Mar 2006 22:32:13 +1000
Received: from beast.redhatters.home (HELO ?10.0.0.251?) (10.0.0.251)
  by 192.168.5.1 with SMTP; 6 Mar 2006 22:32:13 +1000
Message-ID: <440C2CE8.9090204@gentoo.org>
Date:	Mon, 06 Mar 2006 22:36:56 +1000
From:	Stuart Longland <redhatter@gentoo.org>
Organization: Gentoo Foundation
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051029)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Re: does the linux support rootfs on vfat?
References: <50c9a2250603042217l475e84pc9ab7ce87c40eb76@mail.gmail.com>
In-Reply-To: <50c9a2250603042217l475e84pc9ab7ce87c40eb76@mail.gmail.com>
X-Enigmail-Version: 0.93.0.0
OpenPGP: id=63264AB9;
	url=http://dev.gentoo.org/~redhatter/gpgkey.asc
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigCC11A17E0815C80708E22A58"
Return-Path: <redhatter@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10734
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: redhatter@gentoo.org
Precedence: bulk
X-list: linux-mips

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigCC11A17E0815C80708E22A58
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

(Gah... I meant this to be sent publically, not just privately ;-)

zhuzhenhua wrote:
> if in my product based ide disk, i want to it to support the
> u-disk(with vfat fs), and can i set the root fs as vfat too?
> if use vfat as rootfs, what's disadvantage of the selection?

In theory, you could... BUT... FAT32 (and every other FAT variant) lacks:

- Ownership metadata (uid/gid fields)
- Permissions (mode: read/write/execute/sticky/suid/sgid)
- Links (both hard-links and symbolic links)
... probably character devices, block devices, pipes and other numerous
devices that 99.999999% of distributions rely on.

Now, there is UMSDOS, which uses additional special files to emulate
these on top of a standard MS-DOS filesystem ... mind you, it predates
VFAT by many years, and so I'm not sure what it's support is like for
long filenames.  I also haven't seen it in the kernel File System menu
for some time now.

I'd recommend using an external initrd... or an initramfs-based kernel.
 That way it's just one or two files, not one or two hundred. ;-)
-- 
Stuart Longland (aka Redhatter)              .'''.
Gentoo Linux/MIPS Cobalt and Docs Developer  '.'` :
. . . . . . . . . . . . . . . . . . . . . .   .'.'
http://dev.gentoo.org/~redhatter             :.'

International Asperger's Year (1906 ~ 2006)
http://dev.gentoo.org/~redhatter/iay


--------------enigCC11A17E0815C80708E22A58
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFEDCzruarJ1mMmSrkRAvY1AJ4jJDt6iJ0uaZPT+zqhHrYSdZIZJACfb5YK
o29h1orWv/OFvji4gCJ/f+M=
=Hw/J
-----END PGP SIGNATURE-----

--------------enigCC11A17E0815C80708E22A58--
