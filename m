Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Sep 2013 17:07:25 +0200 (CEST)
Received: from pax.zz.de ([88.198.69.77]:54605 "EHLO pax.zz.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6832659Ab3ISPHX3ycTx (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 19 Sep 2013 17:07:23 +0200
Received: by pax.zz.de (Postfix, from userid 1000)
        id EC633415F; Thu, 19 Sep 2013 17:07:22 +0200 (CEST)
Date:   Thu, 19 Sep 2013 17:07:22 +0200
From:   Florian Lohoff <f@zz.de>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Subject: Re: Roll call for porters of architectures in sid and testing
 (Status update)
Message-ID: <20130919150722.GC28967@pax.zz.de>
References: <20130919103158.GB7476@pax.zz.de>
 <20130919135852.GB22468@linux-mips.org>
 <20130919141006.GB9062@pax.zz.de>
 <20130919145451.GE22468@linux-mips.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="GZVR6ND4mMseVXL/"
Content-Disposition: inline
In-Reply-To: <20130919145451.GE22468@linux-mips.org>
Organization: rfc822 - pure communication
User-Agent: Mutt/1.5.20 (2009-06-14)
Return-Path: <flo@pax.zz.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37887
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


--GZVR6ND4mMseVXL/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 19, 2013 at 04:54:51PM +0200, Ralf Baechle wrote:
> On Thu, Sep 19, 2013 at 04:10:06PM +0200, Florian Lohoff wrote:
> > On Thu, Sep 19, 2013 at 03:58:52PM +0200, Ralf Baechle wrote:
> > > On Thu, Sep 19, 2013 at 12:31:58PM +0200, Florian Lohoff wrote:
> > >=20
> > > > just a heads up that Mips and Mipsel are 2 architectures in danger
> > > > of beeing dropped by Debian if no one steps up as a porter beeing
> > > > reachable for addressing architecture specific bugs.=20
> > >=20
> > > What components and packages are we talking about?  Are we talking ab=
out
> > > a fulltime job for a small army of geeks or?
> >=20
> > Its about dealing with architecture specific problems. Looking after
> > ICEs, userspace asm stuff for debian packages where they break etc.
> >=20
> > A typical Debian Developer wont know about the mips specifics and=20
> > needs someone to adress stuff to if the build breaks for architecture
> > specific problems.
> >=20
> > Debian has formalizes the release criterias for their architectures
> > concerning build architecture, availabibility of hardware and=20
> > manpower to fix those problems. This is why there needs to be some
> > names on the list.
> >=20
> > All the Debian architectures are depending on one another. So if a
> > gcc build fails for parisc the new gcc cant propagate to stable/testing.
> > So the release managers are keen on quickly fixing those bugs to not
> > hold up all architectures progressing.
>=20
> Sounds like this is really a job for a number of specialists in various
> fields.
>=20
> You also mentioned the availability of hardware.  How's the situation
> there wrt. to MIPS?

Its not about current availability but the possibility to buy new
hardware for whatever reason:

http://lwn.net/Articles/152600/

Flo
--=20
Florian Lohoff                                                 f@zz.de

--GZVR6ND4mMseVXL/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIVAwUBUjsTKpDdQSDLCfIvAQh7hQ/5AUrWm7vb8XERY/rL0E5fuovVKgyzyIBt
6GXdczZq0xgfeU23F/3Z37pfLCWCeabclZJJiYn59Jig14zfpTUvvU+igugEgDyI
yKOHUWmbZWE9Jc+T/u5HCdKBWjtRbPBTx14gJY8rxJMtXsBBac2vwTYHXt4PNEdh
P+xg7PJYfBH5yXnFQOrPFxjZDKkThVS/9BD0YhCCO7vUrN3eMg11b8hGDzxgRTyc
mhCUN/p+4CzDZU5n9OlZRBUI32G044PJHfCedbCTu3kD1J+c3iXx3uM1CUjrZ+O2
9q96fiN1WLo8JzhNrLOUL7zzZxw9orzwIM+tVdvzAdjrjlCYJ8z9i0OAVbxcP1sw
9KOCADzeXb15rXLO9++7sgZFDi+zuVgXt0ZqVaGvVPKHsKhj/Nf2H1+ronQKeXHU
AKvzMpoEYoJEpcZDszsUyR1vBJH7UmWoQiyVyEGixLvC4P+JYXnq6/yOrLGzzzTL
abYQFUVhiwGow1Fi3KP7ZLGRwNVKTwHYkyJpAN9sCGCQAGyvBBgJIvxFG2AQiyJE
FGMMGbbUoiWIZ6+lEViOEAKQhXA0Rm/3XzCXaEWav+DwvkyGDotCQA+x5Re+CNOe
FmATw/C3kCDyNTYiWJkXyjaGjtMViuR0vYQtxLQDgI17gt2gWqjlv+FP3SpzIixP
BsdtEsrD/3w=
=V+Ky
-----END PGP SIGNATURE-----

--GZVR6ND4mMseVXL/--
