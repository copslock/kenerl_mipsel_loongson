Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Apr 2018 23:52:10 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:35210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990412AbeDLVwCzhFMD (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 12 Apr 2018 23:52:02 +0200
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F30521777;
        Thu, 12 Apr 2018 21:51:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F30521777
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Thu, 12 Apr 2018 22:51:50 +0100
From:   James Hogan <jhogan@kernel.org>
To:     Sinan Kaya <okaya@codeaurora.org>
Cc:     linux-mips@linux-mips.org, arnd@arndb.de, timur@codeaurora.org,
        sulrich@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] MIPS: io: add a barrier after register read in
 readX()
Message-ID: <20180412215149.GA27802@saruman>
References: <1522760109-16497-1-git-send-email-okaya@codeaurora.org>
 <1522760109-16497-2-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline
In-Reply-To: <1522760109-16497-2-git-send-email-okaya@codeaurora.org>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63512
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


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 03, 2018 at 08:55:04AM -0400, Sinan Kaya wrote:
> While a barrier is present in writeX() function before the register write,
> a similar barrier is missing in the readX() function after the register
> read. This could allow memory accesses following readX() to observe
> stale data.
>=20
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> Reported-by: Arnd Bergmann <arnd@arndb.de>

Both patches look like obvious improvements to me, so I'm happy to apply
to my fixes branch.

I'm guessing the case of a write to DMA buffer (i.e. reusing it) after a
MMIO readX() (checking DMA complete) being visible to DMA reads prior to
the readX() is precluded by a control dependency (you shouldn't reuse
buffer until you've checked DMA is complete).

But why don't we always use wmb() in the writeX() case? Might not the
cached write to DMA buffer be reordered with the uncached write to MMIO
register from the coherent DMA point of view? I'm waiting on feedback
=66rom MIPS hardware folk on this topic.

Cheers
James

--9amGYk9869ThD9tj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlrP1O8ACgkQbAtpk944
dnrpqw/8Dad0DiqnZB1K1nVKd3NAh/IRYNJCN/21AB9iuHjz+EjRP/jRgL3DdbtK
0dsYb8zpgOhY6oGdNqSdfjD51W3+2a53fAaGMO6sIeEBYrukRKKMTLPxAbA0XmxR
K6hwn2KGhWcRZvIOFVmTmg3Yac6xXDybfViABG0apVJaeVIzG1gZ5R6qD6HnZezU
OM9caiJ5PedkSd4lvfWjV6E/azqUd/nZJujs11/CKmAe5LbNtddQP9UOa+AuYqzb
XzFRXia7IwnqaoksvNyu3fFqcH7QEE0RutjwZvgIIfehLc+msENq+bAl13C1lCoU
IBszadUACPGcQDericA7fAj8tGomQjlYFsLKtooSUMKqU4aweNlk5f2eKzL1ohP4
imZ8gz4q8PeLvG/RINyD0+QQ3AE3OSvcQTdXQ4LB9Rc3vpPcxPQIzTpWd+pxuhCu
bLUsxlOQC/eiuBYUoIyGDzzn9jcd/L5uGotIEtlfnvlkg+XvGrOQXw6Glw0rL4v0
Z06tsNeUZszbYf3YUIeg+ywaHXAJhQ1pqPZMlXh7qQvwnRi/Nhs9A6ptd7oG72No
W1sEJ+PUjtN2pDT/fEbjKx7QFpAd91Bw/oyAoZPSFk0co00C656ROpZ1LxMLu52k
mmrHohv8XaiW+1dtt5OGCdxRjh7gXMJVeN7rFuPu542EexH+mLY=
=191/
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--
