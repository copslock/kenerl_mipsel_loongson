Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 May 2018 08:00:48 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:33722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990394AbeENGASRXwsO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 14 May 2018 08:00:18 +0200
Received: from jamesdev (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20831217A5;
        Fri, 11 May 2018 21:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1526075635;
        bh=q8oq6HdPF8xJyeE1IJqy7NlgAs61+92JGaiyQLn9oRc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nuy7U6kkFziw0/HvivD4JijLP5KJk/vy1i9bg2BwT+jXWdF//qEH7bz/1ye272c4j
         iwDgtBVOkcuXes1n1wPgmI049UQ6mf9l1hCb6/xwK8MV4r/fAoY91PsACzLtt5vVXR
         Wa66KOHiFDErJ2dgnYWfuUK0mcLzn7WF5xompiQM=
Date:   Fri, 11 May 2018 22:53:51 +0100
From:   James Hogan <jhogan@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] MIPS: Fix build with DEBUG_ZBOOT and MACH_JZ4770
Message-ID: <20180511215350.GA20355@jamesdev>
References: <20180305170704.17073-1-paul@crapouillou.net>
 <20180328153812.2592-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="huq684BweRXVnRxX"
Content-Disposition: inline
In-Reply-To: <20180328153812.2592-1-paul@crapouillou.net>
User-Agent: Mutt/1.9.5 (2018-04-13)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63902
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


--huq684BweRXVnRxX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 28, 2018 at 05:38:12PM +0200, Paul Cercueil wrote:
> The debug definitions were missing for MACH_JZ4770, resulting in a build
> failure when DEBUG_ZBOOT was set.
>=20
> Since the UART addresses are the same across all Ingenic SoCs, we just
> use a #ifdef CONFIG_MACH_INGENIC instead of checking for individual
> Ingenic SoCs.
>=20
> Additionally, I added a #define for the UART0 address in-code and dropped
> the <asm/mach-jz4740/base.h> include, for the reason that this include
> file is slowly being phased out as the whole platform is being moved to
> devicetree.
>=20
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

Applied for 4.17 with fixes tag and 4.16 stable tag.

Thanks
James

--huq684BweRXVnRxX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQS7lRNBWUYtqfDOVL41zuSGKxAj8gUCWvYQ6wAKCRA1zuSGKxAj
8uz0AQC9PKGntccWQ6m5z6EDw5V9yNFMq6qwunv73lq2de7pgQD9H4foYjoxYig3
4Ayuijs6bzL/RR4lyI88f3pLjNjBOg8=
=T+SI
-----END PGP SIGNATURE-----

--huq684BweRXVnRxX--
