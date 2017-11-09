Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Nov 2017 16:44:28 +0100 (CET)
Received: from 19pmail.ess.barracuda.com ([64.235.154.231]:56650 "EHLO
        19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990506AbdKIPoTuG-TX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Nov 2017 16:44:19 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1401.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Thu, 09 Nov 2017 15:44:03 +0000
Received: from localhost (192.168.154.110) by MIPSMAIL01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 9 Nov 2017
 07:43:44 -0800
Date:   Thu, 9 Nov 2017 15:43:42 +0000
From:   James Hogan <james.hogan@mips.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
CC:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>,
        <paul.burton@mips.com>, <macro@linux-mips.org>
Subject: Re: [PATCH] MIPS: page.h: define virt_to_pfn()
Message-ID: <20171109154342.GX15260@jhogan-linux>
References: <20170309211149.8339-1-f.fainelli@gmail.com>
 <20171108231527.GQ15260@jhogan-linux>
 <aa38339b-7f88-3643-cce5-dd60f06d6f13@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="JaUdphvQ2+4F/M7k"
Content-Disposition: inline
In-Reply-To: <aa38339b-7f88-3643-cce5-dd60f06d6f13@gmail.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
X-BESS-ID: 1510242242-321457-5728-72763-6
X-BESS-VER: 2017.12-r1710252241
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.186757
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
X-archive-position: 60807
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

--JaUdphvQ2+4F/M7k
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 08, 2017 at 04:05:28PM -0800, Florian Fainelli wrote:
> On 11/08/2017 03:15 PM, James Hogan wrote:
> > Hi Florian,
> >=20
> > On Thu, Mar 09, 2017 at 01:11:49PM -0800, Florian Fainelli wrote:
> >> Based on the existing definition of virt_to_page() which already does a
> >> PFN_DOWN(vir_to_phys(kaddr)).
> >=20
> > I was just wondering if there was a particular motivation for this
> > change?
>=20
> Initially that was a part of an experiment to try to build and use ION
> on MIPS, but I think this dependency somehow got removed. I might have
> thought about using it for CONFIG_DEBUG_VIRTUAL too.
>=20
> In then end I sent it because it sounded like a simple change that could
> have some use later.

Okay thanks for clarifying. I've applied for 4.15.

Cheers
James

--JaUdphvQ2+4F/M7k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAloEd64ACgkQbAtpk944
dnqG0w/+JbC0dg9ZuMqQtrBkTomBp36bBCmq/S9/ADLVcWGmL6ax0XbP/JGrS2sI
X24Wo9C0iH6qB7UXH+QjowEHNhSzXJcm88nYLhcZo0sv/3bjw3hsIZ8gxUCFqXwr
Cfhp+m3fE+A+mD4JiAT/zhavDwXxWuBaCzVciV5Qo/5HZTHNJXxqOpA4p27+QMcz
dSyTyfNMWj+4q3Bw6C68LMNFXm0xHIS8yoEeB9qd+oCsGSiwMuGNXLM+ZKw/6L0m
zJMZM4lL3wDPBftL2f1VjOvzUD4onkQCngkgOWxYpwejU7v4xvGuV2o8qmSFyiuf
zGhcdP8NKQ/V/s7zl/0hzqBCWtkVkxSyN67VMOFYxiLe2F5ozYZQDZJVMrVg1X1m
+EL5YTAjbqLvrkcCW+/cmu+utPwYiiSrDpggejF4Wc4LZGFqJkvC2KESVFRI56A2
feibbIUUjIckxut33B0m02RBtbnjBMl0KDjOJKVkemHEk5j0wu6TFVkkK+up1Lpt
zmSrpE2rGy88Hxzv8AyXHJ9v9JWIaeHsmdZjaksKiEPEgBnwJZeQdrZz36mQlizi
pUkIuX/0PVMO+XnIJrJ69nzV3ly+G4gwTa9eGl0pp0tGHyyLCQBWzyZg1HO37IFB
Hda9OAGiiN2Oi8HIdIHiD8CM5WlpXPDxFFfY4YkTP+WLQq2XGg4=
=O2ts
-----END PGP SIGNATURE-----

--JaUdphvQ2+4F/M7k--
