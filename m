Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Sep 2003 14:53:16 +0100 (BST)
Received: from honk1.physik.uni-konstanz.de ([IPv6:::ffff:134.34.140.224]:42145
	"EHLO honk1.physik.uni-konstanz.de") by linux-mips.org with ESMTP
	id <S8225474AbTI3Nwo>; Tue, 30 Sep 2003 14:52:44 +0100
Received: from localhost (localhost [127.0.0.1])
	by honk1.physik.uni-konstanz.de (Postfix) with ESMTP id 4A4D42BC41
	for <linux-mips@linux-mips.org>; Tue, 30 Sep 2003 15:52:31 +0200 (CEST)
Received: from honk1.physik.uni-konstanz.de ([127.0.0.1])
 by localhost (honk [127.0.0.1:10024]) (amavisd-new) with ESMTP id 09513-10
 for <linux-mips@linux-mips.org>; Tue, 30 Sep 2003 15:51:58 +0200 (CEST)
Received: from bogon.sigxcpu.org (bogon.physik.uni-konstanz.de [134.34.147.122])
	by honk1.physik.uni-konstanz.de (Postfix) with ESMTP id A4E222BC39
	for <linux-mips@linux-mips.org>; Tue, 30 Sep 2003 15:51:58 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
	id 1339E4256; Tue, 30 Sep 2003 15:58:46 +0200 (CEST)
Date: Tue, 30 Sep 2003 15:58:46 +0200
From: Guido Guenther <agx@sigxcpu.org>
To: linux-mips@linux-mips.org
Subject: Re: [Indy] text console
Message-ID: <20030930135846.GB761@bogon.ms20.nix>
Mail-Followup-To: Guido Guenther <agx@sigxcpu.org>,
	linux-mips@linux-mips.org
References: <20030926122012.GC19876@icm.edu.pl> <20030930112541.GE26507@icm.edu.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="v9Ux+11Zm5mwPlX6"
Content-Disposition: inline
In-Reply-To: <20030930112541.GE26507@icm.edu.pl>
User-Agent: Mutt/1.5.4i
X-Virus-Scanned: by amavisd-new-20021227-p2 (Debian)
Return-Path: <agx@sigxcpu.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3327
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: agx@sigxcpu.org
Precedence: bulk
X-list: linux-mips


--v9Ux+11Zm5mwPlX6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 30, 2003 at 01:25:42PM +0200, Dominik 'Rathann' Mierzejewski wrote:
> Doesn't anyone know? Please help or say it's impossible. I'm
> stuck with 1280x1024@60Hz which is very uncomfortable to my
> eyes.
Try the "monitor" PROM variable to switch to 1024x768. See:
 http://www.parallab.uib.no/SGI_bookshelves/SGI_Admin/books/IA_ConfigOps/sgi_html/ch09.html#LE63851-PARENT
Cheers,
 -- Guido

--v9Ux+11Zm5mwPlX6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/eYwWn88szT8+ZCYRAs2JAJ9vblHl8JwPdQNtbabWku5pxHANgACeJ5mq
vNz3C1J+YuHgL4z7Zx+LK4s=
=YSfz
-----END PGP SIGNATURE-----

--v9Ux+11Zm5mwPlX6--
