Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Jun 2016 23:17:21 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:10593 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27041697AbcFTVRUP6SBy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 Jun 2016 23:17:20 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 1CD8141F8E34;
        Mon, 20 Jun 2016 22:17:13 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.242])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Mon, 20 Jun 2016 22:17:13 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Mon, 20 Jun 2016 22:17:13 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 4D8A015B43EFB;
        Mon, 20 Jun 2016 22:17:08 +0100 (IST)
Received: from localhost (192.168.154.110) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 20 Jun
 2016 22:17:12 +0100
Date:   Mon, 20 Jun 2016 22:17:12 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     <stable@vger.kernel.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        Harvey Hunt <Harvey.Hunt@imgtec.com>
Subject: Please apply to stable, commit d7de413475f4 ("MIPS: Fix 64k page
 support for 32 bit kernels.")
Message-ID: <20160620211712.GO30921@jhogan-linux.le.imgtec.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5G50dybFf3pRZKd7"
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: cee91754
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54126
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

--5G50dybFf3pRZKd7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi stable maintainers,

Please could commit d7de413475f443957a0c1d256e405d19b3a2cb22 ("MIPS: Fix
64k page support for 32 bit kernels.") be applied to stable branches.
This fix was merged into mainline for v4.5-rc4.

Thanks
James

--5G50dybFf3pRZKd7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXaF1YAAoJEGwLaZPeOHZ6bRoP/2+qYAvs8YX1yi6ggeCLdHcq
hL0JK350Zmu9s8Ph5pLvti3ZfR6bHtyPUVyuDuAOEBdfQQM7UwglFRdrJ+5wlQDy
rQDz56oR+HaLfg7vy8c5e0Q9OXtVAud90zaIUKKhf8mPgy0i6uViI8r80ETi7O4z
dzFc9/BttlsRYPYw9f1G7VFVSYU+fn69kdIrh3LiYNMecjN3KmcOygazId+6IkoZ
o7wpwtC+vQCICzps6x7HpFhVt4dtXhhZNS2TuBVw/IirwiYu++1lzkcRutcXRrD+
UxjYH/TCLgTj585mcNa/KX2OIZEWm9ProwWAHKwlsa/6rl1KFjtQCb51WNrWjScQ
uJEEEwQhSXrH2PFdntLuEtv384CudzvQHkhOmsdCTJy89+5NzFJYlHxRRksfJ7eE
qYHQzyeb1aJD+wvUPhQbXnRIxhJ5+1t8NR3gtKb28gWCnFRTzbJJKyEILLJEBR3X
D44h6R+YuQxdVnug1QFxEODOdgAO0XmUzBGyWSbfN5IR9J5AilzwHe/uvVmaPzxE
KjBY0DgZfKjnV6UpJJPHRemhgoqOuCINcOXfXiUUgROzFo+LfjE0IGXyeof50EpX
j8DFBVbPnZpctxcHoG3HEBV0UJuTWhBtMAhRArnQepY9oIbC/bCPaxOj8KeLNTYX
jHOAuHgDLj9DAPlM6p5+
=KnJT
-----END PGP SIGNATURE-----

--5G50dybFf3pRZKd7--
