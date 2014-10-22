Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Oct 2014 00:41:40 +0200 (CEST)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:39708 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012176AbaJVWlit68JD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 Oct 2014 00:41:38 +0200
Received: from [88.202.169.74] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <ben@decadent.org.uk>)
        id 1Xh4b3-0002Ou-Ta; Wed, 22 Oct 2014 23:41:37 +0100
Received: from ben by deadeye with local (Exim 4.84)
        (envelope-from <ben@decadent.org.uk>)
        id 1Xh4C5-0007QK-6t; Wed, 22 Oct 2014 23:15:49 +0100
Message-ID: <1414016140.5994.9.camel@decadent.org.uk>
Subject: Re: Single MIPS kernel
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     David Daney <ddaney.cavm@gmail.com>, linux-mips@linux-mips.org
Date:   Wed, 22 Oct 2014 23:15:40 +0100
In-Reply-To: <20141022192018.GD12502@linux-mips.org>
References: <20141022083437.GB18581@linux-mips.org>
         <5447F155.60106@gmail.com> <20141022192018.GD12502@linux-mips.org>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-eE9+994FPaRJhVrVDoMP"
X-Mailer: Evolution 3.12.7-1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 88.202.169.74
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43510
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ben@decadent.org.uk
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


--=-eE9+994FPaRJhVrVDoMP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2014-10-22 at 21:20 +0200, Ralf Baechle wrote:
> On Wed, Oct 22, 2014 at 11:03:01AM -0700, David Daney wrote:
>=20
> > There is another reason to have a relocatable kernel:  The security peo=
ple
> > are starting to demand it so that they can randomize the load address.
>=20
> That may work for some platforms - but in the MIPS world we still have to
> deal with very claustrophobic systems which barely leave any space to
> move a kernel around.
>=20
> > This is the approach I was thinking of taking.  There would be a small =
PIC
> > wrapper that applied the relocations, and then passed control to the re=
al
> > entry point.
> >=20
> > We would have to be careful of the ex_table, as that is now sorted at b=
uild
> > time.  For that, we could go to the scheme used by x86, and have that
> > addresses in the ex_table be relative, build time sorting is already wo=
rking
> > for x86 relocatable kernels.
>=20
> That's probably more of an implementation detail.  I'm more concerned abo=
ut
> the overall bloat.  I think many embedded users are so addivted to benchm=
ark
> results that this going to make or break the whole scheme.

If you can make relocation a configuration option (as on x86), it would
allow distributions to build multiplatform kernels without preventing
embedded users from building a kernel optimised for their specific
system.  But I know very little about MIPS or how intrusive the changes
for relocation would have to be.  Perhaps it would be too much of a
maintenance burden to make this an option.

Ben.

--=20
Ben Hutchings
For every action, there is an equal and opposite criticism. - Harrison

--=-eE9+994FPaRJhVrVDoMP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIVAwUAVEgslee/yOyVhhEJAQrjeg//ZIRMRXw9/nXXnPt2p9pr0Mnp5PGTYMb7
M9ck2Zg7aHidNmrjt5AnGgMoNtfT1Li01PqySsZoMY80FfSE6q2mKerfhS2CZsdh
uXzp+66KuWgl96Wn53bSpJ28rH1G18BIEEkTEZ4EjaMNE5J7Cfx9vl5GNbnPVqd1
yBGL8xCR23QyaIe0BWcUSwfAGFhRClgwE3YemPYR++WGJsITYQ0J3az+ZijqP49s
l5NdxA11Vuug4jBFmLcrLkQP7EbMetFpXigQMXTtcyYaG46aca4fSBEtkem+6HCh
KNC2CyVhBemD+/ouvzq2N+CeS5jJLlHHvuucEMch7bUFAk2KjRrI/hGCdgKpGiWQ
6L/ih71pu4n4ToEgU+aBuK4g5+s4m+Hi2xZCPHdQ8UcGE8Wg+hvXXgN63XH/rvFG
l6GQ5y4tpKtLRNZE8MvRDLE5Bu1Fn37F2hTD7G67ylNQVUA1SaMYRBR0HejiT33+
9PbIEb6b5b2hEqkLJtnObgCBy9KY9neBKoj/KvmGhRsZIRR1QfwUG/b8gL7PhCun
GePZTKnrEDL5RRYvYbGEtri7mjeyX9sK0jvAi5LqcyEsJwEvzapkf2N7UAcQjyP+
GeugN4e6eKwbVYoc7avvAZiEA//cKN73LZY9fEHZxZtZrxALa0KJoHfQDqSeXDw0
Wk0S3JyLyZ4=
=Oj3y
-----END PGP SIGNATURE-----

--=-eE9+994FPaRJhVrVDoMP--
