Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Nov 2009 22:42:03 +0100 (CET)
Received: from chilli.pcug.org.au ([203.10.76.44]:36943 "EHLO smtps.tip.net.au"
	rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
	id S1493487AbZKXA1y (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 24 Nov 2009 01:27:54 +0100
Received: from canb.auug.org.au (bh02i525f01.au.ibm.com [202.81.18.30])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtps.tip.net.au (Postfix) with ESMTPSA id 5B75114C06E;
	Tue, 24 Nov 2009 11:27:50 +1100 (EST)
Date:	Tue, 24 Nov 2009 11:27:39 +1100
From:	Stephen Rothwell <sfr@canb.auug.org.au>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	linux-mips@linux-mips.org
Subject: Re: linux-next: failed to fetch the mips tree
Message-Id: <20091124112739.dd1ba1f7.sfr@canb.auug.org.au>
In-Reply-To: <20091124000929.GA7223@linux-mips.org>
References: <20091124105303.512479aa.sfr@canb.auug.org.au>
	<20091124000929.GA7223@linux-mips.org>
X-Mailer: Sylpheed 2.7.1 (GTK+ 2.18.3; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Tue__24_Nov_2009_11_27_39_+1100_nlMtMNEaWOnI5tua"
Return-Path: <sfr@canb.auug.org.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25108
X-Approved-By: ralf@linux-mips.org
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sfr@canb.auug.org.au
Precedence: bulk
X-list: linux-mips

--Signature=_Tue__24_Nov_2009_11_27_39_+1100_nlMtMNEaWOnI5tua
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ralf,

On Tue, 24 Nov 2009 00:09:29 +0000 Ralf Baechle <ralf@linux-mips.org> wrote:
>
> On Tue, Nov 24, 2009 at 10:53:03AM +1100, Stephen Rothwell wrote:
>=20
> > git.linux-mips.org[0: 78.24.191.183]: errno=3DConnection refused
> > fatal: unable to connect a socket (Connection refused)
>=20
> Thanks.  I upgraded the machine from Fedora 10 to Fedora 12 and the
> removal of the git "dash-commands" resulted in this failure.  Fixed.

All good now, thanks.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__24_Nov_2009_11_27_39_+1100_nlMtMNEaWOnI5tua
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAksLKHsACgkQjjKRsyhoI8wmuACdH0/k57CcVyFkTBtU34iHniu5
eQQAoLe2iX1HG8JeJH6337HCwRF6mo+8
=HjN+
-----END PGP SIGNATURE-----

--Signature=_Tue__24_Nov_2009_11_27_39_+1100_nlMtMNEaWOnI5tua--
