Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 May 2018 08:00:28 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:33720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990392AbeENGASMexXO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 14 May 2018 08:00:18 +0200
Received: from jamesdev (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78DBD21738;
        Fri, 11 May 2018 14:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1526050372;
        bh=ertlMDGWYmMhb35Rx0ahITY6sG/coZsAdontO+7MDzI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DG6ncGqquscK9VpcD+WKhB4xLVbn6UHe7NmYYFL1Oy3oB/9a0KEg+LM3D4Zx3FPX/
         ObLD3bfE/deV92EHu0TcQW+C3lRYgjc5qy2xyB+0vlm3qEljZ5az7CUneEeM3fALdD
         YO+xwk+w+WEgDd8b44KnPuRz13XbJ3GSsvbCAKUo=
Date:   Fri, 11 May 2018 15:52:47 +0100
From:   James Hogan <jhogan@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Mathieu Malaterre <malat@debian.org>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH v3 5/8] MIPS: jz4740: dts: Add bindings for the
 jz4740-wdt driver
Message-ID: <20180511145246.GA12956@jamesdev>
References: <20180510184751.13416-1-paul@crapouillou.net>
 <20180510184751.13416-5-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
In-Reply-To: <20180510184751.13416-5-paul@crapouillou.net>
User-Agent: Mutt/1.9.5 (2018-04-13)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63901
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


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Thu, May 10, 2018 at 08:47:48PM +0200, Paul Cercueil wrote:
> Also remove the watchdog platform_device from platform.c, since it
> wasn't used anywhere anyway.

Nit: it'd be slightly nicer IMO if the patch body was a superset of the
subject line. It's fine to repeat what the subject says since thats
meant to summarise the body.

> -struct platform_device jz4740_wdt_device = {

There's an extern in arch/mips/include/asm/mach-jz4740/platform.h that
should perhaps be removed also?

Otherwise
Acked-by: James Hogan <jhogan@kernel.org>

I'm happy to apply for 4.18 with that change if you want it to go
through the MIPS tree.

Cheers
James

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQS7lRNBWUYtqfDOVL41zuSGKxAj8gUCWvWuPQAKCRA1zuSGKxAj
8mlfAQCJf5mvfQD9ow7oPKhrS7ZEEtsAokvWC1M/Z2F3mCx3bgD9HQQl05Fya66i
Dpd1TlEADWA+H91gd5uKii85SdfeNwo=
=IGgX
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--
