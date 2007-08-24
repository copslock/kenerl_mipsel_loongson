Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Aug 2007 04:23:14 +0100 (BST)
Received: from mail.lysator.liu.se ([130.236.254.3]:9655 "EHLO
	mail.lysator.liu.se") by ftp.linux-mips.org with ESMTP
	id S20021444AbXHXDXG (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 24 Aug 2007 04:23:06 +0100
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id B9DBE200A20B;
	Fri, 24 Aug 2007 05:22:34 +0200 (CEST)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 15015-01-81; Fri, 24 Aug 2007 05:22:33 +0200 (CEST)
Received: from [192.168.0.132] (cust.fiber-lan.vnet.lk.85.194.49.238.stunet.se [85.194.49.238])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id 718AB200A208;
	Fri, 24 Aug 2007 05:22:31 +0200 (CEST)
In-Reply-To: <20070823203757.GA25971@deprecation.cyrius.com>
References: <20070823203757.GA25971@deprecation.cyrius.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-7--834839395"
Message-Id: <80320FD4-C8A6-4251-9923-58B0954F91D2@27m.se>
Cc:	linux-mips@linux-mips.org
Content-Transfer-Encoding: 7bit
From:	Markus Gothe <markus.gothe@27m.se>
Subject: Re: Tulip driver broken on Cobalt RaQ1 in 2.6
Date:	Fri, 24 Aug 2007 05:22:37 +0200
To:	Martin Michlmayr <tbm@cyrius.com>
X-Pgp-Agent: GPGMail 1.1.2 (Tiger)
X-Mailer: Apple Mail (2.752.3)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Return-Path: <markus.gothe@27m.se>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16264
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markus.gothe@27m.se
Precedence: bulk
X-list: linux-mips

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-7--834839395
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=ISO-8859-1; delsp=yes; format=flowed

Have you diffed the two versions against eachother, for the memory =20
address its running uncached. Check io-remapping.

//Markus

On 23 Aug, 2007, at 22:37 , Martin Michlmayr wrote:

> We have Debian users who happily used 2.4.27 on their Cobalt Raq1 and
> Qube 2700.  However, since we moved to 2.6 these machines stopped
> working.  I found out that the network driver (tulip) is no longer
> working on these machines.  Today I tried to track down when this
> started to happen but I couldn't find a 2.6 release where it actually
> worked.
>
> The 2.4.27 release we have is based on Peter Horton's patches from
> http://www.colonel-panic.org/cobalt-mips/  Today I tested current git,
> and 2.6.18 (which work out of the box), as well as 2.6.12-rc2 and
> 2.6.16-rc1 with Peter's patches.  In all of these releases, network
> would work fine on a RaQ2, but not on a RaQ1.  I'm not sure what
> information to report because I found nothing obvious.  In 2.4.27, we
> get:
>
> PCI: Enabling device 00:07.0 (0045 -> 0047)
> tulip0: Old format EEPROM on 'Cobalt Microserver' board.  Using =20
> substitute media control info.
> tulip0:  EEPROM default media type Autosense.
> tulip0:  Index #0 - Media MII (#11) described by a 21142 MII PHY =20
> (3) block.
> tulip0:  MII transceiver #1 config 1000 status 7809 advertising 01e1.
> eth0: Digital DS21143 Tulip rev 65 at 0x100000, 00:10:E0:00:27:5C, =20
> IRQ 4.
>
> wheras 2.6.16-rc1 has:
>
> PCI: Enabling device 0000:00:07.0 (0041 -> 0043)
> tulip0: Old format EEPROM on 'Cobalt Microserver' board.  Using =20
> substitute media control info.
> tulip0:  EEPROM default media type Autosense.
> tulip0:  Index #0 - Media MII (#11) described by a 21142 MII PHY =20
> (3) block.
> tulip0:  MII transceiver #1 config 1000 status 7809 advertising 01e1.
> eth0: Digital DS21143 Tulip rev 65 at b0001000, 00:10:E0:00:27:5C, =20
> IRQ 20.
>
> The address is different but I doubt this makes a difference =20
> because the
> RaQ2 shows the same difference and here networking works.  I also =20
> noticed
> the following in the boot logs of the RaQ1 with 2.6 that doesn't =20
> happen
> with 2.4, but that's because 2.4 doesn't have such a warning:
>
> Galileo: revision 2
> Galileo: PCI retry count exceeded (06.0)
>
> Does anyone who knows about Cobalt hardware have any idea where to =20
> look?
> I'm happy to send boot logs and test patches if someone wants to
> investigate this problem.
>
> --=20
> Martin Michlmayr
> http://www.cyrius.com/<raq1-git>

_______________________________________

Mr Markus Gothe
Software Engineer

Phone: +46 (0)13 21 81 20 (ext. 1046)
Fax: +46 (0)13 21 21 15
Mobile: +46 (0)73 718 72 80
Diskettgatan 11, SE-583 35 Link=F6ping, Sweden
www.27m.com



--Apple-Mail-7--834839395
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (Darwin)

iD8DBQFGzk7+6I0XmJx2NrwRAunsAJ9tQ2cI7R6h6MVXtWXYnouS0FGKxQCfecuZ
M6RsmhwPWVL08ZV1eKcPteo=
=Zqbp
-----END PGP SIGNATURE-----

--Apple-Mail-7--834839395--
