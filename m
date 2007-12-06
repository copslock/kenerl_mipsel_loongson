Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Dec 2007 16:42:00 +0000 (GMT)
Received: from blu0-omc1-s6.blu0.hotmail.com ([65.55.162.149]:62569 "EHLO
	blu0-omc1-s6.blu0.hotmail.com") by ftp.linux-mips.org with ESMTP
	id S20026788AbXLFQlv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 6 Dec 2007 16:41:51 +0000
Received: from BLU127-W10 ([65.55.162.182]) by blu0-omc1-s6.blu0.hotmail.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 6 Dec 2007 08:41:23 -0800
Message-ID: <BLU127-W10543A7CB1FFFC1CCC77918A6F0@phx.gbl>
X-Originating-IP: [157.185.36.161]
From:	Nathan Eggan <nathan_eggan@live.com>
To:	linux-mips mailing list <linux-mips@linux-mips.org>
Subject: Re: Bug in Au1x00 UART or USB drivers for 2.6 kernels?
Date:	Thu, 6 Dec 2007 16:41:23 +0000
Importance: Normal
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginalArrivalTime: 06 Dec 2007 16:41:23.0595 (UTC) FILETIME=[D65645B0:01C83826]
Return-Path: <nathan_eggan@live.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17718
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nathan_eggan@live.com
Precedence: bulk
X-list: linux-mips


Can anyone see this?  I'm new to Ecartis, so I'm not sure whether any of my messages are getting through.

Plus, my crappy Microsoft Windows Live Hotmail client could be screwing me up.  I'm not sure I can force it to just send purely plain text email.

Thanks,
Nate
_________________________________________________________________
You keep typing, we keep giving. Download Messenger and join the i’m Initiative now.
http://im.live.com/messenger/im/home/?source=TAGLM
From freddy@dusktilldawn.nl Thu Dec  6 16:51:06 2007
Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Dec 2007 16:51:14 +0000 (GMT)
Received: from tool.snarl.nl ([82.95.241.19]:29706 "EHLO tool.snarl.nl")
	by ftp.linux-mips.org with ESMTP id S20026868AbXLFQvG (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 6 Dec 2007 16:51:06 +0000
Received: from localhost (tool.local.snarl.nl [127.0.0.1])
	by tool.snarl.nl (Postfix) with ESMTP id E60795DF94;
	Thu,  6 Dec 2007 17:51:00 +0100 (CET)
Received: from tool.snarl.nl ([127.0.0.1])
	by localhost (tool.local.snarl.nl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id W8VuGNwoEV1s; Thu,  6 Dec 2007 17:51:00 +0100 (CET)
Received: by tool.snarl.nl (Postfix, from userid 1000)
	id 587F35DF6F; Thu,  6 Dec 2007 17:51:00 +0100 (CET)
Date:	Thu, 6 Dec 2007 17:51:00 +0100
From:	Freddy Spierenburg <freddy@dusktilldawn.nl>
To:	Nathan Eggan <nathan_eggan@live.com>
Cc:	linux-mips mailing list <linux-mips@linux-mips.org>
Subject: Re: Bug in Au1x00 UART or USB drivers for 2.6 kernels?
Message-ID: <20071206165100.GP2391@dusktilldawn.nl>
References: <BLU127-W10543A7CB1FFFC1CCC77918A6F0@phx.gbl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iSEM+tA/SPO43KHM"
Content-Disposition: inline
In-Reply-To: <BLU127-W10543A7CB1FFFC1CCC77918A6F0@phx.gbl>
X-User-Agent-Feature: All mail clients suck. This one just sucks less.
X-GPG-Key: http://snarl.nl/~freddy/keys/freddyPublicKey.gpg
User-Agent: Mutt/1.5.16 (2007-06-11)
Return-Path: <freddy@dusktilldawn.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17719
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: freddy@dusktilldawn.nl
Precedence: bulk
X-list: linux-mips


--iSEM+tA/SPO43KHM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Nathan,

On Thu, Dec 06, 2007 at 04:41:23PM +0000, Nathan Eggan wrote:
> Can anyone see this?

Yes, your message came through clearly.

And to reply a little bit more on topic. I had also some strange
serial trouble with 2.6.16, but it dissapeared when I used
2.6.23.9. The trouble I had was using 115200bps and for some strange
reason bytes would be missing on one of the interfaces. I had no
trouble on ttyS2, but ttyS0 would. Strange, but using 2.6.23.9 I
did not experience the same problems. I did not investigate the
real cause, but just wanted to let you know.


--=20
$ cat ~/.signature
Freddy Spierenburg <freddy@dusktilldawn.nl>  http://freddy.snarl.nl/
GnuPG: 0x7941D1E1=3DC948 5851 26D2 FA5C 39F1  E588 6F17 FD5D 7941 D1E1
$ # Please read http://www.ietf.org/rfc/rfc2015.txt before complain!

--iSEM+tA/SPO43KHM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHWChzbxf9XXlB0eERAmXpAJwPAy0TD8UbO0O9W3q3dJpYem6btgCfT7Of
dMdSa+9/guIra+nPJKBu7as=
=ris/
-----END PGP SIGNATURE-----

--iSEM+tA/SPO43KHM--
