Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Jul 2017 12:17:59 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:24397 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23992213AbdGKKRwpKON0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 11 Jul 2017 12:17:52 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 4EBCC41F8E6A;
        Tue, 11 Jul 2017 12:28:25 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Tue, 11 Jul 2017 12:28:25 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Tue, 11 Jul 2017 12:28:25 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 59E8982DE3A36;
        Tue, 11 Jul 2017 11:17:44 +0100 (IST)
Received: from localhost (192.168.154.110) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Tue, 11 Jul
 2017 11:17:47 +0100
Date:   Tue, 11 Jul 2017 11:17:46 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        <stable@vger.kernel.org>
Subject: Re: [PATCH] MIPS: Fix MIPS I ISA /proc/cpuinfo reporting
Message-ID: <20170711101746.GQ31455@jhogan-linux.le.imgtec.org>
References: <alpine.LFD.2.20.1707082259380.5208@eddie.linux-mips.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0pkK7MCEo5hACTvx"
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.20.1707082259380.5208@eddie.linux-mips.org>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59091
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

--0pkK7MCEo5hACTvx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Sat, Jul 08, 2017 at 11:24:44PM +0100, Maciej W. Rozycki wrote:
> Cc: stable@vger.kernel.org # 3.19+
> Fixes: 515a6393dbac ("MIPS: kernel: proc: Add MIPS R6 support to /proc/cpuinfo")

That commit landed in v4.0-rc1, not 3.19.

Most stable tags with comments also have square brackets around the
email too, i.e.:
Cc: <stable@vger.kernel.org> # 4.0+

(though maybe thats just not to confuse git-send-email).

Otherwise:
Reviewed-by: James Hogan <james.hogan@imgtec.com>

Nice catch!

Cheers
James

--0pkK7MCEo5hACTvx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAllkpckACgkQbAtpk944
dnr/zxAAhQSNctVCPgsANR7EOXAhBvqoutCCkfROChat4SaCy7Gye8gazkC/t5Uo
Md1JK8YcGtYBlDMOW+kfk5vKICenE7lvuazQngJkOQsezDSsDhwp8HU3DR+Odk7j
pV9ktZvGgGGBzLl6bflxHaLnW/UhoJdr7QNufRygiU5l8eBRlRVHsFenDMpy3E93
8AmVXc/jMfIMz/yzrZqszQ1nSMAd6mROFppmn+hVHxIUKkhWyHm+lar1KF/aosTs
gXdbcRRpka14GBRHNaF2gH/KMoLL5SbCsJN70scKvVHiuEqsTwIi9Ju+6F27/Jm8
ndMYReCpX94a3sBrtfcAiZH2TPbYCBSDLHR6nYodTHAgz8t2XQyhEbih1R1yP7nN
ExJUga3WE5ve7LuYKq/M+qR+BK+GoZfeS8JWM3djkKLJ/JI5Y/i7uIhvdrmUZH0L
doy3Y34NNFJYbI9fokxndAnjrxSl4QsIr/1DzoT4gcjKB21mx294aMahbK6rXGNV
K1//s215m0jGy6DLYYdJ7nzaydh8eLh/ohiOBedprXsVT0Kcv69lyZUi74W3ZzFd
PyNaoSTPsYdeAV51zSpjdDHyk1f4Qfy56YoFoRu6Z0hkYiiuXFYqDnfoDeqMUEA9
aORuhHVOT5iSejeAxrE4ePDDYUynQNwfkOxiryHvGAVcuc6E7vg=
=6BsU
-----END PGP SIGNATURE-----

--0pkK7MCEo5hACTvx--
