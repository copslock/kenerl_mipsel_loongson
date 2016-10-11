Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Oct 2016 23:16:13 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:2269 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23991344AbcJKVQExE393 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 11 Oct 2016 23:16:04 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 2B76941F8E9C;
        Tue, 11 Oct 2016 22:15:46 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.44.0.242])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Tue, 11 Oct 2016 22:15:46 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Tue, 11 Oct 2016 22:15:46 +0100
Received: from HHMAIL03.hh.imgtec.org (unknown [10.44.0.21])
        by Forcepoint Email with ESMTPS id DFD34AF577BF3;
        Tue, 11 Oct 2016 22:15:54 +0100 (IST)
Received: from HHMAIL01.hh.imgtec.org (10.100.10.19) by HHMAIL03.hh.imgtec.org
 (10.44.0.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Tue, 11 Oct 2016
 22:15:58 +0100
Received: from np-p-burton.localnet (10.100.200.73) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Tue, 11 Oct
 2016 22:15:58 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     Rob Herring <robh@kernel.org>
CC:     Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "Stephen Boyd" <sboyd@codeaurora.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 16/18] dt-bindings: Document img,boston-clock binding
Date:   Tue, 11 Oct 2016 22:15:45 +0100
Message-ID: <2330857.F1IQS18Qic@np-p-burton>
Organization: Imagination Technologies
User-Agent: KMail/5.3.1 (Linux/4.7.6-1-ARCH; KDE/5.26.0; x86_64; ; )
In-Reply-To: <CAL_Jsq+PkQmkkLMjiurmHegewpc6n_ntUMsik8oMZdM2nXHQ6g@mail.gmail.com>
References: <20161005171824.18014-1-paul.burton@imgtec.com> <2468748.fALFhzhDcI@np-p-burton> <CAL_Jsq+PkQmkkLMjiurmHegewpc6n_ntUMsik8oMZdM2nXHQ6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1681193.t5WapgXVv7";
        micalg=pgp-sha256; protocol="application/pgp-signature"
X-Originating-IP: [10.100.200.73]
X-ESG-ENCRYPT-TAG: 1cc78754
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55392
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

