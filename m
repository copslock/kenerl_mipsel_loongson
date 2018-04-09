Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Apr 2018 22:27:03 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:36396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992009AbeDIU0zQAA4n (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 9 Apr 2018 22:26:55 +0200
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE9C420838;
        Mon,  9 Apr 2018 20:26:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE9C420838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Mon, 9 Apr 2018 21:26:43 +0100
From:   James Hogan <jhogan@kernel.org>
To:     Sasha Levin <Alexander.Levin@microsoft.com>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Daney <david.daney@cavium.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH AUTOSEL for 4.9 160/293] MIPS: Give __secure_computing()
 access to syscall arguments.
Message-ID: <20180409202642.GD17347@saruman>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
 <20180409002239.163177-160-alexander.levin@microsoft.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="FFoLq8A0u+X9iRU8"
Content-Disposition: inline
In-Reply-To: <20180409002239.163177-160-alexander.levin@microsoft.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63478
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jhogan@kernel.org
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


--FFoLq8A0u+X9iRU8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 09, 2018 at 12:24:58AM +0000, Sasha Levin wrote:
> From: David Daney <david.daney@cavium.com>
>=20
> [ Upstream commit 669c4092225f0ed5df12ebee654581b558a5e3ed ]
>=20
> KProbes of __seccomp_filter() are not very useful without access to
> the syscall arguments.
>=20
> Do what x86 does, and populate a struct seccomp_data to be passed to
> __secure_computing().  This allows samples/bpf/tracex5 to extract a
> sensible trace.

This broke o32 indirect syscalls, and was fixed by commit 3d729deaf287
("MIPS: seccomp: Fix indirect syscall args").

Cheers
James

--FFoLq8A0u+X9iRU8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlrLzIIACgkQbAtpk944
dnp/EA//SDhwZXbydTT8VuWsDZylcxmerobSmLfJ5EQPDcXUXH423Ae7UsznJ/k5
2d1ag8rbdB1VOTue43G8KJq6q7fXIp8MhO8KkcNvgBJrojbCoUCAoSKyeptCB2EP
AELPmibm2j+TPGc3JgnzHzB+GMKTjcpmEv0hSG4u+PEqWQOAMHJhcHGEc9eSaOry
ELGeogq44tITbjTEKKDenEv8OJ2gfb037e5deBNGcAWDbi0g9jF8O0wi4FK50G3v
Lj6Gnf/DC2HCJ8KxemOFNWzkgJ+/xu3flP96uR85hq3UnjMGK9qrTml2mg4VsIeH
lwmHoTRlpsgxYJrXI1KSTytKw725OhLHp+5GIYsyTrjOdUo5UZt0YmIW8y7Nt01q
gxjx5nYbTvVPzabUAH0l1RL6skEgSB6QvP/JnohMtDJ3ex7KJM/QVi07KuIvIVJ/
qSFXbhui8r4ALY0IOvLb5+YT88hzVBLxa1/ujdRr3WSjvvShHPcTtXUqwOAXVu2V
XvWJyaZOGzCo3UqZbxOPAY0nuB5NrO1wlbhuWlBfOi13+bD24f2nPUDgIvMH8bP8
znv1WRoytoIjBJqqeQWHLxU7BNmnR4f1s7ApVK9PBrDwhRNUnBaSH5D72clPUK/H
/Fpe2lJ7Z7zs9SgNW7plUu9wmbbY5x76jDHtHlKoD4kzW5RpE2Y=
=8wTE
-----END PGP SIGNATURE-----

--FFoLq8A0u+X9iRU8--
