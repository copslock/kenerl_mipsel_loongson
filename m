Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 06 Aug 2005 13:48:34 +0100 (BST)
Received: from 202-47-55-78.adsl.gil.com.au ([IPv6:::ffff:202.47.55.78]:17347
	"EHLO longlandclan.hopto.org") by linux-mips.org with ESMTP
	id <S8224990AbVHFMsM>; Sat, 6 Aug 2005 13:48:12 +0100
Received: (qmail 5740 invoked by uid 210); 6 Aug 2005 22:51:41 +1000
Received: from 10.0.0.251 by www (envelope-from <redhatter@gentoo.org>, uid 201) with qmail-scanner-1.25st 
 (spamassassin: 3.0.2. perlscan: 1.25st.  
 Clear:RC:1(10.0.0.251):. 
 Processed in 0.110896 secs); 06 Aug 2005 12:51:41 -0000
Received: from beast.redhatters.home (HELO ?10.0.0.251?) (10.0.0.251)
  by 192.168.5.1 with SMTP; 6 Aug 2005 22:51:41 +1000
Message-ID: <42F4B25B.6040708@gentoo.org>
Date:	Sat, 06 Aug 2005 22:51:39 +1000
From:	Stuart Longland <redhatter@gentoo.org>
Organization: Gentoo Foundation
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
CC:	cobalt@colonel-panic.org
Subject: netconsole support on Cobalt systems... Anyone tried it?
X-Enigmail-Version: 0.91.0.0
OpenPGP: id=63264AB9;
	url=http://dev.gentoo.org/~redhatter/gpgkey.asc
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigEDB531620BB9790F172F6628"
Return-Path: <redhatter@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8703
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: redhatter@gentoo.org
Precedence: bulk
X-list: linux-mips

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigEDB531620BB9790F172F6628
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi All,

I've been tinkering with my Qube2 tonight, seeing if I can get
netconsole running.  I'd like to get this running for two reasons:

(1) I've only got one null-modem cable, which usually is plugged into my
Indigo2 Impact -- I'd like to leave it where it is if possible.
(2) I'd like to improve support for the Qube 2700, which lacks such
interfaces.

I've looked around on the web, but haven't found a great deal of
material that explains how one uses it.  The best resource thus far has
been the linux/documentation/network/netconsole.txt file, as well as a
crash dump[1] from an AMD64, which shows netconsole in action.

I tried booting with `netconsole=9877@10.0.0.1/eth0,9876@10.0.0.254/` on
the kernel command line, without success.  The system continues to
boot[2], but only outputting to the serial console.

Has anyone here, tried using netconsole on Cobalt hardware?  Has anybody
played with netconsole on _any_ hardware?

Regards,
-- 
 ____                   _             Stuart Longland (a.k.a Redhatter)
/  _ \   ___    ___  __| |__  __   __ Gentoo Linux/MIPS Cobalt and Docs
- (_) \ /   \  ;   \(__   __)/  \ /  \                        Developer
 \    //  O _| / /\ \  | |  | /\ | /\ |
 /   / \   /__| /  \ \ | |  | \/ | \/ |
(___/   \____/|_;  |_| \_/   \__/ \__/ http://dev.gentoo.org/~redhatter

Footnotes,
1. http://mjt.nysv.org/kernelbugfest/netconsole_panic_2.6.12.2

2. I was using my WinCE/MIPS-based[3] PDA, which happens to have a
crippled version of "HyperTerminal".  Unfortunately, it lacks any
ability to capture the text... but otherwise, turns my PDA into a very
convenient portable VT100. :-)

3. I'd like to get Linux working on this thing sometime... see my next
post, which I'll write in a moment. :-)

--------------enigEDB531620BB9790F172F6628
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFC9LJeuarJ1mMmSrkRAsIMAJsH1IcRr1Yqlj3mT/RP4mzoSQyXOQCfWOCI
ZF0olppPJaN2qmIX7Zr+xt0=
=Wswj
-----END PGP SIGNATURE-----

--------------enigEDB531620BB9790F172F6628--
