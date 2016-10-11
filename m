Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Oct 2016 18:01:02 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:42480 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23992170AbcJKQAvTaDYA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 11 Oct 2016 18:00:51 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 2A46341F8E9C;
        Tue, 11 Oct 2016 17:00:33 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.44.0.242])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Tue, 11 Oct 2016 17:00:33 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Tue, 11 Oct 2016 17:00:33 +0100
Received: from HHMAIL03.hh.imgtec.org (unknown [10.44.0.21])
        by Forcepoint Email with ESMTPS id 457C677A38243;
        Tue, 11 Oct 2016 17:00:42 +0100 (IST)
Received: from HHMAIL01.hh.imgtec.org (10.100.10.19) by HHMAIL03.hh.imgtec.org
 (10.44.0.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Tue, 11 Oct 2016
 17:00:45 +0100
Received: from np-p-burton.localnet (10.100.200.1) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Tue, 11 Oct
 2016 17:00:45 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     Rob Herring <robh@kernel.org>
CC:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        <linux-clk@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 16/18] dt-bindings: Document img,boston-clock binding
Date:   Tue, 11 Oct 2016 17:00:44 +0100
Message-ID: <2468748.fALFhzhDcI@np-p-burton>
Organization: Imagination Technologies
User-Agent: KMail/5.3.1 (Linux/4.7.6-1-ARCH; KDE/5.26.0; x86_64; ; )
In-Reply-To: <20161010130121.GA31827@rob-hp-laptop>
References: <20161005171824.18014-1-paul.burton@imgtec.com> <20161005171824.18014-17-paul.burton@imgtec.com> <20161010130121.GA31827@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1510261.TKAFVGyAAe";
        micalg=pgp-sha256; protocol="application/pgp-signature"
X-Originating-IP: [10.100.200.1]
X-ESG-ENCRYPT-TAG: 1cc78754
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55390
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

--nextPart1510261.TKAFVGyAAe
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, 10 October 2016 08:01:21 BST Rob Herring wrote:
> On Wed, Oct 05, 2016 at 06:18:22PM +0100, Paul Burton wrote:
> > Add device tree binding documentation for the clocks provided by the
> > MIPS Boston development board from Imagination Technologies, and a
> > header file describing the available clocks for use by device trees &
> > driver.
> > 
> > Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> > Cc: Michael Turquette <mturquette@baylibre.com>
> > Cc: Stephen Boyd <sboyd@codeaurora.org>
> > Cc: linux-clk@vger.kernel.org
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: devicetree@vger.kernel.org
> > 
> > ---
> > 
> > Changes in v3: None
> > Changes in v2:
> > - Add BOSTON_CLK_INPUT to expose the input clock.
> > 
> >  .../devicetree/bindings/clock/img,boston-clock.txt | 27
> >  ++++++++++++++++++++++ include/dt-bindings/clock/boston-clock.h         
> >   | 14 +++++++++++ 2 files changed, 41 insertions(+)
> >  create mode 100644
> >  Documentation/devicetree/bindings/clock/img,boston-clock.txt create mode
> >  100644 include/dt-bindings/clock/boston-clock.h
> > 
> > diff --git a/Documentation/devicetree/bindings/clock/img,boston-clock.txt
> > b/Documentation/devicetree/bindings/clock/img,boston-clock.txt new file
> > mode 100644
> > index 0000000..c01ea60
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/clock/img,boston-clock.txt
> > @@ -0,0 +1,27 @@
> > +Binding for Imagination Technologies MIPS Boston clock sources.
> > +
> > +This binding uses the common clock binding[1].
> > +
> > +[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
> > +
> > +Required properties:
> > +- compatible : Should be "img,boston-clock".
> > +- #clock-cells : Should be set to 1.
> > +  Values available for clock consumers can be found in the header file:
> > +    <dt-bindings/clock/boston-clock.h>
> > +- regmap : Phandle to the Boston platform register system controller.
> > +  This should contain a phandle to the system controller node covering
> > the
> > +  platform registers provided by the Boston board.
> 
> Can you just make the clock node a child of the system controller and
> drop this?
> 
> Rob

Hi Rob,
 
(Apologies to anyone who received my last; my mail client seems to be 
misconfigured & previously sent HTML mail.)

As I mentioned before technically that could be done, but it would really not 
be at all reflective of the hardware & so seems somewhat contrary to the 
purpose of a device tree.
 
Thanks,
    Paul
--nextPart1510261.TKAFVGyAAe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJX/QysAAoJEIIg2fppPBxl8D8P/jZEbGy4OwrZEmOTXP+Der/O
n0oNrjzD6VkgKOAc4lIZNjRPgHxUXb/qFdL6ObfOnVYxmlfs+KrvzZoO6YbleaG2
Oq3qMqvJsV+VKxPqB2HKVRM/S9pN+GpXdp553oRkPUJwCFJrrTuuW9YHE6c6gegm
O57H2nG/M6KF4mXfQj9sN/H1fU14kwwfEgTRovPZg6m2imLS8yd1behdAY9nRlZj
tanMDIEZlWnrdP61ZAfVAsa/V+ussaJWc40miqHyDEGprLHZ4n9PrwJeMdrJ1SOa
aaFv8Qpk+UiY9Ia+7wL2K9Gdn1aCmbfqcoXZWTQ1hZi1SPTuLYGrXw8FmGnxh5FW
X1SKtW458oP5uW6aQX+r5ixqzoCF6/eUgjH/8BAa60q9nDdA1MlYDk1SfmxnQ+/0
0H5gj+7bR9RoLkGthxCYQuRBncxO3zTL4f6EcNNdjpPiGIVju3BWe2MNTqycf+HO
Acpr5gOAyiK7xDxkRBU4kzL3HxUJuC0VyC61FljgSh1ZAUcKRp8BeULY6W4+haxF
P2UCRXv0bX0l5OEr0YGaOB+yMyEc4JxyxkrCeRNK6iMFR7vDY16Ng+UhHNa1bpog
C1QxPNrkaqSlYAZzF/Q9FnNhCZS1a17z9SszCVO2yAm2w2CZ1MHUK3ib90wWrTkX
10x2FoSR4zN6GDY6AlC/
=Oluv
-----END PGP SIGNATURE-----

--nextPart1510261.TKAFVGyAAe--
