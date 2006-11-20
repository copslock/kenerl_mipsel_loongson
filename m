Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Nov 2006 10:49:41 +0000 (GMT)
Received: from tool.snarl.nl ([213.84.251.124]:54923 "EHLO tool.snarl.nl")
	by ftp.linux-mips.org with ESMTP id S20037841AbWKTKtg (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 20 Nov 2006 10:49:36 +0000
Received: from localhost (tool.local.snarl.nl [127.0.0.1])
	by tool.snarl.nl (Postfix) with ESMTP id 04A245DF94;
	Mon, 20 Nov 2006 11:49:23 +0100 (CET)
Received: from tool.snarl.nl ([127.0.0.1])
	by localhost (tool.local.snarl.nl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id XFi8m+FP1vdq; Mon, 20 Nov 2006 11:49:22 +0100 (CET)
Received: by tool.snarl.nl (Postfix, from userid 1000)
	id 936755DF3D; Mon, 20 Nov 2006 11:49:22 +0100 (CET)
Date:	Mon, 20 Nov 2006 11:49:22 +0100
From:	Freddy Spierenburg <freddy@dusktilldawn.nl>
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
Cc:	linux-mips@linux-mips.org
Subject: Re: au1xmmc.c: does it work?
Message-ID: <20061120104922.GC32045@dusktilldawn.nl>
References: <20061120094053.GA13509@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UPT3ojh+0CqEDtpF"
Content-Disposition: inline
In-Reply-To: <20061120094053.GA13509@roarinelk.homelinux.net>
X-User-Agent-Feature: All mail clients suck. This one just sucks less.
X-GPG-Key: http://snarl.nl/~freddy/keys/freddyPublicKey.gpg
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <freddy@dusktilldawn.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13223
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: freddy@dusktilldawn.nl
Precedence: bulk
X-list: linux-mips


--UPT3ojh+0CqEDtpF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Manuel,

On Mon, Nov 20, 2006 at 10:40:53AM +0100, Manuel Lauss wrote:
> I insert a known working card, and the mmc cmd trace suggests
> CMD9 (send CSD) times out.

Are you working with a real MMC card or with an SD-card?

I myself am not able to get several SD-cards working, even though
SD-cards should be able to talk the MMC-protocol (AFAIK).

What I do have is several MMC-cards working properly, but I have
to add a small side note. I am using the AU1100 processor on our
own designed board. This AU1100 processor has a different DMA
controller than the AU1200 and AU1500. Unfortunaly the mmc driver
is written to use the DMA driver for the AU1200/AU1500 controller
and not the DMA driver for the AU1100. This is why I have a
slightly altered version of the au1xmmc driver. This version is
currently using pio mode instead of DMA. In the future I want it
to correcly use the right DMA driver depending on the processor,
but time constrains keep me at this moment from doing that. Also
it is a little bit addapted for our own hardware, which is like I
mentioned before not the DBAu1100 development board.

If you have trouble with MMC-cards too I'm more than willing to
send you the patch, but it probably needs some tweaking on your
part. That's why I do not yet attach it to this mail. Just ask
me personally for it if you want to try it out.


> Before I go about to trace the problem I'd like to know if
> other people see this problem too or if it's specific to my
> system.

With the SD-cards the driver indeed got no answer on the CMD9
request. So yes, I have the same problem on the AU1100 with the
2.6.16 kernel.


--=20
$ cat ~/.signature
Freddy Spierenburg <freddy@dusktilldawn.nl>  http://freddy.snarl.nl/
GnuPG: 0x7941D1E1=3DC948 5851 26D2 FA5C 39F1  E588 6F17 FD5D 7941 D1E1
$ # Please read http://www.ietf.org/rfc/rfc2015.txt before complain!

--UPT3ojh+0CqEDtpF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFYYgxbxf9XXlB0eERAiXiAKDhMMt6qF7qgBpjgvpEMn8uFVep9gCg8jvL
7WiewsBHkuWQ0EfYNCA2nWo=
=q12V
-----END PGP SIGNATURE-----

--UPT3ojh+0CqEDtpF--
