Received:  by oss.sgi.com id <S553870AbRADWD0>;
	Thu, 4 Jan 2001 14:03:26 -0800
Received: from mail.cosinecom.com ([63.88.104.16]:39435 "EHLO
        exchsrv1.cosinecom.com") by oss.sgi.com with ESMTP
	id <S553867AbRADWDJ>; Thu, 4 Jan 2001 14:03:09 -0800
Received: by exchsrv1.cosinecom.com with Internet Mail Service (5.5.2650.21)
	id <Y4YLX547>; Thu, 4 Jan 2001 14:00:59 -0800
Message-ID: <7EB7C6B62C4FD41196A80090279A29113D7357@exchsrv1.cosinecom.com>
From:   John Van Horne <JohnVan.Horne@cosinecom.com>
To:     "'Maciej W. Rozycki'" <macro@ds2.pg.gda.pl>
Cc:     "'linux-mips@oss.sgi.com'" <linux-mips@oss.sgi.com>
Subject: RE: objcopy error -- was RE: your mail
Date:   Thu, 4 Jan 2001 14:00:59 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C07699.D1E8E970"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C07699.D1E8E970
Content-Type: text/plain;
	charset="iso-8859-1"

This is the same script that worked fine when we were using 
egcs-mips-linux-1.0.3a and binutils-mips-linux-2.8.1.  Have
there been any changes in the linker that would affect how
we write our linker script?

Thanks,
-John

-----Original Message-----
From: Maciej W. Rozycki [mailto:macro@ds2.pg.gda.pl]
Sent: Thursday, January 04, 2001 1:18 PM
To: John Van Horne
Cc: 'linux-mips@oss.sgi.com'
Subject: Re: objcopy error -- was RE: your mail


On Thu, 4 Jan 2001, John Van Horne wrote:

> [jvhorne@guava-lx linux]$ make orionboot
> make -C arch/mips/orion orionboot
> make[1]: Entering directory
>
`/dvlp/jvhorne/jvh_21_lx_mips_cross_test_sv/vobs/gpl/linux/arch/mips/orion'
> mips-linux-objcopy -Obinary --verbose ../../../vmlinux orion.nosym
> copy from ../../../vmlinux(elf32-bigmips) to orion.nosym(binary)
> BFD: Warning: Writing section `.app_header' to huge (ie negative) file
> offset 0x800fec30.
> BFD: Warning: Writing section `.text' to huge (ie negative) file offset
> 0x80100c30.
> BFD: Warning: Writing section `.fixup' to huge (ie negative) file offset
> 0x80236930.
> BFD: Warning: Writing section `.text.exit' to huge (ie negative) file
offset
> 0x80237830.
> .
> .
> .
> mips-linux-objcopy: orion.nosym: File truncated
> 
> 
> Do you think that the reason objcopy fails is because it isn't treating
> the addresses as 32 bit addresses, or could it be something else?

 Note that the binary BFD target fills all "holes" with zeroes.  I suspect
one or more sections are placed at an offset lower than 0x80000000. 
Objcopy would have to make a huge file in this case and it gives up.  You
probably need to fix your linker script.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

------_=_NextPart_001_01C07699.D1E8E970
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
5.5.2652.35">
<TITLE>RE: objcopy error -- was RE: your mail</TITLE>
</HEAD>
<BODY>

<P><FONT SIZE=3D2>This is the same script that worked fine when we were =
using </FONT>
<BR><FONT SIZE=3D2>egcs-mips-linux-1.0.3a and =
binutils-mips-linux-2.8.1.&nbsp; Have</FONT>
<BR><FONT SIZE=3D2>there been any changes in the linker that would =
affect how</FONT>
<BR><FONT SIZE=3D2>we write our linker script?</FONT>
</P>

<P><FONT SIZE=3D2>Thanks,</FONT>
<BR><FONT SIZE=3D2>-John</FONT>
</P>

<P><FONT SIZE=3D2>-----Original Message-----</FONT>
<BR><FONT SIZE=3D2>From: Maciej W. Rozycki [<A =
HREF=3D"mailto:macro@ds2.pg.gda.pl">mailto:macro@ds2.pg.gda.pl</A>]</FON=
T>
<BR><FONT SIZE=3D2>Sent: Thursday, January 04, 2001 1:18 PM</FONT>
<BR><FONT SIZE=3D2>To: John Van Horne</FONT>
<BR><FONT SIZE=3D2>Cc: 'linux-mips@oss.sgi.com'</FONT>
<BR><FONT SIZE=3D2>Subject: Re: objcopy error -- was RE: your =
mail</FONT>
</P>
<BR>

<P><FONT SIZE=3D2>On Thu, 4 Jan 2001, John Van Horne wrote:</FONT>
</P>

<P><FONT SIZE=3D2>&gt; [jvhorne@guava-lx linux]$ make orionboot</FONT>
<BR><FONT SIZE=3D2>&gt; make -C arch/mips/orion orionboot</FONT>
<BR><FONT SIZE=3D2>&gt; make[1]: Entering directory</FONT>
<BR><FONT SIZE=3D2>&gt; =
`/dvlp/jvhorne/jvh_21_lx_mips_cross_test_sv/vobs/gpl/linux/arch/mips/ori=
on'</FONT>
<BR><FONT SIZE=3D2>&gt; mips-linux-objcopy -Obinary --verbose =
../../../vmlinux orion.nosym</FONT>
<BR><FONT SIZE=3D2>&gt; copy from ../../../vmlinux(elf32-bigmips) to =
orion.nosym(binary)</FONT>
<BR><FONT SIZE=3D2>&gt; BFD: Warning: Writing section `.app_header' to =
huge (ie negative) file</FONT>
<BR><FONT SIZE=3D2>&gt; offset 0x800fec30.</FONT>
<BR><FONT SIZE=3D2>&gt; BFD: Warning: Writing section `.text' to huge =
(ie negative) file offset</FONT>
<BR><FONT SIZE=3D2>&gt; 0x80100c30.</FONT>
<BR><FONT SIZE=3D2>&gt; BFD: Warning: Writing section `.fixup' to huge =
(ie negative) file offset</FONT>
<BR><FONT SIZE=3D2>&gt; 0x80236930.</FONT>
<BR><FONT SIZE=3D2>&gt; BFD: Warning: Writing section `.text.exit' to =
huge (ie negative) file offset</FONT>
<BR><FONT SIZE=3D2>&gt; 0x80237830.</FONT>
<BR><FONT SIZE=3D2>&gt; .</FONT>
<BR><FONT SIZE=3D2>&gt; .</FONT>
<BR><FONT SIZE=3D2>&gt; .</FONT>
<BR><FONT SIZE=3D2>&gt; mips-linux-objcopy: orion.nosym: File =
truncated</FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; Do you think that the reason objcopy fails is =
because it isn't treating</FONT>
<BR><FONT SIZE=3D2>&gt; the addresses as 32 bit addresses, or could it =
be something else?</FONT>
</P>

<P><FONT SIZE=3D2>&nbsp;Note that the binary BFD target fills all =
&quot;holes&quot; with zeroes.&nbsp; I suspect</FONT>
<BR><FONT SIZE=3D2>one or more sections are placed at an offset lower =
than 0x80000000. </FONT>
<BR><FONT SIZE=3D2>Objcopy would have to make a huge file in this case =
and it gives up.&nbsp; You</FONT>
<BR><FONT SIZE=3D2>probably need to fix your linker script.</FONT>
</P>

<P><FONT SIZE=3D2>-- </FONT>
<BR><FONT SIZE=3D2>+&nbsp; Maciej W. Rozycki, Technical University of =
Gdansk, Poland&nbsp;&nbsp; +</FONT>
<BR><FONT =
SIZE=3D2>+--------------------------------------------------------------=
+</FONT>
<BR><FONT SIZE=3D2>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; e-mail: =
macro@ds2.pg.gda.pl, PGP key =
available&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C07699.D1E8E970--
