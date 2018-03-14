Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Mar 2018 12:46:02 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.154.211]:39130 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990505AbeCNLpym8hnU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 14 Mar 2018 12:45:54 +0100
Received: from mipsdag02.mipstec.com (mail2.mips.com [12.201.5.32]) by mx1401.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=NO); Wed, 14 Mar 2018 11:45:32 +0000
Received: from localhost (192.168.154.110) by mipsdag02.mipstec.com
 (10.20.40.47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1415.2; Wed, 14
 Mar 2018 04:45:34 -0700
Date:   Wed, 14 Mar 2018 11:45:26 +0000
From:   James Hogan <james.hogan@mips.com>
To:     Hauke Mehrtens <hauke@hauke-m.de>
CC:     <ralf@linux-mips.org>, <john@phrozen.org>, <dev@kresin.me>,
        <linux-mips@linux-mips.org>, <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH 3/3] MIPS: lantiq: ase: Enable MFD_SYSCON
Message-ID: <20180314114524.GB19665@jhogan-linux.mipstec.com>
References: <20180311174123.2578-1-hauke@hauke-m.de>
 <20180311174123.2578-3-hauke@hauke-m.de>
 <20180312213938.GC21642@saruman>
 <70673d93-03c5-6bf6-54a4-bee9f9271304@hauke-m.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qtZFehHsKgwS5rPz"
Content-Disposition: inline
In-Reply-To: <70673d93-03c5-6bf6-54a4-bee9f9271304@hauke-m.de>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
X-ClientProxiedBy: mipsdag02.mipstec.com (10.20.40.47) To
 mipsdag02.mipstec.com (10.20.40.47)
X-BESS-ID: 1521027931-321457-9309-58584-1
X-BESS-VER: 2018.2-r1803082101
X-BESS-Apparent-Source-IP: 12.201.5.32
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.191050
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
X-archive-position: 62974
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

--qtZFehHsKgwS5rPz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 13, 2018 at 11:40:59PM +0100, Hauke Mehrtens wrote:
> We changed the RCU controller drivers for kernel 4.14 and this was
> missing for the Amazon SE SoC. The xrx200/VR9 SoC is the successor of
> the Amazon SE and Danube SoC, but the older SoCs still share the
> architecture and many IP cores with the more recent ones.
>=20
> This is also relevant for upstream kernel, should I extend the
> descriptions of the commit messages and send a V2 of the 3 patches?

Yes, if you wouldn't mind, that'd be great.

Thanks
James

--qtZFehHsKgwS5rPz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqpC04ACgkQbAtpk944
dnoR5w//W5FOq9Qqs9nrG+TZuwE6Thdpg1m2qDgaTvhWy6vMNEYzzd6Vje4Kzidp
WXDAxwxPp84z35TovwqJZiAei+q71EnwxbyjFpsBgqEf6FxIsORb+sfkjVXXydKT
4WaidiynVmYtt0DMODlpuQFEipL9CY3zj4hNR/mQARlDZ2wRqTaCIGoLIJk8XX3A
44UbgAlqZ0YhuWGbSr/V4Hdtx3gBC8dAbIGNTQz2hAe4TB22K1ci6pq24HIIhacm
R76i1vODkodXk3NzZggcoiKK7QLHmF6EGu97j2SghPB2NTK/+nGgiNtZUGLsck3I
dPpGPBpGUqy/Wyvpp2DxqSkZXoMp+KW4fkv5AKvMH3K8tScpiIX9CtsR9YzXjmlF
U6FjzBjhkE1trXhF+7iTQH9jnrYdHTlhusol2uJgMZ4w+HEKKL8vFf2Z3KBm1PnQ
eJS5JvsC88P16OYnnOKi8/3NlHH5XT9AILvs9qsDjiFGVdWxpchLfBnA567+3Co5
ZHPIp2qYsRu0HZaXG/6WRwJMCDFSVS+N+l0RWafURTZr6EMykAwPxmj5BOTPXs3c
gO3XIQrzHHhIpMxRUm307y8dz3s+L2ieqsyJ1nekrPibRyMu+S5NW+65lULpwT4m
DF93I2f6NIs329KQp7QjzVuKBYxk7qq5RTES/zMUqzGnTApXn7Q=
=2LEc
-----END PGP SIGNATURE-----

--qtZFehHsKgwS5rPz--
