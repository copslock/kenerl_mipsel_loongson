Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Sep 2013 16:10:13 +0200 (CEST)
Received: from pax.zz.de ([88.198.69.77]:54180 "EHLO pax.zz.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823977Ab3ISOKHYWDM3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 19 Sep 2013 16:10:07 +0200
Received: by pax.zz.de (Postfix, from userid 1000)
        id CF9E53752; Thu, 19 Sep 2013 16:10:06 +0200 (CEST)
Date:   Thu, 19 Sep 2013 16:10:06 +0200
From:   Florian Lohoff <f@zz.de>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Subject: Re: Roll call for porters of architectures in sid and testing
 (Status update)
Message-ID: <20130919141006.GB9062@pax.zz.de>
References: <20130919103158.GB7476@pax.zz.de>
 <20130919135852.GB22468@linux-mips.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0ntfKIWw70PvrIHh"
Content-Disposition: inline
In-Reply-To: <20130919135852.GB22468@linux-mips.org>
Organization: rfc822 - pure communication
User-Agent: Mutt/1.5.20 (2009-06-14)
Return-Path: <flo@pax.zz.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37884
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f@zz.de
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


--0ntfKIWw70PvrIHh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi,

On Thu, Sep 19, 2013 at 03:58:52PM +0200, Ralf Baechle wrote:
> On Thu, Sep 19, 2013 at 12:31:58PM +0200, Florian Lohoff wrote:
>=20
> > just a heads up that Mips and Mipsel are 2 architectures in danger
> > of beeing dropped by Debian if no one steps up as a porter beeing
> > reachable for addressing architecture specific bugs.=20
>=20
> What components and packages are we talking about?  Are we talking about
> a fulltime job for a small army of geeks or?

Its about dealing with architecture specific problems. Looking after
ICEs, userspace asm stuff for debian packages where they break etc.

A typical Debian Developer wont know about the mips specifics and=20
needs someone to adress stuff to if the build breaks for architecture
specific problems.

Debian has formalizes the release criterias for their architectures
concerning build architecture, availabibility of hardware and=20
manpower to fix those problems. This is why there needs to be some
names on the list.

All the Debian architectures are depending on one another. So if a
gcc build fails for parisc the new gcc cant propagate to stable/testing.
So the release managers are keen on quickly fixing those bugs to not
hold up all architectures progressing.

Flo
--=20
Florian Lohoff                                                 f@zz.de

--0ntfKIWw70PvrIHh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIVAwUBUjsFvpDdQSDLCfIvAQi0yhAAiXXz0MTu7CJ318BlhLW/KuQKci+WGP/M
glKpa1ckQemr5AF5+gUOSnLpFrdxjoGQRjCfLlbiSKTCHE346Npl7PYdeHhpiimt
w7nHs6C3G1tKoWZS5LZeTlVD31kQIRRY1wlCQ2c4s5wNCnrLT4SXRMYM0+Dm8KXX
9Bvax/SmCM52fMcWkPLQNXJKbn64UN4OCAFsDu9iJfuoekaU7IwJV/jsH30Q7n6A
LhSCMLCTyxG5La2b4HsaqzpZQSlO7nGHllxGmPU9h4hI5rUxaP/w+u4pJQ3ktEue
F9fU0CoKwBu7Y52IGmjKAcUSFaQbcZTfVhcL1Sxatya8zS6rUYPMRGqvoBQOzBtR
JX5NAm+AxXxkwMxxyXDbGNIVYupXd9GG3HOi77Hw5h58vHmHWTnmcSXYYXLnOY5b
UL55WrlQRfmJmnNwj5BNDanqlAp6OQ5wK/olCN+RJQePdATlF2/279mf1fYdrTWt
nsYP7saB6D+8ijFdNgjrOs8LJPDZLdT0WcLdD+U1W+wdTkOIrLVtanHKhvXQim8Z
mMS8SukjRoAia30kck/OVFzUv4vez8qXlfvqTNAihgqKo+V9BCqYpt4NMQOd4dX+
4gs3qqwelxPdzkoBxlGL3tnsf5E1HUq/e9K0mAEeiU5ZicM/tPbckiizpbHpZRjw
WSVaYWCR9sw=
=yAKr
-----END PGP SIGNATURE-----

--0ntfKIWw70PvrIHh--
