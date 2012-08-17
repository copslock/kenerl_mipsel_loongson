Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Aug 2012 20:29:46 +0200 (CEST)
Received: from moutng.kundenserver.de ([212.227.126.171]:60274 "EHLO
        moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903487Ab2HQS3k (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 17 Aug 2012 20:29:40 +0200
Received: from mailbox.adnet.avionic-design.de (mailbox.avionic-design.de [109.75.18.3])
        by mrelayeu.kundenserver.de (node=mreu2) with ESMTP (Nemesis)
        id 0MWvfk-1TEefi3oyy-00WIb5; Fri, 17 Aug 2012 20:29:35 +0200
Received: from localhost (localhost [127.0.0.1])
        by mailbox.adnet.avionic-design.de (Postfix) with ESMTP id 6386F2A2830D;
        Fri, 17 Aug 2012 20:29:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at avionic-design.de
Received: from mailbox.adnet.avionic-design.de ([127.0.0.1])
        by localhost (mailbox.avionic-design.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id GgliOjEg+ZcM; Fri, 17 Aug 2012 20:29:32 +0200 (CEST)
Received: from localhost (avionic-0098.adnet.avionic-design.de [172.20.31.233])
        (Authenticated sender: thierry.reding)
        by mailbox.adnet.avionic-design.de (Postfix) with ESMTPA id 8DC4E2A2819B;
        Fri, 17 Aug 2012 20:29:32 +0200 (CEST)
Date:   Fri, 17 Aug 2012 20:29:31 +0200
From:   Thierry Reding <thierry.reding@avionic-design.de>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     David Daney <ddaney.cavm@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-pci@vger.kernel.org,
        linux-mips <linux-mips@linux-mips.org>
Subject: Re: PCI Section mismatch error in linux-next.
Message-ID: <20120817182931.GA27391@avionic-0098.adnet.avionic-design.de>
References: <502E8115.90507@gmail.com>
 <CAErSpo7a77wAxrgZYfg_UdqLEtEf0wUxcbxTghnR7HbRsncKRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="opJtzjQTFsWo+cga"
Content-Disposition: inline
In-Reply-To: <CAErSpo7a77wAxrgZYfg_UdqLEtEf0wUxcbxTghnR7HbRsncKRQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:TXp0yK8x8qeMBEsyiVNnsdrKChhKtJ1BxsapVG2CJyp
 OKraYsYC5BxC/PrG3HE3SeqBTwCAt0IPd0isQF6Um5V4KTfNbE
 JESKtyuNZb2FcMnT0txyxSXPvXfoBs7lxfPeSbDKaqRPJJctXI
 hsQC4K9e+9il5EPIRHX14OJFaTN1UzDbSbSzzsu9SYdKlx7reb
 ietvAkV27AXFowCa5qA3mFMpVGdxn2f7+VrE1bimoEv9yQ0Drn
 XETxo/xZHtaP7lGoqbPI2qAf4sUleyEWvNUmXYsjU3je+HG9LD
 rr48H0KcnIllaN/20x/pJcTiNYcp9G1oRaw18a5fQYzgyvqPSk
 oqohCaX6RXBoYeJR+WFS7dbhlDJTzXFwsg6+Qw6h6eFBephgds
 D+4MKLppFQ0pEtQRhtCW1qAHAUwocEyek0=
X-archive-position: 34257
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


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 17, 2012 at 11:44:31AM -0600, Bjorn Helgaas wrote:
> On Fri, Aug 17, 2012 at 11:36 AM, David Daney <ddaney.cavm@gmail.com> wro=
te:
> > For MIPS, Thierry Reding's patch in linux-next (PCI: Keep pci_fixup_irq=
s()
> > around after init) causes:
> >
> > WARNING: vmlinux.o(.text+0x22c784): Section mismatch in reference from =
the
> > function pci_fixup_irqs() to the function .init.text:pcibios_update_irq=
()
> >
> > The MIPS implementation of pcibios_update_irq() is __init, so there is
> > conflict with the removal of __init from pci_fixup_irqs() and
> > pdev_fixup_irq().
> >
> > Can you guys either remove the patch from linux-next, or improve it to =
also
> > fix up any architecture implementations of pdev_update_irq()?
>=20
> Crap, there are lots of arches with this issue.  I'll fix it up.
> Thanks for pointing it out!

Oh wow... looks like I've opened a can of worms there. This requires
quite a lot of other functions to have their annotations removed as
well. Bjorn, how do you want to handle this?

Thierry

--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQLo2LAAoJEN0jrNd/PrOhb1IP/RdhIzUzNvyJ/Gtw7M0h2/5Q
Jkj9EMeo6UcEaAx98xWTGYtNihfIDfg2LlmGJU5Sgu6mEQqRdFD6WMfOByis0bLP
iS+w7cFA7K0qSdktxker+5+P8tYWIuh+oRXHSqNPvQXhm07XvM2BfYgHfWnvDLlK
VvFeXf+dnXCb8dZUA+uiXXc1GeQbT8UJnx8VPuPPV5tOk8WIKyKopH6EzXWDiLNf
uNrsr90DIv6O2p4qrfkcBiGpcbLaHWBOIJ3jwc6rbqfntL9c1DATZzW6Y0c5jBhh
gX8e9KMMX3OllB6/mWfnjOyBc6Ah9+ZQKFTZIWjcyw0LZPPPVApnURBsU0HPvudZ
wV3BDt22W+9Sq6ojiBr3EmFr8QK5XmpyevKQLBUsjTxVc1MNcPX+c+MgDSmvbZWd
rgw3CtBPcSFCeD8lCr5xHETJ/8ws2v6JpJrm8z9EQNkq572Hiqx2KFL35PxNbFGn
Wck0H+LnEGxr4RajQCDpnnzqTo+X7Xq9xuON/SxFrqUgAgBR1cEDGSM1nRyovXWe
RhD1FjwTKJbKQltQxaXNUAoGMM+B91Ootx7OIhkWd+bpUZ/Z0DN36AjpsehA4c2i
q8y75QpUyvq9cx4gOBO/jWOLj19ZI/DldaulA4dlixCeSM73poUO0C7dAp6wFZ3V
LpRU2groV73HhmaV959s
=Z87r
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--
