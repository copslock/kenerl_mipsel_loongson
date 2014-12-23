Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Dec 2014 00:32:07 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:5974 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27009483AbaLWXcGdKGgB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Dec 2014 00:32:06 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id D268041F8D11;
        Tue, 23 Dec 2014 23:32:00 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.242])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Tue, 23 Dec 2014 23:32:00 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Tue, 23 Dec 2014 23:32:00 +0000
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id E8A2C82B01043;
        Tue, 23 Dec 2014 23:31:56 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 23 Dec 2014 23:32:00 +0000
Received: from localhost (192.168.154.101) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Tue, 23 Dec
 2014 23:31:59 +0000
Date:   Tue, 23 Dec 2014 23:31:54 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-mips@linux-mips.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 07/10] MIPS: support for hybrid FPRs
Message-ID: <20141223233154.GA4171@jhogan-linux.le.imgtec.org>
References: <1410420623-11691-1-git-send-email-paul.burton@imgtec.com>
 <1410420623-11691-8-git-send-email-paul.burton@imgtec.com>
 <20141223232111.GA593@fuloong-minipc.musicnaut.iki.fi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
Content-Disposition: inline
In-Reply-To: <20141223232111.GA593@fuloong-minipc.musicnaut.iki.fi>
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Originating-IP: [192.168.154.101]
X-ESG-ENCRYPT-TAG: b93fcccb
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44907
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

--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 24, 2014 at 01:21:11AM +0200, Aaro Koskinen wrote:
> Hi,
>=20
> On Thu, Sep 11, 2014 at 08:30:20AM +0100, Paul Burton wrote:
> > Hybrid FPRs is a scheme where scalar FP registers are 64b wide, but
> > accesses to odd indexed single registers use bits 63:32 of the
> > preceeding even indexed 64b register. In this mode all FP code
> > except that built for the plain FP64 ABI can execute correctly. Most
> > notably a combination of FP64A & FP32 code can execute correctly,
> > allowing for existing FP32 binaries to be linked with new FP64A binaries
> > that can make use of 64 bit FP & MSA.
>=20
> This commit (4227a2d4efc9c84f35826dc4d1e6dc183f6c1c05, bisected)
> in 3.19-rc1 breaks my Loongson-2F system. I get endless amount
> of "Reserved instruction in kernel code" exceptions when booting.
> See some examples below. Nothing crashes, and there is some forward
> progress, but obviously it's completely unusable.
>=20
> Any ideas?
>=20
> [    2.872000] Reserved instruction in kernel code[#1]:
=2E..
> Code: 30420001  2c420001  0040202d <40038005> 2405feff  00651824  4083800=
5  3c032000  3c052400=20

0x40038005 =3D mfc0 v1,$16,5 =3D mfc0 v1,Config5

Does this help (in linux-next)?:
http://git.linux-mips.org/cgit/ralf/upstream-sfr.git/commit/?id=3D5bba8dec7=
35f18fe7a2fcd8327f28ef095337ff2

Cheers
James

--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUmftqAAoJEGwLaZPeOHZ6ZEAQAIU3oztbgEbp3Zt57RaJWrAe
aKMNiPToXqsP9qE5F5W/g+Y/Dj6LrIM2PF1ffITG1LI70qitR6izPCM9vrqG36Dg
QXyWRdK+lglGCwVzD2LH/C08cp2r/dL3OC0iXwoABJA64WtzJ05xs1L8CFED4uhT
gc0ztumDMpkIYdUo95NM/8+d5Uf2ewfUn1/Nw6iqARZjlDHEGhLrOZitB8cOO3tY
w3UWcvgPovJ//tbygIs5apOz/X8F7lnU9Io6fqgUw4WirkMTDVRJbn2LbVXWD22u
c3TDhHB+enF3zYk8mrGQ6XXUKgAaDVd0UnBo2maiM8N0W50BZcAOJ/qHPxH2Zs1k
3GY7eOoHvaJDDel0ci+h5G2LWFtWvJK3nRvlg80VHCcxspWFaUfAhDr7uJaajq0X
j58q01hMQ+ejS5pxYD1jqCmS8H/dezVOkneewYmBJOX4hkKbZLvTb0MmNzWeC2sU
j7lpUecpR8PJXjZPCMUJXKdVH44ReZrMiqAxZdwRSdPDP+jR0BVVHSY7qooGJLU/
STqBKqDdpHrTtAcjRYKE23PFOj8j5PHgXES4i1NaZZkcOqrdGJeGmOP2Zod5Cm7W
Yo3uU5EpJPc64GzjTYZHSWGC/OnRj5BUWjK0iaAOt4iFHyg7xc3TpDAWZX8Qy+e4
aKuJyGSy57cWpMfFOPxm
=6uMX
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--
