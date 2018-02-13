Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Feb 2018 15:33:18 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:49004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994554AbeBMOdMHconX (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 13 Feb 2018 15:33:12 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C82B821723;
        Tue, 13 Feb 2018 14:33:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C82B821723
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Tue, 13 Feb 2018 14:32:40 +0000
From:   James Hogan <jhogan@kernel.org>
To:     Mathieu Malaterre <malat@debian.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Marcin Nowakowski <marcin.nowakowski@mips.com>,
        linux-mips@linux-mips.org, "# v4 . 11" <stable@vger.kernel.org>
Subject: Re: [PATCH v3] MIPS: fix incorrect mem=X@Y handling
Message-ID: <20180213143239.GE4290@saruman>
References: <20180201113721.24776-1-marcin.nowakowski@mips.com>
 <CA+7wUswiOdqunZfnL-6YFJ6gPfj7bXAdHYbetbW_PdQaN28GzQ@mail.gmail.com>
 <CA+7wUszerm6VQsboY9hhgzEZejFOyKZtoh+eCpAESho-xdmQXw@mail.gmail.com>
 <20180213133832.GD4290@saruman>
 <CA+7wUswyQjRvY1=4g785jNBnfAAqSUbyYSWh3qKHieJVhmbxSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kA1LkgxZ0NN7Mz3A"
Content-Disposition: inline
In-Reply-To: <CA+7wUswyQjRvY1=4g785jNBnfAAqSUbyYSWh3qKHieJVhmbxSg@mail.gmail.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62529
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


--kA1LkgxZ0NN7Mz3A
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2018 at 03:03:24PM +0100, Mathieu Malaterre wrote:
> James,
>=20
> On Tue, Feb 13, 2018 at 2:38 PM, James Hogan <jhogan@kernel.org> wrote:
> > On Tue, Feb 13, 2018 at 01:14:29PM +0100, Mathieu Malaterre wrote:
> >> Could you please review the patch v3 ?
> >
> > Yes, looks good to me, and Ralf had applied to his test branch so I
> > presume he's happy with it too. I'll apply for 4.16.
>=20
> Hum, just to be sure I understand the process. Which branch are you
> talking about:
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/ralf/linux.git

I was referring to upstream-sfr.git branch=3Dmips-next-test
https://git.linux-mips.org/cgit/ralf/upstream-sfr.git/log/?h=3Dmips-next-te=
st

(The mips-next branch there is what Ralf puts into linux-next)

I've applied the patch to my mips-fixes branch here:
git://git.kernel.org/pub/scm/linux/kernel/git/jhogan/mips.git

Sorry it seems a bit haphazard with multiple trees in use.

Cheers
James

--kA1LkgxZ0NN7Mz3A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqC9wcACgkQbAtpk944
dnpDsQ/9HP9dZ3Vlm/NAkshn5Z7CMRBhqjYIij2rtdNxhtJphoFtNeY8toLh7CLa
ywNIz2pErakB2mCpb1I6xHPm7eI2HG4INo2hshu2cJEqPFRm+oWZ9hbrfQpPYH7e
C9zpO+na7hsVTaMRItUtcSo7kljZOx21QeDMRV7mOtiDuW/eTCtr0obk6cf2h/ju
xhQCoh+honGU/JoeN+3PKrvhvvTUc5CX+GdcBxrNebBIgQu9HPuInaxY/bBijjx5
cNE+V0GAY/YWjcHeyj9ztCVtUCmEHIxx6fUazl/w6vyMCVh1yNiNStgZOxr/+gpA
Uj+2KAIOhh4RWdRreiSKItD30oWAmq+36VAWPtbfNd+t4W/h6875U+v75P3uQgni
AVEvyf5eb7/faThS4keMbi7JfNEtjH/PTsQwe5809mLZ7p+LFbaPtt82hs23f0h3
5hFI8FAy9S34PpnOrOd2ghJcIg+bsWWEeVLhVaMcMT7iIP6aUt5uvzzD8K4XRglQ
uHCUN3qd3IbgHUGAUmm4Uhr14SfKcv8mWT6EuWFZD9VkjvcsGHFQv1vErN1i2EEE
FOlWfA94KITKAoIMPum07RQKjHU6HQKwxCODmOwuxNL61r3aHFtk7otKZBbtlgzL
jL88wyDeTD2rbqYIIqg23H8tWSdnttKdfYuyRSMRbvByZGS/Bag=
=OcHK
-----END PGP SIGNATURE-----

--kA1LkgxZ0NN7Mz3A--
