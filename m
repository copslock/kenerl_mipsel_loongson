Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Apr 2018 00:08:52 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:33572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994666AbeDYWIpm9fjn (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 26 Apr 2018 00:08:45 +0200
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D6AF21745;
        Wed, 25 Apr 2018 22:08:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D6AF21745
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Wed, 25 Apr 2018 23:08:34 +0100
From:   James Hogan <jhogan@kernel.org>
To:     NeilBrown <neil@brown.name>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: c-r4k: fix data corruption related to cache
 coherence.
Message-ID: <20180425220834.GC25917@saruman>
References: <87sh7klyhc.fsf@notabene.neil.brown.name>
 <20180425214650.GA25917@saruman>
 <87h8nzlzf1.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0lnxQi9hkpPO77W3"
Content-Disposition: inline
In-Reply-To: <87h8nzlzf1.fsf@notabene.neil.brown.name>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63791
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


--0lnxQi9hkpPO77W3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 26, 2018 at 08:00:18AM +1000, NeilBrown wrote:
> On Wed, Apr 25 2018, James Hogan wrote:
> > So I'm thinking "!mips_cm_present()" should probably be replaced with
> > "!r4k_op_needs_ipi(R4K_INDEX)" (and the comment updated to mention that
> > IPI calls aren't implemented here).
>=20
> That makes sense.  I tried ipi calls at one stage.  Synchronous ones
> cannot be used because this code is called with interrupts disabled, and
> async ones cannot provide the required guarantees.

Okay. I thought something like that might be the case.

>=20
> I'll update the patch, test that it still works, and resend, in the next
> day or so.

Thanks. It wouldn't hurt to also mention why IPIs can't be used in the
code comments, if its fresh in your mind, just for the benefit of next
person to attempt it.

Cheers
James

--0lnxQi9hkpPO77W3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQS7lRNBWUYtqfDOVL41zuSGKxAj8gUCWuD8YQAKCRA1zuSGKxAj
8qhiAQDy4PgqTJQrBqDyhppFRJRq1oCRGDz9EGtqFs51hCP9TgEArA/K9cg3Wszh
ckssoKrrkL4uvnpylKDNzb9aP+4GAQM=
=9Wdc
-----END PGP SIGNATURE-----

--0lnxQi9hkpPO77W3--
