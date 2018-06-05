Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Jun 2018 17:45:49 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:45438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994709AbeFEPpllq6zI (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 5 Jun 2018 17:45:41 +0200
Received: from jamesdev (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 032242075E;
        Tue,  5 Jun 2018 15:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528213535;
        bh=FhAglVYBLB9e+ENrLGQQmTHRFLinlacm6uJZ+y4AYHI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bmt/V8DC7g9y12lMPs8UhC2Uh95KyRcZJ2NJ/XfDkWVjFfy2e//Oo5RuBO5bpdoJS
         afnL5thMwKnGLiwPDYDLvNMlZZh30mbv9fI/H5NfblszKTnWV3eO2YPLpu2tul49pY
         X4kDYIT8Z/qJimP0026vSY2yI8JmCq2C+oVlATBM=
Date:   Tue, 5 Jun 2018 16:45:30 +0100
From:   James Hogan <jhogan@kernel.org>
To:     Tokunori Ikegami <ikegami@allied-telesis.co.jp>
Cc:     Chris Packham <chris.packham@alliedtelesis.co.nz>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH v5 1/1] MIPS: BCM47XX: Enable MIPS32 74K Core
 ExternalSync for BCM47XX PCIe erratum
Message-ID: <20180605154529.GA19361@jamesdev>
References: <20180603140201.10593-1-ikegami@allied-telesis.co.jp>
 <20180603140201.10593-2-ikegami@allied-telesis.co.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cNdxnHkX5QqsyA0e"
Content-Disposition: inline
In-Reply-To: <20180603140201.10593-2-ikegami@allied-telesis.co.jp>
User-Agent: Mutt/1.10.0 (2018-05-17)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64192
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


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 03, 2018 at 11:02:01PM +0900, Tokunori Ikegami wrote:
> The erratum and workaround are described by BCM5300X-ES300-RDS.pdf as bel=
ow.
>=20
>   R10: PCIe Transactions Periodically Fail
>=20
>     Description: The BCM5300X PCIe does not maintain transaction ordering.
>                  This may cause PCIe transaction failure.
>     Fix Comment: Add a dummy PCIe configuration read after a PCIe
>                  configuration write to ensure PCIe configuration access
>                  ordering. Set ES bit of CP0 configu7 register to enable
>                  sync function so that the sync instruction is functional.
>     Resolution:  hndpci.c: extpci_write_config()
>                  hndmips.c: si_mips_init()
>                  mipsinc.h CONF7_ES
>=20
> This is fixed by the CFE MIPS bcmsi chipset driver also for BCM47XX.
> Also the dummy PCIe configuration read is already implemented in the Linux
> BCMA driver.
> Enable ExternalSync in Config7 when CONFIG_BCMA_DRIVER_PCI_HOSTMODE=3Dy
> too so that the sync instruction is externalised.
>=20
> Signed-off-by: Tokunori Ikegami <ikegami@allied-telesis.co.jp>
> Reviewed-by: Paul Burton <paul.burton@mips.com>
> Acked-by: Hauke Mehrtens <hauke@hauke-m.de>
> Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>
> Cc: Rafa=C5=82 Mi=C5=82ecki <zajec5@gmail.com>
> Cc: linux-mips@linux-mips.org

I presume this patch is ready to apply now (thanks for the reviews
folks).

How far back does this need backporting to stable branches?

It applies easily back to 3.14 I think (commit 3c06b12b046e ("MIPS:
BCM47XX: fix position of cpu_wait disabling")), but you mentioned other
fixes too. Have those been backported too, and if not is there any point
backporting this?

Thanks
James

--cNdxnHkX5QqsyA0e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQS7lRNBWUYtqfDOVL41zuSGKxAj8gUCWxawGAAKCRA1zuSGKxAj
8hiDAQD+wF1+KUdI3AtFXaROQoc+yipyveQcpF2P01C9MSdkNgEA1Gobq2cGd6HP
rcNiY2GZMSgrz6bMMAjsHi6AeHsaMgY=
=vpLx
-----END PGP SIGNATURE-----

--cNdxnHkX5QqsyA0e--
