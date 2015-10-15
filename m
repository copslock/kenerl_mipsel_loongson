Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Oct 2015 09:45:41 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:19154 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27007991AbbJOHpiC7PKt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 15 Oct 2015 09:45:38 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 22C2C41F8E32;
        Thu, 15 Oct 2015 08:45:31 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.242])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Thu, 15 Oct 2015 08:45:31 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Thu, 15 Oct 2015 08:45:31 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 70815F1B4B437;
        Thu, 15 Oct 2015 08:45:29 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 15 Oct 2015 08:45:30 +0100
Received: from localhost (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Thu, 15 Oct
 2015 08:45:30 +0100
Date:   Thu, 15 Oct 2015 08:45:30 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
CC:     <ralf@linux-mips.org>, <robh+dt@kernel.org>,
        <linus.walleij@linaro.org>, <linux-mips@linux-mips.org>,
        <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/5] MIPS: dt: xilfpga: Add xilfpga device tree files.
Message-ID: <20151015074530.GD14475@jhogan-linux.le.imgtec.org>
References: <1444827117-10939-1-git-send-email-Zubair.Kakakhel@imgtec.com>
 <1444827117-10939-4-git-send-email-Zubair.Kakakhel@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="iVCmgExH7+hIHJ1A"
Content-Disposition: inline
In-Reply-To: <1444827117-10939-4-git-send-email-Zubair.Kakakhel@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: e4aa9c8
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49557
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

--iVCmgExH7+hIHJ1A
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2015 at 01:51:55PM +0100, Zubair Lutfullah Kakakhel wrote:
> Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>

Any chance of a little more explanation, other than the subject line?

