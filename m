Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Sep 2014 10:54:41 +0200 (CEST)
Received: from mail-we0-f171.google.com ([74.125.82.171]:62975 "EHLO
        mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008039AbaIZIyj2pTxn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 26 Sep 2014 10:54:39 +0200
Received: by mail-we0-f171.google.com with SMTP id k48so9293033wev.2
        for <multiple recipients>; Fri, 26 Sep 2014 01:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=7RaMgtAboRQDx2X9adSdxPdkqhd36jHPbE9zH/pnXgw=;
        b=H7QDrVh/WHtrwvBjNmb3L2p4HVnEB5aRccNfQxdlmdUyGCWORK6ysw9DHdnp/lQeCw
         iOKDWZy8wV5B6j0jS7zkhUCHo5/ITSCnW3E3nunMLAXvnXG1Bx9AbnIFdlMmH8vV+ibX
         IMmUTyHfFSBbdn5eIu4qUrtyqOsj/Qy5uawZTTNEmpIS6tvHzPUeE0p7b8yFj29/PyiF
         GT/k0q0HUOR8SVu1x6yg2Yiy/GCBWRAxghqW+/jJkH63JzFr1MohOay/Lt70cdP8pR0O
         q99zMEJFAI13v7sMjy1delp0f5uBKdPlRABPVzaAC/gYTAddU+zZP9Vb+TwUPBMe3hUF
         +aNw==
X-Received: by 10.180.19.1 with SMTP id a1mr46208236wie.5.1411721674054;
        Fri, 26 Sep 2014 01:54:34 -0700 (PDT)
Received: from localhost (port-6838.pppoe.wtnet.de. [84.46.26.208])
        by mx.google.com with ESMTPSA id f3sm1408720wiz.18.2014.09.26.01.54.32
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Sep 2014 01:54:33 -0700 (PDT)
Date:   Fri, 26 Sep 2014 10:54:32 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Yijing Wang <wangyijing@huawei.com>
Cc:     Liviu Dudau <liviu@dudau.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xinwei Hu <huxinwei@huawei.com>,
        Wuyun <wuyun.wu@huawei.com>,
        linux-arm-kernel@lists.infradead.org,
        Russell King <linux@arm.linux.org.uk>,
        linux-arch@vger.kernel.org, arnab.basu@freescale.com,
        Bharat.Bhushan@freescale.com, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        xen-devel@lists.xenproject.org, Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org, linux-mips@linux-mips.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        Sebastian Ott <sebott@linux.vnet.ibm.com>,
        Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, Chris Metcalf <cmetcalf@tilera.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        David Vrabel <david.vrabel@citrix.com>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH v2 00/22] Use MSI chip framework to configure MSI/MSI-X
 in all platforms
Message-ID: <20140926085430.GG31106@ulmo>
References: <1411614872-4009-1-git-send-email-wangyijing@huawei.com>
 <20140925074235.GN12423@ulmo>
 <20140925144855.GB31157@bart.dudau.co.uk>
 <20140925164937.GB30382@ulmo>
 <20140925171612.GC31157@bart.dudau.co.uk>
 <542505B3.7040208@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="5L6AZ1aJH5mDrqCQ"
Content-Disposition: inline
In-Reply-To: <542505B3.7040208@huawei.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <thierry.reding@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42837
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thierry.reding@gmail.com
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


--5L6AZ1aJH5mDrqCQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2014 at 02:20:35PM +0800, Yijing Wang wrote:
> >> The PCI core can already deal with that. An MSI chip can be set per bus
> >> and the weak pcibios_add_bus() can be used to set that. Often it might
> >> not even be necessary to do it via pcibios_add_bus() if you create the
> >> root bus directly, since you can attach the MSI chip at that time.
> >=20
> > But I'm thinking that we need to move away from pcibios_add_bus() inter=
face to do
> > something that should be generic. You don't need to be called for every=
 bus when all
> > you want is just the root bus in order to add the MSI chip. Also, from =
looking at
> > the current patchset, a lot of architectures would set the MSI chip to =
a global
> > variable, which means you don't have an option to choose the MSI chip b=
ased on the
> > bus.
>=20
> I also agree to remove the pcibios_add_bus() in arm which call .add_bus()=
 to associate msi_chip
