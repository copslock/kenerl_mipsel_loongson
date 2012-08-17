Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Aug 2012 23:33:05 +0200 (CEST)
Received: from moutng.kundenserver.de ([212.227.17.10]:50885 "EHLO
        moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903597Ab2HQVc6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 17 Aug 2012 23:32:58 +0200
Received: from mailbox.adnet.avionic-design.de (mailbox.avionic-design.de [109.75.18.3])
        by mrelayeu.kundenserver.de (node=mrbap4) with ESMTP (Nemesis)
        id 0M8iuS-1SqLcc3Ao0-00C9gz; Fri, 17 Aug 2012 23:32:50 +0200
Received: from localhost (localhost [127.0.0.1])
        by mailbox.adnet.avionic-design.de (Postfix) with ESMTP id 4277E2A282FF;
        Fri, 17 Aug 2012 23:32:50 +0200 (CEST)
X-Virus-Scanned: amavisd-new at avionic-design.de
Received: from mailbox.adnet.avionic-design.de ([127.0.0.1])
        by localhost (mailbox.avionic-design.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 7LD+aXHHtT4U; Fri, 17 Aug 2012 23:32:48 +0200 (CEST)
Received: from localhost (avionic-0098.adnet.avionic-design.de [172.20.31.233])
        (Authenticated sender: thierry.reding)
        by mailbox.adnet.avionic-design.de (Postfix) with ESMTPA id 665A72A282AD;
        Fri, 17 Aug 2012 23:32:48 +0200 (CEST)
Date:   Fri, 17 Aug 2012 23:32:47 +0200
From:   Thierry Reding <thierry.reding@avionic-design.de>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     David Daney <ddaney.cavm@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-pci@vger.kernel.org,
        linux-mips <linux-mips@linux-mips.org>
Subject: Re: PCI Section mismatch error in linux-next.
Message-ID: <20120817213247.GA1056@avionic-0098.mockup.avionic-design.de>
References: <502E8115.90507@gmail.com>
 <CAErSpo7a77wAxrgZYfg_UdqLEtEf0wUxcbxTghnR7HbRsncKRQ@mail.gmail.com>
 <20120817182931.GA27391@avionic-0098.adnet.avionic-design.de>
 <CAErSpo6xhbpmd-rnLqKp9SuRQCp5a7jUzKhz0n6zGGLNHybWqA@mail.gmail.com>
 <20120817200755.GA16021@avionic-0098.adnet.avionic-design.de>
 <CAErSpo4XX7mQBmJfYWzmXCSDAt4BzZoJV6gU9__409K=fpvC6A@mail.gmail.com>
 <20120817204839.GA2017@avionic-0098.mockup.avionic-design.de>
 <20120817210718.GA14842@avionic-0098.mockup.avionic-design.de>
 <CAErSpo7bwHNUchZHeJByxzhsc0uN7RJMLivBo5FuOJzA0Gz2Jg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline
In-Reply-To: <CAErSpo7bwHNUchZHeJByxzhsc0uN7RJMLivBo5FuOJzA0Gz2Jg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:VRfyj3scc1VJzJxSTM1IbDiDauL25qHlWsdYrZdmDNG
 DiAYZXfYmgiY7Rb32CSsVGe8cUP9psRbOpjMGX1piil2x5SRKY
 zMXf0nlI7M4UY3rqUqcvhyTpyuI2B1HHId00At2PQWvtuzuqfU
 r3FJlYAhu+8IcIXnxolDrc1r9kxh0jfuvVlzpbJNnbMQIOOVcZ
 t7BC0kRges0lAyC9SglZJdbvWBxBtv8wFqspTS/5yHia8agL+E
 aHuyqDH2OLUcVoIWd01fJLma+29eEIwY168yeOzXLTC3EwCxHU
 e18lXAGHrB/Jge5OxuRLlUvKTwifNlmRxCXsr9GvQHeYmboAVW
 TXrXgbncgCyE4iEs9EVlcWyqgzZJPAcmgmbL0Y0VEmYcXDrFHl
 gOe2diJ8+Fsn/X/7TfWi6hZ4sYnsOY4Q/zTXjwHQ1CkUok7R8e
 uH56I
X-archive-position: 34267
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


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 17, 2012 at 03:25:22PM -0600, Bjorn Helgaas wrote:
> On Fri, Aug 17, 2012 at 3:07 PM, Thierry Reding
> <thierry.reding@avionic-design.de> wrote:
> > On Fri, Aug 17, 2012 at 10:48:39PM +0200, Thierry Reding wrote:
> >> On Fri, Aug 17, 2012 at 02:39:34PM -0600, Bjorn Helgaas wrote:
> > [...]
> >> > Well, maybe you just need to turn on CONFIG_HOTPLUG.  How would that
> >> > affect you?  I think we would still have to change some __inits to
> >> > __devinit, including pcibios_update_irq(), but it might be more
> >> > manageable.
> >>
> >> You said that depending on HOTPLUG wouldn't be enough because it would
> >> exclude reenumeration at runtime if HOTPLUG wasn't defined. Also it is
> >> theoretically possible to build a kernel without HOTPLUG but have the
> >> enumeration start after init because of deferred probing. Those cases
> >> won't work if we keep __init or __devinit respectively, right?
> >
> > Another possibility would be to make PCI select HOTPLUG or depend on it.
> > That way it would be made sure that __devinit wouldn't cause all the
> > functions to be discarded after init.
>=20
> There's been some discussion recently about whether CONFIG_HOTPLUG is
> worth keeping any more, but nothing's been resolved yet.  If we did
> decide to remove CONFIG_HOTPLUG, or require it for PCI, I would rather
> just remove all the __devinit annotations because they'd be
> superfluous.

I've missed that discussion. Can you point me to it?

> > Also, using PCI without HOTPLUG is sort of contradictory.
>=20
> I'm not sure I follow this one.  I can easily imagine embedded systems
> that use PCI internally but have no slots or connectors, so there's no
> possibility of anything changing.

Contradictory was probably the wrong word. What I meant to say was that
for systems that use PCI it probably wouldn't hurt to enable HOTPLUG as
well. That would sort of go with what you said above, regarding the
removal of HOTPLUG altogether.

Thierry

--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQLrh/AAoJEN0jrNd/PrOh3tgQALYNMSOVoqKR0VO+N4jmx8pz
wtJfWRZrxMOqtxs/5vLdVNR3YyXVbvWth6UfTWasHjDnLsnpHXuz9hvPbyQZ1K10
Ti+cYnz+w3n47fg9hO4F/aQxHAv3Ugnf7o6jdzMEDovpRZcko+ST/3eAjja44ErG
kd6wgUtNPeLZepmGq8hOaWKqmTE5/ll5fasK3+KHKJ7NZFZ0NzTxKRixe/DO3CZ4
NPUDuRPpsw3mGgFyZ9s5d8hJ3tUzuhXX8M3GEDpZzMIzd2EfZ9FqLiw7MzBB6vp3
19epPv8XaDSbA4dz7Mcy/9csGOguHAjsdi+quJrcTTfKXy8ad9cjFhl7Baaw9jya
NSWBWRtWq/itwbCOeFCGBDq8KBCR4fZF9o9imqLpQgJIrIyUbzVXO+C37H60PbaH
OIOzWkCY4wOl12kOaAgaoCKsHr9w69xrhN58qdRQAVB9PX7PLmiddu0oOdk7xpJO
dMSs2kQR/sLeOoDQXoJL66Nf6wbAMQZmy8r6yVBijhlCsbhxkIc9QquoOrqm4tii
neaTdMj1HNszPrcW2/Q5gzdYquzTI79HSryxkxquRXwLZDhcIGajYbFIwVdTmbkF
6RE9H6XjZXMnawDIvR+8rkgh6yDDMhrcdyt8SfuxkT4D1PGdpWL4D2zV1O+Zg0eq
unIBDvNJSUYSwpMmevKM
=rWb7
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--
