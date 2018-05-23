Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 May 2018 10:15:06 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:50096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992492AbeEWIO7Hln1i (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 23 May 2018 10:14:59 +0200
Received: from jamesdev (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 538E020848;
        Wed, 23 May 2018 08:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1527063292;
        bh=Qd/mAtsrKu2Iok6KnBOFefzQvb22NkHHz5+2KW2UYDg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oYdSjRYtQ6mIeTipNGCVzsInN4Q8Ue8QU9obwupgcoQnSzGV+kjCA9g4aKH/2OUEA
         HGIeO9Vjw2hM0i/VF0eS3mJLtYMqOqwTcD6Xrnw0/DbE1VZjzm2QjLSoyX7uhou8Qp
         SU0q3by+D+Q3ygLWKw5n3f2Yvtx6xpdVKucbRkrI=
Date:   Wed, 23 May 2018 09:14:48 +0100
From:   James Hogan <jhogan@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] MIPS: PCI: Use dev_printk() when possible
Message-ID: <20180523081447.GA15645@jamesdev>
References: <152699466671.162686.1029992586935534102.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <152699470263.162686.16975145205315900817.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline
In-Reply-To: <152699470263.162686.16975145205315900817.stgit@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64001
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


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 22, 2018 at 08:11:42AM -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
>=20
> Use the pci_info() and pci_err() wrappers for dev_printk() when possible.
>=20
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  arch/mips/pci/pci-legacy.c |    7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>=20
> diff --git a/arch/mips/pci/pci-legacy.c b/arch/mips/pci/pci-legacy.c
> index 0c65c38e05d6..73643e80f02d 100644
> --- a/arch/mips/pci/pci-legacy.c
> +++ b/arch/mips/pci/pci-legacy.c
> @@ -263,9 +263,7 @@ static int pcibios_enable_resources(struct pci_dev *d=
ev, int mask)
>  				(!(r->flags & IORESOURCE_ROM_ENABLE)))
>  			continue;
>  		if (!r->start && r->end) {
> -			printk(KERN_ERR "PCI: Device %s not available "
> -			       "because of resource collisions\n",
> -			       pci_name(dev));
> +			pci_err(dev, "can't enable device: resource collisions\n");

The pedantic side of me wants to point out that you could wrap that line
after the comma to keep it within 80 columns.

Either way though:
Acked-by: James Hogan <jhogan@kernel.org>

Cheers
James

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQS7lRNBWUYtqfDOVL41zuSGKxAj8gUCWwUi9QAKCRA1zuSGKxAj
8l/hAP9wRhKTLcj7bgyBloqtW+lACwcm1L6ZG8rvMTYeyETdsQD/Ub0CM0qhhbwf
dcBrWIGOv/N8paHxgYfocG/YUmMdTgE=
=PUQd
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--
