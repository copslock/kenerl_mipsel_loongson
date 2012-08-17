Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Aug 2012 23:07:44 +0200 (CEST)
Received: from moutng.kundenserver.de ([212.227.17.10]:51831 "EHLO
        moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903608Ab2HQVH0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 17 Aug 2012 23:07:26 +0200
Received: from mailbox.adnet.avionic-design.de (mailbox.avionic-design.de [109.75.18.3])
        by mrelayeu.kundenserver.de (node=mrbap3) with ESMTP (Nemesis)
        id 0MBSfG-1Srzuo2ayU-00AVkH; Fri, 17 Aug 2012 23:07:20 +0200
Received: from localhost (localhost [127.0.0.1])
        by mailbox.adnet.avionic-design.de (Postfix) with ESMTP id 21D692A2830D;
        Fri, 17 Aug 2012 23:07:20 +0200 (CEST)
X-Virus-Scanned: amavisd-new at avionic-design.de
Received: from mailbox.adnet.avionic-design.de ([127.0.0.1])
        by localhost (mailbox.avionic-design.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id whGNmnHgJEKp; Fri, 17 Aug 2012 23:07:19 +0200 (CEST)
Received: from localhost (avionic-0098.adnet.avionic-design.de [172.20.31.233])
        (Authenticated sender: thierry.reding)
        by mailbox.adnet.avionic-design.de (Postfix) with ESMTPA id 164562A282AD;
        Fri, 17 Aug 2012 23:07:19 +0200 (CEST)
Date:   Fri, 17 Aug 2012 23:07:18 +0200
From:   Thierry Reding <thierry.reding@avionic-design.de>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     David Daney <ddaney.cavm@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-pci@vger.kernel.org,
        linux-mips <linux-mips@linux-mips.org>
Subject: Re: PCI Section mismatch error in linux-next.
Message-ID: <20120817210718.GA14842@avionic-0098.mockup.avionic-design.de>
References: <502E8115.90507@gmail.com>
 <CAErSpo7a77wAxrgZYfg_UdqLEtEf0wUxcbxTghnR7HbRsncKRQ@mail.gmail.com>
 <20120817182931.GA27391@avionic-0098.adnet.avionic-design.de>
 <CAErSpo6xhbpmd-rnLqKp9SuRQCp5a7jUzKhz0n6zGGLNHybWqA@mail.gmail.com>
 <20120817200755.GA16021@avionic-0098.adnet.avionic-design.de>
 <CAErSpo4XX7mQBmJfYWzmXCSDAt4BzZoJV6gU9__409K=fpvC6A@mail.gmail.com>
 <20120817204839.GA2017@avionic-0098.mockup.avionic-design.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
In-Reply-To: <20120817204839.GA2017@avionic-0098.mockup.avionic-design.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:DYqZKPetdNsspzANg7Vt0lJ+e+p8fHkLPWrVYQ3yiaj
 ZyeeTIjNDIBYNKICDKixpfZJRx7XwxDtZvLiCYZk0NqoGU5Ot6
 ZQ/+C1//kQ8kiDPHNLuL3COflr98/97c54lRCSqAIyk3bEKjp3
 96r0VA0UI4f0JYBYpRoSix9ik0stQr83hShe/N8Li0WScm8S7h
 i5IeguXns2pyxtWISzi1dok2XOUDxfeFJ70kmkIYOGym2URDhV
 v6OOWF1RdceVfDfzNdgL3FHcHjQDZrMkHgegvrNp3ZnR8dBHwq
 J99Fb6O94so/X9fRNfk8Swpuu9wC+uCZR/dRLOjJX3CwFglsgJ
 1J2B7f9RSORTqHQ0AV6AyMQ/HpeLoxXXXmDT8cU4bBjZPaiTrN
 hrhlwJ1kwRd3mXSfuQ++I7EzBX9f/XUi2G1OWojuNbzqyaNd5u
 LTa1q
X-archive-position: 34264
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thierry.reding@avionic-design.de
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
Return-Path: <linux-mips-bounce@linux-mips.org>


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 17, 2012 at 10:48:39PM +0200, Thierry Reding wrote:
> On Fri, Aug 17, 2012 at 02:39:34PM -0600, Bjorn Helgaas wrote:
[...]
> > Well, maybe you just need to turn on CONFIG_HOTPLUG.  How would that
> > affect you?  I think we would still have to change some __inits to
> > __devinit, including pcibios_update_irq(), but it might be more
> > manageable.
>=20
> You said that depending on HOTPLUG wouldn't be enough because it would
> exclude reenumeration at runtime if HOTPLUG wasn't defined. Also it is
> theoretically possible to build a kernel without HOTPLUG but have the
> enumeration start after init because of deferred probing. Those cases
> won't work if we keep __init or __devinit respectively, right?

Another possibility would be to make PCI select HOTPLUG or depend on it.
That way it would be made sure that __devinit wouldn't cause all the
functions to be discarded after init.

Also, using PCI without HOTPLUG is sort of contradictory.

Thierry

--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQLrKGAAoJEN0jrNd/PrOhCdcP/3uQiMNPZuOMfFpouaXem6qS
Wo1nLtGkeLLjvRY5jv38voix7MRxeJIkKW1v7YCeuCj5+RjzCO6o+0u+qHS0jZKp
tku2SYP2h12v6p0yIZijyR+ebgPvKOSrBLN2R4IT4487teBeW1dLoyZ3O5QInjOh
BtKwUcXkCDRKGLsBDK1wg+wqe2qlb/tXL7Dc+pn7RdI2l6R69b3rxmPqsDUL2p6f
/wpzcf+2zwNCQnhgHHaYqB/IKfHb0WbZmM/U71JuaowmvLRQu0Eb9UH2qHpJ5stY
UTbDIsMRiXacDvKrFiVYJ4coCY7WrWB1CCvnObVTsru5Fc4E62y3Px99m4yHCzxP
KmW/t0Srf4D5YVwyWmEK83WzGyZOol8cAJfc7Y7gCUJ8zagfaPlX9VXlkfKkgadM
uh4n/2kLnmduituVlEOsbPw8gMwLkflUJIxPSwyNrpkJeWvT2wDakGSrGt/uQ8MW
LKISwrvGXos+cZkyR6HLcJMfgq+LO4AbDvQwRWKur3XkNL0yJBrOByWy3+baZ+Ti
QA1OXc3Sbt5ojAB24bO8c+RGpdhitK8gHI5nJHDQ7Go6IdtQmjykt6dLBQlnBgD6
WT6KBuWtPn1Kmx/ztYG2Zsihz22+uJttHZWSv8yp+rCi1U3FRAjWDlXeVXJxqgMg
yLEUd6DMr7bX7GHD1Jls
=VgbU
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--
