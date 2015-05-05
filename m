Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 May 2015 00:47:01 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:21773 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27012470AbbEEWq7F4jY2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 6 May 2015 00:46:59 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id BBCD541F8E5F;
        Tue,  5 May 2015 23:46:55 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.242])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Tue, 05 May 2015 23:46:55 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Tue, 05 May 2015 23:46:55 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 27AF36AE39CD0;
        Tue,  5 May 2015 23:46:51 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 5 May 2015 23:43:53 +0100
Received: from localhost (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Tue, 5 May
 2015 23:43:52 +0100
Date:   Tue, 5 May 2015 23:43:52 +0100
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
Message-ID: <20150505224352.GA18183@jhogan-linux.le.imgtec.org>
References: <1428444258-25852-1-git-send-email-abrestic@chromium.org>
 <1428444258-25852-2-git-send-email-abrestic@chromium.org>
 <20150505220116.GE17687@jhogan-linux.le.imgtec.org>
 <CAL1qeaFacmDaCW6VSp247HZx+RwJKjYTWQhu5qxjH5JE3ET6Nw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="cNdxnHkX5QqsyA0e"
Content-Disposition: inline
In-Reply-To: <CAL1qeaFacmDaCW6VSp247HZx+RwJKjYTWQhu5qxjH5JE3ET6Nw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: b93fcccb
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47245
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

--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 05, 2015 at 03:16:23PM -0700, Andrew Bresticker wrote:
> Hi James,
>=20
> On Tue, May 5, 2015 at 3:01 PM, James Hogan <james.hogan@imgtec.com> wrot=
e:
> > Hi Andrew,
> >
> > On Tue, Apr 07, 2015 at 03:04:16PM -0700, Andrew Bresticker wrote:
> >> Add a binding document for the USB2.0 PHY found on the IMG Pistachio S=
oC.
> >>
> >> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
> >> Cc: Rob Herring <robh+dt@kernel.org>
> >> Cc: Pawel Moll <pawel.moll@arm.com>
> >> Cc: Mark Rutland <mark.rutland@arm.com>
> >> Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
> >> Cc: Kumar Gala <galak@codeaurora.org>
> >> ---
> >> No changes from v1.
> >> ---
> >>  .../devicetree/bindings/phy/pistachio-usb-phy.txt  | 29 +++++++++++++=
+++++++++
> >>  include/dt-bindings/phy/phy-pistachio-usb.h        | 16 ++++++++++++
> >>  2 files changed, 45 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/phy/pistachio-us=
b-phy.txt
> >>  create mode 100644 include/dt-bindings/phy/phy-pistachio-usb.h
> >>
> >> diff --git a/Documentation/devicetree/bindings/phy/pistachio-usb-phy.t=
xt b/Documentation/devicetree/bindings/phy/pistachio-usb-phy.txt
> >> new file mode 100644
> >> index 0000000..afbc7e2
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/phy/pistachio-usb-phy.txt
> >> @@ -0,0 +1,29 @@
> >> +IMG Pistachio USB PHY
> >> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> +
> >> +Required properties:
> >> +--------------------
> >> + - compatible: Must be "img,pistachio-usb-phy".
> >> + - #phy-cells: Must be 0.  See ./phy-bindings.txt for details.
> >> + - clocks: Must contain an entry for each entry in clock-names.
> >> +   See ../clock/clock-bindings.txt for details.
> >> + - clock-names: Must include "usb_phy".
> >> + - img,cr-top: Must constain a phandle to the CR_TOP syscon node.
> >> + - img,refclk: Indicates the reference clock source for the USB PHY.
> >> +   See <dt-bindings/phy/phy-pistachio-usb.h> for a list of valid valu=
es.
> >
> > Possibly dumb question: why isn't the reference clock source specified
> > in the normal ways like the "usb_phy" clock is?
> >
> > Does the value required here depend on what usb_phy clock gets muxed
> > from or something?
>=20
> Right, the value indicates what clock "usb_phy" is: whether it comes
> from the core clock controller, the XO crystal, or is some external
> clock.  It's a mux internal to the PHY.

Okay. If its a software controllable mux, is there a particular reason
the DT doesn't describe it as such, i.e. have all 3 clock inputs, and
the driver somehow work out which to use?

Cheers
James

--cNdxnHkX5QqsyA0e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVSUeoAAoJEGwLaZPeOHZ6ocsP/iNuBvivgZwJD+T0nymJ/ihN
PPYqHXefGdnvpUISrorcu3ng8G8E6EzfNxEEMDNjsA2FgTMKS7L5aEoA7Tm4srrk
v21l84CtGw5lEA1EMNcqaHm1EgBlshe8Ldn7QkqKJnstrBLhwSopaOsq8pSC3wlg
CtIEAoN/WKBTpoTKDYOiLjMKToG2hHulJzjhQK5E9Cfx2lLDOeemxPCWUM7ApmQ2
fsVl5NW3jmGFTWdWTb0RuQCJ1uu2gRsy6tJq8NGp+hUaxSMnT+AjCzcqygpUkN6e
+pk6qijnzju2xlUOVcgVeaFClh5RZCPLDp9BCNYN3BBtMj8gN/IHKvOaz5g+ZYwd
WnwIa+Ss3n+vZk0+f/fLRwxwpNkoJINPQ3LcYWYPCluWXtQPn3yYu9Sshcc+x1nO
LmuSt/vmc0u8fIKT+/zH4e/a181P373pGBneiJVxzFe/IXrAXOF6xJ66vGmQe7Dv
zGvolYaFjKfJ+3UpFay9pjmReSOdAurmCBmhiip2gaAJsSIsyowQlUp69m0/SyGT
ZUnAkkBwJh0lBxT/BJRndusu+XQvKQEiYYFUnA8WB/n5f5GNb4g2ux74YjVp+GIi
/BWrv0O0n5qbEkzn73PPnHK1hApyZRw5U5O7fJl3GTN8hTO7vC6f7o9OdYfZg/b/
3dLkbEOJt/xF4CQEFX8b
=q+qw
-----END PGP SIGNATURE-----

--cNdxnHkX5QqsyA0e--