> ---
>  arch/mips/boot/dts/Makefile                |  1 +
>  arch/mips/boot/dts/xilfpga/Makefile        |  9 ++++++
>  arch/mips/boot/dts/xilfpga/microAptiv.dtsi | 21 +++++++++++++
>  arch/mips/boot/dts/xilfpga/nexys4ddr.dts   | 47 ++++++++++++++++++++++++=
++++++
>  4 files changed, 78 insertions(+)
>  create mode 100644 arch/mips/boot/dts/xilfpga/Makefile
>  create mode 100644 arch/mips/boot/dts/xilfpga/microAptiv.dtsi
>  create mode 100644 arch/mips/boot/dts/xilfpga/nexys4ddr.dts
>=20
> diff --git a/arch/mips/boot/dts/Makefile b/arch/mips/boot/dts/Makefile
> index 778a340..0571ef7 100644
> --- a/arch/mips/boot/dts/Makefile
> +++ b/arch/mips/boot/dts/Makefile
> @@ -6,6 +6,7 @@ dts-dirs	+=3D mti
>  dts-dirs	+=3D netlogic
>  dts-dirs	+=3D qca
>  dts-dirs	+=3D ralink
> +dts-dirs	+=3D xilfpga
> =20
>  obj-y		:=3D $(addsuffix /, $(dts-dirs))
> =20
> diff --git a/arch/mips/boot/dts/xilfpga/Makefile b/arch/mips/boot/dts/xil=
fpga/Makefile
> new file mode 100644
> index 0000000..913a752
> --- /dev/null
> +++ b/arch/mips/boot/dts/xilfpga/Makefile
> @@ -0,0 +1,9 @@
> +dtb-$(CONFIG_XILFPGA_NEXYS4DDR)	+=3D nexys4ddr.dtb
> +
> +obj-y				+=3D $(patsubst %.dtb, %.dtb.o, $(dtb-y))
> +
> +# Force kbuild to make empty built-in.o if necessary
> +obj-				+=3D dummy.o
> +
> +always				:=3D $(dtb-y)
> +clean-files	:=3D *.dtb *.dtb.S
> diff --git a/arch/mips/boot/dts/xilfpga/microAptiv.dtsi b/arch/mips/boot/=
dts/xilfpga/microAptiv.dtsi
> new file mode 100644
> index 0000000..81d518e
> --- /dev/null
> +++ b/arch/mips/boot/dts/xilfpga/microAptiv.dtsi
> @@ -0,0 +1,21 @@
> +/ {
> +	#address-cells =3D <1>;
> +	#size-cells =3D <1>;
> +	compatible =3D "img,xilfpga";
> +
> +	cpus {
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +		cpu@0 {
> +			device_type =3D "cpu";
> +			compatible =3D "mips,m14Kc";
> +			clocks	=3D <&ext>;
> +			reg =3D <0>;
> +		};
> +	};
> +
> +	ext: ext {
> +		compatible =3D "fixed-clock";
> +		#clock-cells =3D <0>;
> +	};
> +};
> diff --git a/arch/mips/boot/dts/xilfpga/nexys4ddr.dts b/arch/mips/boot/dt=
s/xilfpga/nexys4ddr.dts
> new file mode 100644
> index 0000000..e225ae7
> --- /dev/null
> +++ b/arch/mips/boot/dts/xilfpga/nexys4ddr.dts
> @@ -0,0 +1,47 @@
> +/dts-v1/;
> +
> +#include "microAptiv.dtsi"
> +
> +/ {
> +	compatible =3D "img,xilfpga";

You can have more than one compatible string, separated by commas. Does
it make sense to have one that describes the specific system first
(nexys4ddr??) in addition to the generic xilfpga one? That way software
can still distinguish if it becomes necessary.

> +
> +	memory {
> +		device_type =3D "memory";
> +		reg =3D <0x0 0x07ffffff>;

I think the second cell is size, not end address, so it should
presumably be 0x08000000?

> +	};
> +
> +	cpuintc: interrupt-controller@0 {
> +		#address-cells =3D <0>;
> +		#interrupt-cells =3D <1>;
> +		interrupt-controller;
> +		compatible =3D "mti,cpu-interrupt-controller";
> +	};
> +
> +	axi_gpio: gpio@10600000 {
> +		#gpio-cells =3D <1>;
> +		compatible =3D "xlnx,xps-gpio-1.00.a";
> +		gpio-controller;
> +		reg =3D < 0x10600000 0x10000 >;

Inconsistent whitespace between < > compared to other properties.

> +		xlnx,all-inputs =3D <0x0>;
> +		xlnx,dout-default =3D <0x0>;
> +		xlnx,gpio-width =3D <0x16>;
> +		xlnx,interrupt-present =3D <0x0>;
> +		xlnx,is-dual =3D <0x0>;
> +		xlnx,tri-default =3D <0xffffffff>;
> +	} ;
> +
> +	axi_uart16550: serial@10400000 {
> +		compatible =3D "ns16550a";
> +		reg =3D <0x10400000 0x10000>;
> +
> +		reg-shift =3D <2>;
> +		reg-offset =3D <0x1000>;
> +
> +		clock-frequency =3D <50000000>;

I guess the binding for that device already exists, but is it worth
extending it to take a clock node reference instead of a hardcoded
frequency (I'm guessing ext by the frequency and choice of clocks)?

> +		status =3D "okay";

I don't think you normally need that unless you describe e.g. SoC
peripheral hardware that might not be brought out by the board, in which
case you'd say its disabled in the SoC dtsi file, but enable it at the
board level, which doesn't seem to be happening here.

Cheers
James

> +	};
> +};
> +
> +&ext {
> +	clock-frequency =3D <50000000>;
> +};
> --=20
> 1.9.1
>=20
>=20

--iVCmgExH7+hIHJ1A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWH1maAAoJEGwLaZPeOHZ6uOcQALnH8TsBKviQ5qZ2ZlE/In/w
J7pSjNI3oki5bfa+JKWVRgCtQgwEK8LfmLavTKZbtI9x2dG/qzziBiFlK2n2qW8H
lkH9uQFb9pv/lLQVrGcptoJoKwCsBtal9ub8PXyHN+huwnrewbrAHEFLowrS//k8
Jl3mUp/Tbr+EjhwQ0PaN1DFXvH28Vcl0N+aRJ7PAbMDN1jR+JOFBpuU4T6XsXEg3
/Y5lIH6UM9+lyJQ7JvgxMqApkPjUX0INZMpgmXvbebDoVY0HYUpQg1iOBmD2DJUL
ljY+rtqWNBpwjEuVb/e9iZtYH52acIXPIXcZnHuYy/Sa2yVh0WhB+5fmyKUJCH4E
dQfvzop+vfnMXHwU+ubz5ESr8hezvnTOyPF365TyDscWFvWxGpjoduS2gMXk8f2G
xXLpddwjY5buvZ6/IMoTLqi+rqTK6wP7ATW9HBi2TJnQ0vChAlTz/hFmUMB0I7xK
BV9lraqekIIZkORiiXM5ir/DcKwDGZWT5cgkfxfMB1arEqEpe3DGmfaSbzL+rvJ4
15gl3OxRK7iFBMHgDOl2XgkgsppYDirJblEV3GZuRybnoDtXoG/tElJO+d5PBxRB
b7rsZP792d2ZFGIOwlS64JMN9IdLKw7ishcY5km9LOxg7beKIGuPBo6NPhwjB2se
oxRYHFBWACSPXzPw14gZ
=weQU
-----END PGP SIGNATURE-----

--iVCmgExH7+hIHJ1A--
