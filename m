Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Mar 2018 23:49:58 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:54648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990401AbeCIWtubYiCs (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 9 Mar 2018 23:49:50 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4073421771;
        Fri,  9 Mar 2018 22:49:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4073421771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Fri, 9 Mar 2018 22:49:38 +0000
From:   James Hogan <jhogan@kernel.org>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-mmc@vger.kernel.org, linux-mips@linux-mips.org,
        Alex Smith <alex.smith@imgtec.com>
Subject: Re: [PATCH 09/14] mmc: jz4740: Fix race condition in IRQ mask update
Message-ID: <20180309224937.GI24558@saruman>
References: <20180309151219.18723-1-ezequiel@vanguardiasur.com.ar>
 <20180309151219.18723-10-ezequiel@vanguardiasur.com.ar>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ZOudaV4lSIjFTlHv"
Content-Disposition: inline
In-Reply-To: <20180309151219.18723-10-ezequiel@vanguardiasur.com.ar>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62896
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


--ZOudaV4lSIjFTlHv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 09, 2018 at 12:12:14PM -0300, Ezequiel Garcia wrote:
> From: Alex Smith <alex.smith@imgtec.com>
>=20
> A spinlock is held while updating the internal copy of the IRQ mask,
> but not while writing it to the actual IMASK register. After the lock
> is released, an IRQ can occur before the IMASK register is written.
> If handling this IRQ causes the mask to be changed, when the handler
> returns back to the middle of the first mask update, a stale value
> will be written to the mask register.
>=20
> If this causes an IRQ to become unmasked that cannot have its status
> cleared by writing a 1 to it in the IREG register, e.g. the SDIO IRQ,
> then we can end up stuck with the same IRQ repeatedly being fired but
> not handled. Normally the MMC IRQ handler attempts to clear any
> unexpected IRQs by writing IREG, but for those that cannot be cleared
> in this way then the IRQ will just repeatedly fire.
>=20
> This was resulting in lockups after a while of using Wi-Fi on the
> CI20 (GitHub issue #19).
>=20
> Resolve by holding the spinlock until after the IMASK register has
> been updated.
>=20

Maybe have a Link tag instead of referencing "github issue #19", i.e.:
Link: https://github.com/MIPS/CI20_linux/issues/19

Since this fixes an older commit, it'd be worth adding:

Fixes: 61bfbdb85687 ("MMC: Add support for the controller on JZ4740 SoCs.")

> Signed-off-by: Alex Smith <alex.smith@imgtec.com>

=2E.. and presumably is worthy of backporting (the driver was introduced
in 2.6.36), i.e.:
Cc: stable@vger.kernel.org

Cheers
James

--ZOudaV4lSIjFTlHv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqjD3oACgkQbAtpk944
dnqi3xAAkQdfX4JDrZu7Qa7B1bktfeQvrccImbq3N6kq6sPoz4kyv4rRqaTnvuzk
7KBTBC7eguwpHmWRW8pARxATuKw5TX/5cUYUHcUKJ2ClD8YnW1QqSypxpniaPYjo
T6aafkg1YJ1uPnNvOOEukabeget2TqGpFfga59QcwJMfde6YcECXixinWsdWBY1w
dGdBL+4p0OER3sR8V88CklDVxkMdwbRTWDJj5rbDKd/iLiqzCERuvBKGwSD3sSGr
i+xaNELAW7sgjf7Ju2dM929hjm5m3/B5r8K5wgRYykTHs/3VO1W4JBlZKLFDekeV
V3v9xinwThDl49QzrcVGoEtdyFs5gjdg0n6+lNVQQ4yMi7AbevdHJPznjanQKwzS
tO3TdQyPXTgE5diEvtTHN/7edAGG7fcV6XJBTze4qVzbU1iCfOB3lZLDXo6amm4G
KNBfRpLmaIYVSloC3oBsAZ2+fVh0mtGCOzt14PhdP76aNLCuMlvZaWkl8v5yoCAU
jJqHdRJvsFnLtQN2wdebpCY4DzB1nxw5q/n9Jy2r6KgaDmFkf9dD9Toedv6J9tpD
nMiYxaqJ3IZYDI4A9K/6au6FE0UXCS/b1Ls02pdiqT4RWPXy9FA6MZB0rWvPVomP
4noBsWqzhLjoXlMlqPZOSSfmE8ue2bXo2C/LI1pyhTtp8XicrnI=
=mUvG
-----END PGP SIGNATURE-----

--ZOudaV4lSIjFTlHv--
