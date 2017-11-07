Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Nov 2017 23:51:19 +0100 (CET)
Received: from 19pmail.ess.barracuda.com ([64.235.154.230]:37396 "EHLO
        19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992910AbdKGWvMeeTsC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Nov 2017 23:51:12 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1402.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Tue, 07 Nov 2017 22:50:06 +0000
Received: from localhost (192.168.154.110) by MIPSMAIL01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 7 Nov 2017
 14:48:05 -0800
Date:   Tue, 7 Nov 2017 22:49:26 +0000
From:   James Hogan <james.hogan@mips.com>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
CC:     <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: Standardize DTS files, status "ok" -> "okay"
Message-ID: <20171107224926.GL15260@jhogan-linux>
References: <alpine.LFD.2.21.1709020307150.11468@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="J2pR2RtFp0tAjF3C"
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1709020307150.11468@localhost.localdomain>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
X-BESS-ID: 1510095006-321458-6107-16953-1
X-BESS-VER: 2017.12-r1709122024
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.186689
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
X-archive-position: 60755
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

--J2pR2RtFp0tAjF3C
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 02, 2017 at 03:09:06AM -0400, Robert P. J. Day wrote:
>=20
> While the current kernel code in drivers/of/ allows developers to be
> sloppy and use the status value "ok", the current DTSpec 0.1 makes it
> clear that the only officially proper spelling is "okay", so adjust
> the very small number of DTS files under arch/mips/.
>=20
> Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

Thanks, Applied for 4.15.

Cheers
James

--J2pR2RtFp0tAjF3C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAloCOG8ACgkQbAtpk944
dno+0RAAqD/tj1qqeQwXU/NdDiQUhVJ/S8EsFZNCJ0J0x0kAKS8WmKcPwWhgfHC4
7a5bvqeIeXew6paHCw87IfIduVldFVt2pjHoCfJoOC3YVrdWd7p9N/sem5xaCX8M
3pCQrRMWpUMHPDrQtsZ+PoVyPYkq2JQUz8+OyLZcweGGcNy0dB/+LyWgd8byqqkL
oafioFJqMq6Mci2L4b4dOncO4NI5IxazbZ8OfN+qo5WGFAM83IfA553RHs6fm+AZ
MUCPNp8YVhOvvWOXznmXrWZV7thN5TKaS9bdm3PR8SA198poZyictsFlMxG8TUdD
laTnAGQqKN6Q+VW2lWSlASy+EtWXtG84cCVyRSKnpf7vlqs3UjcCgL8R/GRXHwRr
NlzcDHxF3WGCkDdiHDyImmGhFuJS28WHFbEtw2+vQXU7jOxbhvc2yHlFrX+FGbBs
0HimaM2ewpNsBzRYPYYs8EgyGXI5hRmzKKvLbNmQYIZy393BVvmW9yA8w3K82V5V
L6/kiDHDOlh5EAmOq3uyze0xd56GNrm8ifw+zhsFf0LV3dONqNsBCgcCe8f3u9Ue
Mk0L6IvS2dS3w9wK0N2YbdFgSkUQN7La02oszfO+wdLQf6lttKAqrCYpfZ7vVqsz
nCt+RgH3RkwWO5MOrHBySj9DqE8XSu5/Y6GEu+LOHvKeRTmH/pI=
=J1qy
-----END PGP SIGNATURE-----

--J2pR2RtFp0tAjF3C--
