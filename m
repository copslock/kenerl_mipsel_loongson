Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Aug 2003 13:50:34 +0100 (BST)
Received: from honk1.physik.uni-konstanz.de ([IPv6:::ffff:134.34.140.224]:56249
	"EHLO honk1.physik.uni-konstanz.de") by linux-mips.org with ESMTP
	id <S8225310AbTHHMua>; Fri, 8 Aug 2003 13:50:30 +0100
Received: from localhost (localhost [127.0.0.1])
	by honk1.physik.uni-konstanz.de (Postfix) with ESMTP
	id CD64E2BC3C; Fri,  8 Aug 2003 14:50:28 +0200 (CEST)
Received: from honk1.physik.uni-konstanz.de ([127.0.0.1])
 by localhost (honk [127.0.0.1:10024]) (amavisd-new) with ESMTP id 12490-04;
 Fri,  8 Aug 2003 14:50:24 +0200 (CEST)
Received: from bogon.sigxcpu.org (kons-d9bb55ca.pool.mediaWays.net [217.187.85.202])
	by honk1.physik.uni-konstanz.de (Postfix) with ESMTP
	id 9B2C52BC42; Fri,  8 Aug 2003 14:50:18 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
	id 9B0D7173AC; Thu,  7 Aug 2003 20:37:55 +0200 (CEST)
Date: Thu, 7 Aug 2003 20:37:55 +0200
From: Guido Guenther <agx@sigxcpu.org>
To: Michael Pruznick <michael_pruznick@mvista.com>
Cc: linux-mips@linux-mips.org
Subject: Re: PATCH:2.4:CONFIG_BINFMT_IRIX
Message-ID: <20030807183755.GA9874@bogon.ms20.nix>
Mail-Followup-To: Guido Guenther <agx@sigxcpu.org>,
	Michael Pruznick <michael_pruznick@mvista.com>,
	linux-mips@linux-mips.org
References: <3F2FF67D.8B0C2DFB@mvista.com> <3F329421.D86566A9@mvista.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
Content-Disposition: inline
In-Reply-To: <3F329421.D86566A9@mvista.com>
User-Agent: Mutt/1.5.4i
X-Virus-Scanned: by amavisd-new-20021227-p2 (Debian)
Return-Path: <agx@sigxcpu.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3008
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: agx@sigxcpu.org
Precedence: bulk
X-list: linux-mips


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 07, 2003 at 12:02:09PM -0600, Michael Pruznick wrote:
> This seams to be a better way to eliminate the irix
> stuff from being automatically included when switching
> a board from le to be.
What about leaving Irix compatibility off by default anyway. I don't
think it matters much these days.
 -- Guido

--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/MpyDn88szT8+ZCYRAtmlAKCBuPoGt2znMdfDMRznFuFsR+m4zQCfZ+jl
fGDONGHREN0TLrVyEuc+M+k=
=xV32
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--
