Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 May 2008 02:43:06 +0100 (BST)
Received: from chilli.pcug.org.au ([203.10.76.44]:62095 "EHLO smtps.tip.net.au")
	by ftp.linux-mips.org with ESMTP id S20023287AbYEMBnE (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 13 May 2008 02:43:04 +0100
Received: from ash.ozlabs.ibm.com (bh02i525f01.au.ibm.com [202.81.18.30])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by smtps.tip.net.au (Postfix) with ESMTP id 2695D368003;
	Tue, 13 May 2008 11:42:57 +1000 (EST)
Date:	Tue, 13 May 2008 11:42:44 +1000
From:	Stephen Rothwell <sfr@canb.auug.org.au>
To:	"Dmitri Vorobiev" <dmitri.vorobiev@gmail.com>
Cc:	"Theodore Tso" <tytso@mit.edu>,
	"Martin Michlmayr" <tbm@cyrius.com>, linux-mips@linux-mips.org,
	linux-ext4@vger.kernel.org, ralf@linux-mips.org
Subject: Re: ext4dev build failure on mips: "empty_zero_page" undefined
Message-Id: <20080513114244.736cf625.sfr@canb.auug.org.au>
In-Reply-To: <20080513105549.bb1563f8.sfr@canb.auug.org.au>
References: <20080512130604.GA15008@deprecation.cyrius.com>
	<90edad820805120654n50f7a00cm3c7b4a4f9346d5ea@mail.gmail.com>
	<20080512143426.GB7029@mit.edu>
	<20080512145836.GE15866@deprecation.cyrius.com>
	<90edad820805120814l7ee3f5d3h7f9939854bccf0@mail.gmail.com>
	<20080512173537.GG7029@mit.edu>
	<90edad820805121237r7f4b6e16g135df49cfe27499a@mail.gmail.com>
	<20080513105549.bb1563f8.sfr@canb.auug.org.au>
X-Mailer: Sylpheed 2.5.0beta3 (GTK+ 2.12.9; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Tue__13_May_2008_11_42_44_+1000_D4xdJbk8zH./C2Qr"
Return-Path: <sfr@canb.auug.org.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19232
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sfr@canb.auug.org.au
Precedence: bulk
X-list: linux-mips

--Signature=_Tue__13_May_2008_11_42_44_+1000_D4xdJbk8zH./C2Qr
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 13 May 2008 10:55:49 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> That would be great.  However, let us try with crosstool first. We
> haven't actually tried using crosstool to build a mips cross compiler.
> For a start, do we need mips or mipsel?  (My tame minion is trying to
> build both now.  :-))  Our host arch is powerpc64.

Also, the only compiler version that crosstool seems to know about for
mips is 3.4.5.  Is this version ok for building mips kernels?

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__13_May_2008_11_42_44_+1000_D4xdJbk8zH./C2Qr
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIKPIgTgG2atn1QN8RAlbPAKCLH9Yh2Ofm9Jk0tDqpavAOTZTkowCfbqkn
whC5LVgC8CjZ8HhpONd0yEE=
=lbVq
-----END PGP SIGNATURE-----

--Signature=_Tue__13_May_2008_11_42_44_+1000_D4xdJbk8zH./C2Qr--
