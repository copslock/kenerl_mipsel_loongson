Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 15 Sep 2012 09:58:48 +0200 (CEST)
Received: from moutng.kundenserver.de ([212.227.126.187]:61374 "EHLO
        moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903236Ab2IOH6l (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 15 Sep 2012 09:58:41 +0200
Received: from mailbox.adnet.avionic-design.de (mailbox.avionic-design.de [109.75.18.3])
        by mrelayeu.kundenserver.de (node=mreu3) with ESMTP (Nemesis)
        id 0LblNw-1TtmyH06hY-00jHxy; Sat, 15 Sep 2012 09:57:42 +0200
Received: from localhost (localhost [127.0.0.1])
        by mailbox.adnet.avionic-design.de (Postfix) with ESMTP id 221E92A282D4;
        Sat, 15 Sep 2012 09:57:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at avionic-design.de
Received: from mailbox.adnet.avionic-design.de ([127.0.0.1])
        by localhost (mailbox.avionic-design.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id FU1EKzGoIfCK; Sat, 15 Sep 2012 09:57:38 +0200 (CEST)
Received: from localhost (avionic-0098.adnet.avionic-design.de [172.20.31.233])
        (Authenticated sender: thierry.reding)
        by mailbox.adnet.avionic-design.de (Postfix) with ESMTPA id 6AB292A2818B;
        Sat, 15 Sep 2012 09:57:38 +0200 (CEST)
Date:   Sat, 15 Sep 2012 09:57:37 +0200
From:   Thierry Reding <thierry.reding@avionic-design.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Russell King <linux@arm.linux.org.uk>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
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
Subject: Re: [PATCH 1/2] PCI: Annotate pci_fixup_irqs with __devinit
Message-ID: <20120915075737.GA31258@avionic-0098.mockup.avionic-design.de>
References: <1347655456-2542-1-git-send-email-thierry.reding@avionic-design.de>
 <CAErSpo6BqPUEpMmh2+FuEi-mHFK0U1XCmdCpJfo6V2XcNxzMNg@mail.gmail.com>
 <20120914223531.GA8771@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Content-Disposition: inline
In-Reply-To: <20120914223531.GA8771@kroah.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:z4ZB6PdzY1xIrstHENAfrYAdSCRjDWPVsvDoaG48yS0
 fhZjf4y14sTuedXfjMjHO9Rp0+V92pmUySAI+BVBgGfMziR0o1
 lsfIEbEz9mdKlEhQFCi5/YIK0rlCS3A1Auy9J2Nnp1kDmOoQ4n
 nRNGQg+2jjj5/4fYQMjNJ6vxePoIV+yJhsCc5Dxm5r4Nc2owtJ
 SVsnWx3pffGLEdB28fD0gRsReX4YhzbX6DCdn/VmLnYmPeNVh2
 bjaUXD2z87r1ie3+GeBhOHyu8HFqc8i9nz4C/GrUZE3AtLQXlG
 lyN4VWby/me/rvw8lM7J2XH1dLLKBjFDyYPCJ9n5y9QfgfDyJA
 3VhLtlmvCQuCjRZZ12596QBc6uB2k5jm+SjdjoP2axtAtled4b
 deJqhKxirkoSs8yO/QpqAHq4IT0OzUsH7M=
X-archive-position: 34511
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


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 14, 2012 at 03:35:31PM -0700, Greg Kroah-Hartman wrote:
> On Fri, Sep 14, 2012 at 02:53:11PM -0600, Bjorn Helgaas wrote:
> > +cc Greg KH
> >=20
> > On Fri, Sep 14, 2012 at 2:44 PM, Thierry Reding
> > <thierry.reding@avionic-design.de> wrote:
> > > In order to keep pci_fixup_irqs() around after init (e.g. for hotplug=
),
> > > mark it __devinit instead of __init. This requires the same change for
> > > the implementation of the pcibios_update_irq() function on all
> > > architectures.
> > >
> > > Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
> > > ---
> > > Note: Ideally these annotations should go away completely in order to
> > > be independent of the HOTPLUG symbol. However, there is work underway
> > > to get rid of HOTPLUG altogether, so I've kept the __devinit for now.
>=20
> No, just take away the __init marking completly.  For 3.7,
> CONFIG_HOTPLUG will always be enabled, making it be the same thing.
> That way this saves me the time and energy from deleting the __devinit
> markings when I get to that point in the patch series :)

Done. I'll give other people some time to comment before sending the
updated series.

Thierry

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQVDTxAAoJEN0jrNd/PrOhY84P/1V6CjM7bTnYamaHDOKyZQUc
IyLN3mZRN6AbMMO8awcN6B4BDXuB6ua8nN7ozdlqRnFSUgSXVwWwrezZnrpc+Sws
yO4Axr8IOBxpG2IDX+d2bGWRV5W34kzty5WsZhlPEJxOBSQH0MiNJCgTojSIIf5n
9a6+7fF5qsSamGnmtWKwe01nwvlAsJg0i3sxyguWlFuBqd1IyQMCptCWsSBzMQVc
1EeCDtWdLTKzxNHhkl97rWcQYi3ov8LTK76zUutTSDlpc2+HhX0nu73Tz34fLs9m
k4Z1mw2VLHRUorvFCptwhvB72LR2hssTZxGDt3xbPLERUECtV3wwpFTDT8J4jZj0
bzHCpbfj11K1Y7/Ku/1FBWBXjFPh1+YS0lA39V00WnHBx9Xv2DX6Ytm8FwGCtqEN
wfV+VGyR+tvIWI6oA8vIgc/1xuMuDlrK4Ldn2uwZBHZfq28ghCiKFHasHA5RW+D/
kTA2p4Yvuujuvh6PbsvJv2h4A9Sudko6rzwlclnv7OGxsxCa624yF8YN+rqLVU9C
7Sq/vSCmpj1E3AQ9TKcnYyFYP1sUsc9BnslLNEHNly+MFRJoAMOAx3M6s/30vRJp
FKyDyeWTzkjnlCYDiH/ebSQRk1tO9h6HJXnzrAAU55iJYHDxCGQ15I2emj8v/bqT
3iUVzezeZpRhZ0IPIxbq
=Q8MZ
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--
