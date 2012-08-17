Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Aug 2012 22:08:10 +0200 (CEST)
Received: from moutng.kundenserver.de ([212.227.126.187]:65096 "EHLO
        moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903451Ab2HQUIE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 17 Aug 2012 22:08:04 +0200
Received: from mailbox.adnet.avionic-design.de (mailbox.avionic-design.de [109.75.18.3])
        by mrelayeu.kundenserver.de (node=mreu1) with ESMTP (Nemesis)
        id 0LzFLh-1Tp3DY1hHl-0151CQ; Fri, 17 Aug 2012 22:07:57 +0200
Received: from localhost (localhost [127.0.0.1])
        by mailbox.adnet.avionic-design.de (Postfix) with ESMTP id DFC372A282EE;
        Fri, 17 Aug 2012 22:07:56 +0200 (CEST)
X-Virus-Scanned: amavisd-new at avionic-design.de
Received: from mailbox.adnet.avionic-design.de ([127.0.0.1])
        by localhost (mailbox.avionic-design.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id II-2zX8vFJua; Fri, 17 Aug 2012 22:07:55 +0200 (CEST)
Received: from localhost (avionic-0098.adnet.avionic-design.de [172.20.31.233])
        (Authenticated sender: thierry.reding)
        by mailbox.adnet.avionic-design.de (Postfix) with ESMTPA id BB7192A282AD;
        Fri, 17 Aug 2012 22:07:55 +0200 (CEST)
Date:   Fri, 17 Aug 2012 22:07:55 +0200
From:   Thierry Reding <thierry.reding@avionic-design.de>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     David Daney <ddaney.cavm@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-pci@vger.kernel.org,
        linux-mips <linux-mips@linux-mips.org>
Subject: Re: PCI Section mismatch error in linux-next.
Message-ID: <20120817200755.GA16021@avionic-0098.adnet.avionic-design.de>
References: <502E8115.90507@gmail.com>
 <CAErSpo7a77wAxrgZYfg_UdqLEtEf0wUxcbxTghnR7HbRsncKRQ@mail.gmail.com>
 <20120817182931.GA27391@avionic-0098.adnet.avionic-design.de>
 <CAErSpo6xhbpmd-rnLqKp9SuRQCp5a7jUzKhz0n6zGGLNHybWqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline
In-Reply-To: <CAErSpo6xhbpmd-rnLqKp9SuRQCp5a7jUzKhz0n6zGGLNHybWqA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:LMFwrw6v1DMbzHOP6o8PQMlBs+fUnya2RMfE5fGUaGg
 E3KjwBUbK5Eaty6zkcBBN0iYzRTxgjVbYG2PW95yuKm8lS68YG
 HLDqmBlWS7AJgCvxzq39MWr5I87g5JLop/ns7Wv+uEfg35BySj
 +R5R1po5EsVqTblMhFj5lrIlcRg87JWHAezxoocBpPFaJJM/ax
 QLTZBIk5eXqQgnyYnUR6niLSAQuB1RPyS1IGIfrSIvg3OFL1J/
 spNFoZuexhEAJ6nxT329q8ds/f6ejcRT7lSWX0MP9e1TtNohQv
 e0vjlXdeD4q02uwy4m9UOEUeq2XN4h79IVzXEIpPoYDDA+PZDM
 JXjrJjwGyG6Otsq3Tut6cVlaR3l2yCXyO/eF0u+lr1OSwzriYq
 j696DZ6W+FKIUKieYEZHpRGltRVV/t9szA=
X-archive-position: 34259
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


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 17, 2012 at 01:32:45PM -0600, Bjorn Helgaas wrote:
> On Fri, Aug 17, 2012 at 12:29 PM, Thierry Reding
> <thierry.reding@avionic-design.de> wrote:
> > On Fri, Aug 17, 2012 at 11:44:31AM -0600, Bjorn Helgaas wrote:
> >> On Fri, Aug 17, 2012 at 11:36 AM, David Daney <ddaney.cavm@gmail.com> =
wrote:
> >> > For MIPS, Thierry Reding's patch in linux-next (PCI: Keep pci_fixup_=
irqs()
> >> > around after init) causes:
> >> >
> >> > WARNING: vmlinux.o(.text+0x22c784): Section mismatch in reference fr=
om the
> >> > function pci_fixup_irqs() to the function .init.text:pcibios_update_=
irq()
> >> >
> >> > The MIPS implementation of pcibios_update_irq() is __init, so there =
is
> >> > conflict with the removal of __init from pci_fixup_irqs() and
> >> > pdev_fixup_irq().
> >> >
> >> > Can you guys either remove the patch from linux-next, or improve it =
to also
> >> > fix up any architecture implementations of pdev_update_irq()?
> >>
> >> Crap, there are lots of arches with this issue.  I'll fix it up.
> >> Thanks for pointing it out!
> >
> > Oh wow... looks like I've opened a can of worms there. This requires
> > quite a lot of other functions to have their annotations removed as
> > well. Bjorn, how do you want to handle this?
>=20
> David said "pdev_update_irq()," but I think he meant "pcibios_update_irq(=
)."
>=20
> Almost all the pcibios_update_irq() implementations are identical, so
> I think I'll just supply a weak implementation and remove the
> redundant arch versions.

