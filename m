Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Jul 2015 11:47:01 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:60749 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27009231AbbGMJq5qM42r (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 Jul 2015 11:46:57 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 6E6AE41F8DED;
        Mon, 13 Jul 2015 10:46:52 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Mon, 13 Jul 2015 10:46:52 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Mon, 13 Jul 2015 10:46:52 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id C49671B0D9663;
        Mon, 13 Jul 2015 10:46:49 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 13 Jul 2015 10:46:52 +0100
Received: from [192.168.154.110] (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Mon, 13 Jul
 2015 10:46:51 +0100
Message-ID: <55A38910.1050509@imgtec.com>
Date:   Mon, 13 Jul 2015 10:46:56 +0100
From:   James Hogan <james.hogan@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     Andrew Bresticker <abrestic@chromium.org>,
        <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/9] MIPS: Remove "weak" from platform_maar_init() declaration
References: <20150712230402.11177.11848.stgit@bhelgaas-glaptop2.roam.corp.google.com> <20150712231104.11177.69594.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20150712231104.11177.69594.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature";
        boundary="5mbjVbu3C0Bk9sL1dv0FGw6dsdFu9DBwJ"
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: f107b6f
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48223
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

--5mbjVbu3C0Bk9sL1dv0FGw6dsdFu9DBwJ
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 13/07/15 00:11, Bjorn Helgaas wrote:
> Weak header file declarations are error-prone because they make every
> definition weak, and the linker chooses one based on link order (see
> 10629d711ed7 ("PCI: Remove __weak annotation from pcibios_get_phb_of_no=
de
> decl")).
>=20
> platform_maar_init() is defined in:
>=20
>   - arch/mips/mm/init.c (where it is marked "weak")
>   - arch/mips/mti-malta/malta-memory.c (without annotation)
>=20
> The "weak" attribute on the platform_maar_init() extern declaration app=
lies
> to the platform-specific definition in arch/mips/mti-malta/malta-memory=
=2Ec,
> so both definitions are weak, and which one we get depends on link orde=
r.
>=20
> Remove the "weak" attribute from the declaration.  That makes the malta=

> definition strong, so it will always be preferred if it is present.
>=20
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> CC: linux-mips@linux-mips.org

Reviewed-by: James Hogan <james.hogan@imgtec.com>

Cheers
James

> ---
>  arch/mips/include/asm/maar.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/mips/include/asm/maar.h b/arch/mips/include/asm/maar.=
h
> index 6c62b0f..b02891f 100644
> --- a/arch/mips/include/asm/maar.h
> +++ b/arch/mips/include/asm/maar.h
> @@ -26,7 +26,7 @@
>   *
>   * Return:	The number of MAAR pairs configured.
>   */
> -unsigned __weak platform_maar_init(unsigned num_pairs);
> +unsigned platform_maar_init(unsigned num_pairs);
> =20
>  /**
>   * write_maar_pair() - write to a pair of MAARs
>=20


--5mbjVbu3C0Bk9sL1dv0FGw6dsdFu9DBwJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVo4kQAAoJEGwLaZPeOHZ62RoP/0wwb6YKeRJOHCKsPi3rEGyn
zzmjVwU1TzK+wGjr1E4ZWy8+omHEcF2OUhFPOJpb27SPiOwwJ3IwO3EEnAnkrrqK
udcsljy7O3L4yYqkiJbHZwDrIbJ9iHRWDyzFATMD3AII11cPv7XisbFUtIDbnD0V
EDV3qK+1m0msrCNruZp2u+nau5m9hhUQZr2KDnKb6AB5IHDdn/THP2+smcXpL1E3
BUXDs4+6cq8RnIHPUZnhAT68JBfa6CCbU9tQ4Sd0bCiCSXeCIXmsV4R03uJDj3Ws
QOR8WZmw/MT66F9/5IGl22WXe3Unvc4ITPVyAbH+AJN2Z+SFldXLBzEPFrun1iR3
U4iEGMgrqit4VCHsw9Ctkmkphe+MNvMvbNtAWJh2QbFwOyhbAzU7+WoCPJRu3YIy
EEFXSpFkZhdDvEhlV5fCks8KnvzgcD4w4ukByEFQ08eeTOYPVJy1yklWm2o4lSBT
PUOteNS/Zs7eydiV5Vwwd0Xp8CXpfeayOhB+REjYhZUm4iPdwNeOEuWwuXQVUgzD
QOa4pVmFQV1uoyt3llzEcW2olf/W+pGdr7gov1TI0AlQnsSCM8QXngnERVEKxT5k
ckKfqjgdIsiogalsfrpPUVvSoxOxZRzj6dtVsHHJUgMBsmAaqvhuflWo6qBne/VJ
9nOM0uE60EKsO9k363Y/
=iXWp
-----END PGP SIGNATURE-----

--5mbjVbu3C0Bk9sL1dv0FGw6dsdFu9DBwJ--
