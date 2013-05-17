Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 May 2013 04:47:51 +0200 (CEST)
Received: from kymasys.com ([64.62.140.43]:59451 "HELO kymasys.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with SMTP
        id S6816823Ab3EQCrvNoJsS (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 17 May 2013 04:47:51 +0200
Received: from ::ffff:173.33.185.184 ([173.33.185.184]) by kymasys.com for <linux-mips@linux-mips.org>; Thu, 16 May 2013 19:47:39 -0700
From:   Sanjay Lal <sanjayl@kymasys.com>
Content-Type: multipart/signed; boundary="Apple-Mail=_0949687D-AADF-4235-9978-BBD1CF5267F0"; protocol="application/pgp-signature"; micalg=pgp-sha1
Subject: KVM and run-time determination of ASID parameters
Date:   Thu, 16 May 2013 22:47:37 -0400
Message-Id: <5AD586CC-1A8B-4039-8FF7-313143A8A43B@kymasys.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org
Mime-Version: 1.0 (Apple Message framework v1283)
X-Mailer: Apple Mail (2.1283)
Return-Path: <sanjayl@kymasys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36428
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sanjayl@kymasys.com
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


--Apple-Mail=_0949687D-AADF-4235-9978-BBD1CF5267F0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Commit d532f3d26716a39dfd4b88d687bd344fbe77e390 allowed ASID parameters =
like mask and increment to be determined @ runtime. Unfortunately this =
breaks KVM.  I think it has to do with the fact that KVM is a module and =
ends up with the default mask of 0xfc0. =20

Could we make these parameters globals that are exported so that modules =
end up with the correct patched values?

Regards
Sanjay


--Apple-Mail=_0949687D-AADF-4235-9978-BBD1CF5267F0
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Version: GnuPG/MacGPG2 v2.0.19 (Darwin)

iQIcBAEBAgAGBQJRlZpJAAoJECnL5VT5f2RtL2EP/2TdWsMACUrd9cXPqBNoa6EQ
N82yvHT0hafCHj5caABYqchRqq3X4Uv88B5FukxTmnYaM44WGtCYr0pEDotbUDNC
vrxw8rO0EB+tT9v2pPXfWB1eDmNmRdIQ0h3dZqtivKQiJeKOvESE9oU+pr4o1MZn
/fy+sJY5OLKQKeKLKSa2sBhYIXxqtyka3EXI24PtqB2tfCTSRalHuhk82DhSMp0a
EISIEBlxpMM30Pk0IyPCp2Pv77zq1tZPaOTaPaYU8PFPkY9Ogn9ya3NnurV69tYV
0noKdLioulHljLgVhN/U2hkQrTLimJBFFyiva+8Ay5BfcFEW+ol+X1jj248hv0Gi
qtbI9aEKeEvsJN7JXrCgY4y1QMBN0F1IUuHiwPmIt2RKXPWk7TuRVEb5EuB0Ud+1
ycigzCciwxG5jn9/3MUxoazCiY2SpIH5zfvCLsUxiZwf0T/45QZeYAaM8MNZrIqg
3o2pAOnimELe58N5s+IlBeorn7dOf3xFj8O8o7+O2aObAxWCv1VrT44iRZ0J0Ebr
CEH6utsy6Xk48vrajjCtXaR+dIZNOSRCTzsyDe6GNMgO8U8VRRJPS1N1exFwwM6t
qIzPNkKoOGisusKwO6ryiEKspqnE7aAKDnRpfT5iN+QCgZ/GfFECyF9secWH+Nsu
vB+KMal+y6lfmRgg9K6p
=11FC
-----END PGP SIGNATURE-----

--Apple-Mail=_0949687D-AADF-4235-9978-BBD1CF5267F0--