That makes sense. However I've just tested a build with section mismatch
debugging enabled on ARM and there are a few more that need __init or
__devinit removed to get rid of the warnings:

	pci_common_init()
	pcibios_init_hw()
	pcibios_init_resources()
	pcibios_swizzle()
	pcibios_update_irq()

pci_scan_root_bus() also needs __devinit removed. I haven't checked the
other architectures because I'll have to build cross-compilers for them
first, but I suspect most of them will have a similar list. I'm not sure
how well this kind of change is going to go down with the respective
architecture maintainers, though.

> This is just about the only thing in my "next" branch, so I'll clear
> it out for now, until we get this resolved.

Agreed. Do you want me to take a look at this or would you rather tackle
it yourself?

Thierry

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQLqSbAAoJEN0jrNd/PrOhM5IQAMIvWP5vgHNoZAYFTtFxCUBB
whTwMx8eqiboWHXvP4rP0VkK7RYs0xrgpnGHHu78d1KxBLe6Bj9jC/UrsZheLBP4
81OxPvwrcSeGnpA8vy6jnt//4mMZkhs1IQC+GGYI72Wi3oFBIVOTtZnvLb+QOpmY
jVODrdGiEpsobb/zNP8poRfbMziJHIciV+vhqOb6vH9Q9YcnAi3UJg+qHFPGaMuc
jG7hjlxhMieFnD84yabKetwiZpfg7kVs9T6LD+KZQ5wIFGSxSZjSxTvUSoKmibk9
IEj8cC9Q0+wByEcprZ/ViUslBqSI8O9yo+zkjLfw15xvu8y08kxyjVllEYhMjMn7
dUEkL20VLc/na1hJ2kaWppEDdVmP4FiY29LeA5KSNyjIN+7lFcLPV13iNd8n5hOd
EwwyDbADTJjy+TLmqnaZdJknL9iEkbzkRzvoVazqIrEcXQPvwmF+rXDHBxUY5zbA
3R3mPQIqGYTP4YSNWaO223+kXBlbUePTho5Rxi7Bj6Y1pHwe3MYS9spjfJ7dTWKZ
cg4UDfSa/lmNJJTHJRXYbDKoz9OzKOYyV2KHKFbDWL0qPcqGccX2tKJEPCtIqqGU
TAegcORisZsqXwNEi/5L5yaLQlUNZUPF5TC4CdLswmdNlQG9b69r18mQROABRDtS
nlck9r/PYhVVpBlVfubH
=9dM8
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
