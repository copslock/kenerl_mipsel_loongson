Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 06 Aug 2005 14:04:37 +0100 (BST)
Received: from 202-47-55-78.adsl.gil.com.au ([IPv6:::ffff:202.47.55.78]:59321
	"EHLO longlandclan.hopto.org") by linux-mips.org with ESMTP
	id <S8224990AbVHFNET>; Sat, 6 Aug 2005 14:04:19 +0100
Received: (qmail 5979 invoked by uid 210); 6 Aug 2005 23:07:29 +1000
Received: from 10.0.0.251 by www (envelope-from <redhatter@gentoo.org>, uid 201) with qmail-scanner-1.25st 
 (spamassassin: 3.0.2. perlscan: 1.25st.  
 Clear:RC:1(10.0.0.251):. 
 Processed in 0.09711 secs); 06 Aug 2005 13:07:29 -0000
Received: from beast.redhatters.home (HELO ?10.0.0.251?) (10.0.0.251)
  by 192.168.5.1 with SMTP; 6 Aug 2005 23:07:29 +1000
Message-ID: <42F4B60F.3070402@gentoo.org>
Date:	Sat, 06 Aug 2005 23:07:27 +1000
From:	Stuart Longland <redhatter@gentoo.org>
Organization: Gentoo Foundation
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Linux on the Sharp Mobilion PRO PV5000A?
X-Enigmail-Version: 0.91.0.0
OpenPGP: id=63264AB9;
	url=http://dev.gentoo.org/~redhatter/gpgkey.asc
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigDEF8329372B3149AE5FA879A"
Return-Path: <redhatter@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8704
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: redhatter@gentoo.org
Precedence: bulk
X-list: linux-mips

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDEF8329372B3149AE5FA879A
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi All,

I've recently acquired a new toy, a Sharp PDA.  From what I've read on
the NetBSD/hpcmips website, and other places, it's based around a
Toshiba TX3922 129MHz CPU and has 32MB RAM.

I've done some research, and it looks like this machine may, be a cousin
of the Philips Velo.  I'm yet to pull mine apart (which I'll have to do
at some point, to fix a dickey power socket), so I can't be sure what
hardware mine has.

Anyway, what I was going to ask, is has anyone tried Linux or NetBSD on
this system?  If someone's already started work on porting, then I'd
like to assist where I can, no point in two of us duplicating efforts :-).

I've put some stuff up on the wiki[1], about what I know on the device.
 I'll possibly look into getting some sort of WinCE/MIPS dev environment
set up, so that I can compile apps to explore the hardware on the
device, but I'd be interested to hear if anyone has attempted a port to
such a device.

Regards,
-- 
 ____                   _             Stuart Longland (a.k.a Redhatter)
/  _ \   ___    ___  __| |__  __   __ Gentoo Linux/MIPS Cobalt and Docs
- (_) \ /   \  ;   \(__   __)/  \ /  \                        Developer
 \    //  O _| / /\ \  | |  | /\ | /\ |
 /   / \   /__| /  \ \ | |  | \/ | \/ |
(___/   \____/|_;  |_| \_/   \__/ \__/ http://dev.gentoo.org/~redhatter

Footnotes:
1. http://www.linux-mips.org/wiki/Sharp_Mobilion_Pro_PV5000A

--------------enigDEF8329372B3149AE5FA879A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFC9LYSuarJ1mMmSrkRAkOjAJ0Vp+awWHAmV75aZpZQ9MFtyPsaOwCdHuP8
aa0ecOUawY94GebDaihfrwY=
=JCMH
-----END PGP SIGNATURE-----

--------------enigDEF8329372B3149AE5FA879A--
