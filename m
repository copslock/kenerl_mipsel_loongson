Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 14 Apr 2018 01:52:38 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:40960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994629AbeDMXwaxaJIz (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 14 Apr 2018 01:52:30 +0200
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20F3521777;
        Fri, 13 Apr 2018 23:52:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20F3521777
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Sat, 14 Apr 2018 00:52:18 +0100
From:   James Hogan <jhogan@kernel.org>
To:     Sinan Kaya <okaya@codeaurora.org>
Cc:     linux-mips@linux-mips.org, arnd@arndb.de, timur@codeaurora.org,
        sulrich@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] MIPS: io: add a barrier after register read in
 readX()
Message-ID: <20180413235217.GA19138@saruman>
References: <1523586646-19630-1-git-send-email-okaya@codeaurora.org>
 <1523586646-19630-2-git-send-email-okaya@codeaurora.org>
 <d1f91bcc-4523-e8fb-2f16-4a5932460d44@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline
In-Reply-To: <d1f91bcc-4523-e8fb-2f16-4a5932460d44@codeaurora.org>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63532
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


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 12, 2018 at 10:33:42PM -0400, Sinan Kaya wrote:
> On 4/12/2018 10:30 PM, Sinan Kaya wrote:
> > +	/* prevent prefetching of coherent DMA dma prematurely */	\
>=20
> I tried to write DMA data but my keyboard is not cooperating. I'll hold o=
nto
> posting another version until I hear back from you for wmb().

No problem, I've applied both for 4.17 and tweaked the comment.

Thanks
James

--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlrRQrEACgkQbAtpk944
dnqY4RAAq6jl/vHVaZ0FYWlFRCUfB4mtkGvuABwRvP7PdI8FSX2k1vkjqyNoump0
xisJa/BloRCYaPmOxzLEwdMjdvTq7fFatAp0gk+8RZy1TuniDUsqdZUFx3CyMsdr
h9AJ7mqQ/T0owWkmq2QFXiXTa4BcCua72E/coQwkcabJw7+YlI820lbacrWW+j3Z
1hYFNjmq6Wtb0UgA/rUB8T0D95WHNT7B89flPYQkORJBtPzrMSPTebbpmrfw5hOj
d7bp/6HlP+AFz+Y+zRwXBe30j23Zrlh7UU11bmAyZK8yf9M2zR02mUz02Rn4wOhK
OBHpAahyfVqFiwFe2c0bRt9/SKg/CGV4jOa9xHRbxeGiVXQk6B0t7j2lcbUfrSHH
1qOYtkaFF/S0l4YmlLlfyWqA8HV2JdAxZf2awfE9HYrjFwx2TdCrRJrGyKTq4ksI
VsvPjUZat7Zm9ugki48XawxdRJ3gyR7PmaL0BASd8B+C50jcD6nlDoZpFvP+s6lu
oHRA/1bPxPD7V67RSqUEyBTLyFqJy5f1aD+TZKmlmCPzH41sbSYDKO68LmHwxTX0
bVAXIaHemuVGQzsQ+H/1wasAvOQ6G7mcy6tXUi1lwHQIVmy02Lq7wb6FnfbmMFUa
aFsgsF2VGy824J2PFuWSq/32H61Z5j22XeHRLJ3yikQybh4xBvQ=
=Ic/U
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--
