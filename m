Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 May 2015 10:26:52 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:62729 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27010556AbbEFI0uPeKTw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 6 May 2015 10:26:50 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 7408A41F8DFD;
        Wed,  6 May 2015 09:26:46 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.242])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Wed, 06 May 2015 09:26:46 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Wed, 06 May 2015 09:26:46 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id EC8BFEC7B59C9;
        Wed,  6 May 2015 09:26:44 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 6 May 2015 09:25:44 +0100
Received: from localhost (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Wed, 6 May
 2015 09:25:43 +0100
Date:   Wed, 6 May 2015 09:25:43 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Andrew Bresticker <abrestic@chromium.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        James Hartley <james.hartley@imgtec.com>,
        Damien Horsley <Damien.Horsley@imgtec.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Ian Campbell" <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>
Subject: Re: [PATCH V2 1/3] phy: Add binding document for Pistachio USB2.0 PHY
Message-ID: <20150506082543.GC18183@jhogan-linux.le.imgtec.org>
References: <1428444258-25852-1-git-send-email-abrestic@chromium.org>
 <1428444258-25852-2-git-send-email-abrestic@chromium.org>
 <20150505220116.GE17687@jhogan-linux.le.imgtec.org>
 <CAL1qeaFacmDaCW6VSp247HZx+RwJKjYTWQhu5qxjH5JE3ET6Nw@mail.gmail.com>
 <20150505224352.GA18183@jhogan-linux.le.imgtec.org>
 <CAL1qeaG=O7LYo6RRxEMZw2da=eKAp0Dd+LxhBX32TojyBkr=xA@mail.gmail.com>
 <20150505233534.GB18183@jhogan-linux.le.imgtec.org>
 <CAL1qeaE9O3RBNVv9DrZZRu6sebkK2GOnbv6hWQsUR5MHKMcGgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="qtZFehHsKgwS5rPz"
Content-Disposition: inline
In-Reply-To: <CAL1qeaE9O3RBNVv9DrZZRu6sebkK2GOnbv6hWQsUR5MHKMcGgA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: b93fcccb
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47252
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

--qtZFehHsKgwS5rPz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 05, 2015 at 06:06:08PM -0700, Andrew Bresticker wrote:
> On Tue, May 5, 2015 at 4:35 PM, James Hogan <james.hogan@imgtec.com> wrot=
e:
> > On Tue, May 05, 2015 at 04:09:31PM -0700, Andrew Bresticker wrote:
> >> On Tue, May 5, 2015 at 3:43 PM, James Hogan <james.hogan@imgtec.com> w=
rote:
> >> > On Tue, May 05, 2015 at 03:16:23PM -0700, Andrew Bresticker wrote:
> >> >> Hi James,
> >> >>
> >> >> On Tue, May 5, 2015 at 3:01 PM, James Hogan <james.hogan@imgtec.com=
> wrote:
> >> >> > Hi Andrew,
> >> >> >
> >> >> > On Tue, Apr 07, 2015 at 03:04:16PM -0700, Andrew Bresticker wrote:
> >> >> >> Add a binding document for the USB2.0 PHY found on the IMG Pista=
chio SoC.
> >> >> >>
> >> >> >> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
> >> >> >> Cc: Rob Herring <robh+dt@kernel.org>
> >> >> >> Cc: Pawel Moll <pawel.moll@arm.com>
> >> >> >> Cc: Mark Rutland <mark.rutland@arm.com>
> >> >> >> Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
> >> >> >> Cc: Kumar Gala <galak@codeaurora.org>
> >> >> >> ---
> >> >> >> No changes from v1.
> >> >> >> ---
> >> >> >>  .../devicetree/bindings/phy/pistachio-usb-phy.txt  | 29 +++++++=
+++++++++++++++
> >> >> >>  include/dt-bindings/phy/phy-pistachio-usb.h        | 16 +++++++=
+++++
> >> >> >>  2 files changed, 45 insertions(+)
> >> >> >>  create mode 100644 Documentation/devicetree/bindings/phy/pistac=
hio-usb-phy.txt
> >> >> >>  create mode 100644 include/dt-bindings/phy/phy-pistachio-usb.h
> >> >> >>
> >> >> >> diff --git a/Documentation/devicetree/bindings/phy/pistachio-usb=
-phy.txt b/Documentation/devicetree/bindings/phy/pistachio-usb-phy.txt
> >> >> >> new file mode 100644
> >> >> >> index 0000000..afbc7e2
> >> >> >> --- /dev/null
> >> >> >> +++ b/Documentation/devicetree/bindings/phy/pistachio-usb-phy.txt
> >> >> >> @@ -0,0 +1,29 @@
> >> >> >> +IMG Pistachio USB PHY
> >> >> >> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> >> >> +
> >> >> >> +Required properties:
> >> >> >> +--------------------
> >> >> >> + - compatible: Must be "img,pistachio-usb-phy".
> >> >> >> + - #phy-cells: Must be 0.  See ./phy-bindings.txt for details.
> >> >> >> + - clocks: Must contain an entry for each entry in clock-names.
> >> >> >> +   See ../clock/clock-bindings.txt for details.
> >> >> >> + - clock-names: Must include "usb_phy".
> >> >> >> + - img,cr-top: Must constain a phandle to the CR_TOP syscon nod=
e.
> >> >> >> + - img,refclk: Indicates the reference clock source for the USB=
 PHY.
> >> >> >> +   See <dt-bindings/phy/phy-pistachio-usb.h> for a list of vali=
d values.
> >> >> >
> >> >> > Possibly dumb question: why isn't the reference clock source spec=
ified
> >> >> > in the normal ways like the "usb_phy" clock is?
> >> >> >
> >> >> > Does the value required here depend on what usb_phy clock gets mu=
xed
> >> >> > from or something?
> >> >>
> >> >> Right, the value indicates what clock "usb_phy" is: whether it comes
> >> >> from the core clock controller, the XO crystal, or is some external
> >> >> clock.  It's a mux internal to the PHY.
> >> >
> >> > Okay. If its a software controllable mux, is there a particular reas=
on
> >> > the DT doesn't describe it as such, i.e. have all 3 clock inputs, and
> >> > the driver somehow work out which to use?
> >>
> >> Well, I'm not sure how the driver would determine which clock to use
> >> without a device-tree property like the one I've got here :).  Also,
> >
> > Does it make sense to just look for the "best" usable source clock based
> > on the supported rates listed in fsel_rate_map[] (for some definition of
> > "best" such as "fastest" / "slowest" / "first usable"), or are things
> > just not that simple?
> >
> > I'm just wondering how the DT writer would decide, since it seems to
> > come down to a policy decision rather than a description of the
> > hardware, which should probably be avoided in DT bindings if possible.
>=20
> Ah, sorry if that was unclear - this *is* describing a hardware
> property.  The DT author would pick a value by looking at which clock
> is connected to the PHY in the schematic.

Okay cool. Sorry for the noise.

Thanks
James

--qtZFehHsKgwS5rPz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVSdAHAAoJEGwLaZPeOHZ6xxwP/jKHty710vHJJYfovVyvvMOB
mFHIOLYOwbOh2H532NnbBUBKVmsxwfXRfLCdl3mWb+phoodwzA0A9a0pALj3O4iH
Uc/HTTV7HOI3d5SFkioOeHNzue1DDnAWnMsEJFsdebdpjz/RC8TZFMI5GnD3bgi9
OmhHgpOLzr03X0Xi/D3cQtpB0VpZIaXRM12gbKn3yrzM8gZP2Rk8jY2xUQz15B9j
W0Q0FUxNRhg3JZlhI+5XilJw7b+Php6X8BHlYF/0yumRFL3oi0h6/FpEROXzeTqN
8lQlX8w37OiHyDl9rV+h+pqXc0X9kGeKMBCSgZsy2RBlXCKpOWXxgAKv1KIizUPz
EhlbdAzBQ6F2OEFudN/dQSxvWO99c0Ot1o7Vk/eOJvKO+yWp9qbS1oNYEdLy85+Q
lNrMdnNGQy4G219Ort5pOy9OU0OgK/oLYJ9QpKXW9Xq5sK2UKvZZpxhGEZv908Ry
xWDWeQM7aNxgWxifxkwhK10S6ZDkjnoUL31yQQIlBb3Ef2c+j9/WMhl+g72ACsGM
9r49fdsdeEtGOb8g4ymIQp3j/pOLDj1gyMGhI0jzn4po0c6dlAP8qTWTnDCGDzoo
18dS0m9eKo/pTcj0qeOD+X0l9RUTTlEB8dSQs2Apq2r0haoWaj58CkMQv19FueU4
qCpcmnlWAWcg3zn3ZuM7
=LHaj
-----END PGP SIGNATURE-----

--qtZFehHsKgwS5rPz--
