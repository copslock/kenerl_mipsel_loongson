Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 15 Sep 2012 09:54:13 +0200 (CEST)
Received: from moutng.kundenserver.de ([212.227.17.9]:49343 "EHLO
        moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903239Ab2IOHyE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 15 Sep 2012 09:54:04 +0200
Received: from mailbox.adnet.avionic-design.de (mailbox.avionic-design.de [109.75.18.3])
        by mrelayeu.kundenserver.de (node=mreu2) with ESMTP (Nemesis)
        id 0MBG3l-1TKjfJ3xDh-009wBL; Sat, 15 Sep 2012 09:53:05 +0200
Received: from localhost (localhost [127.0.0.1])
        by mailbox.adnet.avionic-design.de (Postfix) with ESMTP id 0BF6F2A282D4;
        Sat, 15 Sep 2012 09:53:04 +0200 (CEST)
X-Virus-Scanned: amavisd-new at avionic-design.de
Received: from mailbox.adnet.avionic-design.de ([127.0.0.1])
        by localhost (mailbox.avionic-design.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id GD-fCSsbMocr; Sat, 15 Sep 2012 09:53:03 +0200 (CEST)
Received: from localhost (avionic-0098.adnet.avionic-design.de [172.20.31.233])
        (Authenticated sender: thierry.reding)
        by mailbox.adnet.avionic-design.de (Postfix) with ESMTPA id 716852A2818B;
        Sat, 15 Sep 2012 09:53:02 +0200 (CEST)
Date:   Sat, 15 Sep 2012 09:53:01 +0200
From:   Thierry Reding <thierry.reding@avionic-design.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Russell King <linux@arm.linux.org.uk>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Mundt <lethal@linux-sh.org>,
        "David S. Miller" <davem@davemloft.net>,
        Chris Metcalf <cmetcalf@tilera.com>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Chris Zankel <chris@zankel.net>,
        Greg Ungerer <gerg@uclinux.org>, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@linux-mips.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: Provide a default pcibios_update_irq()
Message-ID: <20120915075301.GA31044@avionic-0098.mockup.avionic-design.de>
References: <1347655456-2542-1-git-send-email-thierry.reding@avionic-design.de>
 <1347655456-2542-2-git-send-email-thierry.reding@avionic-design.de>
 <CAMuHMdWuR_tdMw9iVkaQ3D9p1HVU_L05ap=MzBuo1jLD6YdHHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="9jxsPFA5p3P2qPhR"
Content-Disposition: inline
In-Reply-To: <CAMuHMdWuR_tdMw9iVkaQ3D9p1HVU_L05ap=MzBuo1jLD6YdHHw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:+WM1IBlhxGXCa1U3T21B9tS4Ln9hnPL8z3edAljLR97
 tGcJzIAXzo25dc89sm6KU/20G61r+KrsRgf7uZs956M5WNoaHe
 XdBo8Ro5FYrhv3FesDimr5qug4tVoTZBUidqs5iJIhdN8Gnki1
 qjO4pXEiQ1rbkme7N5abi5Ce2p8Ru0N6cy4DFmwO1BEl3TH7LI
 l2jvH9UGSyOAdqRktKaMgK2kZs4w+1fmIAU6Uyfh+RywkBwUIn
 dnBqxWeWJ1MLJp+l1vdumWXHWze52MXfxAfsDy7H5hWqueCYYS
 wVGCttukaG2Q1e1jbAP4PQ/hpemaKywICjltOnFNWaIWHekbGc
 p0lFWRObMT6lbiBlfi5Rh2R5XQ90QA+QOFLC0oekzp87SWtWaV
 9oa4hp4ICwAqeFWQwywIE0odZpLep5oEP0=
X-archive-position: 34510
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


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 15, 2012 at 09:32:10AM +0200, Geert Uytterhoeven wrote:
> On Fri, Sep 14, 2012 at 10:44 PM, Thierry Reding
> <thierry.reding@avionic-design.de> wrote:
> > --- a/drivers/pci/setup-irq.c
> > +++ b/drivers/pci/setup-irq.c
> > @@ -17,6 +17,14 @@
> >  #include <linux/ioport.h>
> >  #include <linux/cache.h>
> >
> > +void __devinit __weak pcibios_update_irq(struct pci_dev *dev, int irq)
> > +{
> > +#ifdef CONFIG_PCI_DEBUG
> > +       printk(KERN_DEBUG "PCI: Assigning IRQ %02d to %s\n", irq,
> > +              pci_name(dev));
>=20
> pr_debug()?
> Or even better, dev_dbg()?

The problem with pr_debug() and dev_dbg() is that they will be compiled
out if DEBUG is not defined. Perhaps we should pass -DDEBUG if PCI_DEBUG
is configured and make this dev_dbg()?

Thierry

--9jxsPFA5p3P2qPhR
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQVDPdAAoJEN0jrNd/PrOhyIYP/Ru7vr3AxNAHfW1yg4IPxgM0
HlExgyk6vrHq2RxLK1h714L7sqYK3Gn7AQcXUa8sCHhTqJ7v/nmfnguP9m4K/QJO
SnC+nG4VgwIn7aZHevaupjVcHWXGtL1aR7zUWb7LzqDq+bKYHxpXAz2p8bCzotJG
nZd2OyMdbjVLnONcjdSpbVNHRvKe7UoS4R9I2PvciJI/oUYlV03aMXYpRxujxnIY
DbLxoyCCLsBphYBDx9IvQCFFpBaXqgTVa9PWQ1MlytfuEWoLr6nOVD01bgMizOGS
Ry1Wbs3YAVHjFN/68iLZGjZCz9ODft2MYpw47akDX2InilvlPUH3GZZ4bu+31tP1
bd2M4ZCNAC8EK/UPxAxcyMFhqJ688qpHhDXsPDX349lYdo2SjG90/5CMl6cYL1Xv
Hd/1Uygl+Mmw9oPNX/hpozAJeKvT9P8VqGunn0uabdBxl+4Uo6ucauWRs2V0DY+z
eEX1mVwYSddgcLt9LCU45Io03p3M6W2CRIOwG9beckMj00c07riHX4w6z/OhIsF5
/rhDGvqTr9LHs8L45SzqygsuVWGZiGAryRsHDdXxj2yS+yT1HCDjFboPwsgx6K9P
IcUekJYFy1RxEB7YzK8oyfl7EhigIQAzdyhqL/QgjhtTla6vG7cXcgMYJgXhRtBG
qq23DlFKzpQ/g5tsIqjp
=aCDh
-----END PGP SIGNATURE-----

--9jxsPFA5p3P2qPhR--
