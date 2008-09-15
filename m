Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Sep 2008 20:39:07 +0100 (BST)
Received: from mx1.razamicroelectronics.com ([63.111.213.197]:1635 "EHLO
	hq-ex-mb01.razamicroelectronics.com") by ftp.linux-mips.org with ESMTP
	id S62086341AbYIOTjB (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 15 Sep 2008 20:39:01 +0100
X-MimeOLE: Produced By Microsoft Exchange V6.5
Received:  from 10.8.0.19 ([10.8.0.19]) by hq-ex-mb01.razamicroelectronics.com ([10.1.1.40]) via Exchange Front-End Server webmail.razamicroelectronics.com ([10.1.1.41]) with Microsoft Exchange Server HTTP-DAV ; Mon, 15 Sep 2008 19:26:27 +0000
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C91768.F2EF7E62"
Received:  from kh-d820-ubuntu by webmail.razamicroelectronics.com; 15 Sep 2008 14:26:28 -0500
X-Mailer: Evolution 2.22.3.1 
Content-class: urn:content-classes:message
Subject: Re: [PATCH] Au1200 USB Device Controller and device-only OTG
Date:	Mon, 15 Sep 2008 12:26:28 -0700
Message-ID: <1221506788.6680.11.camel@kh-d820-ubuntu.razamicroelectronics.com>
In-Reply-To: <200809151216.02148.david-b@pacbell.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] Au1200 USB Device Controller and device-only OTG
Thread-Index: AckXaPLvFtNs594gSmKEd69DNZHVvg==
References: <> <1221155967-25502-1-git-send-email-khickey@rmicorp.com> <200809151216.02148.david-b@pacbell.net>
From:	"Kevin Hickey" <khickey@rmicorp.com>
To:	"David Brownell" <david-b@pacbell.net>
Cc:	<linux-mips@linux-mips.org>, <ralf@linux-mips.org>,
	<linux-usb@vger.kernel.org>, <mano@roarinelk.homelinux.net>
Return-Path: <khickey@rmicorp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20496
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: khickey@rmicorp.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

------_=_NextPart_001_01C91768.F2EF7E62
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Mon, 2008-09-15 at 12:16 -0700, David Brownell wrote:
> On Thursday 11 September 2008, Kevin Hickey wrote:
> > basic device-only OTG (On-The-Go) support
>=20
> That does't look like it's done right.  For starters, it abuses
> Kconfig to handle a board-specific config option.  Put that data
> in platform_data instead ...
I don't understand what you mean by this.  Can you be more specific?
>=20
> Second, it breaks some previously-working code.
Can you be more specific?
>=20
> Third, it misbehaves even on an x86 config.  Needs something like
> the appended patch.
Does it only misbehave on an x86 config or also on a MIPS config?  I
have no problems when building for DB1200. =20
>=20
> - Dave
>=20
>=20
> --- g26.orig/drivers/usb/gadget/Kconfig	2008-09-15 12:10:22.000000000 =
-0700
> +++ g26/drivers/usb/gadget/Kconfig	2008-09-15 12:10:06.000000000 -0700
> @@ -490,7 +490,7 @@ config USB_GADGET_DUALSPEED
> =20
>  config USB_PORT_AU1200OTG
>  	boolean "AU1200 USB portmux control (On-The-Go support)"
> -	depends on USB_GADGET_AU1200 || USB_EHCI_HCD || USB_OHCI_HCD
> +	depends on USB_GADGET_AU1200 && (USB_EHCI_HCD || USB_OHCI_HCD)
>  	default n
>  	help
>  	   The AU1200 and Au1200 USB device port can be used as either a =
host
>=20
--=20
Kevin Hickey
Alchemy Solutions
RMI Corporation
khickey@rmicorp.com
P: 512.691.8044

------_=_NextPart_001_01C91768.F2EF7E62
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7652.24">
<TITLE>Re: [PATCH] Au1200 USB Device Controller and device-only =
OTG</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>On Mon, 2008-09-15 at 12:16 -0700, David Brownell =
wrote:<BR>
&gt; On Thursday 11 September 2008, Kevin Hickey wrote:<BR>
&gt; &gt; basic device-only OTG (On-The-Go) support<BR>
&gt;<BR>
&gt; That does't look like it's done right.&nbsp; For starters, it =
abuses<BR>
&gt; Kconfig to handle a board-specific config option.&nbsp; Put that =
data<BR>
&gt; in platform_data instead ...<BR>
I don't understand what you mean by this.&nbsp; Can you be more =
specific?<BR>
&gt;<BR>
&gt; Second, it breaks some previously-working code.<BR>
Can you be more specific?<BR>
&gt;<BR>
&gt; Third, it misbehaves even on an x86 config.&nbsp; Needs something =
like<BR>
&gt; the appended patch.<BR>
Does it only misbehave on an x86 config or also on a MIPS config?&nbsp; =
I<BR>
have no problems when building for DB1200.&nbsp;<BR>
&gt;<BR>
&gt; - Dave<BR>
&gt;<BR>
&gt;<BR>
&gt; --- =
g26.orig/drivers/usb/gadget/Kconfig&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
2008-09-15 12:10:22.000000000 -0700<BR>
&gt; +++ g26/drivers/usb/gadget/Kconfig&nbsp;&nbsp;&nbsp; 2008-09-15 =
12:10:06.000000000 -0700<BR>
&gt; @@ -490,7 +490,7 @@ config USB_GADGET_DUALSPEED<BR>
&gt;&nbsp;<BR>
&gt;&nbsp; config USB_PORT_AU1200OTG<BR>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; boolean &quot;AU1200 USB portmux =
control (On-The-Go support)&quot;<BR>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; depends on USB_GADGET_AU1200 || =
USB_EHCI_HCD || USB_OHCI_HCD<BR>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; depends on USB_GADGET_AU1200 &amp;&amp; =
(USB_EHCI_HCD || USB_OHCI_HCD)<BR>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; default n<BR>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; help<BR>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; The AU1200 and Au1200 =
USB device port can be used as either a host<BR>
&gt;<BR>
--<BR>
Kevin Hickey<BR>
Alchemy Solutions<BR>
RMI Corporation<BR>
khickey@rmicorp.com<BR>
P: 512.691.8044<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C91768.F2EF7E62--
