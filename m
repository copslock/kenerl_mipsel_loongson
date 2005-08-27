Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 27 Aug 2005 14:31:58 +0100 (BST)
Received: from 202-47-55-78.adsl.gil.com.au ([IPv6:::ffff:202.47.55.78]:45246
	"EHLO longlandclan.hopto.org") by linux-mips.org with ESMTP
	id <S8225006AbVH0Nbk>; Sat, 27 Aug 2005 14:31:40 +0100
Received: (qmail 11495 invoked by uid 210); 27 Aug 2005 23:37:19 +1000
Received: from 10.0.0.251 by www (envelope-from <redhatter@gentoo.org>, uid 201) with qmail-scanner-1.25st 
 (spamassassin: 3.0.2. perlscan: 1.25st.  
 Clear:RC:1(10.0.0.251):. 
 Processed in 0.205289 secs); 27 Aug 2005 13:37:19 -0000
Received: from beast.redhatters.home (HELO ?10.0.0.251?) (10.0.0.251)
  by 192.168.5.1 with SMTP; 27 Aug 2005 23:37:19 +1000
Message-ID: <43106C91.4070002@gentoo.org>
Date:	Sat, 27 Aug 2005 23:37:21 +1000
From:	Stuart Longland <redhatter@gentoo.org>
Organization: Gentoo Foundation
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Krishna B S <bskris@gmail.com>
CC:	linux-mips@linux-mips.org
Subject: Re: Selection of 2.4.31 from CVS?
References: <1943a41305082605013432e6f8@mail.gmail.com>
In-Reply-To: <1943a41305082605013432e6f8@mail.gmail.com>
X-Enigmail-Version: 0.91.0.0
OpenPGP: id=63264AB9;
	url=http://dev.gentoo.org/~redhatter/gpgkey.asc
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig83B0CE9E4A31CE94170490E4"
Return-Path: <redhatter@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8829
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: redhatter@gentoo.org
Precedence: bulk
X-list: linux-mips

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig83B0CE9E4A31CE94170490E4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Krishna B S wrote:
> Hi All,
> 
> I am looking for building a toolchain based on Linux-MIPS kernel for a
> MIPS 4Kc board. When I look at CVS Weekly Snapshots
> (http://www.longlandclan.hopto.org/~stuartl/mips-linux/sources/), I
> find many versions of 2.4.31 for use.
> 
> Which one should I consider for my usage? Is there any thumb rule for
> selecting a stable version of 2.4.31 from the CVS? Which CVS tag
> should I use for 2.4.31?

These are all just created on a weekly basis via a cron job on my
server.  Unless there have been CVS commits in the meantime to the
kernel 2.4 branch, then they should be practically identical.

My script is too dumb to realise this, however, and so creates a new
tarball of 2.4.31 each week regardless.  One of these days I'll probably
start pruning out the stale versions there, but for the moment, there's
plenty of space.

I should also point out, that server is hosted on my ADSL connection, so
you won't get wonderful download speeds.  If you can, using rsync or CVS
direct to ftp.linux-mips.org is preferrable over downloading off this
server.  ;-)

-- 
 ____                   _             Stuart Longland (a.k.a Redhatter)
/  _ \   ___    ___  __| |__  __   __ Gentoo Linux/MIPS Cobalt and Docs
- (_) \ /   \  ;   \(__   __)/  \ /  \                        Developer
 \    //  O _| / /\ \  | |  | /\ | /\ |
 /   / \   /__| /  \ \ | |  | \/ | \/ |
(___/   \____/|_;  |_| \_/   \__/ \__/ http://dev.gentoo.org/~redhatter

--------------enig83B0CE9E4A31CE94170490E4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDEGyUuarJ1mMmSrkRAjHrAJ9sqKn3j6KBbKhMr6TfK5C0B7QlQgCggAvG
nJfysdqVV2DFNqHb/LE2BnY=
=kGK3
-----END PGP SIGNATURE-----

--------------enig83B0CE9E4A31CE94170490E4--
