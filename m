Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 07 Aug 2005 13:40:01 +0100 (BST)
Received: from 202-47-55-78.adsl.gil.com.au ([IPv6:::ffff:202.47.55.78]:61569
	"EHLO longlandclan.hopto.org") by linux-mips.org with ESMTP
	id <S8224943AbVHGMjm>; Sun, 7 Aug 2005 13:39:42 +0100
Received: (qmail 21500 invoked by uid 210); 7 Aug 2005 22:43:15 +1000
Received: from 10.0.0.251 by www (envelope-from <redhatter@gentoo.org>, uid 201) with qmail-scanner-1.25st 
 (spamassassin: 3.0.2. perlscan: 1.25st.  
 Clear:RC:1(10.0.0.251):. 
 Processed in 0.097349 secs); 07 Aug 2005 12:43:15 -0000
Received: from beast.redhatters.home (HELO ?10.0.0.251?) (10.0.0.251)
  by 192.168.5.1 with SMTP; 7 Aug 2005 22:43:15 +1000
Message-ID: <42F601E1.1050707@gentoo.org>
Date:	Sun, 07 Aug 2005 22:43:13 +1000
From:	Stuart Longland <redhatter@gentoo.org>
Organization: Gentoo Foundation
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Re: Linux on the Sharp Mobilion PRO PV5000A?
References: <42F4B60F.3070402@gentoo.org> <20050806225911.5cc0ed63.yuasa@hh.iij4u.or.jp> <20050807103123.GC25175@deprecation.cyrius.com>
In-Reply-To: <20050807103123.GC25175@deprecation.cyrius.com>
X-Enigmail-Version: 0.91.0.0
OpenPGP: id=63264AB9;
	url=http://dev.gentoo.org/~redhatter/gpgkey.asc
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigFACCFBDCC86888B9C1991756"
Return-Path: <redhatter@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8707
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: redhatter@gentoo.org
Precedence: bulk
X-list: linux-mips

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFACCFBDCC86888B9C1991756
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Martin Michlmayr wrote:
> * Yoichi Yuasa <yuasa@hh.iij4u.or.jp> [2005-08-06 22:59]:
> 
>>This is old information about TX3922.
>>
>>http://www.sikigami.com/~fuku/linux-telios/index-en.html
>>
>>I don't know that Telios and PV5000A are the same.
> 
> 
> I'm fairly sure they aren't.  If I remember correctly, the companion
> chip PLUM2 was only used in the Telios.

Well... I actually pulled mine apart tonight.
http://www.linux-mips.org/wiki/Sharp_Mobilion_Pro_PV5000A#A_look_inside

My primary objective was to fix a wobbly power socket... but I also took
the time to take snaps of the board & its chips.  In putting the unit
back together again though, it seems I now have some spare screws...
oddly enough, WinCE seems to boot & run ever so slightly faster.

You could say I've made it more efficient by removing parts -- but I
don't think screws count :-)

I'll have to google some of the ICs... I actually thought this would be
using the Philips Poseidon SoC, but no, there's not a single chip with
"Philips" written on it anywhere.  It's mostly Toshiba circuitry -- one
will be responsible for I/O, I know that much. :-)

-- 
 ____                   _             Stuart Longland (a.k.a Redhatter)
/  _ \   ___    ___  __| |__  __   __ Gentoo Linux/MIPS Cobalt and Docs
- (_) \ /   \  ;   \(__   __)/  \ /  \                        Developer
 \    //  O _| / /\ \  | |  | /\ | /\ |
 /   / \   /__| /  \ \ | |  | \/ | \/ |
(___/   \____/|_;  |_| \_/   \__/ \__/ http://dev.gentoo.org/~redhatter

--------------enigFACCFBDCC86888B9C1991756
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFC9gHluarJ1mMmSrkRAvTQAJ4jf9U4QSuUKIpz/4AohQibgRld+QCfRaON
x7YFVg9Qt+hLa9R8Ajnbpfo=
=aY8F
-----END PGP SIGNATURE-----

--------------enigFACCFBDCC86888B9C1991756--
