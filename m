Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Jun 2018 23:35:35 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:40242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992992AbeFTVf3QrrAZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 20 Jun 2018 23:35:29 +0200
Received: from jamesdev (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9EC32083A;
        Wed, 20 Jun 2018 21:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529530523;
        bh=VmeS3cp0iW/LzNAJELkosgq7Pgj07zg2rrjVSEGyHkw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hN8dTZVBhpzO3OzYq+IR9UQqqHcHmch51Y0DEkvSce5NPEEsg2gDNsogtyadf/sPx
         LLffuYPQN9iqY3v1X8eIysaiHnfbRbB+GPvBjdryR4zGY1dg3DvciaHiSfaB+wV9Ra
         tdkXLD+mpFZ71VXSI75nDBp2I4q9s2V0+fZ5bpUU=
Date:   Wed, 20 Jun 2018 22:35:19 +0100
From:   James Hogan <jhogan@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Allan Nielsen <Allan.Nielsen@microsemi.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mips: mscc: build FIT image for Ocelot
Message-ID: <20180620213518.GC22606@jamesdev>
References: <20180425211607.2645-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="S1BNGpv0yoYahz37"
Content-Disposition: inline
In-Reply-To: <20180425211607.2645-1-alexandre.belloni@bootlin.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64401
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


--S1BNGpv0yoYahz37
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Wed, Apr 25, 2018 at 11:16:06PM +0200, Alexandre Belloni wrote:
> +config FIT_IMAGE_FDT_OCELOT_PCB123
> +	bool "Include FDT for Microsemi Ocelot PCB123"
> +	select MSCC_OCELOT
> +	help
> +	  Enable this to include the FDT for the Ocelot PCB123 platform
> +	  from Microsemi in the FIT kernel image.
> +	  This require u-boot on the platform.

nit: s/require/requires/

Reviewed-by: James Hogan <jhogan@kernel.org>

Cheers
James

--S1BNGpv0yoYahz37
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQS7lRNBWUYtqfDOVL41zuSGKxAj8gUCWyrIlgAKCRA1zuSGKxAj
8g1GAP9Vks506o7RiTuEOxZk0KT4ieio5219M8qOXbdI4R/oDQD9E38xNMnjOE+e
rQLqP+NZxeOzWr3m4rXpf3+r7orYuQw=
=i+eZ
-----END PGP SIGNATURE-----

--S1BNGpv0yoYahz37--
