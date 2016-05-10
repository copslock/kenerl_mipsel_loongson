Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 May 2016 17:34:44 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:5108 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27028415AbcEJPem3JIXj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 10 May 2016 17:34:42 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id A980941F8DCA;
        Tue, 10 May 2016 16:34:36 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.242])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Tue, 10 May 2016 16:34:36 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Tue, 10 May 2016 16:34:36 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email with ESMTPS id 2A9AE8B0D36C5;
        Tue, 10 May 2016 16:34:33 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Tue, 10 May 2016 16:34:36 +0100
Received: from localhost (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.266.1; Tue, 10 May
 2016 16:34:35 +0100
Date:   Tue, 10 May 2016 16:34:35 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>,
        Matt Redfearn <Matt.Redfearn@imgtec.com>
Subject: Re: [PATCH 2/5] MIPS: Add defs & probing of 64-bit CP0_EBase
Message-ID: <20160510153435.GJ23699@jhogan-linux.le.imgtec.org>
References: <1461937563-13199-1-git-send-email-james.hogan@imgtec.com>
 <1461937563-13199-3-git-send-email-james.hogan@imgtec.com>
 <20160510100209.GB12554@jhogan-linux.le.imgtec.org>
 <20160510102406.GF16402@linux-mips.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/qIPZgKzMPM+y5U5"
Content-Disposition: inline
In-Reply-To: <20160510102406.GF16402@linux-mips.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: ebfc6934
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53345
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

--/qIPZgKzMPM+y5U5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 10, 2016 at 12:24:06PM +0200, Ralf Baechle wrote:
> On Tue, May 10, 2016 at 11:02:09AM +0100, James Hogan wrote:
>=20
> > On Fri, Apr 29, 2016 at 02:46:00PM +0100, James Hogan wrote:
> > > MIPS64r2 and later cores may optionally have a 64-bit CP0_EBase
> > > register, with a write gate (WG) bit to allow the upper half to be
> > > written. The presence of this feature will need to be known about for=
 VZ
> > > support in order to correctly save and restore the guest CP0_EBase
> > > register, so add CPU feature definitions and probing for this
> > > capability.
> >=20
> > Okay, so it turns out EBase.WG can be present on MIPS32 too, to allow
> > writing of bits 31:30 (thanks Matt!), so this needs a little more
> > thought.
>=20
> So drop the series for now or do you want to patch it up later?

Yes, please drop it. I'll submit a v2 which probes for WG instead (i.e.
detects it on MIPS32 too).

Thanks
James

--/qIPZgKzMPM+y5U5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXMf+LAAoJEGwLaZPeOHZ6yIQP/1OUynuniMpTI77R6tJ5kQgw
8+NsLQx3ITHtdeLqJAcAp82h9lo0HwQ66i0aCUrIpEL5qrfzmM3EDk94SzKFCUln
PPvOUws/ZhsJ84x70hWLSH5TBf2jpG23nT8O6GiQV7y3xgtHQvv07c/nVsMoLLFU
Kii+JJsXYbRFohJFQ9UHDIje/RBDDWz12ZA6EkcVt1imkRykMO4/VRWU1otwiGtU
a3lUUJdsxKSzkn25rHqcjbLyTJCciL4LmYEMm7+mPxTTttRTpMV3Kn5Y7rcQt84l
L9Qto/G+gdeeHW+RAmKNgLn4GYbNRm2s+MH1mVayIVmQUW9ntEnaQiOCtSBg+1WH
vd7XqEQ0mCoOOWAsrNspyHqzEd/BnRAA5DvOY6n4Dsptwfsu5/nVO3sDMHjuhVeB
B3wVDa+0PzMkzwwbbm6sl1lSuuW5L1pCZe05wUiX9qU0EbTo0RyZVJd44uhJYboI
gL168+xavyH2cJY6ch0xxEMGHkPc0V4UUGDAvO8LYcI7vhzp+s3DonA5ogiulmWN
NsC8aUwgr++0Ib2klJQuU7Jyigix0TjuMvk5Ozo4c8YeXCHyw+pjtIR9c8UNJdSl
28fnFaUIFetEROXFl2+6UTtyGtQAdW/jtleKeDvP4GZ8nfVa+srmvV8KryGLgu9L
2YwZXhvRA/J5VDHj9Kyv
=m6JZ
-----END PGP SIGNATURE-----

--/qIPZgKzMPM+y5U5--
