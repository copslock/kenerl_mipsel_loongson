Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 May 2018 08:15:27 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:37416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990392AbeENGPSXcrPO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 14 May 2018 08:15:18 +0200
Received: from jamesdev (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4B8B21726;
        Fri, 11 May 2018 12:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1526042877;
        bh=YeLl+x/AsBCNHjGkuPgy3TGg5EQUWi7EMgaCp74KuJY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yqMxn3dLjYpYRBqZNveeKYPLnSbFemBhk8wbWT1c0DRMqV6lEZHnpRNq4Sz4giBwj
         65l9IfylxCtrCEj6TfR6cbAkJfbqs1txqDUy8jVq1wc+z/YsI64+90jXFLlKzzwjyX
         me6F7cvfk8rFDLZV9cOFpg5p4ZbRs58rOI9EiBi4=
Date:   Fri, 11 May 2018 13:47:53 +0100
From:   James Hogan <jhogan@kernel.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: VPE: fix spelling mistake: "uneeded" -> "unneeded"
Message-ID: <20180511124752.GA9014@jamesdev>
References: <20180510165900.13733-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="oyUTqETQ0mS9luUI"
Content-Disposition: inline
In-Reply-To: <20180510165900.13733-1-colin.king@canonical.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63905
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


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 10, 2018 at 05:59:00PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>=20
> Trivial fix to spelling mistake in pr_warn message text
>=20
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

> -		pr_warn("VPE loader: elf size too big. Perhaps strip uneeded symbols\n=
");
> +		pr_warn("VPE loader: elf size too big. Perhaps strip unneeded symbols\=
n");

Applied for 4.18

thanks
James

--oyUTqETQ0mS9luUI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQS7lRNBWUYtqfDOVL41zuSGKxAj8gUCWvWQ9wAKCRA1zuSGKxAj
8hZHAPwOzorxqzdhC0mAmwifelQKD5g4nHGCxd6ieKGXdNWW+wEAwuNvsZ5g325T
Soc3Jo1u4U5SIZr1VuYiu/RHB85Vegw=
=kRJ6
-----END PGP SIGNATURE-----

--oyUTqETQ0mS9luUI--
