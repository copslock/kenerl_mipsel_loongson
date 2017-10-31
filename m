Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Oct 2017 22:54:17 +0100 (CET)
Received: from 19pmail.ess.barracuda.com ([64.235.150.244]:60189 "EHLO
        19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992361AbdJaVyIBJsHl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 31 Oct 2017 22:54:08 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx2.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Tue, 31 Oct 2017 21:53:47 +0000
Received: from localhost (192.168.154.110) by MIPSMAIL01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 31 Oct
 2017 14:51:56 -0700
Date:   Tue, 31 Oct 2017 21:52:42 +0000
From:   James Hogan <james.hogan@mips.com>
To:     Paul Burton <paul.burton@mips.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Nathan Sullivan <nathan.sullivan@ni.com>,
        <linux-mips@linux-mips.org>
Subject: Re: [PATCH for-4.14] MIPS: generic: Fix NI 169445 its build
Message-ID: <20171031215241.GG15235@jhogan-linux>
References: <20171031214107.15596-1-james.hogan@mips.com>
 <20171031214538.zyr2bnyanjm2gf7i@pburton-laptop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="l5oECiFRo5dp+2y7"
Content-Disposition: inline
In-Reply-To: <20171031214538.zyr2bnyanjm2gf7i@pburton-laptop>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
X-BESS-ID: 1509486819-298553-26021-105557-7
X-BESS-VER: 2017.12-r1710252241
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.61
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.186463
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
        0.60 MARKETING_SUBJECT      HEADER: Subject contains 
        popular marketing words 
        0.01 BSF_SC0_SA_TO_FROM_DOMAIN_MATCH META: Sender Domain Matches Recipient Domain 
X-BESS-Outbound-Spam-Status: SCORE=0.61 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, MARKETING_SUBJECT, BSF_SC0_SA_TO_FROM_DOMAIN_MATCH
X-BESS-BRTS-Status: 1
Return-Path: <James.Hogan@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60619
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

--l5oECiFRo5dp+2y7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 31, 2017 at 02:45:39PM -0700, Paul Burton wrote:
> On Tue, Oct 31, 2017 at 09:41:07PM +0000, James Hogan wrote:
> > From: James Hogan <jhogan@kernel.org>
> >=20
> > Since commit 04a85e087ad6 ("MIPS: generic: Move NI 169445 FIT image
> > source to its own file"), a generic 32r2el_defconfig kernel fails to
> > build with the following build error:
> >=20
> >   ITB     arch/mips/boot/vmlinux.gz.itb
> > Error: arch/mips/boot/vmlinux.gz.its:111.1-2 syntax error
> > FATAL ERROR: Unable to parse input tree
> > mkimage Can't read arch/mips/boot/vmlinux.gz.itb.tmp: Invalid argument
>=20
> Hmm - I fixed this up already here:
>=20
>   https://patchwork.linux-mips.org/patch/16941/
>=20
> and Ralf said he was going to fix up the original commit. I guess it got =
lost
> somewhere..?

Ah yes. It looks like Ralf did fix the original commit, i.e. commit
7aacf86b75bc ("MIPS: NI 169445 board support"), but the change wasn't
transferred to the separate file when the conflict in commit
04a85e087ad6 ("MIPS: generic: Move NI 169445 FIT image source to its own
file") was resolved.

I think my patch has a more correct commit message / Fixes tag now, so I
think this patch is still applicable.

Cheers
James

--l5oECiFRo5dp+2y7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAln48KMACgkQbAtpk944
dnr2GhAAv4xCjwUGMXqgsEpueCmG7j9f1lr1WvzhsYIEj2tlrxnpys/xO3h2zy/2
e1IJsyFCkjz6KqSben/22E8XUY9mKac4VWDNKV/iaG2glwekZCLdXfCwAiPqN6Bh
0zjl0jLRrBEOiqiDMG/U60RsJb0Hx+5JHV4jyCViwX1iPHaCDzLQL2Wh0TPwoG4j
P2+au+6OvoDImT22SR8vUpwbXrIjnPUjnyC2RcnlEXqgnZmUo9U0ZGRqAlbFaJxD
4p+WFPRybiI2yzxNdquRyY8T107zKtdC8r1O9PWZw44nGQYyfHKuTHe+Yook0hDj
vzcHZyudMLJByW2Y2QEZkVIk/z3QvXJvjRG48+PbAwn8sxLD9YTqJ0Dp27aX1DF6
OTjstVY7i993tyS8vaqwLn6AwfpNf6sI6Xu9f6/pyn7Dt3GramjgTJHkODB+mh0F
vvHt+I4P0Rr2EKowhFzLYlUW8CnMI6ujfY/ZPfnGtvbwkzUvmNSgcQ+kX23CHzCX
olLDIxVkNZsF4sR4j34b7ZTPClthzt0GMnEWRx44wj8QpZScDwsH1cv+MVq6RDqk
rFgjroNUuaCPOb4iSVs3zrN9HSA3DQOUdYqWh7RB24GsBRqSz/dProCL7jhSr9H8
mQhqkAGD/lJxgoUQaA7ZCeGty1Z105fDWZUfCR0AkS2qZT+Lyg8=
=SxvM
-----END PGP SIGNATURE-----

--l5oECiFRo5dp+2y7--
