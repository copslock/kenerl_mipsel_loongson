Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Sep 2005 06:56:27 +0100 (BST)
Received: from 202-47-55-78.adsl.gil.com.au ([202.47.55.78]:46314 "EHLO
	longlandclan.hopto.org") by ftp.linux-mips.org with ESMTP
	id S8133684AbVI3F4G (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 30 Sep 2005 06:56:06 +0100
Received: (qmail 22053 invoked by uid 210); 30 Sep 2005 15:55:54 +1000
Received: from 10.0.0.251 by www (envelope-from <redhatter@gentoo.org>, uid 201) with qmail-scanner-1.25st 
 (spamassassin: 3.0.4. perlscan: 1.25st.  
 Clear:RC:1(10.0.0.251):. 
 Processed in 0.098293 secs); 30 Sep 2005 05:55:54 -0000
Received: from beast.redhatters.home (HELO ?10.0.0.251?) (10.0.0.251)
  by 192.168.5.1 with SMTP; 30 Sep 2005 15:55:54 +1000
Message-ID: <433CD36E.7040807@gentoo.org>
Date:	Fri, 30 Sep 2005 15:55:58 +1000
From:	Stuart Longland <redhatter@gentoo.org>
Organization: Gentoo Foundation
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	oski <oski2001@hotmail.com>
CC:	linux-mips@linux-mips.org
Subject: Re: Compiling a kernel for ibm z50
References: <BAY101-DAV76EF721B0CFCE85875AC3D28A0@phx.gbl> <20050928183731.GA18480@linux-mips.org>
In-Reply-To: <20050928183731.GA18480@linux-mips.org>
X-Enigmail-Version: 0.91.0.0
OpenPGP: id=63264AB9;
	url=http://dev.gentoo.org/~redhatter/gpgkey.asc
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig2C16DC01A01881EB550A5D20"
Return-Path: <redhatter@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9084
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: redhatter@gentoo.org
Precedence: bulk
X-list: linux-mips

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2C16DC01A01881EB550A5D20
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Ralf Baechle wrote:
> On Tue, Sep 27, 2005 at 06:19:51PM +0100, oski wrote:
> 
> 
>>This is my set up:
>>-An old Pentium II box with Redhat 8
>>-Downloaded linux-2.6.13.mipscvs-20050904 from www.longlandclan...and bzip2
>>and tar into /usr/src.
>>-Installed the mipsel crosscompiler from MIPS SDE
>>-After make config, when trying to make dep, I get a warning: make dep is
>>unnecessary now.
>>-Doing a ls arch/mips/boot I get a file called "compressed" with only a
>>folder called "CVS" .
> 
> 
> That's because who made that tarball didn't know his way around CVS enough
> to supply a -P option.  Nothing to worry, just extra clutter.
> 
>   Ralf

Heh, I've never had to use -P.  Hence my script[1] doesn't use -P.  Mind
you, I'll possibly end up porting that script to use git, once I get git
figured out (and the repository dragged across the web... good thing the
month's quota is almost up).

Incidentally, you do realise that you don't `make bzImage` like you do
under x86 don't you?  On mips, we use the raw vmlinux file (or
sometimes, we `make vmlinux.32`).  This is fed to the bootloader.
-- 
 ____                   _             Stuart Longland (a.k.a Redhatter)
/  _ \   ___    ___  __| |__  __   __ Gentoo Linux/MIPS Cobalt and Docs
- (_) \ /   \  ;   \(__   __)/  \ /  \                        Developer
 \    //  O _| / /\ \  | |  | /\ | /\ |
 /   / \   /__| /  \ \ | |  | \/ | \/ |
(___/   \____/|_;  |_| \_/   \__/ \__/ http://dev.gentoo.org/~redhatter
1.
http://www.longlandclan.hopto.org/~stuartl/mips-linux/utilities/get_kernel.sh.gz

--------------enig2C16DC01A01881EB550A5D20
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD4DBQFDPNNxuarJ1mMmSrkRArGeAJ91Iy+wBYJ/x0NbQiD7bBe5TGNF8ACXeffj
rI00wKova7h8JcDlkSS5Aw==
=t4B2
-----END PGP SIGNATURE-----

--------------enig2C16DC01A01881EB550A5D20--