> and PCI bus.
>=20
> In my opinions, all PCI devices under the same PCI hostbridge must share =
same msi chip, right ?
> So if we can associate msi chip and PCI hostbridge, every PCI device can =
find correct msi chip.
> PCI hostbridge private attributes can be saved in PCI sysdata, and this d=
ata will be propagate to
> PCI root bus and its child buses.

struct pci_sys_data is architecture specific, so the code won't become
any more generic than it is now.

> >>> What I would like to see is a way of creating the pci_host_bridge str=
ucture outside
> >>> the pci_create_root_bus(). That would then allow us to pass this sort=
 of platform
> >>> details like associated msi_chip into the host bridge and the child b=
usses will
> >>> have an easy way of finding the information needed by finding the roo=
t bus and then
> >>> the host bridge structure. Then the generic pci_scan_root_bus() can b=
e used by (mostly)
> >>> everyone and the drivers can remove their kludges that try to work ar=
ound the
> >>> current limitations.
> >>
> >> I think both issues are orthogonal. Last time I checked a lot of work
> >> was still necessary to unify host bridges enough so that it could be
> >> shared across architectures. But perhaps some of that work has
> >> happened in the meantime.
> >=20
> > Breaking out the host bridge creation from root bus creation is not dif=
ficult, just not
> > agree upon. That would be the first step in making the generic host bri=
ge structure
> > useful for sharing, specially if used as a sort of "parent" structure t=
hat you can
> > wrap with your actual host bridge structure.
>=20
> Breaking out the host bridge creation is a good idea, but there need a lo=
t of changes, we can
> do it in another series.

I agree, this can be done step by step.

> And if we save msi chip in pci sysdata now, it will be easy to
> move it to generic pci host bridge. We can also move the pci domain numbe=
r and other common info to it.

But like I said above, we wouldn't gain anything by moving the MSI chip
into struct pci_sys_data, since the core code couldn't access it from
there. The code wouldn't become more generic than the current approach
of using pcibios_add_bus(). At least for Tegra it's trivial to just hook
it up in tegra_pcie_scan_bus() directly (patch attached). So I think a
generic solution would be to allow it to be easily associated with a
bus.

Perhaps it would be as simple as adding a pci_scan_root_bus_with_msi()
or something with a less awkward name, or extending the existing
pci_scan_root_bus() with an MSI chip parameter. The function already has
too many arguments for my taste, though, so I'd like to avoid the
latter.

Thierry

--5L6AZ1aJH5mDrqCQ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUJSnGAAoJEN0jrNd/PrOh0goP/iGwtiVYdL1p9IiDbqXeyVl7
QGAF4ZYvzn/3r/fJPxkuPj0OtOLlZL6nC6ldkcJZDW95TNsyFy2sOwj5EaqZ1b5Z
nIy33WvSqw/dpbWGUQrMtxEFormJGo/eXWUokc4LJjuCtoYwu/DIFG37ER+22UGB
Bb1RQ/Ds1maXRtIy7jPQuHFgL5W4cDfSVJTJNEJqpmDCs/LTfw1dD/U+8w6BY545
b/0YYPMQHYsnNJS33wHalb9yXdUnJd3HaEe+X321zPliCHNHjBNGCswxLqCd95Cl
UyPGX1OlFcsN7IxJkz3pGoe+FSZAB/OybV+90YfxFuEfVBpGe304Q3vNlH8ugcWC
K/9oBAWG3Qz184JT9w2ZonuFrsxUdSoeL6EqYAY7FBN9w/Lb6lfAgzeSl98a0N/9
IfjoapMpIWRKt3nPT0EhttoARkum+/qo9LlJ/8SKNbjTY7bmAHplu4ohJAGGe4Xh
0XF98TY+PGfngwaftMSxdHv9Q4mNfZ7eewmhuxftqvvQ1esIlISwlDEdWwG/BsWn
brvccYhQp8hsCE1hYNWhnVz2XTPVLgSb6VPLqR1KKWSA73aUdAJgeeh6nIt8qecT
fqNodyF0aLYQaOZmGzajF0ljxQdB1bhlyZ1awnsbsLlNg9luUO+FzqiLUmQU1D3s
K2fDZGKlZfFeXJY/oYnO
=1FJM
-----END PGP SIGNATURE-----

--5L6AZ1aJH5mDrqCQ--
