Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Jun 2006 16:29:23 +0100 (BST)
Received: from hm397.locaweb.com.br ([200.234.205.160]:41178 "HELO
	hm397.locaweb.com.br") by ftp.linux-mips.org with SMTP
	id S8133722AbWFGP3O (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 7 Jun 2006 16:29:14 +0100
Received: (qmail 1589 invoked from network); 7 Jun 2006 15:29:05 -0000
Received: from unknown (10.1.10.191)
  by hm397.locaweb.com.br with QMQP; 7 Jun 2006 15:29:05 -0000
Received: from unknown (HELO p3) (reservas@morrodaspedras.com@200.138.224.4)
  by hm191.locaweb.com.br with SMTP; 7 Jun 2006 15:29:15 -0000
Message-ID: <01c201c68a47$1beaed90$7d01010a@p3>
From:	<reservas@morrodaspedras.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>,
	"Vitaly Wool" <vitalywool@gmail.com>
Cc:	<linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>
References: <20060607105221.7b15b243.vitalywool@gmail.com> <20060607142702.GA20184@linux-mips.org>
Subject: Re: PNX8550 fails to compile in 2.6.17-rc4
Date:	Wed, 7 Jun 2006 12:29:03 -0300
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_01BF_01C68A2D.F621F5E0"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2869
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
Return-Path: <reservas@morrodaspedras.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11689
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: reservas@morrodaspedras.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

------=_NextPart_000_01BF_01C68A2D.F621F5E0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Please, dont wright no more for me. Tanks.
  ----- Original Message -----=20
  From: Ralf Baechle=20
  To: Vitaly Wool=20
  Cc: linux-kernel@vger.kernel.org ; linux-mips@linux-mips.org=20
  Sent: Wednesday, June 07, 2006 11:27 AM
  Subject: Re: PNX8550 fails to compile in 2.6.17-rc4


  On Wed, Jun 07, 2006 at 10:52:21AM +0400, Vitaly Wool wrote:

  > when I try to compile Linux kernel for pnx8550 in 2.6.17-rc4, I get =
the following error:
  >=20
  >   CC      arch/mips/philips/pnx8550/common/setup.o
  > =
/home/vital/work/opensource/mtd/arch/mips/philips/pnx8550/common/setup.c:=
 In function `plat_setup':
  > =
/home/vital/work/opensource/mtd/arch/mips/philips/pnx8550/common/setup.c:=
133: warning: implicit declaration of function `ip3106_lcr'
  > =
/home/vital/work/opensource/mtd/arch/mips/philips/pnx8550/common/setup.c:=
134: error: invalid lvalue in assignment
  > =
/home/vital/work/opensource/mtd/arch/mips/philips/pnx8550/common/setup.c:=
135: warning: implicit declaration of function `ip3106_baud'
  > =
/home/vital/work/opensource/mtd/arch/mips/philips/pnx8550/common/setup.c:=
135: error: invalid lvalue in assignment
  > make[2]: *** [arch/mips/philips/pnx8550/common/setup.o] Error 1
  > make[1]: *** [arch/mips/philips/pnx8550/common] Error 2
  > make: *** [vmlinux] Error 2
  >=20
  > I guess it's not what it should be ;-)

  This seems to be one of the serial bits for the ip3106 which must have
  been lost on the way to kernel.org.  Unfortunately the original author
  does no longer take care of the code.  I just took a stab at the =
PNX8550
  code and it has a significant number of other problems.  All small in
  the sum large enough such that I will mark PNX8550 support broken.

    Ralf

  [MIPS] Mark PNX8550 support broken.
     =20
  Broken in too many way for me to fix it for 2.6.17.

  Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

  diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
  index 0e25c1d..d87177f 100644
  --- a/arch/mips/Kconfig
  +++ b/arch/mips/Kconfig
  @@ -440,12 +440,12 @@ config MIPS_XXS1500
  =20
   config PNX8550_V2PCI
    bool "Philips PNX8550 based Viper2-PCI board"
  - select PNX8550
  + select PNX8550 && BROKEN
    select SYS_SUPPORTS_LITTLE_ENDIAN
  =20
   config PNX8550_JBS
    bool "Philips PNX8550 based JBS board"
  - select PNX8550
  + select PNX8550 && BROKEN
    select SYS_SUPPORTS_LITTLE_ENDIAN
  =20
   config DDB5074
  -
  To unsubscribe from this list: send the line "unsubscribe =
linux-kernel" in
  the body of a message to majordomo@vger.kernel.org
  More majordomo info at  http://vger.kernel.org/majordomo-info.html
  Please read the FAQ at  http://www.tux.org/lkml/



  --=20
  No virus found in this incoming message.
  Checked by AVG Free Edition.
  Version: 7.1.394 / Virus Database: 268.8.2/357 - Release Date: =
6/6/2006

------=_NextPart_000_01BF_01C68A2D.F621F5E0
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2900.2873" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DTahoma>Please, dont wright no more for me. =
Tanks.</FONT></DIV>
<BLOCKQUOTE=20
style=3D"PADDING-RIGHT: 0px; PADDING-LEFT: 5px; MARGIN-LEFT: 5px; =
BORDER-LEFT: #000000 2px solid; MARGIN-RIGHT: 0px">
  <DIV style=3D"FONT: 10pt arial">----- Original Message ----- </DIV>
  <DIV=20
  style=3D"BACKGROUND: #e4e4e4; FONT: 10pt arial; font-color: =
black"><B>From:</B>=20
  <A title=3Dralf@linux-mips.org =
href=3D"mailto:ralf@linux-mips.org">Ralf=20
  Baechle</A> </DIV>
  <DIV style=3D"FONT: 10pt arial"><B>To:</B> <A =
title=3Dvitalywool@gmail.com=20
  href=3D"mailto:vitalywool@gmail.com">Vitaly Wool</A> </DIV>
  <DIV style=3D"FONT: 10pt arial"><B>Cc:</B> <A =
title=3Dlinux-kernel@vger.kernel.org=20
  =
href=3D"mailto:linux-kernel@vger.kernel.org">linux-kernel@vger.kernel.org=
</A> ;=20
  <A title=3Dlinux-mips@linux-mips.org=20
  =
href=3D"mailto:linux-mips@linux-mips.org">linux-mips@linux-mips.org</A> =
</DIV>
  <DIV style=3D"FONT: 10pt arial"><B>Sent:</B> Wednesday, June 07, 2006 =
11:27=20
  AM</DIV>
  <DIV style=3D"FONT: 10pt arial"><B>Subject:</B> Re: PNX8550 fails to =
compile in=20
  2.6.17-rc4</DIV>
  <DIV><BR></DIV>On Wed, Jun 07, 2006 at 10:52:21AM +0400, Vitaly Wool=20
  wrote:<BR><BR>&gt; when I try to compile Linux kernel for pnx8550 in=20
  2.6.17-rc4, I get the following error:<BR>&gt; <BR>&gt;&nbsp;&nbsp;=20
  CC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  arch/mips/philips/pnx8550/common/setup.o<BR>&gt;=20
  =
/home/vital/work/opensource/mtd/arch/mips/philips/pnx8550/common/setup.c:=
 In=20
  function `plat_setup':<BR>&gt;=20
  =
/home/vital/work/opensource/mtd/arch/mips/philips/pnx8550/common/setup.c:=
133:=20
  warning: implicit declaration of function `ip3106_lcr'<BR>&gt;=20
  =
/home/vital/work/opensource/mtd/arch/mips/philips/pnx8550/common/setup.c:=
134:=20
  error: invalid lvalue in assignment<BR>&gt;=20
  =
/home/vital/work/opensource/mtd/arch/mips/philips/pnx8550/common/setup.c:=
135:=20
  warning: implicit declaration of function `ip3106_baud'<BR>&gt;=20
  =
/home/vital/work/opensource/mtd/arch/mips/philips/pnx8550/common/setup.c:=
135:=20
  error: invalid lvalue in assignment<BR>&gt; make[2]: ***=20
  [arch/mips/philips/pnx8550/common/setup.o] Error 1<BR>&gt; make[1]: =
***=20
  [arch/mips/philips/pnx8550/common] Error 2<BR>&gt; make: *** [vmlinux] =
Error=20
  2<BR>&gt; <BR>&gt; I guess it's not what it should be ;-)<BR><BR>This =
seems to=20
  be one of the serial bits for the ip3106 which must have<BR>been lost =
on the=20
  way to kernel.org.&nbsp; Unfortunately the original author<BR>does no =
longer=20
  take care of the code.&nbsp; I just took a stab at the PNX8550<BR>code =
and it=20
  has a significant number of other problems.&nbsp; All small in<BR>the =
sum=20
  large enough such that I will mark PNX8550 support =
broken.<BR><BR>&nbsp;=20
  Ralf<BR><BR>[MIPS] Mark PNX8550 support broken.<BR>&nbsp;&nbsp;&nbsp;=20
  <BR>Broken in too many way for me to fix it for =
2.6.17.<BR><BR>Signed-off-by:=20
  Ralf Baechle &lt;<A=20
  =
href=3D"mailto:ralf@linux-mips.org">ralf@linux-mips.org</A>&gt;<BR><BR>di=
ff=20
  --git a/arch/mips/Kconfig b/arch/mips/Kconfig<BR>index =
0e25c1d..d87177f=20
  100644<BR>--- a/arch/mips/Kconfig<BR>+++ b/arch/mips/Kconfig<BR>@@ =
-440,12=20
  +440,12 @@ config MIPS_XXS1500<BR>&nbsp;<BR>&nbsp;config=20
  PNX8550_V2PCI<BR>&nbsp; bool "Philips PNX8550 based Viper2-PCI =
board"<BR>-=20
  select PNX8550<BR>+ select PNX8550 &amp;&amp; BROKEN<BR>&nbsp; select=20
  SYS_SUPPORTS_LITTLE_ENDIAN<BR>&nbsp;<BR>&nbsp;config =
PNX8550_JBS<BR>&nbsp;=20
  bool "Philips PNX8550 based JBS board"<BR>- select PNX8550<BR>+ select =
PNX8550=20
  &amp;&amp; BROKEN<BR>&nbsp; select=20
  SYS_SUPPORTS_LITTLE_ENDIAN<BR>&nbsp;<BR>&nbsp;config =
DDB5074<BR>-<BR>To=20
  unsubscribe from this list: send the line "unsubscribe linux-kernel" =
in<BR>the=20
  body of a message to <A=20
  =
href=3D"mailto:majordomo@vger.kernel.org">majordomo@vger.kernel.org</A><B=
R>More=20
  majordomo info at&nbsp; <A=20
  =
href=3D"http://vger.kernel.org/majordomo-info.html">http://vger.kernel.or=
g/majordomo-info.html</A><BR>Please=20
  read the FAQ at&nbsp; <A=20
  =
href=3D"http://www.tux.org/lkml/">http://www.tux.org/lkml/</A><BR><BR><BR=
><BR>--=20
  <BR>No virus found in this incoming message.<BR>Checked by AVG Free=20
  Edition.<BR>Version: 7.1.394 / Virus Database: 268.8.2/357 - Release =
Date:=20
  6/6/2006<BR></BLOCKQUOTE></BODY></HTML>

------=_NextPart_000_01BF_01C68A2D.F621F5E0--
