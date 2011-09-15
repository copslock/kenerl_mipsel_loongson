Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Sep 2011 02:51:18 +0200 (CEST)
Received: from mail-vw0-f51.google.com ([209.85.212.51]:63751 "EHLO
        mail-vw0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491179Ab1IOAvJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 15 Sep 2011 02:51:09 +0200
Received: by vws20 with SMTP id 20so3429448vws.24
        for <multiple recipients>; Wed, 14 Sep 2011 17:51:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.52.177.40 with SMTP id cn8mr418501vdc.468.1316047863388; Wed,
 14 Sep 2011 17:51:03 -0700 (PDT)
Received: by 10.52.101.232 with HTTP; Wed, 14 Sep 2011 17:51:02 -0700 (PDT)
Received: by 10.52.101.232 with HTTP; Wed, 14 Sep 2011 17:51:02 -0700 (PDT)
In-Reply-To: <1314820906-14004-3-git-send-email-david.daney@cavium.com>
References: <1314820906-14004-1-git-send-email-david.daney@cavium.com>
        <1314820906-14004-3-git-send-email-david.daney@cavium.com>
Date:   Wed, 14 Sep 2011 18:51:02 -0600
X-Google-Sender-Auth: w0ZzFTRQLHsC0y9rX-JZs5BSBDw
Message-ID: <CACxGe6tA6D9JVf0_K-JAGnKcQmDmD=1ytqqYb6or-KjP9uZNxg@mail.gmail.com>
Subject: Re: [PATCH 2/3] netdev/of/phy: Add MDIO bus multiplexer support.
From:   Grant Likely <grant.likely@secretlab.ca>
To:     David Daney <david.daney@cavium.com>,
        David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        devicetree-discuss@lists.ozlabs.org, ralf@linux-mips.org
Content-Type: multipart/alternative; boundary=bcaec5016323679bef04acf045b4
X-archive-position: 31086
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: grant.likely@secretlab.ca
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 7518

--bcaec5016323679bef04acf045b4
Content-Type: text/plain; charset=ISO-8859-1

On Aug 31, 2011 2:01 PM, "David Daney" <david.daney@cavium.com> wrote:
>
> This patch adds a somewhat generic framework for MDIO bus
> multiplexers.  It is modeled on the I2C multiplexer.
>
> The multiplexer is needed if there are multiple PHYs with the same
> address connected to the same MDIO bus adepter, or if there is
> insufficient electrical drive capability for all the connected PHY
> devices.
>
> Conceptually it could look something like this:
>
>                   ------------------
>                   | Control Signal |
>                   --------+---------
>                           |
>  ---------------   --------+------
>  | MDIO MASTER |---| Multiplexer |
>  ---------------   --+-------+----
>                     |       |
>                     C       C
>                     h       h
>                     i       i
>                     l       l
>                     d       d
>                     |       |
>     ---------       A       B   ---------
>     |       |       |       |   |       |
>     | PHY@1 +-------+       +---+ PHY@1 |
>     |       |       |       |   |       |
>     ---------       |       |   ---------
>     ---------       |       |   ---------
>     |       |       |       |   |       |
>     | PHY@2 +-------+       +---+ PHY@2 |
>     |       |                   |       |
>     ---------                   ---------
>
> This framework configures the bus topology from device tree data.  The
> mechanics of switching the multiplexer is left to device specific
> drivers.
>
> The follow-on patch contains a multiplexer driven by GPIO lines.
>
> Signed-off-by: David Daney <david.daney@cavium.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: "David S. Miller" <davem@davemloft.net>
> ---
>  Documentation/devicetree/bindings/net/mdio-mux.txt |  132 ++++++++++++++
>  drivers/net/phy/Kconfig                            |    8 +
>  drivers/net/phy/Makefile                           |    1 +
>  drivers/net/phy/mdio-mux.c                         |  182
++++++++++++++++++++
>  include/linux/mdio-mux.h                           |   18 ++
>  5 files changed, 341 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/net/mdio-mux.txt
>  create mode 100644 drivers/net/phy/mdio-mux.c
>  create mode 100644 include/linux/mdio-mux.h
>
> diff --git a/Documentation/devicetree/bindings/net/mdio-mux.txt
b/Documentation/devicetree/bindings/net/mdio-mux.txt
> new file mode 100644
> index 0000000..a908312
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/mdio-mux.txt
> @@ -0,0 +1,132 @@
> +Common MDIO bus multiplexer/switch properties.
> +
> +An MDIO bus multiplexer/switch will have several child busses that are
> +numbered uniquely in a device dependent manner.  The nodes for an MDIO
> +bus multiplexer/switch will have one child node for each child bus.
> +
> +Required properties:
> +- parent-bus : phandle to the parent MDIO bus.

As discussed, I like mdio-parent-bus.

> +
> +Optional properties:
> +- Other properties specific to the multiplexer/switch hardware.
> +
> +Required properties for child nodes:
> +- #address-cells = <1>;
> +- #size-cells = <0>;
> +- cell-index : The sub-bus number.

Use reg, not cell-index. That is what it is there for. And add the
appropriate #address/size-cells in the parent.

I've not reviewed the implementation, but with the changes. I'm okay with
the binding.

g.

--bcaec5016323679bef04acf045b4
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<p><br>
On Aug 31, 2011 2:01 PM, &quot;David Daney&quot; &lt;<a href=3D"mailto:davi=
d.daney@cavium.com">david.daney@cavium.com</a>&gt; wrote:<br>
&gt;<br>
&gt; This patch adds a somewhat generic framework for MDIO bus<br>
&gt; multiplexers. =A0It is modeled on the I2C multiplexer.<br>
&gt;<br>
&gt; The multiplexer is needed if there are multiple PHYs with the same<br>
&gt; address connected to the same MDIO bus adepter, or if there is<br>
&gt; insufficient electrical drive capability for all the connected PHY<br>
&gt; devices.<br>
&gt;<br>
&gt; Conceptually it could look something like this:<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ------------------<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | Control Signal |<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 --------+---------<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |<br>
&gt; =A0--------------- =A0 --------+------<br>
&gt; =A0| MDIO MASTER |---| Multiplexer |<br>
&gt; =A0--------------- =A0 --+-------+----<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A0 =A0 |<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 C =A0 =A0 =A0 C<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 h =A0 =A0 =A0 h<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 i =A0 =A0 =A0 i<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 l =A0 =A0 =A0 l<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 d =A0 =A0 =A0 d<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A0 =A0 |<br>
&gt; =A0 =A0 --------- =A0 =A0 =A0 A =A0 =A0 =A0 B =A0 ---------<br>
&gt; =A0 =A0 | =A0 =A0 =A0 | =A0 =A0 =A0 | =A0 =A0 =A0 | =A0 | =A0 =A0 =A0 =
|<br>
&gt; =A0 =A0 | PHY@1 +-------+ =A0 =A0 =A0 +---+ PHY@1 |<br>
&gt; =A0 =A0 | =A0 =A0 =A0 | =A0 =A0 =A0 | =A0 =A0 =A0 | =A0 | =A0 =A0 =A0 =
|<br>
&gt; =A0 =A0 --------- =A0 =A0 =A0 | =A0 =A0 =A0 | =A0 ---------<br>
&gt; =A0 =A0 --------- =A0 =A0 =A0 | =A0 =A0 =A0 | =A0 ---------<br>
&gt; =A0 =A0 | =A0 =A0 =A0 | =A0 =A0 =A0 | =A0 =A0 =A0 | =A0 | =A0 =A0 =A0 =
|<br>
&gt; =A0 =A0 | PHY@2 +-------+ =A0 =A0 =A0 +---+ PHY@2 |<br>
&gt; =A0 =A0 | =A0 =A0 =A0 | =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A0 =
=A0 |<br>
&gt; =A0 =A0 --------- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ---------<br>
&gt;<br>
&gt; This framework configures the bus topology from device tree data. =A0T=
he<br>
&gt; mechanics of switching the multiplexer is left to device specific<br>
&gt; drivers.<br>
&gt;<br>
&gt; The follow-on patch contains a multiplexer driven by GPIO lines.<br>
&gt;<br>
&gt; Signed-off-by: David Daney &lt;<a href=3D"mailto:david.daney@cavium.co=
m">david.daney@cavium.com</a>&gt;<br>
&gt; Cc: Grant Likely &lt;<a href=3D"mailto:grant.likely@secretlab.ca">gran=
t.likely@secretlab.ca</a>&gt;<br>
&gt; Cc: &quot;David S. Miller&quot; &lt;<a href=3D"mailto:davem@davemloft.=
net">davem@davemloft.net</a>&gt;<br>
&gt; ---<br>
&gt; =A0Documentation/devicetree/bindings/net/mdio-mux.txt | =A0132 +++++++=
+++++++<br>
&gt; =A0drivers/net/phy/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0| =A0 =A08 +<br>
&gt; =A0drivers/net/phy/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 | =A0 =A01 +<br>
&gt; =A0drivers/net/phy/mdio-mux.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 | =A0182 ++++++++++++++++++++<br>
&gt; =A0include/linux/mdio-mux.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 | =A0 18 ++<br>
&gt; =A05 files changed, 341 insertions(+), 0 deletions(-)<br>
&gt; =A0create mode 100644 Documentation/devicetree/bindings/net/mdio-mux.t=
xt<br>
&gt; =A0create mode 100644 drivers/net/phy/mdio-mux.c<br>
&gt; =A0create mode 100644 include/linux/mdio-mux.h<br>
&gt;<br>
&gt; diff --git a/Documentation/devicetree/bindings/net/mdio-mux.txt b/Docu=
mentation/devicetree/bindings/net/mdio-mux.txt<br>
&gt; new file mode 100644<br>
&gt; index 0000000..a908312<br>
&gt; --- /dev/null<br>
&gt; +++ b/Documentation/devicetree/bindings/net/mdio-mux.txt<br>
&gt; @@ -0,0 +1,132 @@<br>
&gt; +Common MDIO bus multiplexer/switch properties.<br>
&gt; +<br>
&gt; +An MDIO bus multiplexer/switch will have several child busses that ar=
e<br>
&gt; +numbered uniquely in a device dependent manner. =A0The nodes for an M=
DIO<br>
&gt; +bus multiplexer/switch will have one child node for each child bus.<b=
r>
&gt; +<br>
&gt; +Required properties:<br>
&gt; +- parent-bus : phandle to the parent MDIO bus.</p>
<p>As discussed, I like mdio-parent-bus.</p>
<p>&gt; +<br>
&gt; +Optional properties:<br>
&gt; +- Other properties specific to the multiplexer/switch hardware.<br>
&gt; +<br>
&gt; +Required properties for child nodes:<br>
&gt; +- #address-cells =3D &lt;1&gt;;<br>
&gt; +- #size-cells =3D &lt;0&gt;;<br>
&gt; +- cell-index : The sub-bus number.</p>
<p>Use reg, not cell-index. That is what it is there for. And add the appro=
priate #address/size-cells in the parent.</p>
<p>I&#39;ve not reviewed the implementation, but with the changes. I&#39;m =
okay with the binding.</p>
<p>g.<br>
</p>

--bcaec5016323679bef04acf045b4--