--nextPart1681193.t5WapgXVv7
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, 11 October 2016 15:06:46 BST Rob Herring wrote:
> On Tue, Oct 11, 2016 at 11:00 AM, Paul Burton <paul.burton@imgtec.com> 
wrote:
> > On Monday, 10 October 2016 08:01:21 BST Rob Herring wrote:
> >> On Wed, Oct 05, 2016 at 06:18:22PM +0100, Paul Burton wrote:
> >> > Add device tree binding documentation for the clocks provided by the
> >> > MIPS Boston development board from Imagination Technologies, and a
> >> > header file describing the available clocks for use by device trees &
> >> > driver.
> >> > 
> >> > Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> >> > Cc: Michael Turquette <mturquette@baylibre.com>
> >> > Cc: Stephen Boyd <sboyd@codeaurora.org>
> >> > Cc: linux-clk@vger.kernel.org
> >> > Cc: Rob Herring <robh+dt@kernel.org>
> >> > Cc: Mark Rutland <mark.rutland@arm.com>
> >> > Cc: devicetree@vger.kernel.org
> >> > 
> >> > ---
> >> > 
> >> > Changes in v3: None
> >> > Changes in v2:
> >> > - Add BOSTON_CLK_INPUT to expose the input clock.
> >> > 
> >> >  .../devicetree/bindings/clock/img,boston-clock.txt | 27
> >> >  ++++++++++++++++++++++ include/dt-bindings/clock/boston-clock.h
> >> >  
> >> >   | 14 +++++++++++ 2 files changed, 41 insertions(+)
> >> >  
> >> >  create mode 100644
> >> >  Documentation/devicetree/bindings/clock/img,boston-clock.txt create
> >> >  mode
> >> >  100644 include/dt-bindings/clock/boston-clock.h
> >> > 
> >> > diff --git
> >> > a/Documentation/devicetree/bindings/clock/img,boston-clock.txt
> >> > b/Documentation/devicetree/bindings/clock/img,boston-clock.txt new file
> >> > mode 100644
> >> > index 0000000..c01ea60
> >> > --- /dev/null
> >> > +++ b/Documentation/devicetree/bindings/clock/img,boston-clock.txt
> >> > @@ -0,0 +1,27 @@
> >> > +Binding for Imagination Technologies MIPS Boston clock sources.
> >> > +
> >> > +This binding uses the common clock binding[1].
> >> > +
> >> > +[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
> >> > +
> >> > +Required properties:
> >> > +- compatible : Should be "img,boston-clock".
> >> > +- #clock-cells : Should be set to 1.
> >> > +  Values available for clock consumers can be found in the header
> >> > file:
> >> > +    <dt-bindings/clock/boston-clock.h>
> >> > +- regmap : Phandle to the Boston platform register system controller.
> >> > +  This should contain a phandle to the system controller node covering
> >> > the
> >> > +  platform registers provided by the Boston board.
> >> 
> >> Can you just make the clock node a child of the system controller and
> >> drop this?
> >> 
> >> Rob
> > 
> > Hi Rob,
> > 
> > (Apologies to anyone who received my last; my mail client seems to be
> > misconfigured & previously sent HTML mail.)
> > 
> > As I mentioned before technically that could be done, but it would really
> > not be at all reflective of the hardware & so seems somewhat contrary to
> > the purpose of a device tree.
> 
> Given that you need a reference back to the system controller, it does
> match the h/w. The system controller h/w contains various functions,
> therefore the system controller node should contain nodes for those
> functions (or the sys ctrlr itself could be the clock provider node
> with no child nodes). Otherwise, what is the parent of the clock node?
> Root? Root should generally be the top level devices of the SoC,
> though it gets used for things which have no good parent.
> 
> Rob

Hi Rob,

The "system controller" here is a bunch of registers which contain information 
about the system - nothing more & nothing less. There are a few random bits of 
functionality such as system level reset exposed through them, but things like 
clocks are not part of some coherent block of hardware known as the system 
controller. The register exposing information about the clocks has no actual 
connection to the clocks at all - it's just a dumb register whose value is 
filled in by whomever generates the FPGA bitfile. I don't see how that can be 
reasonably seen as the clocks being a child of this ecclectic bunch of 
registers.

Perhaps the use of syscon has been misleading here? I'm using the syscon code 
purely as a nice way to obtain a regmap to that bunch of registers. Please 
believe me when I say I know this hardware well enough to know that there 
isn't a coherent block of system controller hardware that provides the clocks 
here.

Thanks,
    Paul
--nextPart1681193.t5WapgXVv7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJX/VaBAAoJEIIg2fppPBxlbjUP/jt9jAVkOgzQuXBd6B3l4jHM
sseuupUm8bc+oR28dQpaHTinZKfLMV+KtnY638Aj/0D9We96R0j5ZiVcisIjTchP
JuvIojL9mW5X9FNNWSr0UlmMB/XJFYr7z26nuxmB7JUw4iEdh5ji/hLDhXmAsfi8
7mkt4NBlxCBuiJe9WJtAPFZxR7RSCvvotUGAcXAm3Ep2ZiL6WWw3CqRSWc+LXwPH
mVyGtfNsVP0EXB1rlc3Q5pxibb5CFCD5r35ghp6z6UrEa0Ze8w/j4PvHhcsMvX7l
11CyFkckfC7DcjfKXJRzhAdZY6PfgffJcXrcAEQ64vacHvF0cwuxG8lIZtSGJUl6
MW2G6A3gnwr9rhb5nQ7okPpWXm1lcZPuIrCGBWz156P9v1hJc5TF1xR0SJreHK2Q
ZXHFqTi0LZ6cV+1fz6byill2Xor6+CUHO+vOnmAtRe7n5/0SjlH/aRSWMZGi1iav
1HfNXDmgUa9jdeIBQ5HfvrcXgU8foawg4v4RwjULnijkG2oRYCqAVGdeindchMYc
wz64lAFYNx1vTT3woe+74f9KXXmfdA3hliNjHQiox+N+0S+z9LFEs/mUdDfcHvE8
lHOXpzwUKHQbzOF+VoUaKdwZAbdtlvz6hz3VaudmndJ7AEgG/XVqoFoJ3rsWioYY
7WJZ7OnLZ4banxhEsX11
=7AlU
-----END PGP SIGNATURE-----

--nextPart1681193.t5WapgXVv7--
