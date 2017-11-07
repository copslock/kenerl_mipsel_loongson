Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Nov 2017 11:03:31 +0100 (CET)
Received: from 19pmail.ess.barracuda.com ([64.235.150.244]:43328 "EHLO
        19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990593AbdKGKDYTEnfw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Nov 2017 11:03:24 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx30.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Tue, 07 Nov 2017 10:02:59 +0000
Received: from localhost (192.168.154.110) by MIPSMAIL01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 7 Nov 2017
 02:01:58 -0800
Date:   Tue, 7 Nov 2017 10:03:16 +0000
From:   James Hogan <james.hogan@mips.com>
To:     "Steven J. Hill" <Steven.Hill@cavium.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: Urgent patch for upstream.
Message-ID: <20171107100316.GH15235@jhogan-linux>
References: <0e020882-3de1-3704-a25a-d394fd874d97@cavium.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="s8uQA167RD2xhjBe"
Content-Disposition: inline
In-Reply-To: <0e020882-3de1-3704-a25a-d394fd874d97@cavium.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
X-BESS-ID: 1510048978-637140-17702-812953-1
X-BESS-VER: 2017.12-r1710252241
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.186667
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <James.Hogan@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60736
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@mips.com
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

--s8uQA167RD2xhjBe
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Steven,

On Tue, Nov 07, 2017 at 12:01:07AM -0600, Steven J. Hill wrote:
> James, et al.
>=20
> The patch <https://patchwork.linux-mips.org/patch/17400/> really needs
> to go into 4.14 to fix MIPS build breakage. 4.14-rc7 does not have this
> fix. How can we get this upstreamed?

The patch that it claims to fix isn't in mainline, its in linux-next
(the mips-for-linux-next branch), and has been broken there for about a
month or so. That is the place it should be fixed.

I've actually fixed that branch locally already but hadn't pushed it
anywhere. I'll see what I can do to get that branch updated.

Cheers
James

--s8uQA167RD2xhjBe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAloBhNEACgkQbAtpk944
dnopQhAAnajwEFEoRic25bajI3+sAkkFebbMZIXGp1f4zDJJ7UOkzrWMUyWXcrgp
UViWg7PgmiaPX7V/zluEhvHo9psnYdHwvhwZfuLHMHAiPDagneYqyEHfQlOaHIsR
GbUNphOTa6WIhOz7ay3D3PiBQCU5ZbSXmphf2g69ceyAm1R+6eUWthSlD0h0ewaf
jH9LYS5kecoyG3UGW+arP14h8jLX3oPjC1gNIOenULeKsMXnKYjwMzouhWbh59HW
03vn4QqZkC50qu6zH7EALsbZd1BNA73NLtoQuN68L8eFQJoxl2PWFsFV5XaKxN4q
vzeFfVPGE5duCKGS/HFbSzbRyJcu73altvfOkfU1m+290mTQ+kiaJHctZEOm5C0J
71XuhhbfnEEwlpC77Ze3ScdtlTYrlxMLehHbDpIVN43HCMEXQhRXCzjc9yhVhwcC
kQkg+Sgm4C1sKYtCjClEDaFEN87EAtXm8ukLlQ9dRAjyGagmlaI9f6hIpQMHFYCv
sz6+XS66FR2G0RptZbWMiwqo2ZDWjL6u7uK/3jqSmq5H0gK1XoqoB0JNcE92DpaZ
UdDSocbx8357pYO6sTUAs0xFGQew+WtOSXrGbmGsxICGxOuO/ZzCGm0d2hmEWDTc
3MxqrBKdJUrwzn8oTEQfS3CEMmq1PSu7R759VO0/zkZm3K9ORxo=
=I/Dk
-----END PGP SIGNATURE-----

--s8uQA167RD2xhjBe--
