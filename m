Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 01 Oct 2005 03:56:28 +0100 (BST)
Received: from 202-47-55-78.adsl.gil.com.au ([202.47.55.78]:49590 "EHLO
	longlandclan.hopto.org") by ftp.linux-mips.org with ESMTP
	id S3465602AbVJAC4L (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 1 Oct 2005 03:56:11 +0100
Received: (qmail 4278 invoked by uid 210); 1 Oct 2005 12:55:14 +1000
Received: from 10.0.0.251 by www (envelope-from <redhatter@gentoo.org>, uid 201) with qmail-scanner-1.25st 
 (spamassassin: 3.0.4. perlscan: 1.25st.  
 Clear:RC:1(10.0.0.251):. 
 Processed in 0.138133 secs); 01 Oct 2005 02:55:14 -0000
Received: from beast.redhatters.home (HELO ?10.0.0.251?) (10.0.0.251)
  by 192.168.5.1 with SMTP; 1 Oct 2005 12:55:13 +1000
Message-ID: <433DFA95.70705@gentoo.org>
Date:	Sat, 01 Oct 2005 12:55:17 +1000
From:	Stuart Longland <redhatter@gentoo.org>
Organization: Gentoo Foundation
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	oski <oski2001@hotmail.com>
CC:	linux-mips@linux-mips.org
Subject: Re: Compiling a kernel for ibm z50
References: <BAY101-DAV76EF721B0CFCE85875AC3D28A0@phx.gbl> <20050928183731.GA18480@linux-mips.org> <433CD36E.7040807@gentoo.org> <BAY101-DAV1223E6E4198CCF9DD3D75FD28F0@phx.gbl>
In-Reply-To: <BAY101-DAV1223E6E4198CCF9DD3D75FD28F0@phx.gbl>
X-Enigmail-Version: 0.91.0.0
OpenPGP: id=63264AB9;
	url=http://dev.gentoo.org/~redhatter/gpgkey.asc
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigEB2DE53FAECC018A762F91AC"
Return-Path: <redhatter@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9105
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: redhatter@gentoo.org
Precedence: bulk
X-list: linux-mips

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigEB2DE53FAECC018A762F91AC
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

oski wrote:
> Hi,
> 
> I realised something was not OK when trying to make zImage or make stripped
> i gor the warning that not rule were available. I need an small kernel able
> to boot from the msdos partition of my microdrive using hpcboot. A big
> kernel will be a waste of space in the microdrive.
> 
> Anyway after make clean I can not find vmlinux anywhere, I was expecting it
> to be in arch/mips/boot but nothing there. Any ideas?
> 
> many thanks
> 
> oski

Look in the linux/ directory, not the linux/arch/mips/boot/ directory. :-)
You know -- the one you ran `make vmlinux` in. ;-)

The latter directory is an x86-ism -- we don't do things that way on
MIPS. :-)
-- 
 ____                   _             Stuart Longland (a.k.a Redhatter)
/  _ \   ___    ___  __| |__  __   __ Gentoo Linux/MIPS Cobalt and Docs
- (_) \ /   \  ;   \(__   __)/  \ /  \                        Developer
 \    //  O _| / /\ \  | |  | /\ | /\ |
 /   / \   /__| /  \ \ | |  | \/ | \/ |
(___/   \____/|_;  |_| \_/   \__/ \__/ http://dev.gentoo.org/~redhatter

--------------enigEB2DE53FAECC018A762F91AC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDPfqYuarJ1mMmSrkRAnwgAJ9i+XmXTeIcncfW4j8UzyGmv/aDpACdExBm
0ZkxIc3s6NYXpT8TTdzwmOg=
=PXib
-----END PGP SIGNATURE-----

--------------enigEB2DE53FAECC018A762F91AC--
