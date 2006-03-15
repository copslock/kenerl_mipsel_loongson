Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Mar 2006 00:15:29 +0000 (GMT)
Received: from mxout.mainstreet.net ([199.245.73.25]:53961 "EHLO
	mxout.mainstreet.net") by ftp.linux-mips.org with ESMTP
	id S8133643AbWCOAPR (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 15 Mar 2006 00:15:17 +0000
Received: from mail.idt.com (mail.idt.com [157.165.5.20])
	by mxout.mainstreet.net (8.13.4/8.13.4) with ESMTP id k2F0OCID005840;
	Tue, 14 Mar 2006 16:24:14 -0800 (PST)
Received: from corpml1.corp.idt.com (corpml1.corp.idt.com [157.165.140.20])
	by mail.idt.com (8.13.4/8.13.4) with ESMTP id k2F0O5BE000977;
	Tue, 14 Mar 2006 16:24:06 -0800 (PST)
Received: from CORPBRIDGE.corp.idt.com (localhost [127.0.0.1])
	by corpml1.corp.idt.com (8.11.7p1+Sun/8.11.7) with ESMTP id k2F0Nx827214;
	Tue, 14 Mar 2006 16:24:00 -0800 (PST)
Received: by corpbridge.corp.idt.com with Internet Mail Service (5.5.2658.3)
	id <1X0CB11Q>; Tue, 14 Mar 2006 16:23:59 -0800
Message-ID: <73943A6B3BEAA1468EE1A4A090129F4316B15A81@corpbridge.corp.idt.com>
From:	"Tiwari, Rakesh" <Rakesh.Tiwari@idt.com>
To:	"'Chris Wedgwood'" <cw@f00f.org>
Cc:	"'Ralf Baechle'" <ralf@linux-mips.org>,
	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject:  [PATCH 2.6.16-rc5 1/5] IDT Interprise Processor Support for Linu
	x  2.6.x
Date:	Tue, 14 Mar 2006 16:23:50 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2658.3)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C647C6.BBD27F73"
X-Scanned-By: MIMEDefang 2.43
Return-Path: <Rakesh.Tiwari@idt.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10816
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Rakesh.Tiwari@idt.com
Precedence: bulk
X-list: linux-mips

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C647C6.BBD27F73
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C647C6.BBD27F73"


------_=_NextPart_001_01C647C6.BBD27F73
Content-Type: text/plain

Hi Chris/All,

The attached patch adds support for the IDT Interprise processor RC32438
based on the MIPS 4KC core. 

Additional information regarding IDT processor's can be found at 
http://www.idt.com/?catID=58532 <http://www.idt.com/?catID=58532> 

Signed-off-by: Rakesh Tiwari <rischelp@idt.com>

Thx
Rakesh

 <<idt_rc32438.patch>> 

>  -----Original Message-----
> From: 	Tiwari, Rakesh  
> Sent:	Monday, March 13, 2006 1:07 PM
> To:	'Chris Wedgwood'; Tiwari, Rakesh
> Cc:	'Ralf Baechle'; linux-mips@linux-mips.org
> Subject:	RE: [PATCH] IDT Interprise Processor Support for Linux
> 2.6.x
> 
> Hi Chris,
> 
> Appreciate your feedback.
> Please see my comments below, inline prefixed by [rkt]
> 
> Look forward for additional comments/suggestions, if any.
> 
> Thanks
> Rakesh
> 
> 
> -----Original Message-----
> From: Chris Wedgwood [mailto:cw@f00f.org <mailto:cw@f00f.org> ] 
> Sent: Friday, March 10, 2006 9:46 AM
> To: Tiwari, Rakesh
> Cc: 'Ralf Baechle'; linux-mips@linux-mips.org
> Subject: Re: [PATCH] IDT Interprise Processor Support for Linux 2.6.x
> 
> 
> Additional comments:
> 
>   * Firstly, it's really great to see this!
> 
>   * A single 1.6MB patch is far from ideal, please try to break it
>     into a series of smaller logically separate patches.  It's hard to
>     comment on a giant patch.  Perhaps something like:
>       - a patch for each CPU
>       - a patch for each driver
>       - a patch for each platform/eval-board
>     and see what you have left. Each patch should have a suitable
>     description.  Also put "Signed-off-by:" lines on your patches.
> 
>     [rkt] Agreed, 1.6MB is a huge patch. I will try to break it down into
>           multiple patches (ard 5) based on platform/eval board and will
>           send it out soon.
> 
>   * You shouldn't be removing .gitignore :-)
> 
>     [rkt] I think these are still there.
>  	
>   * The Ethernet drivers should probably go jeff@garzik.org and cc
>     netdev@vger.kernel.org
> 
>     [rkt] The Ethernet interface/driver is integral to each processor
>     and dependent upon other system header files, unlike a regular NIC.
>     I can try posting the patches (probably sub-patch) to Jeff and netdev,
>     in order to get feedback on the driver.
> 
> 	
>   * The code contains unreferenced functions?  Without even looking
>     hard I can see rc32434_mii_handler is declared and not used for
>     example.
> 
>     [rkt] Chris you hit the bulls eye. This is the only function which
>     I missed out... Will clean it up.
> 	
>   * It might be that some of the CPU-level code should be platform
>     level.  For example having two UARTs is a feature of the EB434 not
>     the rc32434 so EB434_UART1_IRQ is misplaced I would argue.
> 
>     [rkt] Since all the IDT's processors are primarily SoC's, the UARTS
> are
>      part of the processor. In case on rc32434 there is only 1 UART.
> However
>      rc32438 has 2 UARTS
> 
>  	
>   * Some init code should probably be declared __init and similar
> 
>   * There is quite a bit of extraneous white-space that could be
>     cleaned up and some minor indentation cleanups to match what is
>     elsewhere in the kernel.
> 
>    [rkt] Will try to clean up as much as possible...
> 
> Sorry this is a little vague and 'hand-wavy', if you post smaller
> logically complete patches I think you'll get better feedback where people
> can comment more easily.  Ideally inline to the email if you can, m$
> lookout/$exchange as that just makes a mess, if you have to use that then
> attach them as you did.

------_=_NextPart_001_01C647C6.BBD27F73
Content-Type: text/html
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
5.5.2658.2">
<TITLE> [PATCH 2.6.16-rc5 1/5] IDT Interprise Processor Support for =
Linux  2.6.x</TITLE>
</HEAD>
<BODY>

<P><FONT COLOR=3D"#0000FF" SIZE=3D2 FACE=3D"Arial">Hi Chris/All,</FONT>
</P>

<P><FONT COLOR=3D"#0000FF" SIZE=3D2 FACE=3D"Arial">The attached patch =
adds support for the IDT Interprise processor RC32438</FONT>
<BR><FONT COLOR=3D"#0000FF" SIZE=3D2 FACE=3D"Arial">based on the MIPS =
4KC core. </FONT>
</P>

<P><FONT COLOR=3D"#0000FF" SIZE=3D2 FACE=3D"Arial">Additional =
information regarding IDT processor's can be found at </FONT>
<BR><A HREF=3D"http://www.idt.com/?catID=3D58532"><U></U><U><FONT =
COLOR=3D"#0000FF" SIZE=3D2 =
FACE=3D"Arial">http://www.idt.com/?catID=3D58532</FONT></U></A>
</P>

<P><FONT COLOR=3D"#0000FF" SIZE=3D2 FACE=3D"Arial">Signed-off-by: =
Rakesh Tiwari &lt;rischelp@idt.com&gt;</FONT>
</P>

<P><FONT COLOR=3D"#0000FF" SIZE=3D2 FACE=3D"Arial">Thx<BR>
Rakesh</FONT>
</P>

<P><FONT FACE=3D"Arial" SIZE=3D2 COLOR=3D"#000000"> =
&lt;&lt;idt_rc32438.patch&gt;&gt; </FONT>
</P>
<UL>
<P><FONT FACE=3D"Arial"></FONT>&nbsp;<FONT SIZE=3D1 =
FACE=3D"Tahoma">-----Original Message-----</FONT>
<BR><B><FONT SIZE=3D1 FACE=3D"Tahoma">From: &nbsp;</FONT></B> <FONT =
SIZE=3D1 FACE=3D"Tahoma">Tiwari, Rakesh&nbsp; </FONT>
<BR><B><FONT SIZE=3D1 FACE=3D"Tahoma">Sent:&nbsp;&nbsp;</FONT></B> =
<FONT SIZE=3D1 FACE=3D"Tahoma">Monday, March 13, 2006 1:07 PM</FONT>
<BR><B><FONT SIZE=3D1 =
FACE=3D"Tahoma">To:&nbsp;&nbsp;&nbsp;&nbsp;</FONT></B> <FONT SIZE=3D1 =
FACE=3D"Tahoma">'Chris Wedgwood'; Tiwari, Rakesh</FONT>
<BR><B><FONT SIZE=3D1 =
FACE=3D"Tahoma">Cc:&nbsp;&nbsp;&nbsp;&nbsp;</FONT></B> <FONT SIZE=3D1 =
FACE=3D"Tahoma">'Ralf Baechle'; linux-mips@linux-mips.org</FONT>
<BR><B><FONT SIZE=3D1 =
FACE=3D"Tahoma">Subject:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</FONT=
></B> <FONT SIZE=3D1 FACE=3D"Tahoma">RE: [PATCH] IDT Interprise =
Processor Support for Linux&nbsp; 2.6.x</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Hi Chris,</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Appreciate your feedback.</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Arial">Please see my comments below, inline =
prefixed by [rkt]</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Look forward for additional =
comments/suggestions, if any.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Thanks</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Arial">Rakesh</FONT>
</P>
<BR>

<P><FONT SIZE=3D2 FACE=3D"Arial">-----Original Message-----</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Arial">From: Chris Wedgwood [</FONT><A =
HREF=3D"mailto:cw@f00f.org"><U><FONT COLOR=3D"#0000FF" SIZE=3D2 =
FACE=3D"Arial">mailto:cw@f00f.org</FONT></U></A><FONT SIZE=3D2 =
FACE=3D"Arial">] </FONT>
<BR><FONT SIZE=3D2 FACE=3D"Arial">Sent: Friday, March 10, 2006 9:46 =
AM</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Arial">To: Tiwari, Rakesh</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Arial">Cc: 'Ralf Baechle'; =
linux-mips@linux-mips.org</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Arial">Subject: Re: [PATCH] IDT Interprise =
Processor Support for Linux 2.6.x</FONT>
</P>
<BR>

<P><FONT SIZE=3D2 FACE=3D"Arial">Additional comments:</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">&nbsp; * Firstly, it's really great to =
see this!</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">&nbsp; * A single 1.6MB patch is far =
from ideal, please try to break it</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp;&nbsp; into a series of =
smaller logically separate patches.&nbsp; It's hard to</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp;&nbsp; comment on a giant =
patch.&nbsp; Perhaps something like:</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - a =
patch for each CPU</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - a =
patch for each driver</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - a =
patch for each platform/eval-board</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp;&nbsp; and see what you =
have left. Each patch should have a suitable</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp;&nbsp; description.&nbsp; =
Also put &quot;Signed-off-by:&quot; lines on your =
patches.<I></I></FONT>
</P>

<P><I><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp;&nbsp; [rkt] Agreed, =
1.6MB is a huge patch. I will try to break it down into</FONT></I>
<BR><I><FONT SIZE=3D2 =
FACE=3D"Arial">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
multiple patches (ard 5) based on platform/eval board and =
will</FONT></I>
<BR><I><FONT SIZE=3D2 =
FACE=3D"Arial">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
send it out soon.</FONT></I>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">&nbsp; * You shouldn't be removing =
.gitignore :-)</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp;&nbsp;</FONT><I> <FONT =
SIZE=3D2 FACE=3D"Arial">[rkt] I think these are still there.</FONT></I>
<BR><FONT SIZE=3D2 =
FACE=3D"Arial">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </FONT>
<BR><FONT SIZE=3D2 FACE=3D"Arial">&nbsp; * The Ethernet drivers should =
probably go jeff@garzik.org and cc</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp;&nbsp; =
netdev@vger.kernel.org</FONT>
</P>

<P><I><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp;&nbsp; [rkt] The =
Ethernet interface/driver is integral to each processor</FONT></I>
<BR><I><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp;&nbsp; and dependent =
upon other system header files, unlike a regular NIC.</FONT></I>
<BR><I><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp;&nbsp; I can try =
posting the patches (</FONT><FONT SIZE=3D2 =
FACE=3D"Arial">probably</FONT><FONT SIZE=3D2 FACE=3D"Arial"> sub-patch) =
to Jeff and netdev,</FONT></I>
<BR><I><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp;&nbsp; in order to get =
feedback on the driver.</FONT></I>
</P>

<P>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
<BR><FONT SIZE=3D2 FACE=3D"Arial">&nbsp; * The code contains =
unreferenced functions?&nbsp; Without even looking</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp;&nbsp; hard I can see =
rc32434_mii_handler is declared and not used for</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp;&nbsp; example.</FONT>
</P>

<P><I><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp;&nbsp; [rkt] Chris you =
hit the bulls eye. This is the only function which</FONT></I>
<BR><I><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp;&nbsp; I missed out... =
Will clean it up.</FONT></I>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
<BR><FONT SIZE=3D2 FACE=3D"Arial">&nbsp; * It might be that some of the =
CPU-level code should be platform</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp;&nbsp; level.&nbsp; For =
example having two UARTs is a feature of the EB434 not</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp;&nbsp; the rc32434 so =
EB434_UART1_IRQ is misplaced I would argue.</FONT>
</P>

<P><I><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp;&nbsp; [rkt] Since all =
the IDT's processors are primarily SoC's, the UARTS are</FONT></I>
<BR><I><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp;&nbsp;&nbsp; part of =
the processor. In case on rc32434 there is only 1 UART. =
However</FONT></I>
<BR><I><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp;&nbsp;&nbsp; rc32438 =
has 2 UARTS</FONT></I>
</P>

<P><FONT SIZE=3D2 =
FACE=3D"Arial">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </FONT>
<BR><FONT SIZE=3D2 FACE=3D"Arial">&nbsp; * Some init code should =
probably be declared __init and similar</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">&nbsp; * There is quite a bit of =
extraneous white-space that could be</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp;&nbsp; cleaned up and =
some minor indentation cleanups to match what is</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp;&nbsp; elsewhere in the =
kernel.</FONT>
</P>

<P><I><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp; [rkt] Will try to =
clean up as much as possible...</FONT></I>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Sorry this is a little vague and =
'hand-wavy', if you post smaller logically complete patches I think =
you'll get better feedback where people can comment more easily.&nbsp; =
Ideally inline to the email if you can, m$ lookout/$exchange as that =
just makes a mess, if you have to use that then attach them as you =
did.</FONT></P>
</UL>
</BODY>
</HTML>
------_=_NextPart_001_01C647C6.BBD27F73--

------_=_NextPart_000_01C647C6.BBD27F73
Content-Type: application/octet-stream;
	name="idt_rc32438.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="idt_rc32438.patch"

diff -uNr linux-2.6.16-rc5/arch/mips/configs/rc32438_defconfig =
acacia/arch/mips/configs/rc32438_defconfig=0A=
--- linux-2.6.16-rc5/arch/mips/configs/rc32438_defconfig	1969-12-31 =
16:00:00.000000000 -0800=0A=
+++ acacia/arch/mips/configs/rc32438_defconfig	2006-03-14 =
10:47:33.000000000 -0800=0A=
@@ -0,0 +1,982 @@=0A=
+#=0A=
+# Automatically generated make config: don't edit=0A=
+# Linux kernel version: 2.6.16-rc5=0A=
+# Thu Mar  9 10:57:39 2006=0A=
+#=0A=
+CONFIG_MIPS=3Dy=0A=
+=0A=
+#=0A=
+# Machine selection=0A=
+#=0A=
+# CONFIG_MIPS_MTX1 is not set=0A=
+# CONFIG_MIPS_BOSPORUS is not set=0A=
+# CONFIG_MIPS_PB1000 is not set=0A=
+# CONFIG_MIPS_PB1100 is not set=0A=
+# CONFIG_MIPS_PB1500 is not set=0A=
+# CONFIG_MIPS_PB1550 is not set=0A=
+# CONFIG_MIPS_PB1200 is not set=0A=
+# CONFIG_MIPS_DB1000 is not set=0A=
+# CONFIG_MIPS_DB1100 is not set=0A=
+# CONFIG_MIPS_DB1500 is not set=0A=
+# CONFIG_MIPS_DB1550 is not set=0A=
+# CONFIG_MIPS_DB1200 is not set=0A=
+# CONFIG_MIPS_MIRAGE is not set=0A=
+# CONFIG_MIPS_COBALT is not set=0A=
+# CONFIG_MACH_DECSTATION is not set=0A=
+# CONFIG_MIPS_EV64120 is not set=0A=
+# CONFIG_MIPS_EV96100 is not set=0A=
+# CONFIG_MIPS_IVR is not set=0A=
+CONFIG_IDT_BOARDS=3Dy=0A=
+# CONFIG_MIPS_ITE8172 is not set=0A=
+# CONFIG_MACH_JAZZ is not set=0A=
+# CONFIG_LASAT is not set=0A=
+# CONFIG_MIPS_ATLAS is not set=0A=
+# CONFIG_MIPS_MALTA is not set=0A=
+# CONFIG_MIPS_SEAD is not set=0A=
+# CONFIG_MIPS_SIM is not set=0A=
+# CONFIG_MOMENCO_JAGUAR_ATX is not set=0A=
+# CONFIG_MOMENCO_OCELOT is not set=0A=
+# CONFIG_MOMENCO_OCELOT_3 is not set=0A=
+# CONFIG_MOMENCO_OCELOT_C is not set=0A=
+# CONFIG_MOMENCO_OCELOT_G is not set=0A=
+# CONFIG_MIPS_XXS1500 is not set=0A=
+# CONFIG_PNX8550_V2PCI is not set=0A=
+# CONFIG_PNX8550_JBS is not set=0A=
+# CONFIG_DDB5074 is not set=0A=
+# CONFIG_DDB5476 is not set=0A=
+# CONFIG_DDB5477 is not set=0A=
+# CONFIG_MACH_VR41XX is not set=0A=
+# CONFIG_PMC_YOSEMITE is not set=0A=
+# CONFIG_QEMU is not set=0A=
+# CONFIG_SGI_IP22 is not set=0A=
+# CONFIG_SGI_IP27 is not set=0A=
+# CONFIG_SGI_IP32 is not set=0A=
+# CONFIG_SIBYTE_BIGSUR is not set=0A=
+# CONFIG_SIBYTE_SWARM is not set=0A=
+# CONFIG_SIBYTE_SENTOSA is not set=0A=
+# CONFIG_SIBYTE_RHONE is not set=0A=
+# CONFIG_SIBYTE_CARMEL is not set=0A=
+# CONFIG_SIBYTE_PTSWARM is not set=0A=
+# CONFIG_SIBYTE_LITTLESUR is not set=0A=
+# CONFIG_SIBYTE_CRHINE is not set=0A=
+# CONFIG_SIBYTE_CRHONE is not set=0A=
+# CONFIG_SNI_RM200_PCI is not set=0A=
+# CONFIG_TOSHIBA_JMR3927 is not set=0A=
+# CONFIG_TOSHIBA_RBTX4927 is not set=0A=
+# CONFIG_TOSHIBA_RBTX4938 is not set=0A=
+CONFIG_IDT_EB438=3Dy=0A=
+# CONFIG_RC32438_REVISION_ZA is not set=0A=
+# CONFIG_IDT_EB434 is not set=0A=
+# CONFIG_IDT_EB365 is not set=0A=
+# CONFIG_IDT_EB355 is not set=0A=
+# CONFIG_IDT_S334 is not set=0A=
+CONFIG_IDT_BOARD_FREQ=3D150000000=0A=
+CONFIG_IDT_ZIMAGE_ADDR=3D0x91000000=0A=
+# CONFIG_IDT_BOOT_NVRAM is not set=0A=
+CONFIG_RWSEM_GENERIC_SPINLOCK=3Dy=0A=
+CONFIG_GENERIC_CALIBRATE_DELAY=3Dy=0A=
+CONFIG_DMA_NONCOHERENT=3Dy=0A=
+CONFIG_DMA_NEED_PCI_MAP_STATE=3Dy=0A=
+# CONFIG_CPU_BIG_ENDIAN is not set=0A=
+CONFIG_CPU_LITTLE_ENDIAN=3Dy=0A=
+CONFIG_SYS_SUPPORTS_BIG_ENDIAN=3Dy=0A=
+CONFIG_SYS_SUPPORTS_LITTLE_ENDIAN=3Dy=0A=
+CONFIG_IRQ_CPU=3Dy=0A=
+CONFIG_SWAP_IO_SPACE=3Dy=0A=
+CONFIG_BOOT_ELF32=3Dy=0A=
+CONFIG_MIPS_L1_CACHE_SHIFT=3D5=0A=
+=0A=
+#=0A=
+# CPU selection=0A=
+#=0A=
+CONFIG_CPU_MIPS32_R1=3Dy=0A=
+# CONFIG_CPU_MIPS32_R2 is not set=0A=
+# CONFIG_CPU_MIPS64_R1 is not set=0A=
+# CONFIG_CPU_MIPS64_R2 is not set=0A=
+# CONFIG_CPU_R3000 is not set=0A=
+# CONFIG_CPU_TX39XX is not set=0A=
+# CONFIG_CPU_VR41XX is not set=0A=
+# CONFIG_CPU_R4300 is not set=0A=
+# CONFIG_CPU_R4X00 is not set=0A=
+# CONFIG_CPU_TX49XX is not set=0A=
+# CONFIG_CPU_R5000 is not set=0A=
+# CONFIG_CPU_R5432 is not set=0A=
+# CONFIG_CPU_R6000 is not set=0A=
+# CONFIG_CPU_NEVADA is not set=0A=
+# CONFIG_CPU_R8000 is not set=0A=
+# CONFIG_CPU_R10000 is not set=0A=
+# CONFIG_CPU_RM7000 is not set=0A=
+# CONFIG_CPU_RM9000 is not set=0A=
+# CONFIG_CPU_SB1 is not set=0A=
+CONFIG_SYS_HAS_CPU_MIPS32_R1=3Dy=0A=
+CONFIG_CPU_MIPS32=3Dy=0A=
+CONFIG_CPU_MIPSR1=3Dy=0A=
+CONFIG_SYS_SUPPORTS_32BIT_KERNEL=3Dy=0A=
+CONFIG_CPU_SUPPORTS_32BIT_KERNEL=3Dy=0A=
+=0A=
+#=0A=
+# Kernel type=0A=
+#=0A=
+CONFIG_32BIT=3Dy=0A=
+# CONFIG_64BIT is not set=0A=
+CONFIG_PAGE_SIZE_4KB=3Dy=0A=
+# CONFIG_PAGE_SIZE_8KB is not set=0A=
+# CONFIG_PAGE_SIZE_16KB is not set=0A=
+# CONFIG_PAGE_SIZE_64KB is not set=0A=
+CONFIG_CPU_HAS_PREFETCH=3Dy=0A=
+# CONFIG_MIPS_MT is not set=0A=
+# CONFIG_64BIT_PHYS_ADDR is not set=0A=
+CONFIG_CPU_ADVANCED=3Dy=0A=
+CONFIG_CPU_HAS_LLSC=3Dy=0A=
+# CONFIG_CPU_HAS_WB is not set=0A=
+CONFIG_CPU_HAS_SYNC=3Dy=0A=
+CONFIG_GENERIC_HARDIRQS=3Dy=0A=
+CONFIG_GENERIC_IRQ_PROBE=3Dy=0A=
+CONFIG_ARCH_FLATMEM_ENABLE=3Dy=0A=
+CONFIG_SELECT_MEMORY_MODEL=3Dy=0A=
+CONFIG_FLATMEM_MANUAL=3Dy=0A=
+# CONFIG_DISCONTIGMEM_MANUAL is not set=0A=
+# CONFIG_SPARSEMEM_MANUAL is not set=0A=
+CONFIG_FLATMEM=3Dy=0A=
+CONFIG_FLAT_NODE_MEM_MAP=3Dy=0A=
+# CONFIG_SPARSEMEM_STATIC is not set=0A=
+CONFIG_SPLIT_PTLOCK_CPUS=3D4=0A=
+CONFIG_PREEMPT_NONE=3Dy=0A=
+# CONFIG_PREEMPT_VOLUNTARY is not set=0A=
+# CONFIG_PREEMPT is not set=0A=
+=0A=
+#=0A=
+# Code maturity level options=0A=
+#=0A=
+CONFIG_EXPERIMENTAL=3Dy=0A=
+CONFIG_BROKEN_ON_SMP=3Dy=0A=
+CONFIG_INIT_ENV_ARG_LIMIT=3D32=0A=
+=0A=
+#=0A=
+# General setup=0A=
+#=0A=
+CONFIG_LOCALVERSION=3D""=0A=
+CONFIG_LOCALVERSION_AUTO=3Dy=0A=
+# CONFIG_SWAP is not set=0A=
+CONFIG_SYSVIPC=3Dy=0A=
+# CONFIG_POSIX_MQUEUE is not set=0A=
+# CONFIG_BSD_PROCESS_ACCT is not set=0A=
+CONFIG_SYSCTL=3Dy=0A=
+# CONFIG_AUDIT is not set=0A=
+CONFIG_IKCONFIG=3Dy=0A=
+# CONFIG_IKCONFIG_PROC is not set=0A=
+CONFIG_INITRAMFS_SOURCE=3D""=0A=
+# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set=0A=
+CONFIG_EMBEDDED=3Dy=0A=
+# CONFIG_KALLSYMS is not set=0A=
+# CONFIG_HOTPLUG is not set=0A=
+CONFIG_PRINTK=3Dy=0A=
+CONFIG_BUG=3Dy=0A=
+CONFIG_ELF_CORE=3Dy=0A=
+# CONFIG_BASE_FULL is not set=0A=
+# CONFIG_FUTEX is not set=0A=
+# CONFIG_EPOLL is not set=0A=
+CONFIG_SHMEM=3Dy=0A=
+CONFIG_CC_ALIGN_FUNCTIONS=3D0=0A=
+CONFIG_CC_ALIGN_LABELS=3D0=0A=
+CONFIG_CC_ALIGN_LOOPS=3D0=0A=
+CONFIG_CC_ALIGN_JUMPS=3D0=0A=
+# CONFIG_SLAB is not set=0A=
+# CONFIG_TINY_SHMEM is not set=0A=
+CONFIG_BASE_SMALL=3D1=0A=
+CONFIG_SLOB=3Dy=0A=
+=0A=
+#=0A=
+# Loadable module support=0A=
+#=0A=
+CONFIG_MODULES=3Dy=0A=
+CONFIG_MODULE_UNLOAD=3Dy=0A=
+# CONFIG_MODULE_FORCE_UNLOAD is not set=0A=
+CONFIG_OBSOLETE_MODPARM=3Dy=0A=
+# CONFIG_MODVERSIONS is not set=0A=
+# CONFIG_MODULE_SRCVERSION_ALL is not set=0A=
+# CONFIG_KMOD is not set=0A=
+=0A=
+#=0A=
+# Block layer=0A=
+#=0A=
+# CONFIG_LBD is not set=0A=
+=0A=
+#=0A=
+# IO Schedulers=0A=
+#=0A=
+CONFIG_IOSCHED_NOOP=3Dy=0A=
+CONFIG_IOSCHED_AS=3Dy=0A=
+CONFIG_IOSCHED_DEADLINE=3Dy=0A=
+CONFIG_IOSCHED_CFQ=3Dy=0A=
+CONFIG_DEFAULT_AS=3Dy=0A=
+# CONFIG_DEFAULT_DEADLINE is not set=0A=
+# CONFIG_DEFAULT_CFQ is not set=0A=
+# CONFIG_DEFAULT_NOOP is not set=0A=
+CONFIG_DEFAULT_IOSCHED=3D"anticipatory"=0A=
+=0A=
+#=0A=
+# Bus options (PCI, PCMCIA, EISA, ISA, TC)=0A=
+#=0A=
+CONFIG_HW_HAS_PCI=3Dy=0A=
+CONFIG_PCI=3Dy=0A=
+CONFIG_PCI_LEGACY_PROC=3Dy=0A=
+CONFIG_MMU=3Dy=0A=
+=0A=
+#=0A=
+# PCCARD (PCMCIA/CardBus) support=0A=
+#=0A=
+# CONFIG_PCCARD is not set=0A=
+=0A=
+#=0A=
+# PCI Hotplug Support=0A=
+#=0A=
+# CONFIG_HOTPLUG_PCI is not set=0A=
+=0A=
+#=0A=
+# Executable file formats=0A=
+#=0A=
+CONFIG_BINFMT_ELF=3Dy=0A=
+# CONFIG_BINFMT_MISC is not set=0A=
+CONFIG_TRAD_SIGNALS=3Dy=0A=
+=0A=
+#=0A=
+# Networking=0A=
+#=0A=
+CONFIG_NET=3Dy=0A=
+=0A=
+#=0A=
+# Networking options=0A=
+#=0A=
+# CONFIG_NETDEBUG is not set=0A=
+CONFIG_PACKET=3Dy=0A=
+CONFIG_PACKET_MMAP=3Dy=0A=
+CONFIG_UNIX=3Dy=0A=
+CONFIG_XFRM=3Dy=0A=
+# CONFIG_XFRM_USER is not set=0A=
+CONFIG_NET_KEY=3Dy=0A=
+CONFIG_INET=3Dy=0A=
+CONFIG_IP_MULTICAST=3Dy=0A=
+# CONFIG_IP_ADVANCED_ROUTER is not set=0A=
+CONFIG_IP_FIB_HASH=3Dy=0A=
+CONFIG_IP_PNP=3Dy=0A=
+# CONFIG_IP_PNP_DHCP is not set=0A=
+# CONFIG_IP_PNP_BOOTP is not set=0A=
+# CONFIG_IP_PNP_RARP is not set=0A=
+# CONFIG_NET_IPIP is not set=0A=
+# CONFIG_NET_IPGRE is not set=0A=
+# CONFIG_IP_MROUTE is not set=0A=
+# CONFIG_ARPD is not set=0A=
+# CONFIG_SYN_COOKIES is not set=0A=
+# CONFIG_INET_AH is not set=0A=
+# CONFIG_INET_ESP is not set=0A=
+# CONFIG_INET_IPCOMP is not set=0A=
+# CONFIG_INET_TUNNEL is not set=0A=
+# CONFIG_INET_DIAG is not set=0A=
+# CONFIG_TCP_CONG_ADVANCED is not set=0A=
+CONFIG_TCP_CONG_BIC=3Dy=0A=
+=0A=
+#=0A=
+# IP: Virtual Server Configuration=0A=
+#=0A=
+CONFIG_IP_VS=3Dm=0A=
+# CONFIG_IP_VS_DEBUG is not set=0A=
+CONFIG_IP_VS_TAB_BITS=3D12=0A=
+=0A=
+#=0A=
+# IPVS transport protocol load balancing support=0A=
+#=0A=
+CONFIG_IP_VS_PROTO_TCP=3Dy=0A=
+CONFIG_IP_VS_PROTO_UDP=3Dy=0A=
+CONFIG_IP_VS_PROTO_ESP=3Dy=0A=
+CONFIG_IP_VS_PROTO_AH=3Dy=0A=
+=0A=
+#=0A=
+# IPVS scheduler=0A=
+#=0A=
+CONFIG_IP_VS_RR=3Dm=0A=
+CONFIG_IP_VS_WRR=3Dm=0A=
+CONFIG_IP_VS_LC=3Dm=0A=
+CONFIG_IP_VS_WLC=3Dm=0A=
+CONFIG_IP_VS_LBLC=3Dm=0A=
+CONFIG_IP_VS_LBLCR=3Dm=0A=
+CONFIG_IP_VS_DH=3Dm=0A=
+CONFIG_IP_VS_SH=3Dm=0A=
+CONFIG_IP_VS_SED=3Dm=0A=
+CONFIG_IP_VS_NQ=3Dm=0A=
+=0A=
+#=0A=
+# IPVS application helper=0A=
+#=0A=
+CONFIG_IP_VS_FTP=3Dm=0A=
+# CONFIG_IPV6 is not set=0A=
+CONFIG_NETFILTER=3Dy=0A=
+# CONFIG_NETFILTER_DEBUG is not set=0A=
+=0A=
+#=0A=
+# Core Netfilter Configuration=0A=
+#=0A=
+CONFIG_NETFILTER_NETLINK=3Dm=0A=
+CONFIG_NETFILTER_NETLINK_QUEUE=3Dm=0A=
+CONFIG_NETFILTER_NETLINK_LOG=3Dm=0A=
+CONFIG_NETFILTER_XTABLES=3Dm=0A=
+CONFIG_NETFILTER_XT_TARGET_CLASSIFY=3Dm=0A=
+CONFIG_NETFILTER_XT_TARGET_CONNMARK=3Dm=0A=
+CONFIG_NETFILTER_XT_TARGET_MARK=3Dm=0A=
+CONFIG_NETFILTER_XT_TARGET_NFQUEUE=3Dm=0A=
+CONFIG_NETFILTER_XT_TARGET_NOTRACK=3Dm=0A=
+CONFIG_NETFILTER_XT_MATCH_COMMENT=3Dm=0A=
+CONFIG_NETFILTER_XT_MATCH_CONNBYTES=3Dm=0A=
+CONFIG_NETFILTER_XT_MATCH_CONNMARK=3Dm=0A=
+CONFIG_NETFILTER_XT_MATCH_CONNTRACK=3Dm=0A=
+CONFIG_NETFILTER_XT_MATCH_DCCP=3Dm=0A=
+CONFIG_NETFILTER_XT_MATCH_HELPER=3Dm=0A=
+CONFIG_NETFILTER_XT_MATCH_LENGTH=3Dm=0A=
+CONFIG_NETFILTER_XT_MATCH_LIMIT=3Dm=0A=
+CONFIG_NETFILTER_XT_MATCH_MAC=3Dm=0A=
+CONFIG_NETFILTER_XT_MATCH_MARK=3Dm=0A=
+CONFIG_NETFILTER_XT_MATCH_PKTTYPE=3Dm=0A=
+CONFIG_NETFILTER_XT_MATCH_REALM=3Dm=0A=
+CONFIG_NETFILTER_XT_MATCH_SCTP=3Dm=0A=
+CONFIG_NETFILTER_XT_MATCH_STATE=3Dm=0A=
+CONFIG_NETFILTER_XT_MATCH_STRING=3Dm=0A=
+CONFIG_NETFILTER_XT_MATCH_TCPMSS=3Dm=0A=
+=0A=
+#=0A=
+# IP: Netfilter Configuration=0A=
+#=0A=
+CONFIG_IP_NF_CONNTRACK=3Dm=0A=
+CONFIG_IP_NF_CT_ACCT=3Dy=0A=
+CONFIG_IP_NF_CONNTRACK_MARK=3Dy=0A=
+CONFIG_IP_NF_CONNTRACK_EVENTS=3Dy=0A=
+CONFIG_IP_NF_CONNTRACK_NETLINK=3Dm=0A=
+# CONFIG_IP_NF_CT_PROTO_SCTP is not set=0A=
+CONFIG_IP_NF_FTP=3Dm=0A=
+CONFIG_IP_NF_IRC=3Dm=0A=
+# CONFIG_IP_NF_NETBIOS_NS is not set=0A=
+CONFIG_IP_NF_TFTP=3Dm=0A=
+CONFIG_IP_NF_AMANDA=3Dm=0A=
+CONFIG_IP_NF_PPTP=3Dm=0A=
+CONFIG_IP_NF_QUEUE=3Dm=0A=
+CONFIG_IP_NF_IPTABLES=3Dm=0A=
+CONFIG_IP_NF_MATCH_IPRANGE=3Dm=0A=
+CONFIG_IP_NF_MATCH_MULTIPORT=3Dm=0A=
+CONFIG_IP_NF_MATCH_TOS=3Dm=0A=
+CONFIG_IP_NF_MATCH_RECENT=3Dm=0A=
+CONFIG_IP_NF_MATCH_ECN=3Dm=0A=
+CONFIG_IP_NF_MATCH_DSCP=3Dm=0A=
+CONFIG_IP_NF_MATCH_AH_ESP=3Dm=0A=
+CONFIG_IP_NF_MATCH_TTL=3Dm=0A=
+CONFIG_IP_NF_MATCH_OWNER=3Dm=0A=
+CONFIG_IP_NF_MATCH_ADDRTYPE=3Dm=0A=
+CONFIG_IP_NF_MATCH_HASHLIMIT=3Dm=0A=
+CONFIG_IP_NF_MATCH_POLICY=3Dm=0A=
+CONFIG_IP_NF_FILTER=3Dm=0A=
+CONFIG_IP_NF_TARGET_REJECT=3Dm=0A=
+CONFIG_IP_NF_TARGET_LOG=3Dm=0A=
+CONFIG_IP_NF_TARGET_ULOG=3Dm=0A=
+CONFIG_IP_NF_TARGET_TCPMSS=3Dm=0A=
+CONFIG_IP_NF_NAT=3Dm=0A=
+CONFIG_IP_NF_NAT_NEEDED=3Dy=0A=
+CONFIG_IP_NF_TARGET_MASQUERADE=3Dm=0A=
+CONFIG_IP_NF_TARGET_REDIRECT=3Dm=0A=
+CONFIG_IP_NF_TARGET_NETMAP=3Dm=0A=
+CONFIG_IP_NF_TARGET_SAME=3Dm=0A=
+CONFIG_IP_NF_NAT_SNMP_BASIC=3Dm=0A=
+CONFIG_IP_NF_NAT_IRC=3Dm=0A=
+CONFIG_IP_NF_NAT_FTP=3Dm=0A=
+CONFIG_IP_NF_NAT_TFTP=3Dm=0A=
+CONFIG_IP_NF_NAT_AMANDA=3Dm=0A=
+CONFIG_IP_NF_NAT_PPTP=3Dm=0A=
+CONFIG_IP_NF_MANGLE=3Dm=0A=
+CONFIG_IP_NF_TARGET_TOS=3Dm=0A=
+CONFIG_IP_NF_TARGET_ECN=3Dm=0A=
+CONFIG_IP_NF_TARGET_DSCP=3Dm=0A=
+CONFIG_IP_NF_TARGET_TTL=3Dm=0A=
+CONFIG_IP_NF_TARGET_CLUSTERIP=3Dm=0A=
+CONFIG_IP_NF_RAW=3Dm=0A=
+CONFIG_IP_NF_ARPTABLES=3Dm=0A=
+CONFIG_IP_NF_ARPFILTER=3Dm=0A=
+CONFIG_IP_NF_ARP_MANGLE=3Dm=0A=
+=0A=
+#=0A=
+# DCCP Configuration (EXPERIMENTAL)=0A=
+#=0A=
+# CONFIG_IP_DCCP is not set=0A=
+=0A=
+#=0A=
+# SCTP Configuration (EXPERIMENTAL)=0A=
+#=0A=
+# CONFIG_IP_SCTP is not set=0A=
+=0A=
+#=0A=
+# TIPC Configuration (EXPERIMENTAL)=0A=
+#=0A=
+# CONFIG_TIPC is not set=0A=
+# CONFIG_ATM is not set=0A=
+# CONFIG_BRIDGE is not set=0A=
+# CONFIG_VLAN_8021Q is not set=0A=
+# CONFIG_DECNET is not set=0A=
+# CONFIG_LLC2 is not set=0A=
+# CONFIG_IPX is not set=0A=
+# CONFIG_ATALK is not set=0A=
+# CONFIG_X25 is not set=0A=
+# CONFIG_LAPB is not set=0A=
+# CONFIG_NET_DIVERT is not set=0A=
+# CONFIG_ECONET is not set=0A=
+# CONFIG_WAN_ROUTER is not set=0A=
+=0A=
+#=0A=
+# QoS and/or fair queueing=0A=
+#=0A=
+CONFIG_NET_SCHED=3Dy=0A=
+# CONFIG_NET_SCH_CLK_JIFFIES is not set=0A=
+CONFIG_NET_SCH_CLK_GETTIMEOFDAY=3Dy=0A=
+# CONFIG_NET_SCH_CLK_CPU is not set=0A=
+=0A=
+#=0A=
+# Queueing/Scheduling=0A=
+#=0A=
+CONFIG_NET_SCH_CBQ=3Dm=0A=
+CONFIG_NET_SCH_HTB=3Dm=0A=
+CONFIG_NET_SCH_HFSC=3Dm=0A=
+CONFIG_NET_SCH_PRIO=3Dm=0A=
+CONFIG_NET_SCH_RED=3Dm=0A=
+CONFIG_NET_SCH_SFQ=3Dm=0A=
+CONFIG_NET_SCH_TEQL=3Dm=0A=
+CONFIG_NET_SCH_TBF=3Dm=0A=
+CONFIG_NET_SCH_GRED=3Dm=0A=
+CONFIG_NET_SCH_DSMARK=3Dm=0A=
+CONFIG_NET_SCH_NETEM=3Dm=0A=
+CONFIG_NET_SCH_INGRESS=3Dm=0A=
+=0A=
+#=0A=
+# Classification=0A=
+#=0A=
+CONFIG_NET_CLS=3Dy=0A=
+CONFIG_NET_CLS_BASIC=3Dm=0A=
+CONFIG_NET_CLS_TCINDEX=3Dm=0A=
+CONFIG_NET_CLS_ROUTE4=3Dm=0A=
+CONFIG_NET_CLS_ROUTE=3Dy=0A=
+CONFIG_NET_CLS_FW=3Dm=0A=
+CONFIG_NET_CLS_U32=3Dm=0A=
+# CONFIG_CLS_U32_PERF is not set=0A=
+# CONFIG_CLS_U32_MARK is not set=0A=
+CONFIG_NET_CLS_RSVP=3Dm=0A=
+CONFIG_NET_CLS_RSVP6=3Dm=0A=
+# CONFIG_NET_EMATCH is not set=0A=
+# CONFIG_NET_CLS_ACT is not set=0A=
+CONFIG_NET_CLS_POLICE=3Dy=0A=
+# CONFIG_NET_CLS_IND is not set=0A=
+CONFIG_NET_ESTIMATOR=3Dy=0A=
+=0A=
+#=0A=
+# Network testing=0A=
+#=0A=
+# CONFIG_NET_PKTGEN is not set=0A=
+# CONFIG_HAMRADIO is not set=0A=
+# CONFIG_IRDA is not set=0A=
+# CONFIG_BT is not set=0A=
+# CONFIG_IEEE80211 is not set=0A=
+=0A=
+#=0A=
+# Device Drivers=0A=
+#=0A=
+=0A=
+#=0A=
+# Generic Driver Options=0A=
+#=0A=
+CONFIG_STANDALONE=3Dy=0A=
+CONFIG_PREVENT_FIRMWARE_BUILD=3Dy=0A=
+# CONFIG_FW_LOADER is not set=0A=
+=0A=
+#=0A=
+# Connector - unified userspace <-> kernelspace linker=0A=
+#=0A=
+# CONFIG_CONNECTOR is not set=0A=
+=0A=
+#=0A=
+# Memory Technology Devices (MTD)=0A=
+#=0A=
+# CONFIG_MTD is not set=0A=
+=0A=
+#=0A=
+# Parallel port support=0A=
+#=0A=
+# CONFIG_PARPORT is not set=0A=
+=0A=
+#=0A=
+# Plug and Play support=0A=
+#=0A=
+=0A=
+#=0A=
+# Block devices=0A=
+#=0A=
+# CONFIG_BLK_CPQ_DA is not set=0A=
+# CONFIG_BLK_CPQ_CISS_DA is not set=0A=
+# CONFIG_BLK_DEV_DAC960 is not set=0A=
+# CONFIG_BLK_DEV_UMEM is not set=0A=
+# CONFIG_BLK_DEV_COW_COMMON is not set=0A=
+# CONFIG_BLK_DEV_LOOP is not set=0A=
+# CONFIG_BLK_DEV_NBD is not set=0A=
+# CONFIG_BLK_DEV_SX8 is not set=0A=
+# CONFIG_BLK_DEV_RAM is not set=0A=
+CONFIG_BLK_DEV_RAM_COUNT=3D16=0A=
+# CONFIG_CDROM_PKTCDVD is not set=0A=
+# CONFIG_ATA_OVER_ETH is not set=0A=
+=0A=
+#=0A=
+# ATA/ATAPI/MFM/RLL support=0A=
+#=0A=
+# CONFIG_IDE is not set=0A=
+=0A=
+#=0A=
+# SCSI device support=0A=
+#=0A=
+# CONFIG_RAID_ATTRS is not set=0A=
+# CONFIG_SCSI is not set=0A=
+=0A=
+#=0A=
+# Multi-device support (RAID and LVM)=0A=
+#=0A=
+# CONFIG_MD is not set=0A=
+=0A=
+#=0A=
+# Fusion MPT device support=0A=
+#=0A=
+# CONFIG_FUSION is not set=0A=
+=0A=
+#=0A=
+# IEEE 1394 (FireWire) support=0A=
+#=0A=
+# CONFIG_IEEE1394 is not set=0A=
+=0A=
+#=0A=
+# I2O device support=0A=
+#=0A=
+# CONFIG_I2O is not set=0A=
+=0A=
+#=0A=
+# Network device support=0A=
+#=0A=
+CONFIG_NETDEVICES=3Dy=0A=
+# CONFIG_DUMMY is not set=0A=
+# CONFIG_BONDING is not set=0A=
+# CONFIG_EQUALIZER is not set=0A=
+# CONFIG_TUN is not set=0A=
+=0A=
+#=0A=
+# ARCnet devices=0A=
+#=0A=
+# CONFIG_ARCNET is not set=0A=
+=0A=
+#=0A=
+# PHY device support=0A=
+#=0A=
+CONFIG_PHYLIB=3Dm=0A=
+=0A=
+#=0A=
+# MII PHY device drivers=0A=
+#=0A=
+CONFIG_MARVELL_PHY=3Dm=0A=
+CONFIG_DAVICOM_PHY=3Dm=0A=
+CONFIG_QSEMI_PHY=3Dm=0A=
+CONFIG_LXT_PHY=3Dm=0A=
+CONFIG_CICADA_PHY=3Dm=0A=
+=0A=
+#=0A=
+# Ethernet (10 or 100Mbit)=0A=
+#=0A=
+CONFIG_NET_ETHERNET=3Dy=0A=
+CONFIG_MII=3Dy=0A=
+CONFIG_IDT_RC32438_ETH=3Dy=0A=
+# CONFIG_HAPPYMEAL is not set=0A=
+# CONFIG_SUNGEM is not set=0A=
+# CONFIG_CASSINI is not set=0A=
+# CONFIG_NET_VENDOR_3COM is not set=0A=
+# CONFIG_DM9000 is not set=0A=
+=0A=
+#=0A=
+# Tulip family network device support=0A=
+#=0A=
+# CONFIG_NET_TULIP is not set=0A=
+# CONFIG_HP100 is not set=0A=
+CONFIG_NET_PCI=3Dy=0A=
+# CONFIG_PCNET32 is not set=0A=
+# CONFIG_AMD8111_ETH is not set=0A=
+# CONFIG_ADAPTEC_STARFIRE is not set=0A=
+# CONFIG_B44 is not set=0A=
+# CONFIG_FORCEDETH is not set=0A=
+# CONFIG_DGRS is not set=0A=
+# CONFIG_EEPRO100 is not set=0A=
+CONFIG_E100=3Dy=0A=
+# CONFIG_FEALNX is not set=0A=
+# CONFIG_NATSEMI is not set=0A=
+# CONFIG_NE2K_PCI is not set=0A=
+# CONFIG_8139CP is not set=0A=
+# CONFIG_8139TOO is not set=0A=
+# CONFIG_SIS900 is not set=0A=
+# CONFIG_EPIC100 is not set=0A=
+# CONFIG_SUNDANCE is not set=0A=
+# CONFIG_TLAN is not set=0A=
+# CONFIG_VIA_RHINE is not set=0A=
+# CONFIG_LAN_SAA9730 is not set=0A=
+=0A=
+#=0A=
+# Ethernet (1000 Mbit)=0A=
+#=0A=
+# CONFIG_ACENIC is not set=0A=
+# CONFIG_DL2K is not set=0A=
+# CONFIG_E1000 is not set=0A=
+# CONFIG_NS83820 is not set=0A=
+# CONFIG_HAMACHI is not set=0A=
+# CONFIG_YELLOWFIN is not set=0A=
+# CONFIG_R8169 is not set=0A=
+# CONFIG_SIS190 is not set=0A=
+# CONFIG_SKGE is not set=0A=
+# CONFIG_SKY2 is not set=0A=
+# CONFIG_SK98LIN is not set=0A=
+# CONFIG_VIA_VELOCITY is not set=0A=
+# CONFIG_TIGON3 is not set=0A=
+# CONFIG_BNX2 is not set=0A=
+=0A=
+#=0A=
+# Ethernet (10000 Mbit)=0A=
+#=0A=
+# CONFIG_CHELSIO_T1 is not set=0A=
+# CONFIG_IXGB is not set=0A=
+# CONFIG_S2IO is not set=0A=
+=0A=
+#=0A=
+# Token Ring devices=0A=
+#=0A=
+# CONFIG_TR is not set=0A=
+=0A=
+#=0A=
+# Wireless LAN (non-hamradio)=0A=
+#=0A=
+# CONFIG_NET_RADIO is not set=0A=
+=0A=
+#=0A=
+# Wan interfaces=0A=
+#=0A=
+# CONFIG_WAN is not set=0A=
+# CONFIG_FDDI is not set=0A=
+# CONFIG_HIPPI is not set=0A=
+# CONFIG_PPP is not set=0A=
+# CONFIG_SLIP is not set=0A=
+# CONFIG_SHAPER is not set=0A=
+# CONFIG_NETCONSOLE is not set=0A=
+# CONFIG_NETPOLL is not set=0A=
+# CONFIG_NET_POLL_CONTROLLER is not set=0A=
+=0A=
+#=0A=
+# ISDN subsystem=0A=
+#=0A=
+# CONFIG_ISDN is not set=0A=
+=0A=
+#=0A=
+# Telephony Support=0A=
+#=0A=
+# CONFIG_PHONE is not set=0A=
+=0A=
+#=0A=
+# Input device support=0A=
+#=0A=
+CONFIG_INPUT=3Dy=0A=
+=0A=
+#=0A=
+# Userland interfaces=0A=
+#=0A=
+# CONFIG_INPUT_MOUSEDEV is not set=0A=
+# CONFIG_INPUT_JOYDEV is not set=0A=
+# CONFIG_INPUT_TSDEV is not set=0A=
+# CONFIG_INPUT_EVDEV is not set=0A=
+# CONFIG_INPUT_EVBUG is not set=0A=
+=0A=
+#=0A=
+# Input Device Drivers=0A=
+#=0A=
+# CONFIG_INPUT_KEYBOARD is not set=0A=
+# CONFIG_INPUT_MOUSE is not set=0A=
+# CONFIG_INPUT_JOYSTICK is not set=0A=
+# CONFIG_INPUT_TOUCHSCREEN is not set=0A=
+# CONFIG_INPUT_MISC is not set=0A=
+=0A=
+#=0A=
+# Hardware I/O ports=0A=
+#=0A=
+# CONFIG_SERIO is not set=0A=
+# CONFIG_GAMEPORT is not set=0A=
+=0A=
+#=0A=
+# Character devices=0A=
+#=0A=
+CONFIG_VT=3Dy=0A=
+CONFIG_VT_CONSOLE=3Dy=0A=
+CONFIG_HW_CONSOLE=3Dy=0A=
+# CONFIG_SERIAL_NONSTANDARD is not set=0A=
+=0A=
+#=0A=
+# Serial drivers=0A=
+#=0A=
+CONFIG_SERIAL_8250=3Dy=0A=
+CONFIG_SERIAL_8250_CONSOLE=3Dy=0A=
+CONFIG_SERIAL_8250_NR_UARTS=3D4=0A=
+CONFIG_SERIAL_8250_RUNTIME_UARTS=3D4=0A=
+# CONFIG_SERIAL_8250_EXTENDED is not set=0A=
+=0A=
+#=0A=
+# Non-8250 serial port support=0A=
+#=0A=
+CONFIG_SERIAL_CORE=3Dy=0A=
+CONFIG_SERIAL_CORE_CONSOLE=3Dy=0A=
+# CONFIG_SERIAL_JSM is not set=0A=
+CONFIG_UNIX98_PTYS=3Dy=0A=
+CONFIG_LEGACY_PTYS=3Dy=0A=
+CONFIG_LEGACY_PTY_COUNT=3D256=0A=
+=0A=
+#=0A=
+# IPMI=0A=
+#=0A=
+# CONFIG_IPMI_HANDLER is not set=0A=
+=0A=
+#=0A=
+# Watchdog Cards=0A=
+#=0A=
+# CONFIG_WATCHDOG is not set=0A=
+# CONFIG_RTC is not set=0A=
+# CONFIG_GEN_RTC is not set=0A=
+# CONFIG_DTLK is not set=0A=
+# CONFIG_R3964 is not set=0A=
+# CONFIG_APPLICOM is not set=0A=
+=0A=
+#=0A=
+# Ftape, the floppy tape device driver=0A=
+#=0A=
+# CONFIG_DRM is not set=0A=
+# CONFIG_RAW_DRIVER is not set=0A=
+=0A=
+#=0A=
+# TPM devices=0A=
+#=0A=
+# CONFIG_TCG_TPM is not set=0A=
+# CONFIG_TELCLOCK is not set=0A=
+=0A=
+#=0A=
+# I2C support=0A=
+#=0A=
+# CONFIG_I2C is not set=0A=
+=0A=
+#=0A=
+# SPI support=0A=
+#=0A=
+# CONFIG_SPI is not set=0A=
+# CONFIG_SPI_MASTER is not set=0A=
+=0A=
+#=0A=
+# Dallas's 1-wire bus=0A=
+#=0A=
+# CONFIG_W1 is not set=0A=
+=0A=
+#=0A=
+# Hardware Monitoring support=0A=
+#=0A=
+# CONFIG_HWMON is not set=0A=
+# CONFIG_HWMON_VID is not set=0A=
+=0A=
+#=0A=
+# Misc devices=0A=
+#=0A=
+=0A=
+#=0A=
+# Multimedia Capabilities Port drivers=0A=
+#=0A=
+=0A=
+#=0A=
+# Multimedia devices=0A=
+#=0A=
+# CONFIG_VIDEO_DEV is not set=0A=
+=0A=
+#=0A=
+# Digital Video Broadcasting Devices=0A=
+#=0A=
+# CONFIG_DVB is not set=0A=
+=0A=
+#=0A=
+# Graphics support=0A=
+#=0A=
+# CONFIG_FB is not set=0A=
+=0A=
+#=0A=
+# Console display driver support=0A=
+#=0A=
+# CONFIG_VGA_CONSOLE is not set=0A=
+CONFIG_DUMMY_CONSOLE=3Dy=0A=
+=0A=
+#=0A=
+# Sound=0A=
+#=0A=
+# CONFIG_SOUND is not set=0A=
+=0A=
+#=0A=
+# USB support=0A=
+#=0A=
+CONFIG_USB_ARCH_HAS_HCD=3Dy=0A=
+CONFIG_USB_ARCH_HAS_OHCI=3Dy=0A=
+# CONFIG_USB is not set=0A=
+=0A=
+#=0A=
+# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'=0A=
+#=0A=
+=0A=
+#=0A=
+# USB Gadget Support=0A=
+#=0A=
+# CONFIG_USB_GADGET is not set=0A=
+=0A=
+#=0A=
+# MMC/SD Card support=0A=
+#=0A=
+# CONFIG_MMC is not set=0A=
+=0A=
+#=0A=
+# InfiniBand support=0A=
+#=0A=
+# CONFIG_INFINIBAND is not set=0A=
+=0A=
+#=0A=
+# SN Devices=0A=
+#=0A=
+=0A=
+#=0A=
+# EDAC - error detection and reporting (RAS)=0A=
+#=0A=
+=0A=
+#=0A=
+# File systems=0A=
+#=0A=
+CONFIG_EXT2_FS=3Dy=0A=
+# CONFIG_EXT2_FS_XATTR is not set=0A=
+# CONFIG_EXT2_FS_XIP is not set=0A=
+# CONFIG_EXT3_FS is not set=0A=
+# CONFIG_REISERFS_FS is not set=0A=
+# CONFIG_JFS_FS is not set=0A=
+# CONFIG_FS_POSIX_ACL is not set=0A=
+# CONFIG_XFS_FS is not set=0A=
+# CONFIG_OCFS2_FS is not set=0A=
+# CONFIG_MINIX_FS is not set=0A=
+# CONFIG_ROMFS_FS is not set=0A=
+# CONFIG_INOTIFY is not set=0A=
+# CONFIG_QUOTA is not set=0A=
+# CONFIG_DNOTIFY is not set=0A=
+# CONFIG_AUTOFS_FS is not set=0A=
+# CONFIG_AUTOFS4_FS is not set=0A=
+# CONFIG_FUSE_FS is not set=0A=
+=0A=
+#=0A=
+# CD-ROM/DVD Filesystems=0A=
+#=0A=
+# CONFIG_ISO9660_FS is not set=0A=
+# CONFIG_UDF_FS is not set=0A=
+=0A=
+#=0A=
+# DOS/FAT/NT Filesystems=0A=
+#=0A=
+# CONFIG_MSDOS_FS is not set=0A=
+# CONFIG_VFAT_FS is not set=0A=
+# CONFIG_NTFS_FS is not set=0A=
+=0A=
+#=0A=
+# Pseudo filesystems=0A=
+#=0A=
+CONFIG_PROC_FS=3Dy=0A=
+CONFIG_PROC_KCORE=3Dy=0A=
+CONFIG_SYSFS=3Dy=0A=
+# CONFIG_TMPFS is not set=0A=
+# CONFIG_HUGETLB_PAGE is not set=0A=
+CONFIG_RAMFS=3Dy=0A=
+# CONFIG_RELAYFS_FS is not set=0A=
+# CONFIG_CONFIGFS_FS is not set=0A=
+=0A=
+#=0A=
+# Miscellaneous filesystems=0A=
+#=0A=
+# CONFIG_ADFS_FS is not set=0A=
+# CONFIG_AFFS_FS is not set=0A=
+# CONFIG_HFS_FS is not set=0A=
+# CONFIG_HFSPLUS_FS is not set=0A=
+# CONFIG_BEFS_FS is not set=0A=
+# CONFIG_BFS_FS is not set=0A=
+# CONFIG_EFS_FS is not set=0A=
+# CONFIG_CRAMFS is not set=0A=
+# CONFIG_VXFS_FS is not set=0A=
+# CONFIG_HPFS_FS is not set=0A=
+# CONFIG_QNX4FS_FS is not set=0A=
+# CONFIG_SYSV_FS is not set=0A=
+# CONFIG_UFS_FS is not set=0A=
+=0A=
+#=0A=
+# Network File Systems=0A=
+#=0A=
+# CONFIG_NFS_FS is not set=0A=
+# CONFIG_NFSD is not set=0A=
+# CONFIG_SMB_FS is not set=0A=
+# CONFIG_CIFS is not set=0A=
+# CONFIG_NCP_FS is not set=0A=
+# CONFIG_CODA_FS is not set=0A=
+# CONFIG_AFS_FS is not set=0A=
+# CONFIG_9P_FS is not set=0A=
+=0A=
+#=0A=
+# Partition Types=0A=
+#=0A=
+# CONFIG_PARTITION_ADVANCED is not set=0A=
+CONFIG_MSDOS_PARTITION=3Dy=0A=
+=0A=
+#=0A=
+# Native Language Support=0A=
+#=0A=
+# CONFIG_NLS is not set=0A=
+=0A=
+#=0A=
+# Profiling support=0A=
+#=0A=
+# CONFIG_PROFILING is not set=0A=
+=0A=
+#=0A=
+# Kernel hacking=0A=
+#=0A=
+# CONFIG_PRINTK_TIME is not set=0A=
+# CONFIG_MAGIC_SYSRQ is not set=0A=
+# CONFIG_DEBUG_KERNEL is not set=0A=
+CONFIG_LOG_BUF_SHIFT=3D14=0A=
+CONFIG_CROSSCOMPILE=3Dy=0A=
+CONFIG_CMDLINE=3D""=0A=
+=0A=
+#=0A=
+# Security options=0A=
+#=0A=
+# CONFIG_KEYS is not set=0A=
+# CONFIG_SECURITY is not set=0A=
+=0A=
+#=0A=
+# Cryptographic options=0A=
+#=0A=
+# CONFIG_CRYPTO is not set=0A=
+=0A=
+#=0A=
+# Hardware crypto devices=0A=
+#=0A=
+=0A=
+#=0A=
+# Library routines=0A=
+#=0A=
+CONFIG_CRC_CCITT=3Dy=0A=
+CONFIG_CRC16=3Dm=0A=
+CONFIG_CRC32=3Dy=0A=
+# CONFIG_LIBCRC32C is not set=0A=
+CONFIG_TEXTSEARCH=3Dy=0A=
+CONFIG_TEXTSEARCH_KMP=3Dm=0A=
+CONFIG_TEXTSEARCH_BM=3Dm=0A=
+CONFIG_TEXTSEARCH_FSM=3Dm=0A=
diff -uNr linux-2.6.16-rc5/arch/mips/idt-boards/Kconfig =
acacia/arch/mips/idt-boards/Kconfig=0A=
--- linux-2.6.16-rc5/arch/mips/idt-boards/Kconfig	1969-12-31 =
16:00:00.000000000 -0800=0A=
+++ acacia/arch/mips/idt-boards/Kconfig	2006-03-14 13:42:54.000000000 =
-0800=0A=
@@ -0,0 +1,42 @@=0A=
+config IDT_EB438=0A=
+	bool " Support for the IDT 79EB438 evaluation board"=0A=
+	depends on IDT_BOARDS=0A=
+	select DMA_NONCOHERENT=0A=
+	select IRQ_CPU=0A=
+	select HW_HAS_PCI=0A=
+	select SWAP_IO_SPACE=0A=
+	select SYS_HAS_CPU_MIPS32_R1=0A=
+	select SYS_SUPPORTS_LITTLE_ENDIAN=0A=
+	select BOOT_ELF32=0A=
+	select SYS_SUPPORTS_32BIT_KERNEL=0A=
+	select SYS_SUPPORTS_BIG_ENDIAN=0A=
+	help=0A=
+	 IDT evaluation board based on RC32438 Interprise Processor=0A=
+=0A=
+config RC32438_REVISION_ZA=0A=
+	bool " Support for ZA version"=0A=
+	depends on IDT_EB438=0A=
+	help=0A=
+	 Enable this option for enabling the workaround for the bugs=0A=
+	 in the ZA part.=0A=
+=0A=
+config  IDT_BOARD_FREQ=0A=
+        int "  Board Frequency (HZ)"=0A=
+        depends on IDT_EB438 =0A=
+        default 100000000 if IDT_EB434 =0A=
+        help=0A=
+         Specify the board frequency in Hz.=0A=
+=0A=
+config  IDT_ZIMAGE_ADDR=0A=
+        hex "  zImage Address"=0A=
+        depends on IDT_EB438 =0A=
+        default "0x88000000" if IDT_EB438=0A=
+        help=0A=
+         You may create a compressed image by running 'make zImage' =
that can=0A=
+         either be loaded using the bootloader, or can be burned into =
the flash.=0A=
+         Specify the address where zImage will be loaded. The default =
address=0A=
+         is that of flash.=0A=
+=0A=
+config  IDT_BOOT_NVRAM=0A=
+        depends on IDT_EB438=0A=
+        bool "  Enable reading environment variables from NVRAM"=0A=
diff -uNr =
linux-2.6.16-rc5/arch/mips/idt-boards/rc32438/EB438/boot/csu_idt.S =
acacia/arch/mips/idt-boards/rc32438/EB438/boot/csu_idt.S=0A=
--- linux-2.6.16-rc5/arch/mips/idt-boards/rc32438/EB438/boot/csu_idt.S	=
1969-12-31 16:00:00.000000000 -0800=0A=
+++ acacia/arch/mips/idt-boards/rc32438/EB438/boot/csu_idt.S	2006-03-14 =
13:36:04.000000000 -0800=0A=
@@ -0,0 +1,414 @@=0A=
+/**********************************************************************=
****=0A=
+ *=0A=
+ *  BRIEF MODULE DESCRIPTION=0A=
+ *   Board initialization code.=0A=
+ *=0A=
+ *  Copyright 2006 IDT Inc. (rischelp@idt.com)=0A=
+ *         =0A=
+ *  This program is free software; you can redistribute  it and/or =
modify it=0A=
+ *  under  the terms of  the GNU General  Public License as published =
by the=0A=
+ *  Free Software Foundation;  either version 2 of the  License, or =
(at your=0A=
+ *  option) any later version.=0A=
+ *=0A=
+ *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR =
IMPLIED=0A=
+ *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED =
WARRANTIES OF=0A=
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE =
DISCLAIMED.  IN=0A=
+ *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, =
INDIRECT,=0A=
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES =
(INCLUDING, BUT=0A=
+ *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; =
LOSS OF=0A=
+ *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED =
AND ON=0A=
+ *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, =
OR TORT=0A=
+ *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE =
USE OF=0A=
+ *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH =
DAMAGE.=0A=
+ *=0A=
+ *  You should have received a copy of the  GNU General Public License =
along=0A=
+ *  with this program; if not, write  to the Free Software Foundation, =
Inc.,=0A=
+ *  675 Mass Ave, Cambridge, MA 02139, USA.=0A=
+ *=0A=
+ =
************************************************************************=
**=0A=
+ */=0A=
+=0A=
+#include <linux/config.h>=0A=
+#include <linux/threads.h>=0A=
+=0A=
+#include <asm/asm.h>=0A=
+#include <asm/mipsregs.h>=0A=
+#include <asm/asm-offsets.h>=0A=
+#include <asm/cachectl.h>=0A=
+=0A=
+#include "idthdr.h"=0A=
+#include "iregdef.h"=0A=
+#include "idtcpu.h"=0A=
+#include "s438ram.h"=0A=
+#include "s438.h"=0A=
+=0A=
+/*--------------------------------------------------------------=0A=
+** prom entry point table=0A=
+*-------------------------------------------------------------*/=0A=
+=0A=
+FRAME(start,sp,0,ra)=0A=
+	j idtstart        /* begin monitor from start       |00| */=0A=
+=0A=
+idtstart:=0A=
+=0A=
+  .set  noreorder=0A=
+/* ------ Alternate functions for GPIO pins =
--------------------------------*/=0A=
+/* Neb: only UART0, UART1 and mem_addr */=0A=
+	li    t0, GPIO_BASE=0A=
+	li    t1, 0x00f00303=0A=
+	sw    t1, 0x0(t0)=0A=
+      =0A=
+	mtc0  zero, C0_CAUSE=0A=
+        nop=0A=
+	li    v0, 0x0=0A=
+	or    v0, (SR_CU0 | SR_BEV)=0A=
+	mtc0  v0, C0_SR=0A=
+        nop=0A=
+	mfc0  v1, C0_CONFIG=0A=
+	nop=0A=
+	and   v1, ~(0x7)=0A=
+	ori   v1, 0x3=0A=
+	mtc0  v1, C0_CONFIG=0A=
+        nop=0A=
+        nop=0A=
+            =0A=
+/* ------------------- Disable WatchDog Timer =
----------------------------- */=0A=
+      li    t0, WTC_BASE=0A=
+      li    t1, 0x0=0A=
+      sw    t1, 0x3C(t0) /* WTC */=0A=
+=0A=
+/* ------------- Clear PCI Local Base Control registers =
------------------- */=0A=
+      li    t0, 0xb8080000=0A=
+      sw    zero, 0x18(t0)=0A=
+      sw    zero, 0x24(t0)=0A=
+      sw    zero, 0x30(t0)=0A=
+      sw    zero, 0x3c(t0)=0A=
+=0A=
+/* ------------------- Assert PCI reset =
----------------------------------- */=0A=
+      lw    t1, (t0)=0A=
+      andi  t2, t1, 0x1=0A=
+      beqz  t2, 2f=0A=
+            nop=0A=
+      andi  t2, t1, 0x3fe=0A=
+      sw    t2, (t0)=0A=
+      li    t2, 0x1000=0A=
+1:=0A=
+      addi  t2, -1=0A=
+      bnez  t2, 1b=0A=
+            nop=0A=
+2:=0A=
+      ori   t2, t1, 0x1=0A=
+      sw    t2, (t0)=0A=
+      lui   t2, 0x2=0A=
+rip:=0A=
+      lw    t1, 4(t0)=0A=
+      and   t1, t1, t2=0A=
+      bnez  t1, rip=0A=
+            nop=0A=
+=0A=
+/* ----------- Set Disable Write Transaction Merging on IPBus =
------------- */=0A=
+      lui   t0, 0xb804=0A=
+      li    t1, 0x8=0A=
+      sw    t1, 0x4054(t0)=0A=
+=0A=
+/* ------------------- Setup Device Controller =
---------------------------- */=0A=
+      li    t0, DEV_CTL_BASE      /* load 2 base address registers' =
base    */=0A=
+      lui   t2, 0xB800=0A=
+      lw    t1, 0x8004(t2)        /* get BCV                           =
     */=0A=
+      li    t2, 0x80              /* check width of boot device 8/16 =
bit    */=0A=
+      and   t1, t1, t2=0A=
+      bnez  t1, 1f                =0A=
+            nop=0A=
+    /* 8 bit device - boot from PROM - CS1 is FLASH                    =
     */=0A=
+      li    t1, DEV_PROM_CTRL     /* device0 control parameter         =
     */=0A=
+      sw    t1, 0x8(t0)           /* set the control register  CS0     =
     */=0A=
+      li    t1, DEV_PROM_TC       /* device0 timing config parameter   =
     */=0A=
+      sw    t1, 0xC(t0)=0A=
+      li    t1, DEV1_BASE         /* set the device base register for =
CS1   */=0A=
+      sw    t1, 0x10(t0)=0A=
+      li    t1, DEV_FLASH_MASK    /* set the device mask register for =
CS1   */=0A=
+      sw    t1, 0x14(t0) =0A=
+      li    t1, DEV_FLASH_CTRL    /* set the device control register =
for CS1*/=0A=
+      sw    t1, 0x18(t0)=0A=
+      li    t1, DEV_FLASH_TC      /* set the device timing register =
for CS1 */=0A=
+      sw    t1, 0x1C(t0) =0A=
+      b     2f                    =0A=
+            nop=0A=
+1:=0A=
+    /* 16 bit device - boot from FLASH - CS1 is PROM                   =
     */=0A=
+      li    t1, DEV_FLASH_CTRL    /* device0 control parameter         =
     */=0A=
+      sw    t1, 0x8(t0)           /* set the control register  CS0     =
     */=0A=
+      li    t1, DEV_FLASH_TC      /* device0 timing config parameter   =
     */=0A=
+      sw    t1, 0xC(t0)=0A=
+      li    t1, DEV1_BASE         /* set the device base register for =
CS1   */=0A=
+      sw    t1, 0x10(t0)=0A=
+      li    t1, DEV_PROM_MASK     /* set the device mask register for =
CS1   */=0A=
+      sw    t1, 0x14(t0) =0A=
+      li    t1, DEV_PROM_CTRL     /* set the device control register =
for CS1*/=0A=
+      sw    t1, 0x18(t0)=0A=
+      li    t1, DEV_PROM_TC       /* set the device timing register =
for CS1 */=0A=
+      sw    t1, 0x1C(t0) =0A=
+2:=0A=
+      li    t1, DEV2_BASE         /* set the device base register for =
CS1   */=0A=
+      sw    t1, 0x20(t0)=0A=
+      li    t1, DEV2_MASK         /* set the device mask register for =
CS1   */=0A=
+      sw    t1, 0x24(t0) =0A=
+      li    t1, DEV2_CTRL         /* set the device control register =
for CS1*/=0A=
+      sw    t1, 0x28(t0)=0A=
+      li    t1, DEV2_TC           /* set the device timing register =
for CS1 */=0A=
+      sw    t1, 0x2C(t0) =0A=
+=0A=
+      li    t1, DEV3_BASE         /* set the device base register for =
CS1   */=0A=
+      sw    t1, 0x30(t0)=0A=
+      li    t1, DEV3_MASK         /* set the device mask register for =
CS1   */=0A=
+      sw    t1, 0x34(t0) =0A=
+      li    t1, DEV3_CTRL         /* set the device control register =
for CS1*/=0A=
+      sw    t1, 0x38(t0)=0A=
+      li    t1, DEV3_TC           /* set the device timing register =
for CS1 */=0A=
+      sw    t1, 0x3C(t0) =0A=
+=0A=
+      li    t1, DEV4_BASE         /* set the device base register for =
CS1   */=0A=
+      sw    t1, 0x40(t0)=0A=
+      li    t1, DEV4_MASK         /* set the device mask register for =
CS1   */=0A=
+      sw    t1, 0x44(t0) =0A=
+      li    t1, DEV4_CTRL         /* set the device control register =
for CS1*/=0A=
+      sw    t1, 0x48(t0)=0A=
+      li    t1, DEV4_TC           /* set the device timing register =
for CS1 */=0A=
+      sw    t1, 0x4C(t0) =0A=
+=0A=
+      li    t1, DEV5_BASE         /* set the device base register for =
CS1   */=0A=
+      sw    t1, 0x50(t0)=0A=
+      li    t1, DEV5_MASK         /* set the device mask register for =
CS1   */=0A=
+      sw    t1, 0x54(t0) =0A=
+      li    t1, DEV5_CTRL         /* set the device control register =
for CS1*/=0A=
+      sw    t1, 0x58(t0)=0A=
+      li    t1, DEV5_TC           /* set the device timing register =
for CS1 */=0A=
+      sw    t1, 0x5C(t0) =0A=
+=0A=
+#if MEMCFG !=3D SRAM_ONLY=0A=
+=0A=
+/* ------------- INITIALIZE DDR SDRAM CONTROLLER =
---------------------------*/=0A=
+=0A=
+      li    t1, 0x0               /* Add 200 microseconds of delay =
*/=0A=
+      li    t2, DELAY_200USEC=0A=
+1:=0A=
+      add   t1, 1=0A=
+      bne   t1, t2, 1b=0A=
+            nop=0A=
+=0A=
+/*-------------- Initialize DDR Base and Mask Registers =
--------------------*/=0A=
+=0A=
+      li    t0, DDRBASE=0A=
+=0A=
+  /* Load the DDRC, reset  Refresh Enable */=0A=
+      li    t1, DDRC_VAL_AT_INIT=0A=
+      sw    t1, 0x10(t0)=0A=
+      =0A=
+      sw    zero, 0x4(t0)=0A=
+      sw    zero, 0xc(t0)=0A=
+      sw    zero, 0x18(t0)=0A=
+=0A=
+  /* Store DDR0BASE */=0A=
+      li    t1, DDR0_BASE_VAL=0A=
+      sw    t1, 0x0(t0)=0A=
+=0A=
+  /* Store DDR0MASK */=0A=
+      li    t1, DDR0_MASK_VAL=0A=
+      sw    t1, 0x4(t0)=0A=
+=0A=
+  /* Store DDR1BASE */=0A=
+      li    t1, DDR1_BASE_VAL=0A=
+      sw    t1, 0x8(t0)=0A=
+=0A=
+  /* Load DDR1MASK to disable DDR CS1 */=0A=
+      li    t1, DDR1_MASK_VAL=0A=
+      sw    t1, 0x0C(t0)=0A=
+=0A=
+  /* Store DDR0ABASE */=0A=
+      li    t1, DDR0_BASE_VAL=0A=
+      sw    t1, 0x14(t0)=0A=
+=0A=
+  /* Load DDR0AMASK to disable alternate Mapping */=0A=
+      li    t1, DDR0_AMASK_VAL=0A=
+      sw    t1, 0x18(t0)=0A=
+=0A=
+      li    t1, DDR_CUST_NOP      /* Write to DDR Custom transaction =
register */=0A=
+      sw    t1, 0x20(t0)=0A=
+=0A=
+      li    t2, DATA_PATTERN=0A=
+      li    t1, 0xA0000000 | DDR0_BASE_VAL=0A=
+      sw    t2, 0x0(t1)=0A=
+=0A=
+  /* Add 200 microseconds of delay */=0A=
+      li    t1, 0x0=0A=
+      li    t2, DELAY_200USEC=0A=
+1:=0A=
+      add   t1, 1=0A=
+      bne   t1, t2, 1b=0A=
+            nop=0A=
+            =0A=
+  /* Register t0 carries pointer to the DDR_BASE: 0xB8018000 */=0A=
+      li    t1, DDR_CUST_PRECHARGE=0A=
+      sw    t1, 0x20(t0)    /* Write to DDR Custom transaction =
register */=0A=
+=0A=
+  /* Generate A10 high to pre-charge both the banks */=0A=
+      li    t2, DATA_PATTERN=0A=
+      li    t1, 0xA0000000 | DDR_PRECHARGE_OFFSET | DDR0_BASE_VAL=0A=
+      sw    t2, 0x0(t1)=0A=
+=0A=
+  /* Register t0 carries pointer to the DDR_BASE: 0xB8018000 */=0A=
+      li    t1, DDR_LD_EMODE_REG=0A=
+      sw    t1, 0x20(t0)    /* Write to DDR Custom transaction =
register */=0A=
+=0A=
+  /* Generate EMODE register contents on A15-A2 */=0A=
+      li    t2, DATA_PATTERN=0A=
+      li    t1, 0xA0000000 | DDR_EMODE_VAL | DDR0_BASE_VAL=0A=
+      sw    t2, 0x0(t1)=0A=
+=0A=
+  /* Register t0 carries pointer to the DDR_BASE: 0xB8018000 */=0A=
+      li    t1, DDR_LD_MODE_REG=0A=
+      sw    t1, 0x20(t0)    /* Write to DDR Custom transaction =
register */=0A=
+=0A=
+  /* Generate Mode register contents on the address bus A15-A2  */=0A=
+      li    t2, DATA_PATTERN=0A=
+      li    t1, 0xA0000000 | DDR_DLL_RES_MODE_VAL | DDR0_BASE_VAL=0A=
+      sw    t2, 0x0(t1)=0A=
+=0A=
+  /* Delay of  1.6 microseconds ~ 300 delay iteration value */=0A=
+      li    t1, 0x0=0A=
+      li    t2, 500=0A=
+1:=0A=
+      add   t1, 1=0A=
+      bne   t1, t2, 1b=0A=
+            nop=0A=
+=0A=
+  /* Register t0 carries pointer to the DDR_BASE: 0xB8018000 */=0A=
+      li    t1, DDR_CUST_PRECHARGE=0A=
+      sw    t1, 0x20(t0)    /* Write to DDR Custom transaction =
register */=0A=
+=0A=
+  /* Generate A10 high to pre-charge both the banks */=0A=
+      li    t2, DATA_PATTERN=0A=
+      li    t1, 0xA0000000 | DDR_PRECHARGE_OFFSET | DDR0_BASE_VAL=0A=
+      sw    t2, 0x0(t1)=0A=
+=0A=
+  /* Implements 9 cycles of Auto refresh allowing =0A=
+     sufficient margin for stability*/=0A=
+      li    t4, 9=0A=
+      li    t3, 0=0A=
+1:=0A=
+      li    t1, DDR_CUST_REFRESH=0A=
+      sw    t1, 0x20(t0)    /* Write to DDR Custom transaction =
register */=0A=
+=0A=
+  /* Read it back to flush CPU write buffers */=0A=
+      lw    t1, 0x20(t0)=0A=
+=0A=
+  /* Access DDR */=0A=
+      li    t2, DATA_PATTERN=0A=
+      li    t1, 0xA0000000 | DDR0_BASE_VAL=0A=
+      sw    t2, 0x0(t1)=0A=
+=0A=
+      add   t3, 1=0A=
+      bne   t3, t4, 1b=0A=
+            nop=0A=
+=0A=
+  /* Register t0 carries pointer to the DDR_BASE: 0xB8018000 */=0A=
+      li    t1, DDR_LD_MODE_REG=0A=
+      sw    t1, 0x20(t0)    /* Write to DDR Custom transaction =
register */=0A=
+=0A=
+  /* Generate Mode Register contents on the address bus A12-A0 */=0A=
+      li    t2, DATA_PATTERN=0A=
+      li    t1, 0xA0000000 | DDR_DLL_MODE_VAL | DDR0_BASE_VAL=0A=
+      sw    t2, 0x0(t1)=0A=
+=0A=
+  /* Initialize the refresh timer with fast refresh count */=0A=
+      li    t0, RCOUNT=0A=
+      li    t1, DDR_REF_CMP_FAST=0A=
+      =0A=
+  /* Set the RCOMPARE register */=0A=
+      sw    t1, 0x4(t0)=0A=
+=0A=
+  /* Enable the Refresh timer */=0A=
+      li    t1, 0x1           /* CE set to enabled the  Refresh =
counter */=0A=
+      sw    t1, 0x8(t0)=0A=
+=0A=
+  /* Enable RE-refresh enable in the DDRC register */=0A=
+      li    t0, DDRBASE=0A=
+      li    t1, DDRC_VAL_NORMAL=0A=
+      sw    t1, 0x10(t0)=0A=
+=0A=
+  /* Add 200 microseconds of delay */=0A=
+      li    t1, 0x0=0A=
+      li    t2, DELAY_200USEC=0A=
+1:=0A=
+      add   t1, 1=0A=
+      bne   t1, t2, 1b=0A=
+            nop=0A=
+=0A=
+      li    t0, RCOUNT=0A=
+=0A=
+  /* Find Refresh Timer Compare value value based on revision - Check =
for IP7 */=0A=
+      li    t2, 0x1=0A=
+      mtc0  t2, C0_COMPARE=0A=
+      mtc0  zero, C0_COUNT=0A=
+            nop=0A=
+            nop=0A=
+      mfc0  t1, C0_CAUSE=0A=
+            nop=0A=
+      li    t3, DDR_REF_CMP_VAL_ZB=0A=
+      andi  t1, 0x8000=0A=
+      bnez  t1, acacia_zb=0A=
+            nop=0A=
+      li    t3, DDR_REF_CMP_VAL=0A=
+acacia_zb:=0A=
+=0A=
+  /* Disable the refresh counter before changing the compare value =
*/=0A=
+      li    t1, 0x0=0A=
+      sw    t1, 0x8(t0)=0A=
+=0A=
+  /* Set the RCOMPARE register */=0A=
+      sw    t3, 0x4(t0)=0A=
+=0A=
+  /* Enable the Refresh timer */=0A=
+      li    t1, 0x1           /* CE set to enabled the  Refresh =
counter */=0A=
+      sw    t1, 0x8(t0)=0A=
+=0A=
+  /* Add 200 microseconds of delay */=0A=
+      li    t1, 0x0=0A=
+      li    t2, DELAY_200USEC=0A=
+1:=0A=
+      add   t1, 1=0A=
+      bne   t1, t2, 1b=0A=
+            nop=0A=
+=0A=
+#endif=0A=
+	li    t0, 0xa0000000=0A=
+	li    t1, 0xa0100000=0A=
+1:=0A=
+	sw    zero, 0x00(t0)=0A=
+	sw    zero, 0x04(t0)=0A=
+	sw    zero, 0x08(t0)=0A=
+	sw    zero, 0x0c(t0)=0A=
+	addiu t0, 16=0A=
+	nop=0A=
+	blt   t0, t1, 1b=0A=
+	nop=0A=
+	nop=0A=
+	nop=0A=
+3:=0A=
+	mfc0  t0, C0_SR=0A=
+	nop=0A=
+	nop=0A=
+	and   t0, ~SR_BEV=0A=
+	mtc0  t0, C0_SR=0A=
+	nop=0A=
+	nop=0A=
+4:=0A=
+=0A=
+/* Jump to zImage startup */=0A=
+	=0A=
+	la     k0, zstartup=0A=
+	j      k0=0A=
+	nop=0A=
+	nop=0A=
+=0A=
+ENDFRAME(start)=0A=
diff -uNr =
linux-2.6.16-rc5/arch/mips/idt-boards/rc32438/EB438/boot/head.S =
acacia/arch/mips/idt-boards/rc32438/EB438/boot/head.S=0A=
--- linux-2.6.16-rc5/arch/mips/idt-boards/rc32438/EB438/boot/head.S	=
1969-12-31 16:00:00.000000000 -0800=0A=
+++ acacia/arch/mips/idt-boards/rc32438/EB438/boot/head.S	2006-03-14 =
13:36:04.000000000 -0800=0A=
@@ -0,0 +1,126 @@=0A=
+/**********************************************************************=
****=0A=
+ *=0A=
+ *  BRIEF MODULE DESCRIPTION=0A=
+ *   Board initialisation code.=0A=
+ *=0A=
+ *  Copyright 2006 IDT Inc. (rischelp@idt.com)=0A=
+ *         =0A=
+ *  This program is free software; you can redistribute  it and/or =
modify it=0A=
+ *  under  the terms of  the GNU General  Public License as published =
by the=0A=
+ *  Free Software Foundation;  either version 2 of the  License, or =
(at your=0A=
+ *  option) any later version.=0A=
+ *=0A=
+ *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR =
IMPLIED=0A=
+ *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED =
WARRANTIES OF=0A=
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE =
DISCLAIMED.  IN=0A=
+ *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, =
INDIRECT,=0A=
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES =
(INCLUDING, BUT=0A=
+ *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; =
LOSS OF=0A=
+ *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED =
AND ON=0A=
+ *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, =
OR TORT=0A=
+ *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE =
USE OF=0A=
+ *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH =
DAMAGE.=0A=
+ *=0A=
+ *  You should have received a copy of the  GNU General Public License =
along=0A=
+ *  with this program; if not, write  to the Free Software Foundation, =
Inc.,=0A=
+ *  675 Mass Ave, Cambridge, MA 02139, USA.=0A=
+ *=0A=
+ =
************************************************************************=
**=0A=
+ */=0A=
+=0A=
+#include <linux/config.h>=0A=
+#include <linux/threads.h>=0A=
+=0A=
+#include <asm/asm.h>=0A=
+#include <asm/cacheops.h>=0A=
+#include <asm/mipsregs.h>=0A=
+#include <asm/asm-offsets.h>=0A=
+#include <asm/cachectl.h>=0A=
+#include <asm/regdef.h>=0A=
+=0A=
+#define IndexInvalidate_I       0x00=0A=
+=0A=
+	.set noreorder=0A=
+	.cprestore=0A=
+	LEAF(zstartup)=0A=
+zstartup:=0A=
+=0A=
+        la      sp, .stack=0A=
+	move	s0, a0=0A=
+	move	s1, a1=0A=
+	move	s2, a2=0A=
+	move	s3, a3=0A=
+=0A=
+	/* Clear BSS */=0A=
+	/* Note: when zImage is in ROM, _edata and _bss point to=0A=
+	 * ROM space even when using -Tbss on the linker command line;=0A=
+	 * maybe ld.script needs to be corrected.=0A=
+	 */=0A=
+	la	a0, .stack=0A=
+	la	a2, _end=0A=
+1:	sw	zero, 0(a0)=0A=
+	bne	a2, a0, 1b=0A=
+	addu	a0, 4=0A=
+=0A=
+	/* flush the I-Cache */=0A=
+	li	k0, 0x80000000  # start address=0A=
+	li	k1, 0x80004000  # end address (16KB I-Cache)=0A=
+	subu	k1, 128=0A=
+=0A=
+2:=0A=
+	.set mips3=0A=
+	cache   IndexInvalidate_I, 0(k0)=0A=
+	cache   IndexInvalidate_I, 16(k0)=0A=
+	cache   IndexInvalidate_I, 32(k0)=0A=
+	cache   IndexInvalidate_I, 48(k0)=0A=
+	cache   IndexInvalidate_I, 64(k0)=0A=
+	cache   IndexInvalidate_I, 80(k0)=0A=
+	cache   IndexInvalidate_I, 96(k0)=0A=
+	cache   IndexInvalidate_I, 112(k0)=0A=
+	.set mips0=0A=
+=0A=
+	bne	k0, k1, 2b=0A=
+	addu	k0, k0, 128=0A=
+	/* done */=0A=
+=0A=
+	/* flush the D-Cache */=0A=
+	li	k0, 0x80000000  # start address=0A=
+	li	k1, 0x80004000  # end address (16KB I-Cache)=0A=
+	subu	k1, 128=0A=
+=0A=
+2:=0A=
+	.set mips3=0A=
+	cache   Index_Writeback_Inv_D, 0(k0)=0A=
+	cache   Index_Writeback_Inv_D, 16(k0)=0A=
+	cache   Index_Writeback_Inv_D, 32(k0)=0A=
+	cache   Index_Writeback_Inv_D, 48(k0)=0A=
+	cache   Index_Writeback_Inv_D, 64(k0)=0A=
+	cache   Index_Writeback_Inv_D, 80(k0)=0A=
+	cache   Index_Writeback_Inv_D, 96(k0)=0A=
+	cache   Index_Writeback_Inv_D, 112(k0)=0A=
+	.set mips0=0A=
+=0A=
+	bne	k0, k1, 2b=0A=
+	addu	k0, k0, 128=0A=
+	/* done */=0A=
+=0A=
+	la	ra, 3f=0A=
+	la	k0, decompress_kernel=0A=
+	jr	k0=0A=
+	nop=0A=
+3:=0A=
+=0A=
+	move	a0, s0=0A=
+	move	a1, s1=0A=
+	move	a2, s2=0A=
+	move	a3, s3=0A=
+	li	k0, KERNEL_ENTRY=0A=
+	jr	k0=0A=
+	nop=0A=
+4:=0A=
+	b 4b=0A=
+	END(zstartup)=0A=
+=0A=
+	.bss=0A=
+	.fill 0x2000=0A=
+	EXPORT(.stack)=0A=
diff -uNr =
linux-2.6.16-rc5/arch/mips/idt-boards/rc32438/EB438/boot/idtcpu.h =
acacia/arch/mips/idt-boards/rc32438/EB438/boot/idtcpu.h=0A=
--- linux-2.6.16-rc5/arch/mips/idt-boards/rc32438/EB438/boot/idtcpu.h	=
1969-12-31 16:00:00.000000000 -0800=0A=
+++ acacia/arch/mips/idt-boards/rc32438/EB438/boot/idtcpu.h	2006-03-14 =
13:36:04.000000000 -0800=0A=
@@ -0,0 +1,335 @@=0A=
+/**********************************************************************=
****=0A=
+ *=0A=
+ *  BRIEF MODULE DESCRIPTION=0A=
+ *   IDT CPU register definitions. Though the registers are already =
defined=0A=
+ *   under asm directory, they are once again declared here for the =
ease of=0A=
+ *   syncing up with IDT bootloader code.=0A=
+ *=0A=
+ *  Copyright 2006 IDT Inc. (rischelp@idt.com)=0A=
+ *         =0A=
+ *  This program is free software; you can redistribute  it and/or =
modify it=0A=
+ *  under  the terms of  the GNU General  Public License as published =
by the=0A=
+ *  Free Software Foundation;  either version 2 of the  License, or =
(at your=0A=
+ *  option) any later version.=0A=
+ *=0A=
+ *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR =
IMPLIED=0A=
+ *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED =
WARRANTIES OF=0A=
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE =
DISCLAIMED.  IN=0A=
+ *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, =
INDIRECT,=0A=
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES =
(INCLUDING, BUT=0A=
+ *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; =
LOSS OF=0A=
+ *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED =
AND ON=0A=
+ *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, =
OR TORT=0A=
+ *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE =
USE OF=0A=
+ *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH =
DAMAGE.=0A=
+ *=0A=
+ *  You should have received a copy of the  GNU General Public License =
along=0A=
+ *  with this program; if not, write  to the Free Software Foundation, =
Inc.,=0A=
+ *  675 Mass Ave, Cambridge, MA 02139, USA.=0A=
+ *=0A=
+ =
************************************************************************=
**=0A=
+ */=0A=
+=0A=
+#if !defined(__IDTCPU_H__)=0A=
+#define __IDTCPU_H__=0A=
+/*=0A=
+** memory configuration and mapping=0A=
+*/=0A=
+#define K0BASE		0x80000000=0A=
+#define K0SIZE		0x20000000=0A=
+#define K1BASE		0xa0000000=0A=
+#define K1SIZE		0x20000000=0A=
+#define K2BASE		0xc0000000=0A=
+#if defined(CPU_R32364)=0A=
+#define K2SIZE		0x40000000=0A=
+#define ICEBASE		0xff000000=0A=
+#define ICESIZE		0x01000000=0A=
+#elif defined(CPU_R32438)=0A=
+#define K2SIZE		0x20000000=0A=
+#define K3BASE		0xe0000000=0A=
+#define K3SIZE    0x20000000=0A=
+#define ICEBASE		0xff200000=0A=
+#define ICESIZE		0x00200000=0A=
+#endif=0A=
+=0A=
+#define KUBASE		0=0A=
+#define KUSIZE		0x80000000=0A=
+=0A=
+/*=0A=
+** Exception Vectors=0A=
+*/=0A=
+=0A=
+#define	T_VEC	(K0BASE + 0x000)			/* tlbmiss vector */=0A=
+#define X_VEC	(K0BASE + 0x080)			/* xtlbmiss vector */=0A=
+#define C_VEC	(K1BASE + 0x100)			/* cache error vector */=0A=
+#define E_VEC	(K0BASE + 0x180)			/* exception vector */=0A=
+#define I_VEC	(K0BASE + 0X200)			/* interrupt vector */=0A=
+#define	R_VEC	(K1BASE + 0x1fc00000)	/* reset vector */=0A=
+=0A=
+/*=0A=
+** Address conversion macros=0A=
+*/=0A=
+#ifdef CLANGUAGE=0A=
+#define	CAST(as) (as)=0A=
+#else=0A=
+#define	CAST(as)=0A=
+#endif=0A=
+=0A=
+#define	K0_TO_K1(x)		(CAST(unsigned)(x) | 0xA0000000)	/* kseg0 to =
kseg1 */=0A=
+#define	K1_TO_K0(x)		(CAST(unsigned)(x) & 0x9FFFFFFF)	/* kseg1 to =
kseg0 */=0A=
+#define	K0_TO_PHYS(x)	(CAST(unsigned)(x) & 0x1FFFFFFF)	/* kseg0 to =
physical */=0A=
+#define	K1_TO_PHYS(x)	(CAST(unsigned)(x) & 0x1FFFFFFF)	/* kseg1 to =
physical */=0A=
+#define	PHYS_TO_K0(x)	(CAST(unsigned)(x) | 0x80000000)	/* physical to =
kseg0 */=0A=
+#define	PHYS_TO_K1(x)	(CAST(unsigned)(x) | 0xA0000000)	/* physical to =
kseg1 */=0A=
+=0A=
+#if defined(CPU_R32364)             /* Includes RC32332, RC32334 */=0A=
+#define	CFG_ICE					0x80000000	/* ICE detect */=0A=
+#define	CFG_ECMASK			0x70000000	/* System Clock Ratio */=0A=
+#define	CFG_ECBY2				0x00000000 	/* divide by 2 */=0A=
+#define	CFG_ECBY3				0x10000000 	/* divide by 3 */=0A=
+#define	CFG_ECBY4				0x20000000 	/* divide by 4 */=0A=
+#define	CFG_BE					0x00008000	/* Big Endian */=0A=
+#define	CFG_ICMASK			0x00000e00	/* Instruction cache size */=0A=
+#define	CFG_ICSHIFT			9=0A=
+#define	CFG_DCMASK			0x000001c0	/* Data cache size */=0A=
+#define	CFG_DCSHIFT			6=0A=
+#define	CFG_IB					0x00000020	/* Instruction cache line size */=0A=
+#define	CFG_DB					0x00000010	/* Data cache line size */=0A=
+#define	CFG_K0MASK			0x00000007	/* KSEG0 coherency algorithm */=0A=
+#elif defined(CPU_R32438)=0A=
+#define	CFG_MM					0x00060000  /* write buffer Merge Mode */=0A=
+#define CFG_BM					0x00010000  /* Burst Mode */=0A=
+#define	CFG_BE					0x00008000	/* Big Endian */=0A=
+#define	CFG_K0MASK			0x00000007	/* KSEG0 coherency algorithm */=0A=
+#endif=0A=
+=0A=
+/*=0A=
+ * Primary cache mode=0A=
+ */=0A=
+#if defined(CPU_R32364)=0A=
+#define CFG_C_NCHRNT_WT_NWA			0=0A=
+#define CFG_C_NCHRNT_WT					1=0A=
+#define CFG_C_UNCACHED					2=0A=
+#define CFG_C_NCHRNT_WB					3=0A=
+=0A=
+/* Cache Operations */=0A=
+#define Index_Invalidate_I      0x0         /* 0       0 */=0A=
+#define Index_Writeback_Inv_D   0x1         /* 0       1 */=0A=
+#define Index_Invalidate_SI     0x2         /* 0       2 */=0A=
+#define Index_Writeback_Inv_SD  0x3         /* 0       3 */=0A=
+#define Index_Load_Tag_I        0x4         /* 1       0 */=0A=
+#define Index_Load_Tag_D        0x5         /* 1       1 */=0A=
+#define Index_Load_Tag_SI       0x6         /* 1       2 */=0A=
+#define Index_Load_Tag_SD       0x7         /* 1       3 */=0A=
+#define Index_Store_Tag_I       0x8         /* 2       0 */=0A=
+#define Index_Store_Tag_D       0x9         /* 2       1 */=0A=
+#define Index_Store_Tag_SI      0xA         /* 2       2 */=0A=
+#define Index_Store_Tag_SD      0xB         /* 2       3 */=0A=
+#define Create_Dirty_Exc_D      0xD         /* 3       1 */=0A=
+#define Create_Dirty_Exc_SD     0xF         /* 3       3 */=0A=
+#define Hit_Invalidate_I        0x10        /* 4       0 */=0A=
+#define Hit_Invalidate_D        0x11        /* 4       1 */=0A=
+#define Hit_Invalidate_SI       0x12        /* 4       2 */=0A=
+#define Hit_Invalidate_SD       0x13        /* 4       3 */=0A=
+#define Hit_Writeback_Inv_D     0x15        /* 5       1 */=0A=
+#define Hit_Writeback_Inv_SD    0x17        /* 5       3 */=0A=
+#define Fill_I                  0x14        /* 5       0 */=0A=
+#define Hit_Writeback_D         0x19        /* 6       1 */=0A=
+#define Hit_Writeback_SD        0x1B        /* 6       3 */=0A=
+#define Hit_Writeback_I         0x18        /* 6       0 */=0A=
+#define Hit_Set_Virtual_SI      0x1E        /* 7       2 */=0A=
+#define Hit_Set_Virtual_SD      0x1F        /* 7       3 */=0A=
+#define CFG_EW32        				0x00040000      /* 32 bit */=0A=
+#elif defined(CPU_R32438)=0A=
+#define CFG_C_UNCACHED					2=0A=
+#define CFG_C_NCHRNT_WB					3=0A=
+=0A=
+/* Cache Operations */=0A=
+#define Index_Invalidate_I      0x0         /* 0       0 */=0A=
+#define Index_Invalidate_D      0x1         /* 0       0 */=0A=
+#define Index_Load_Tag_I        0x4         /* 1       0 */=0A=
+#define Index_Load_Tag_D        0x5         /* 1       1 */=0A=
+#define Index_Store_Tag_I       0x8         /* 2       0 */=0A=
+#define Index_Store_Tag_D       0x9         /* 2       1 */=0A=
+#define Hit_Invalidate_I        0x10        /* 4       0 */=0A=
+#define Hit_Invalidate_D        0x11        /* 4       1 */=0A=
+#define Fill_I                  0x14        /* 5       0 */=0A=
+#define Fetch_Lock_I						0x1C        /* 7       0 */=0A=
+#define Fetch_Lock_D						0x1D        /* 7       1 */=0A=
+#define CFG_EW32        				0x00040000      /* 32 bit */=0A=
+#endif=0A=
+=0A=
+/*=0A=
+** TLB resource defines=0A=
+*/=0A=
+=0A=
+#define	N_TLB_ENTRIES				16=0A=
+#define	TLBHI_VPN2MASK			0xffffe000=0A=
+#define	TLBHI_PIDMASK				0x000000ff=0A=
+#define	TLBHI_NPID					256=0A=
+=0A=
+#define	TLBLO_PFNMASK				0x03ffffc0=0A=
+#define	TLBLO_PFNSHIFT			6=0A=
+#define	TLBLO_D							0x00000004	/* writeable */=0A=
+#define	TLBLO_V							0x00000002	/* valid bit */=0A=
+#define	TLBLO_G							0x00000001	/* global access bit */=0A=
+#define	TLBLO_CMASK					0x00000038	/* cache algorithm mask */=0A=
+#define	TLBLO_CSHIFT				3=0A=
+=0A=
+#define	TLBLO_UNCACHED			(CFG_C_UNCACHED << TLBLO_CSHIFT)=0A=
+#define	TLBLO_NCHRNT_WT_NWA	(CFG_C_NCHRNT_WT_NWA << TLBLO_CSHIFT)=0A=
+#if defined(CPU_R32364)=0A=
+#define	TLBLO_NCHRNT_WT			(CFG_C_NCHRNT_WT << TLBLO_CSHIFT)=0A=
+#define	TLBLO_NCHRNT_WB			(CFG_C_NCHRNT_WB << TLBLO_CSHIFT)=0A=
+#endif=0A=
+=0A=
+#define	TLBINX_PROBE				0x80000000=0A=
+#define	TLBINX_INXMASK			0x0000003f=0A=
+=0A=
+#define	TLBRAND_RANDMASK		0x0000003f=0A=
+=0A=
+#define	TLBCTXT_BASEMASK		0xff800000=0A=
+#define	TLBCTXT_BASESHIFT		23=0A=
+=0A=
+#define	TLBCTXT_VPN2MASK		0x007ffff0=0A=
+#define	TLBCTXT_VPN2SHIFT		4=0A=
+=0A=
+#define	TLBPGMASK_MASK			0x01ffe000=0A=
+=0A=
+#define	SR_CUMASK				0xf0000000	/* coproc usable bits */=0A=
+#define	SR_CU3					0x80000000	/* Coprocessor 3 usable */=0A=
+#define	SR_CU2					0x40000000	/* Coprocessor 2 usable */=0A=
+#define	SR_CU1					0x20000000	/* Coprocessor 1 usable */=0A=
+#define	SR_CU0					0x10000000	/* Coprocessor 0 usable */=0A=
+=0A=
+/* #define	SR_PE						0x00100000*/  /* cache parity error */=0A=
+=0A=
+#if defined(CPU_R32364)=0A=
+#define	SR_RE						0X02000000	/* Reverse Endianness */=0A=
+#define	SR_DL						0x01000000	/* Data Cache Locking */=0A=
+#define	SR_IL						0x00800000	/* Instruction Cache Locking */=0A=
+=0A=
+#define	SR_BEV					0x00400000	/* Use boot exception vectors */=0A=
+#define	SR_SR						0x00100000	/* Soft reset */=0A=
+#define	SR_CH						0x00040000	/* Cache hit */=0A=
+#define	SR_CE						0x00020000	/* Use cache ECC  */=0A=
+#define	SR_DE						0x00010000	/* Disable cache exceptions */=0A=
+=0A=
+#elif defined(CPU_R32438)=0A=
+#define	SR_RP						0X08000000	/* Reduced Power mode */=0A=
+=0A=
+#define	SR_RE						0X02000000	/* Reverse Endianness */=0A=
+=0A=
+#define	SR_BEV					0x00400000	/* Use boot exception vectors */=0A=
+#define	SR_TS						0X00200000	/* TLB Shutdown */=0A=
+#define	SR_SR						0x00100000	/* Soft reset */=0A=
+#define	SR_NMI					0X00080000	/* NMI */=0A=
+#endif=0A=
+/*=0A=
+**	status register interrupt masks and bits=0A=
+*/=0A=
+=0A=
+#define	SR_IMASK				0x0000ff00	/* Interrupt mask */=0A=
+#define	SR_IMASK8				0x00000000	/* mask level 8 */=0A=
+#define	SR_IMASK7				0x00008000	/* mask level 7 */=0A=
+#define	SR_IMASK6				0x0000c000	/* mask level 6 */=0A=
+#define	SR_IMASK5				0x0000e000	/* mask level 5 */=0A=
+#define	SR_IMASK4				0x0000f000	/* mask level 4 */=0A=
+#define	SR_IMASK3				0x0000f800	/* mask level 3 */=0A=
+#define	SR_IMASK2				0x0000fc00	/* mask level 2 */=0A=
+#define	SR_IMASK1				0x0000fe00	/* mask level 1 */=0A=
+#define	SR_IMASK0				0x0000ff00	/* mask level 0 */=0A=
+=0A=
+#define	SR_IMASKSHIFT		8=0A=
+=0A=
+#define	SR_IBIT8				0x00008000	/* bit level 8 */=0A=
+#define	SR_IBIT7				0x00004000	/* bit level 7 */=0A=
+#define	SR_IBIT6				0x00002000	/* bit level 6 */=0A=
+#define	SR_IBIT5				0x00001000	/* bit level 5 */=0A=
+#define	SR_IBIT4				0x00000800	/* bit level 4 */=0A=
+#define	SR_IBIT3				0x00000400	/* bit level 3 */=0A=
+#define	SR_IBIT2				0x00000200	/* bit level 2 */=0A=
+#define	SR_IBIT1				0x00000100	/* bit level 1 */=0A=
+=0A=
+#define	SR_KSMASK				0x00000016	/* Kernel mode mask */=0A=
+#define	SR_KSUSER				0x00000000	/* User Mode */=0A=
+#define	SR_KSKERNEL			0x00000016	/* Kernel Mode */=0A=
+=0A=
+#define	SR_ERL					0x00000004	/* Error level */=0A=
+#define	SR_EXL					0x00000002	/* Exception level */=0A=
+#define	SR_IE						0x00000001	/* Interrupts enabled */=0A=
+#define	NOT_SR_IEC      0xfffffffe  /* assembler problem with li =
~SR_IEC */=0A=
+=0A=
+/*=0A=
+ * Cause Register=0A=
+ */=0A=
+#define	CAUSE_BD				0x80000000	/* Branch delay slot */=0A=
+#define	CAUSE_CEMASK		0x30000000	/* coprocessor error */=0A=
+#define	CAUSE_CESHIFT		28=0A=
+#if defined(CPU_R32364)=0A=
+#define	CAUSE_IPE				0x04000000	/* Imprecise exception */=0A=
+#define	CAUSE_DW				0x02000000	/* Data watch */=0A=
+#define	CAUSE_IW				0x01000000	/* Instruction watch */=0A=
+#elif defined(CPU_R32438)=0A=
+#define CAUSE_IV			 	0x00800000	/* Interrupt Vector location */=0A=
+#define CAUSE_WP			 	0x00400000	/* Watch Exception deferred */=0A=
+#endif=0A=
+=0A=
+#define	CAUSE_IPMASK		0x0000FF00	/* Pending interrupt mask */=0A=
+#define	CAUSE_IPSHIFT		8=0A=
+=0A=
+/* Notice: Watch Exception if Exc. Code is 23 is not included in the =
mask=0A=
+ *	   for R32364.=0A=
+ */=0A=
+#define	CAUSE_EXCMASK		0x0000003C	/* Cause code bits */=0A=
+#define	CAUSE_EXCSHIFT	2=0A=
+=0A=
+#ifndef XDS=0A=
+/*=0A=
+**  Coprocessor 0 registers=0A=
+*/=0A=
+#define	C0_INX					$0		/* tlb index */=0A=
+#define	C0_RANDOM				$1=0A=
+#define	C0_TLBLO0				$2		/* tlb entry low 0 */=0A=
+#define	C0_TLBLO1				$3		/* tlb entry low 1 */=0A=
+#define	C0_CTXT					$4		/* tlb context */=0A=
+#define	C0_PAGEMASK			$5		/* tlb page mask */=0A=
+#define	C0_WIRED				$6		/* number of wired tlb entries */=0A=
+=0A=
+#define	C0_BADVADDR			$8		/* bad virtual address */=0A=
+#define	C0_COUNT				$9		/* timer count */=0A=
+#define	C0_TLBHI				$10		/* tlb entry hi */=0A=
+#define	C0_COMPARE			$11		/* timer comparator  */=0A=
+#define	C0_SR						$12		/* status register */=0A=
+#define	C0_CAUSE				$13		/* exception cause */=0A=
+#define	C0_EPC					$14		/* exception pc */=0A=
+#define	C0_PRID					$15		/* revision identifier */=0A=
+#define	C0_CONFIG				$16		/* configuration register */=0A=
+=0A=
+#if defined(CPU_R32364)=0A=
+#define	C0_IWATCH				$18		/* Instr brk pt Virtual add. */=0A=
+#define	C0_DWATCH				$19		/* Data brk pt Virtual add. */=0A=
+=0A=
+#define	C0_IEPC					$22		/* Imprecise Exception pc */=0A=
+#define	C0_DEPC					$23		/* Debug Exception pc */=0A=
+#define	C0_DEBUG				$24		/* Debug control/status reg */=0A=
+=0A=
+#define	C0_ECC					$26		/* primary cache Parity control */=0A=
+#define	C0_CACHEERR			$27		/* cache error status */=0A=
+#define	C0_TAGLO				$28		/* cache tag lo */=0A=
+#define	C0_ERRPC				$30		/* cache error pc */=0A=
+#elif defined(CPU_R32438)=0A=
+#define	C0_WATCHLO			$18		/* Watchpoint address (low) */=0A=
+#define	C0_WATCHHI			$19		/* Watchpoint address (high) */=0A=
+=0A=
+#define	C0_DEBUG				$23		/* Debug control/status reg */=0A=
+#define	C0_DEPC					$24		/* Debug Exception pc */=0A=
+=0A=
+#define	C0_ERRCTL				$26		/* Cache Error Control */=0A=
+#define	C0_TAGLO				$28		/* Cache Tag Lo */=0A=
+#define	C0_ERRPC				$30		/* Cache Error PC */=0A=
+#define C0_DESAVE				$31		/* Debug scratchpad reg. */=0A=
+#endif =0A=
+=0A=
+#endif=0A=
+#endif /* defined(__IDTCPU_H__) */=0A=
diff -uNr =
linux-2.6.16-rc5/arch/mips/idt-boards/rc32438/EB438/boot/idthdr.h =
acacia/arch/mips/idt-boards/rc32438/EB438/boot/idthdr.h=0A=
--- linux-2.6.16-rc5/arch/mips/idt-boards/rc32438/EB438/boot/idthdr.h	=
1969-12-31 16:00:00.000000000 -0800=0A=
+++ acacia/arch/mips/idt-boards/rc32438/EB438/boot/idthdr.h	2006-03-14 =
13:36:04.000000000 -0800=0A=
@@ -0,0 +1,53 @@=0A=
+/**********************************************************************=
****=0A=
+ *=0A=
+ *  BRIEF MODULE DESCRIPTION=0A=
+ *   Some macros. Though they are already defined else where in the =
linux=0A=
+ *   tree, they are once again declared here for the ease of syncing =
up with=0A=
+ *    IDT bootloader code.=0A=
+ *=0A=
+ *  Copyright 2006 IDT Inc. (rischelp@idt.com)=0A=
+ *         =0A=
+ *  This program is free software; you can redistribute  it and/or =
modify it=0A=
+ *  under  the terms of  the GNU General  Public License as published =
by the=0A=
+ *  Free Software Foundation;  either version 2 of the  License, or =
(at your=0A=
+ *  option) any later version.=0A=
+ *=0A=
+ *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR =
IMPLIED=0A=
+ *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED =
WARRANTIES OF=0A=
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE =
DISCLAIMED.  IN=0A=
+ *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, =
INDIRECT,=0A=
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES =
(INCLUDING, BUT=0A=
+ *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; =
LOSS OF=0A=
+ *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED =
AND ON=0A=
+ *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, =
OR TORT=0A=
+ *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE =
USE OF=0A=
+ *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH =
DAMAGE.=0A=
+ *=0A=
+ *  You should have received a copy of the  GNU General Public License =
along=0A=
+ *  with this program; if not, write  to the Free Software Foundation, =
Inc.,=0A=
+ *  675 Mass Ave, Cambridge, MA 02139, USA.=0A=
+ *=0A=
+ =
************************************************************************=
**=0A=
+ */=0A=
+=0A=
+#ifndef XDS=0A=
+=0A=
+#define	FRAME(name,frm_reg,offset,ret_reg)	\=0A=
+	.globl	name;				\=0A=
+	.ent	name;				\=0A=
+name:;						\=0A=
+	.frame	frm_reg,offset,ret_reg=0A=
+=0A=
+#define ENDFRAME(name) 	.end name=0A=
+=0A=
+#else=0A=
+=0A=
+#define FRAME(name,frm_reg,offset,ret_reg)      \=0A=
+name:=0A=
+=0A=
+#define ENDFRAME(name)=0A=
+=0A=
+#endif=0A=
+=0A=
+=0A=
+=0A=
diff -uNr =
linux-2.6.16-rc5/arch/mips/idt-boards/rc32438/EB438/boot/image.lds.in =
acacia/arch/mips/idt-boards/rc32438/EB438/boot/image.lds.in=0A=
--- =
linux-2.6.16-rc5/arch/mips/idt-boards/rc32438/EB438/boot/image.lds.in	=
1969-12-31 16:00:00.000000000 -0800=0A=
+++ acacia/arch/mips/idt-boards/rc32438/EB438/boot/image.lds.in	=
2006-03-14 13:36:04.000000000 -0800=0A=
@@ -0,0 +1,31 @@=0A=
+OUTPUT_ARCH(mips)=0A=
+ENTRY(zstartup)=0A=
+SECTIONS=0A=
+{=0A=
+  /* Read-only sections, merged into text segment: */=0A=
+  . =3D IMSTART;=0A=
+  .init          : { *(.init)		} =3D0=0A=
+  .text      :=0A=
+  {=0A=
+    _ftext =3D . ;=0A=
+    *(.text)=0A=
+    *(.rodata)=0A=
+    *(.rodata1)=0A=
+   . =3D ALIGN(4096);=0A=
+    input_data =3D .;=0A=
+    arch/mips/idt-boards/rc32438/EB438/boot/piggy.o=0A=
+    input_data_end =3D .;=0A=
+   . =3D ALIGN(4096);=0A=
+    *(.gnu.warning)=0A=
+  } =3D0=0A=
+=0A=
+  .reginfo : { *(.reginfo) }=0A=
+=0A=
+   . =3D BSS_START;=0A=
+  __bss_start =3D .;=0A=
+  .bss       :=0A=
+  {=0A=
+   *(.bss)=0A=
+  _end =3D . ;=0A=
+  }=0A=
+}=0A=
diff -uNr =
linux-2.6.16-rc5/arch/mips/idt-boards/rc32438/EB438/boot/iregdef.h =
acacia/arch/mips/idt-boards/rc32438/EB438/boot/iregdef.h=0A=
--- linux-2.6.16-rc5/arch/mips/idt-boards/rc32438/EB438/boot/iregdef.h	=
1969-12-31 16:00:00.000000000 -0800=0A=
+++ acacia/arch/mips/idt-boards/rc32438/EB438/boot/iregdef.h	2006-03-14 =
13:36:04.000000000 -0800=0A=
@@ -0,0 +1,274 @@=0A=
+/**********************************************************************=
****=0A=
+ *=0A=
+ *  BRIEF MODULE DESCRIPTION=0A=
+ *   IDT CPU register definitions. Though the registers are already =
defined=0A=
+ *   under asm directory, they are once again declared here for the =
ease of=0A=
+ *   syncing up with IDT bootloader code.=0A=
+ *=0A=
+ *  Copyright 2006 IDT Inc. (rischelp@idt.com)=0A=
+ *         =0A=
+ *  This program is free software; you can redistribute  it and/or =
modify it=0A=
+ *  under  the terms of  the GNU General  Public License as published =
by the=0A=
+ *  Free Software Foundation;  either version 2 of the  License, or =
(at your=0A=
+ *  option) any later version.=0A=
+ *=0A=
+ *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR =
IMPLIED=0A=
+ *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED =
WARRANTIES OF=0A=
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE =
DISCLAIMED.  IN=0A=
+ *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, =
INDIRECT,=0A=
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES =
(INCLUDING, BUT=0A=
+ *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; =
LOSS OF=0A=
+ *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED =
AND ON=0A=
+ *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, =
OR TORT=0A=
+ *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE =
USE OF=0A=
+ *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH =
DAMAGE.=0A=
+ *=0A=
+ *  You should have received a copy of the  GNU General Public License =
along=0A=
+ *  with this program; if not, write  to the Free Software Foundation, =
Inc.,=0A=
+ *  675 Mass Ave, Cambridge, MA 02139, USA.=0A=
+ *=0A=
+ =
************************************************************************=
**=0A=
+ */=0A=
+=0A=
+#ifdef CLANGUAGE=0A=
+struct ireg_desc {=0A=
+	char 	*ptr_field_name;	/* field name   */=0A=
+	short	num_digits;				/* number ofdigits to display */=0A=
+	short	num_spaces;				/* number of spaces to follow */=0A=
+	reg_t	fld_mask;					/* mask to extract value of field */=0A=
+	int	fld_shift;					/* shift amount to position field */=0A=
+  short    cpu;=0A=
+	char *CONST *ptr_enum_list;	/* ptr to an enumeration list */=0A=
+	  };=0A=
+=0A=
+/*=0A=
+** reg_name - structure that gives the reg. name, alt. reg name=0A=
+**		the reg index for fetching the value, the number=0A=
+**		of spaces req. so a tabular display will align=0A=
+**		a pointer to a structure defining the fields if=0A=
+**		required and a flag for the output type.=0A=
+*/=0A=
+struct reg_name {=0A=
+	char	*register_name;=0A=
+	char	*alt_reg_name;=0A=
+	short	reg_index;=0A=
+	short	space_pad;=0A=
+	CONST struct ireg_desc *ptr_reg_desc_flds;=0A=
+	unsigned char format_type;=0A=
+	unsigned char print_type;=0A=
+	short   reg_group;=0A=
+  short    cpu;=0A=
+	  };=0A=
+=0A=
+/* print format specifiers */=0A=
+#define PRT_HEX		0=0A=
+#define PRT_SGL 	1=0A=
+#define PRT_DBL 	2=0A=
+=0A=
+/* register group classifiers */=0A=
+#define GRP_CPU		0x0001=0A=
+#define GRP_FPR		0x0002=0A=
+#define GRP_FPS		0x0004=0A=
+#define GRP_FPD		0x0008=0A=
+#define GRP_CP0		0x0010=0A=
+#define GRP_CP0R	0x0020=0A=
+#endif=0A=
+=0A=
+/*=0A=
+** register names=0A=
+*/=0A=
+#define r0		$0=0A=
+#define r1		$1=0A=
+#define r2		$2=0A=
+#define r3		$3=0A=
+#define r4		$4=0A=
+#define r5		$5=0A=
+#define r6		$6=0A=
+#define r7		$7=0A=
+#define r8		$8=0A=
+#define r9		$9=0A=
+#define r10		$10=0A=
+#define r11		$11=0A=
+#define r12		$12=0A=
+#define r13		$13=0A=
+#define r14		$14=0A=
+#define r15		$15=0A=
+#define r16		$16=0A=
+#define r17		$17=0A=
+#define r18		$18=0A=
+#define r19		$19=0A=
+#define r20		$20=0A=
+#define r21		$21=0A=
+#define r22		$22=0A=
+#define r23		$23=0A=
+#define r24		$24=0A=
+#define r25		$25=0A=
+#define r26		$26=0A=
+#define r27		$27=0A=
+#define r28		$28=0A=
+#define r29		$29=0A=
+#define r30		$30=0A=
+#define r31		$31=0A=
+=0A=
+#define zero	$0		/* wired zero */=0A=
+#define AT		$at		/* assembler temp */=0A=
+#define v0		$2		/* return value */=0A=
+#define v1		$3=0A=
+#define a0		$4		/* argument registers a0-a3 */=0A=
+#define a1		$5=0A=
+#define a2		$6=0A=
+#define a3		$7=0A=
+#define t0		$8		/* caller saved  t0-t9 */=0A=
+#define t1		$9=0A=
+#define t2		$10=0A=
+#define t3		$11=0A=
+#define t4		$12=0A=
+#define t5		$13=0A=
+#define t6		$14=0A=
+#define t7		$15=0A=
+#define s0		$16		/* callee saved s0-s8 */=0A=
+#define s1		$17=0A=
+#define s2		$18=0A=
+#define s3		$19=0A=
+#define s4		$20=0A=
+#define s5		$21=0A=
+#define s6		$22=0A=
+#define s7		$23=0A=
+#define t8		$24=0A=
+#define t9		$25=0A=
+#define k0		$26		/* kernel usage */=0A=
+#define k1		$27		/* kernel usage */=0A=
+#define gp		$28		/* sdata pointer */=0A=
+#define sp		$29		/* stack pointer */=0A=
+#define s8		$30		/* yet another saved reg for the callee */=0A=
+#define fp		$30		/* frame pointer - this is being phased out by MIPS =
*/=0A=
+#define ra		$31		/* return address */=0A=
+=0A=
+/*=0A=
+** relative position of registers in save reg area=0A=
+*/=0A=
+#define	R_R0		0=0A=
+#define	R_R1		1=0A=
+#define	R_R2		2=0A=
+#define	R_R3		3=0A=
+#define	R_R4		4=0A=
+#define	R_R5		5=0A=
+#define	R_R6		6=0A=
+#define	R_R7		7=0A=
+#define	R_R8		8=0A=
+#define	R_R9		9=0A=
+#define	R_R10		10=0A=
+#define	R_R11		11=0A=
+#define	R_R12		12=0A=
+#define	R_R13		13=0A=
+#define	R_R14		14=0A=
+#define	R_R15		15=0A=
+#define	R_R16		16=0A=
+#define	R_R17		17=0A=
+#define	R_R18		18=0A=
+#define	R_R19		19=0A=
+#define	R_R20		20=0A=
+#define	R_R21		21=0A=
+#define	R_R22		22=0A=
+#define	R_R23		23=0A=
+#define	R_R24		24=0A=
+#define	R_R25		25=0A=
+#define	R_R26		26=0A=
+#define	R_R27		27=0A=
+#define	R_R28		28=0A=
+#define	R_R29		29=0A=
+#define	R_R30		30=0A=
+#define	R_R31		31=0A=
+#define NCLIENTREGS	32=0A=
+#define	R_EPC				32=0A=
+#define	R_MDHI			33=0A=
+#define	R_MDLO		  34=0A=
+#define	R_SR				35=0A=
+#define	R_CAUSE			36=0A=
+#define	R_TLBHI			37=0A=
+#define	R_TLBLO0		38=0A=
+#define	R_BADVADDR	39=0A=
+#define	R_INX				40=0A=
+#define	R_RAND			41=0A=
+#define	R_CTXT			42=0A=
+#define	R_EXCTYPE		43=0A=
+#define R_MODE			44=0A=
+#define R_PRID			45=0A=
+#define R_TLBLO1		46=0A=
+#define R_PAGEMASK	47=0A=
+#define R_WIRED			48=0A=
+#define R_COUNT			49=0A=
+#define R_COMPARE		50=0A=
+#define R_CONFIG		51=0A=
+#if defined(CPU_R32438)=0A=
+#define R_WATCHLO   52=0A=
+#define R_WATCHHI   53=0A=
+#elif defined(CPU_R32364)=0A=
+#define R_IWATCH    52=0A=
+#define R_DWATCH    53=0A=
+#define R_ECC				54=0A=
+#define R_CACHEERR	55=0A=
+#endif=0A=
+#define R_TAGLO			56=0A=
+#define R_TAGHI			57=0A=
+#define R_ERRPC			58=0A=
+=0A=
+#define NREGS			  59=0A=
+=0A=
+#if __mips >=3D 3=0A=
+=0A=
+#define R_SZ		8=0A=
+#ifndef CLANGUAGE=0A=
+#define sreg		sd=0A=
+#define lreg		ld=0A=
+#define rmfc0		mfc0=0A=
+#define rmtc0		mtc0=0A=
+#endif=0A=
+=0A=
+#else=0A=
+=0A=
+#define R_SZ		4=0A=
+#ifndef CLANGUAGE=0A=
+#define sreg		sw=0A=
+#define lreg		lw=0A=
+#define rmfc0		mfc0=0A=
+#define rmtc0		mtc0=0A=
+#endif=0A=
+=0A=
+#endif=0A=
+=0A=
+/*=0A=
+** For those who like to think in terms of the compiler names for the =
regs=0A=
+*/=0A=
+#define	R_ZERO	R_R0=0A=
+#define	R_AT		R_R1=0A=
+#define	R_V0		R_R2=0A=
+#define	R_V1		R_R3=0A=
+#define	R_A0		R_R4=0A=
+#define	R_A1		R_R5=0A=
+#define	R_A2		R_R6=0A=
+#define	R_A3		R_R7=0A=
+#define	R_T0		R_R8=0A=
+#define	R_T1		R_R9=0A=
+#define	R_T2		R_R10=0A=
+#define	R_T3		R_R11=0A=
+#define	R_T4		R_R12=0A=
+#define	R_T5		R_R13=0A=
+#define	R_T6		R_R14=0A=
+#define	R_T7		R_R15=0A=
+#define	R_S0		R_R16=0A=
+#define	R_S1		R_R17=0A=
+#define	R_S2		R_R18=0A=
+#define	R_S3		R_R19=0A=
+#define	R_S4		R_R20=0A=
+#define	R_S5		R_R21=0A=
+#define	R_S6		R_R22=0A=
+#define	R_S7		R_R23=0A=
+#define	R_T8		R_R24=0A=
+#define	R_T9		R_R25=0A=
+#define	R_K0		R_R26=0A=
+#define	R_K1		R_R27=0A=
+#define	R_GP		R_R28=0A=
+#define	R_SP		R_R29=0A=
+#define	R_FP		R_R30=0A=
+#define	R_RA		R_R31=0A=
diff -uNr =
linux-2.6.16-rc5/arch/mips/idt-boards/rc32438/EB438/boot/Makefile =
acacia/arch/mips/idt-boards/rc32438/EB438/boot/Makefile=0A=
--- linux-2.6.16-rc5/arch/mips/idt-boards/rc32438/EB438/boot/Makefile	=
1969-12-31 16:00:00.000000000 -0800=0A=
+++ acacia/arch/mips/idt-boards/rc32438/EB438/boot/Makefile	2006-03-14 =
13:36:04.000000000 -0800=0A=
@@ -0,0 +1,136 @@=0A=
+#######################################################################=
########=0A=
+#=0A=
+#  BRIEF MODULE DESCRIPTION=0A=
+#     Makefile create a compressed zImage or Rommable rImage=0A=
+#=0A=
+#  Copyright 2006 IDT Inc. (rischelp@idt.com)=0A=
+#=0A=
+#  This program is free software; you can redistribute  it and/or =
modify it=0A=
+#  under  the terms of  the GNU General  Public License as published =
by the=0A=
+#  Free Software Foundation;  either version 2 of the  License, or (at =
your=0A=
+#  option) any later version.=0A=
+#=0A=
+#  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR =
IMPLIED=0A=
+#  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED =
WARRANTIES OF=0A=
+#   MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE =
DISCLAIMED.  IN=0A=
+#   NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, =
INDIRECT,=0A=
+#   INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES =
(INCLUDING, BUT=0A=
+#   NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; =
LOSS OF=0A=
+#   USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED =
AND ON=0A=
+#   ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, =
OR TORT=0A=
+#   (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE =
USE OF=0A=
+#   THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH =
DAMAGE.=0A=
+#=0A=
+#   You should have received a copy of the  GNU General Public License =
along=0A=
+#   with this program; if not, write  to the Free Software Foundation, =
Inc.,=0A=
+#   675 Mass Ave, Cambridge, MA 02139, USA.=0A=
+# =0A=
+#######################################################################=
########=0A=
+=0A=
+#######################################################################=
########=0A=
+# The following is taken from IDT/Sim Makefile=0A=
+#######################################################################=
######=0A=
+TARGET=3D438=0A=
+TARGETDIR=3DS438=0A=
+MHZ=3D100000000=0A=
+=0A=
+#=0A=
+# following refers to memory type in use in eval board and if more =
than one=0A=
+# then the order is implied.  These are values for the switch =
MEMCFG.=0A=
+#=0A=
+SRAM_ONLY=3D1=0A=
+SDRAM_ONLY=3D2=0A=
+SRAM_N_SDRAM=3D3=0A=
+SDRAM_N_SRAM=3D4=0A=
+=0A=
+# following refers to size of the DRAM space.=0A=
+# These are values for the switch DRAMSZ.=0A=
+=0A=
+MB32=3D1=0A=
+MB64=3D2=0A=
+MB128=3D3=0A=
+MB32SO=3D4=0A=
+=0A=
+MACH=3D -DEB438 -DS438 -DCPU_R32438 -DMIPSEL -DINET =
-DMEMCFG=3D$(SDRAM_ONLY) -DDRAMSZ=3D$(MB64) -DIDTSIM -DMHZ=3D$(MHZ) =
-DNVRAM_RTC -DUSE_SPI=0A=
+COMMSWITCHES =3D $(MACH)=0A=
+#***************** END IDT/Sim Makefile =
##################################### =0A=
+ZDEBUG=3D1=0A=
+export ZDEBUG=0A=
+=0A=
+# working space for gunzip:=0A=
+FREE_RAM      :=3D 0x80C00000=0A=
+END_RAM       :=3D 0x80E00000=0A=
+=0A=
+KERNELCONFIG  :=3D $(TOPDIR)/.config=0A=
+include $(KERNELCONFIG)=0A=
+=0A=
+SIZE =3D $(CROSS_COMPILE)size=0A=
+=0A=
+O_FORMAT =3D $(shell $(OBJDUMP) -i | head -2 | grep elf32)=0A=
+=0A=
+SYSTEM	      :=3D $(TOPDIR)/vmlinux=0A=
+ZBSS          :=3D 0x800A0000=0A=
+=0A=
+ZIMSTART      :=3D $(CONFIG_IDT_ZIMAGE_ADDR)=0A=
+RIMSTART      :=3D 0x9FC00000=0A=
+=0A=
+LOADADDR      :=3D 0x$(shell $(NM) $(SYSTEM) | grep "A _text" |cut -f1 =
-d' ')=0A=
+KERNEL_ENTRY  :=3D $(shell $(OBJDUMP) -f $(SYSTEM) | sed -n -e =
's/^start address //p')=0A=
+=0A=
+#######################################################################=
#############=0A=
+ZIMFLAGS        =3D s/IMSTART/$(ZIMSTART)/;s/BSS_START/$(ZBSS)/=0A=
+RIMFLAGS        =3D s/IMSTART/$(RIMSTART)/;s/BSS_START/$(ZBSS)/=0A=
+CFLAGS	:=3D -fno-pic -nostdinc -G 0 -mno-abicalls -fno-pic -pipe =
-I$(TOPDIR)/include=0A=
+AFLAGS	:=3D -D__ASSEMBLY__ $(CFLAGS)=0A=
+=0A=
+#######################################################################=
#############=0A=
+OBJECTS=3D $(obj)/piggy.o $(obj)/head.o $(obj)/misc.o=0A=
+ifneq ($(ZDEBUG),0)=0A=
+OBJECTS +=3D $(obj)/uart16550.o=0A=
+endif=0A=
+=0A=
+$(obj)/zImage.lds: $(obj)/image.lds.in $(KERNELCONFIG)=0A=
+	@sed "$(ZIMFLAGS)" < $< > $@=0A=
+=0A=
+$(obj)/rImage.lds: $(obj)/image.lds.in $(KERNELCONFIG)=0A=
+	@sed "$(RIMFLAGS)" < $< > $@=0A=
+=0A=
+$(obj)/piggy.o: $(SYSTEM) $(obj)/Makefile=0A=
+	$(OBJCOPY) -S -O binary -R .note -R .comment $(SYSTEM) =
$(SYSTEM).bin=0A=
+	gzip -f -9 < $(SYSTEM).bin > $(SYSTEM).gz=0A=
+	echo "O_FORMAT:  " $(O_FORMAT); =0A=
+	$(LD) -r -b binary --oformat $(O_FORMAT) -o $(obj)/piggy.o =
$(SYSTEM).gz=0A=
+	rm -f $(SYSTEM).bin $(SYSTEM).gz=0A=
+=0A=
+$(obj)/head.o: $(obj)/head.S $(SYSTEM) $(obj)/Makefile=0A=
+	$(CC) $(AFLAGS) -DKERNEL_ENTRY=3D$(KERNEL_ENTRY) -c $(obj)/head.S -o =
$(obj)/head.o=0A=
+=0A=
+$(obj)/misc.o: $(obj)/misc.c $(obj)/Makefile=0A=
+	$(CC) $(CFLAGS) -DLOADADDR=3D$(LOADADDR) -DFREE_RAM=3D$(FREE_RAM) =
-DEND_RAM=3D$(END_RAM) \=0A=
+		-c $< -DZDEBUG=3D$(ZDEBUG) -o $(obj)/misc.o=0A=
+=0A=
+$(obj)/uart16550.o: $(obj)/uart16550.c $(KERNELCONFIG)=0A=
+	$(CC) $(CFLAGS) -c $< -o $(obj)/uart16550.o=0A=
+=0A=
+$(obj)/csu_idt.o: $(obj)/csu_idt.S Makefile $(SYSTEM)=0A=
+	$(CC) $(AFLAGS) $(COMMSWITCHES) -c $< -o $(obj)/csu_idt.o=0A=
+=0A=
+zImage: $(obj)/zImage.lds $(SYSTEM) $(OBJECTS)=0A=
+	$(LD) -T$(obj)/zImage.lds -o $(TOPDIR)/zImage $(OBJECTS)=0A=
+	$(OBJCOPY) -S -O binary -R .note -R .comment $(TOPDIR)/zImage =
$(TOPDIR)/zImage.bin=0A=
+	$(OBJCOPY) -I binary -S -O srec --srec-forceS3 --srec-len=3D32 =
--change-start=3D0x00000000 \=0A=
+		 $(TOPDIR)/zImage.bin $(TOPDIR)/zImage.prm=0A=
+	$(SIZE) $(TOPDIR)/zImage |awk -F" " '{ print $$4 "\t" $$5 }' > =
$(TOPDIR)/zImage.size=0A=
+	rm -f *.o=0A=
+=0A=
+rImage: $(obj)/rImage.lds $(SYSTEM) $(OBJECTS) $(obj)/csu_idt.o=0A=
+	echo $(TOPDRIR)=0A=
+	@rm -f $(TOPDIR)/*.prm=0A=
+	$(LD) -T$(obj)/rImage.lds -o $(TOPDIR)/rImage $(obj)/csu_idt.o =
$(OBJECTS) =0A=
+	$(OBJCOPY) -S -O binary -R .note -R .comment $(TOPDIR)/rImage =
$(TOPDIR)/rImage.bin=0A=
+	$(OBJCOPY) -I binary -S -O srec --srec-forceS3 --srec-len=3D32 =
--change-start=3D0x00000000 \=0A=
+		 $(TOPDIR)/rImage.bin $(TOPDIR)/rImage.prm=0A=
+	$(SIZE) $(TOPDIR)/rImage |awk -F" " '{ print $$4 "\t" $$5 }' > =
$(TOPDIR)/rImage.size=0A=
+	rm -f *.o=0A=
+clean:=0A=
+	rm -f *.o $(TOPDIR)/zImage* $(TOPDIR)/rImage* $(TOPDIR)/*.prm =
$(TOPDIR)/rImage.size $(TOPDIR)/zImage.size=0A=
diff -uNr =
linux-2.6.16-rc5/arch/mips/idt-boards/rc32438/EB438/boot/misc.c =
acacia/arch/mips/idt-boards/rc32438/EB438/boot/misc.c=0A=
--- linux-2.6.16-rc5/arch/mips/idt-boards/rc32438/EB438/boot/misc.c	=
1969-12-31 16:00:00.000000000 -0800=0A=
+++ acacia/arch/mips/idt-boards/rc32438/EB438/boot/misc.c	2006-03-14 =
13:36:04.000000000 -0800=0A=
@@ -0,0 +1,339 @@=0A=
+/**********************************************************************=
****=0A=
+ *=0A=
+ *  BRIEF MODULE DESCRIPTION=0A=
+ *   Code to un-compress linux image=0A=
+ *=0A=
+ *  Copyright 2006 IDT Inc. (rischelp@idt.com)=0A=
+ *         =0A=
+ *  This program is free software; you can redistribute  it and/or =
modify it=0A=
+ *  under  the terms of  the GNU General  Public License as published =
by the=0A=
+ *  Free Software Foundation;  either version 2 of the  License, or =
(at your=0A=
+ *  option) any later version.=0A=
+ *=0A=
+ *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR =
IMPLIED=0A=
+ *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED =
WARRANTIES OF=0A=
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE =
DISCLAIMED.  IN=0A=
+ *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, =
INDIRECT,=0A=
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES =
(INCLUDING, BUT=0A=
+ *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; =
LOSS OF=0A=
+ *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED =
AND ON=0A=
+ *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, =
OR TORT=0A=
+ *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE =
USE OF=0A=
+ *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH =
DAMAGE.=0A=
+ *=0A=
+ *  You should have received a copy of the  GNU General Public License =
along=0A=
+ *  with this program; if not, write  to the Free Software Foundation, =
Inc.,=0A=
+ *  675 Mass Ave, Cambridge, MA 02139, USA.=0A=
+ *=0A=
+ =
************************************************************************=
**=0A=
+ */=0A=
+=0A=
+#include <linux/types.h>=0A=
+=0A=
+/*=0A=
+ * gzip declarations=0A=
+ */=0A=
+#define OF(args)  args=0A=
+#define STATIC static=0A=
+#define memzero(s, n)     memset ((s), 0, (n))=0A=
+typedef unsigned char uch;=0A=
+typedef unsigned short ush;=0A=
+typedef unsigned long ulg;=0A=
+#define WSIZE 0x8000		/* Window size must be at least 32k, */=0A=
+				/* and a power of two */=0A=
+static uch *inbuf;		/* input buffer */=0A=
+static uch window[WSIZE];	/* Sliding window buffer */=0A=
+=0A=
+/* gzip flag byte */=0A=
+#define ASCII_FLAG   0x01	/* bit 0 set: file probably ASCII text */=0A=
+#define CONTINUATION 0x02	/* bit 1 set: continuation of multi-part =
gzip file */=0A=
+#define EXTRA_FIELD  0x04	/* bit 2 set: extra field present */=0A=
+#define ORIG_NAME    0x08	/* bit 3 set: original file name present =
*/=0A=
+#define COMMENT      0x10	/* bit 4 set: file comment present */=0A=
+#define ENCRYPTED    0x20	/* bit 5 set: file is encrypted */=0A=
+#define RESERVED     0xC0	/* bit 6,7:   reserved */=0A=
+=0A=
+=0A=
+static unsigned insize;	/* valid bytes in inbuf */=0A=
+static unsigned inptr;	/* index of next byte to be processed in inbuf =
*/=0A=
+static unsigned outcnt;	/* bytes in output buffer */=0A=
+=0A=
+void variable_init(void);=0A=
+#if ZDEBUG > 0=0A=
+static void puts(const char *);=0A=
+extern void putc_init(void);=0A=
+extern void putc(unsigned char c);=0A=
+#endif=0A=
+static int fill_inbuf(void);=0A=
+static void flush_window(void);=0A=
+static void error(char *m);=0A=
+static void gzip_mark(void **);=0A=
+static void gzip_release(void **);=0A=
+=0A=
+extern char input_data[];=0A=
+=0A=
+extern char input_data_end[];=0A=
+=0A=
+#if ZDEBUG > 0=0A=
+void int2hex(unsigned long val)=0A=
+{=0A=
+        unsigned char buf[10];=0A=
+        int i;=0A=
+        for (i =3D 7;  i >=3D 0;  i--)=0A=
+        {=0A=
+                buf[i] =3D "0123456789ABCDEF"[val & 0x0F];=0A=
+                val >>=3D 4;=0A=
+        }=0A=
+        buf[8] =3D '\0';=0A=
+        puts(buf);=0A=
+}=0A=
+#endif=0A=
+=0A=
+static unsigned long byte_count;=0A=
+=0A=
+int get_byte(void)=0A=
+{=0A=
+#if ZDEBUG > 1=0A=
+	static int printCnt;=0A=
+#endif=0A=
+	unsigned char c =3D (inptr < insize ? inbuf[inptr++] : =
fill_inbuf());=0A=
+	byte_count++;=0A=
+=0A=
+#if ZDEBUG > 1=0A=
+	if (printCnt++ < 32)=0A=
+	{=0A=
+	  puts("byte count =3D ");=0A=
+	  int2hex(byte_count);=0A=
+	  puts(" byte val =3D ");=0A=
+	  int2hex(c);=0A=
+	  puts("\n");=0A=
+	}=0A=
+#endif=0A=
+	return c;=0A=
+}=0A=
+=0A=
+/* Diagnostic functions */=0A=
+#ifdef DEBUG=0A=
+#  define Assert(cond,msg) {if(!(cond)) error(msg);}=0A=
+#  define Trace(x) fprintf x=0A=
+#  define Tracev(x) {if (verbose) fprintf x ;}=0A=
+#  define Tracevv(x) {if (verbose>1) fprintf x ;}=0A=
+#  define Tracec(c,x) {if (verbose && (c)) fprintf x ;}=0A=
+#  define Tracecv(c,x) {if (verbose>1 && (c)) fprintf x ;}=0A=
+#else=0A=
+#  define Assert(cond,msg)=0A=
+#  define Trace(x)=0A=
+#  define Tracev(x)=0A=
+#  define Tracevv(x)=0A=
+#  define Tracec(c,x)=0A=
+#  define Tracecv(c,x)=0A=
+#endif=0A=
+=0A=
+/*=0A=
+ * This is set up by the setup-routine at boot-time=0A=
+ */=0A=
+=0A=
+static long bytes_out;=0A=
+static uch *output_data;=0A=
+static unsigned long output_ptr;=0A=
+=0A=
+=0A=
+static void *malloc(int size);=0A=
+static void free(void *where);=0A=
+static void error(char *m);=0A=
+static void gzip_mark(void **);=0A=
+static void gzip_release(void **);=0A=
+=0A=
+static unsigned long free_mem_ptr;=0A=
+static unsigned long free_mem_end_ptr;=0A=
+=0A=
+#include "../../../../../../lib/inflate.c"=0A=
+=0A=
+static void *malloc(int size)=0A=
+{=0A=
+	void *p;=0A=
+=0A=
+	if (size < 0)=0A=
+		error("Malloc error\n");=0A=
+	if (free_mem_ptr <=3D 0) error("Memory error\n");=0A=
+=0A=
+	free_mem_ptr =3D (free_mem_ptr + 3) & ~3;	/* Align */=0A=
+=0A=
+	p =3D (void *) free_mem_ptr;=0A=
+	free_mem_ptr +=3D size;=0A=
+=0A=
+	if (free_mem_ptr >=3D free_mem_end_ptr)=0A=
+		error("\nOut of memory\n");=0A=
+=0A=
+	return p;=0A=
+}=0A=
+=0A=
+static void free(void *where)=0A=
+{				/* Don't care */=0A=
+}=0A=
+=0A=
+static void gzip_mark(void **ptr)=0A=
+{=0A=
+	*ptr =3D (void *) free_mem_ptr;=0A=
+}=0A=
+=0A=
+static void gzip_release(void **ptr)=0A=
+{=0A=
+	free_mem_ptr =3D (long) *ptr;=0A=
+}=0A=
+#if ZDEBUG > 0=0A=
+static void puts(const char *s)=0A=
+{=0A=
+	while (*s) {=0A=
+		if (*s =3D=3D 10)=0A=
+			putc(13);=0A=
+		putc(*s++);=0A=
+	}=0A=
+}=0A=
+#endif=0A=
+void *memset(void *s, int c, size_t n)=0A=
+{=0A=
+	int i;=0A=
+	char *ss =3D (char *) s;=0A=
+=0A=
+	for (i =3D 0; i < n; i++)=0A=
+		ss[i] =3D c;=0A=
+	return s;=0A=
+}=0A=
+=0A=
+void *memcpy(void *__dest, __const void *__src, size_t __n)=0A=
+{=0A=
+	int i;=0A=
+	char *d =3D (char *) __dest, *s =3D (char *) __src;=0A=
+=0A=
+	for (i =3D 0; i < __n; i++)=0A=
+		d[i] =3D s[i];=0A=
+	return __dest;=0A=
+}=0A=
+=0A=
+/* =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=0A=
+ * Fill the input buffer. This is called only when the buffer is =
empty=0A=
+ * and at least one byte is really needed.=0A=
+ */=0A=
+static int fill_inbuf(void)=0A=
+{=0A=
+	if (insize !=3D 0) {=0A=
+		error("ran out of input data\n");=0A=
+	}=0A=
+=0A=
+	inbuf =3D input_data;=0A=
+	insize =3D &input_data_end[0] - &input_data[0];=0A=
+	inptr =3D 1;=0A=
+	return inbuf[0];=0A=
+}=0A=
+=0A=
+/* =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=0A=
+ * Write the output window window[0..outcnt-1] and update crc and =
bytes_out.=0A=
+ * (Used for the decompressed data only.)=0A=
+ */=0A=
+static void flush_window(void)=0A=
+{=0A=
+	ulg c =3D crc;		/* temporary variable */=0A=
+	unsigned n;=0A=
+	uch *in, *out, ch;=0A=
+=0A=
+	in =3D window;=0A=
+	out =3D &output_data[output_ptr];=0A=
+	for (n =3D 0; n < outcnt; n++) {=0A=
+		ch =3D *out++ =3D *in++;=0A=
+		c =3D crc_32_tab[((int) c ^ ch) & 0xff] ^ (c >> 8);=0A=
+	}=0A=
+	crc =3D c;=0A=
+	bytes_out +=3D (ulg) outcnt;=0A=
+	output_ptr +=3D (ulg) outcnt;=0A=
+	outcnt =3D 0;=0A=
+}=0A=
+=0A=
+#if ZDEBUG > 0=0A=
+void check_mem(void)=0A=
+{=0A=
+	int i;=0A=
+=0A=
+	puts("\ncplens =3D ");=0A=
+	for (i =3D 0; i < 10; i++) {=0A=
+		int2hex(cplens[i]);=0A=
+		puts(" ");=0A=
+	}=0A=
+	puts("\ncplext =3D ");=0A=
+	for (i =3D 0; i < 10; i++) {=0A=
+		int2hex(cplext[i]);=0A=
+		puts(" ");=0A=
+	}=0A=
+	puts("\nborder =3D ");=0A=
+	for (i =3D 0; i < 10; i++) {=0A=
+		int2hex(border[i]);=0A=
+		puts(" ");=0A=
+	}=0A=
+	puts("\n");=0A=
+}=0A=
+#endif=0A=
+static void error(char *x)=0A=
+{=0A=
+#if ZDEBUG > 1=0A=
+	check_mem();=0A=
+	puts("\n\n");=0A=
+	puts(x);=0A=
+	puts("byte_count =3D ");=0A=
+	int2hex(byte_count);=0A=
+	puts("\n");=0A=
+	puts("\n\n -- Error. System halted");=0A=
+#endif=0A=
+	while (1);		/* Halt */=0A=
+}=0A=
+=0A=
+void variable_init(void)=0A=
+{=0A=
+	byte_count =3D 0;=0A=
+	output_data =3D (char *) LOADADDR;=0A=
+	free_mem_ptr =3D FREE_RAM;=0A=
+	free_mem_end_ptr =3D END_RAM;=0A=
+#if ZDEBUG > 1=0A=
+	puts("output_data      0x");=0A=
+	int2hex((unsigned long)output_data); puts("\n");=0A=
+	puts("free_mem_ptr     0x");=0A=
+	int2hex(free_mem_ptr); puts("\n");=0A=
+	puts("free_mem_end_ptr 0x");=0A=
+	int2hex(free_mem_end_ptr); puts("\n");=0A=
+	puts("input_data       0x");=0A=
+	int2hex((unsigned long)input_data); puts("\n");=0A=
+#endif=0A=
+}=0A=
+=0A=
+int decompress_kernel(void)=0A=
+{=0A=
+#if ZDEBUG > 0=0A=
+  putc_init();=0A=
+#if ZDEBUG > 2=0A=
+  check_mem();=0A=
+#endif=0A=
+#endif=0A=
+=0A=
+  variable_init();=0A=
+=0A=
+  makecrc();=0A=
+#if ZDEBUG > 0=0A=
+  puts("\n");=0A=
+  puts("Uncompressing Linux... \n");=0A=
+#endif=0A=
+  gunzip();		// ...see inflate.c=0A=
+#if ZDEBUG > 0=0A=
+  puts("Ok, booting the kernel.\n");=0A=
+#endif=0A=
+=0A=
+#if ZDEBUG > 1=0A=
+ {=0A=
+  unsigned long *p =3D (unsigned long *)LOADADDR;=0A=
+  int2hex(p[0]); puts("\n");=0A=
+  int2hex(p[1]); puts("\n");=0A=
+  int2hex(p[2]); puts("\n");=0A=
+  int2hex(p[3]); puts("\n");=0A=
+ }=0A=
+#endif=0A=
+=0A=
+  return 0;=0A=
+}=0A=
diff -uNr =
linux-2.6.16-rc5/arch/mips/idt-boards/rc32438/EB438/boot/rImage.lds =
acacia/arch/mips/idt-boards/rc32438/EB438/boot/rImage.lds=0A=
--- linux-2.6.16-rc5/arch/mips/idt-boards/rc32438/EB438/boot/rImage.lds	=
1969-12-31 16:00:00.000000000 -0800=0A=
+++ acacia/arch/mips/idt-boards/rc32438/EB438/boot/rImage.lds	=
2006-03-14 15:44:33.000000000 -0800=0A=
@@ -0,0 +1,31 @@=0A=
+OUTPUT_ARCH(mips)=0A=
+ENTRY(zstartup)=0A=
+SECTIONS=0A=
+{=0A=
+  /* Read-only sections, merged into text segment: */=0A=
+  . =3D 0x9FC00000;=0A=
+  .init          : { *(.init)		} =3D0=0A=
+  .text      :=0A=
+  {=0A=
+    _ftext =3D . ;=0A=
+    *(.text)=0A=
+    *(.rodata)=0A=
+    *(.rodata1)=0A=
+   . =3D ALIGN(4096);=0A=
+    input_data =3D .;=0A=
+    arch/mips/idt-boards/rc32438/EB438/boot/piggy.o=0A=
+    input_data_end =3D .;=0A=
+   . =3D ALIGN(4096);=0A=
+    *(.gnu.warning)=0A=
+  } =3D0=0A=
+=0A=
+  .reginfo : { *(.reginfo) }=0A=
+=0A=
+   . =3D 0x800A0000;=0A=
+  __bss_start =3D .;=0A=
+  .bss       :=0A=
+  {=0A=
+   *(.bss)=0A=
+  _end =3D . ;=0A=
+  }=0A=
+}=0A=
diff -uNr =
linux-2.6.16-rc5/arch/mips/idt-boards/rc32438/EB438/boot/s438.h =
acacia/arch/mips/idt-boards/rc32438/EB438/boot/s438.h=0A=
--- linux-2.6.16-rc5/arch/mips/idt-boards/rc32438/EB438/boot/s438.h	=
1969-12-31 16:00:00.000000000 -0800=0A=
+++ acacia/arch/mips/idt-boards/rc32438/EB438/boot/s438.h	2006-03-14 =
13:36:04.000000000 -0800=0A=
@@ -0,0 +1,137 @@=0A=
+/**********************************************************************=
****=0A=
+ *=0A=
+ *  BRIEF MODULE DESCRIPTION=0A=
+ *   Some useful macros.=0A=
+ *=0A=
+ *  Copyright 2006 IDT Inc. (rischelp@idt.com)=0A=
+ *         =0A=
+ *  This program is free software; you can redistribute  it and/or =
modify it=0A=
+ *  under  the terms of  the GNU General  Public License as published =
by the=0A=
+ *  Free Software Foundation;  either version 2 of the  License, or =
(at your=0A=
+ *  option) any later version.=0A=
+ *=0A=
+ *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR =
IMPLIED=0A=
+ *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED =
WARRANTIES OF=0A=
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE =
DISCLAIMED.  IN=0A=
+ *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, =
INDIRECT,=0A=
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES =
(INCLUDING, BUT=0A=
+ *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; =
LOSS OF=0A=
+ *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED =
AND ON=0A=
+ *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, =
OR TORT=0A=
+ *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE =
USE OF=0A=
+ *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH =
DAMAGE.=0A=
+ *=0A=
+ *  You should have received a copy of the  GNU General Public License =
along=0A=
+ *  with this program; if not, write  to the Free Software Foundation, =
Inc.,=0A=
+ *  675 Mass Ave, Cambridge, MA 02139, USA.=0A=
+ *=0A=
+ =
************************************************************************=
**=0A=
+ */=0A=
+=0A=
+#ifndef __S438__=0A=
+#define __S438__=0A=
+/******************************** D E F I N E S =
*******************************/=0A=
+=0A=
+/*=0A=
+** following defines simple and uniform to save and restore context=0A=
+** when enrtering and leaving as assemblu language program when =
memory=0A=
+** and registers are both premiunm.=0A=
+*/=0A=
+#define SAVE_CNTXT  \=0A=
+  subu  sp, 64;     \=0A=
+  sw    t0, 60(sp); \=0A=
+  sw    t1, 56(sp); \=0A=
+  sw    t2, 52(sp); \=0A=
+  sw    t3, 48(sp); \=0A=
+  sw    t4, 44(sp); \=0A=
+  sw    t5, 40(sp); \=0A=
+  sw    t6, 36(sp); \=0A=
+  sw    t7, 32(sp); \=0A=
+  sw    t8, 28(sp); \=0A=
+  sw    t9, 24(sp); \=0A=
+  sw    a0, 20(sp); \=0A=
+  sw    a1, 16(sp); \=0A=
+  sw    a2, 12(sp); \=0A=
+  sw    a3,  8(sp); \=0A=
+  sw    ra,  4(sp)=0A=
+=0A=
+#define RSTR_CNTXT  \=0A=
+  lw    t0, 60(sp); \=0A=
+  lw    t1, 56(sp); \=0A=
+  lw    t2, 52(sp); \=0A=
+  lw    t3, 48(sp); \=0A=
+  lw    t4, 44(sp); \=0A=
+  lw    t5, 40(sp); \=0A=
+  lw    t6, 36(sp); \=0A=
+  lw    t7, 32(sp); \=0A=
+  lw    t8, 28(sp); \=0A=
+  lw    t9, 24(sp); \=0A=
+  lw    a0, 20(sp); \=0A=
+  lw    a1, 16(sp); \=0A=
+  lw    a2, 12(sp); \=0A=
+  lw    a3,  8(sp); \=0A=
+  lw    ra,  4(sp); \=0A=
+  add   sp, 64=0A=
+=0A=
+/*=0A=
+** Following define is to specify a maximum value for a software=0A=
+** busy wait counter.=0A=
+*/=0A=
+/*=0A=
+#define LP_CNT_100NS  1000      =0A=
+#define LP_CNT_3S     1000000   =0A=
+*/=0A=
+=0A=
+/*=0A=
+** Following are other common timer definitions.=0A=
+*/=0A=
+#define DDRBASE           PHYS_TO_K1(0x18018000)=0A=
+#define TIMER_BASE        PHYS_TO_K1(0x18028000)  =0A=
+#define WTC_BASE          PHYS_TO_K1(0x18030000)  =0A=
+#define INTERRUPT_BASE    PHYS_TO_K1(0x18038000)=0A=
+#define GPIO_BASE         PHYS_TO_K1(0x18048000)=0A=
+=0A=
+#define TIMEOUT_COUNT     0x00000FFF=0A=
+#define ENABLE_TIMER      0x1=0A=
+#define DISABLE_TIMER     0x0=0A=
+#define BIG_VALUE         0xFFFFFFFF=0A=
+=0A=
+/*=0A=
+** following few lines define a macro DISPLAY=0A=
+** which is used to write a set of 4 characters=0A=
+** onto the EB438 LED.=0A=
+*/=0A=
+=0A=
+#ifndef LED_BASE=0A=
+=0A=
+#define LED_BASE    PHYS_TO_K1(0x0C040000)=0A=
+#define LED_DIGIT0  0x3=0A=
+#define LED_DIGIT1  0x2=0A=
+#define LED_DIGIT2  0x1=0A=
+#define LED_DIGIT3  0x0=0A=
+#define LED_CLEAR   -0x40000=0A=
+=0A=
+#endif=0A=
+=0A=
+#define DISPLAY(d0, d1, d2, d3)     \=0A=
+        li    t6, LED_BASE                    ;\=0A=
+        lb    t7, LED_CLEAR(t6)               ;\=0A=
+              nop                             ;\=0A=
+        li    t7, (d0) & 0xff                 ;\=0A=
+        sb    t7, LED_DIGIT0(t6)              ;\=0A=
+        li    t7, (d1) & 0xff                 ;\=0A=
+        sb    t7, LED_DIGIT1(t6)              ;\=0A=
+        li    t7, (d2) & 0xff                 ;\=0A=
+        sb    t7, LED_DIGIT2(t6)              ;\=0A=
+        li    t7, (d3) & 0xff                 ;\=0A=
+        sb    t7, LED_DIGIT3(t6)=0A=
+=0A=
+#define LEDCLEAR()              \=0A=
+        li    t6, LED_BASE                    ;\=0A=
+        lb    t7, LED_CLEAR(t6)               ;\=0A=
+              nop=0A=
+=0A=
+#define DESTRUCTIVE     1=0A=
+#define NONDESTRUCTIVE  0=0A=
+=0A=
+#endif=0A=
diff -uNr =
linux-2.6.16-rc5/arch/mips/idt-boards/rc32438/EB438/boot/s438ram.h =
acacia/arch/mips/idt-boards/rc32438/EB438/boot/s438ram.h=0A=
--- linux-2.6.16-rc5/arch/mips/idt-boards/rc32438/EB438/boot/s438ram.h	=
1969-12-31 16:00:00.000000000 -0800=0A=
+++ acacia/arch/mips/idt-boards/rc32438/EB438/boot/s438ram.h	2006-03-14 =
13:36:04.000000000 -0800=0A=
@@ -0,0 +1,140 @@=0A=
+/**********************************************************************=
****=0A=
+ *=0A=
+ *  BRIEF MODULE DESCRIPTION=0A=
+ *   IDT EB438 DDR setup values.=0A=
+ *=0A=
+ *  Copyright 2006 IDT Inc. (rischelp@idt.com)=0A=
+ *         =0A=
+ *  This program is free software; you can redistribute  it and/or =
modify it=0A=
+ *  under  the terms of  the GNU General  Public License as published =
by the=0A=
+ *  Free Software Foundation;  either version 2 of the  License, or =
(at your=0A=
+ *  option) any later version.=0A=
+ *=0A=
+ *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR =
IMPLIED=0A=
+ *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED =
WARRANTIES OF=0A=
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE =
DISCLAIMED.  IN=0A=
+ *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, =
INDIRECT,=0A=
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES =
(INCLUDING, BUT=0A=
+ *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; =
LOSS OF=0A=
+ *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED =
AND ON=0A=
+ *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, =
OR TORT=0A=
+ *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE =
USE OF=0A=
+ *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH =
DAMAGE.=0A=
+ *=0A=
+ *  You should have received a copy of the  GNU General Public License =
along=0A=
+ *  with this program; if not, write  to the Free Software Foundation, =
Inc.,=0A=
+ *  675 Mass Ave, Cambridge, MA 02139, USA.=0A=
+ *=0A=
+ =
************************************************************************=
**=0A=
+ */=0A=
+=0A=
+#ifndef __S438RAM__=0A=
+#define __S438RAM__=0A=
+/******************************** D E F I N E S =
*******************************/=0A=
+=0A=
+#define SRAM_ONLY     1=0A=
+#define SDRAM_ONLY    2=0A=
+#define SRAM_N_SDRAM  3=0A=
+#define SDRAM_N_SRAM  4=0A=
+=0A=
+#define MB32      1=0A=
+#define MB64      2=0A=
+#define MB128     3=0A=
+=0A=
+#define DEV_CTL_BASE        PHYS_TO_K1(0x18010000)  /* device =
controller regs */=0A=
+#define DDR_CTL_BASE        PHYS_TO_K1(0x18018010)  /* DDR controller =
regs */=0A=
+=0A=
+#define DEV1_BASE           0x08000000=0A=
+#define DEV_PROM_MASK       0xFFF00000=0A=
+#define DEV_PROM_CTRL       0x04108324=0A=
+#define DEV_PROM_TC         0x00000000=0A=
+#define DEV_FLASH_MASK      0xFFE00000=0A=
+#define DEV_FLASH_CTRL      0x04108325=0A=
+#define DEV_FLASH_TC        0x00000000=0A=
+=0A=
+#define DEV2_BASE           0x0C000000=0A=
+#define DEV2_MASK           0xFC000000=0A=
+#define DEV2_CTRL           0x04108324              /* 8-bit devices =
*/=0A=
+#define DEV2_TC             0x00000000=0A=
+=0A=
+#if MEMCFG =3D=3D SRAM_ONLY || MEMCFG =3D=3D SRAM_N_SDRAM=0A=
+#define DEV3_BASE           0x00000000=0A=
+#define DEV3_MASK           0xFC000000=0A=
+#define DEV3_CTRL           0x04108325              /* 16-bit devices =
*/=0A=
+#define DEV3_TC             0x00000000=0A=
+#else=0A=
+#define DEV3_BASE           0x10000000=0A=
+#define DEV3_MASK           0xFC000000=0A=
+#define DEV3_CTRL           0x04108325              /* 16-bit devices =
*/=0A=
+#define DEV3_TC             0x00000000=0A=
+#endif=0A=
+=0A=
+#define DEV4_BASE           0x00000000=0A=
+#define DEV4_MASK           0x00000000=0A=
+#define DEV4_CTRL           0x0FFFFFF4              /* ?-bit devices =
*/=0A=
+#define DEV4_TC             0x00001FFF=0A=
+=0A=
+#define DEV5_BASE           0x00000000=0A=
+#define DEV5_MASK           0x00000000=0A=
+#define DEV5_CTRL           0x0FFFFFF4              /* ?-bit devices =
*/=0A=
+#define DEV5_TC             0x00001FFF=0A=
+=0A=
+#define DATA_PATTERN        0xA5A5A5A5=0A=
+#define RCOUNT              PHYS_TO_K1(0x18028024)=0A=
+=0A=
+#if DRAMSZ =3D=3D MB64=0A=
+=0A=
+#if MEMCFG =3D=3D SDRAM_ONLY || MEMCFG =3D=3D SDRAM_N_SRAM=0A=
+#define DDR0_BASE_VAL       0x00000000=0A=
+#define DDR0_MASK_VAL       0xFC000000=0A=
+#define DDR1_BASE_VAL       0x04000000=0A=
+#define DDR1_MASK_VAL       0x00000000=0A=
+#define DDR0_ABASE_VAL      0x08000000=0A=
+#define DDR0_AMASK_VAL      0x00000000=0A=
+#elif MEMCFG =3D=3D SRAM_N_SDRAM=0A=
+#define DDR0_BASE_VAL       0x04000000=0A=
+#define DDR0_MASK_VAL       0xFC000000=0A=
+#define DDR1_BASE_VAL       0x08000000=0A=
+#define DDR1_MASK_VAL       0x00000000=0A=
+#define DDR0_ABASE_VAL      0x00000000=0A=
+#define DDR0_AMASK_VAL      0x00000000=0A=
+#elif MEMCFG =3D=3D SRAM_ONLY=0A=
+#define DDR0_BASE_VAL       0x00000000=0A=
+#define DDR0_MASK_VAL       0x00000000=0A=
+#define DDR1_BASE_VAL       0x00000000=0A=
+#define DDR1_MASK_VAL       0x00000000=0A=
+#define DDR0_ABASE_VAL      0x00000000=0A=
+#define DDR0_AMASK_VAL      0x00000000=0A=
+#else=0A=
+illegal value for MEMCFG=0A=
+#endif=0A=
+=0A=
+#define DDRC_VAL_NORMAL       0x82984940 /* 0xA32A4980 */=0A=
+#define DDRC_VAL_AT_INIT      0x02984940 /* 0x232A4980 */=0A=
+=0A=
+#define DDR_REF_CMP_FAST      0x00000080 /* was 0x00000100 */=0A=
+#define DDR_REF_CMP_VAL       0x00000080 /* was 0x0000040e */=0A=
+#define DDR_REF_CMP_VAL_ZB    0x0000040E=0A=
+=0A=
+#define DDR_CUST_NOP          0x0000003F=0A=
+#define DDR_CUST_PRECHARGE    0x00000033=0A=
+#define DDR_CUST_REFRESH      0x00000027=0A=
+#define DDR_LD_MODE_REG       0x00000023=0A=
+#define DDR_LD_EMODE_REG      0x00000063=0A=
+=0A=
+/* =0A=
+ * All generated addresses for DDR init during custom transactions are =
shifted=0A=
+ * by two address lines - see spec for used DDR chip=0A=
+ */=0A=
+#define DDR_PRECHARGE_OFFSET  0x00001000  /* 0x0400 - 9-bit page*/=0A=
+#define DDR_EMODE_VAL         0x00000000  /* 0x0000 */=0A=
+#define DDR_DLL_RES_MODE_VAL  0x00000584  /* 0x0161 - Reset DLL, CL2.5 =
*/=0A=
+#define DDR_DLL_MODE_VAL      0x00000184  /* 0x0061 - CL2.5 */=0A=
+=0A=
+#define DELAY_200USEC         25000       /* not exactly */=0A=
+=0A=
+#else=0A=
+#error "unrecognized dram size"=0A=
+#endif=0A=
+=0A=
+#endif=0A=
diff -uNr =
linux-2.6.16-rc5/arch/mips/idt-boards/rc32438/EB438/boot/uart16550.c =
acacia/arch/mips/idt-boards/rc32438/EB438/boot/uart16550.c=0A=
--- =
linux-2.6.16-rc5/arch/mips/idt-boards/rc32438/EB438/boot/uart16550.c	=
1969-12-31 16:00:00.000000000 -0800=0A=
+++ acacia/arch/mips/idt-boards/rc32438/EB438/boot/uart16550.c	=
2006-03-14 13:36:04.000000000 -0800=0A=
@@ -0,0 +1,177 @@=0A=
+/**********************************************************************=
****=0A=
+ *=0A=
+ *  BRIEF MODULE DESCRIPTION=0A=
+ *   UART code.=0A=
+ *=0A=
+ *  Copyright 2006 IDT Inc. (rischelp@idt.com)=0A=
+ *         =0A=
+ *  This program is free software; you can redistribute  it and/or =
modify it=0A=
+ *  under  the terms of  the GNU General  Public License as published =
by the=0A=
+ *  Free Software Foundation;  either version 2 of the  License, or =
(at your=0A=
+ *  option) any later version.=0A=
+ *=0A=
+ *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR =
IMPLIED=0A=
+ *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED =
WARRANTIES OF=0A=
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE =
DISCLAIMED.  IN=0A=
+ *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, =
INDIRECT,=0A=
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES =
(INCLUDING, BUT=0A=
+ *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; =
LOSS OF=0A=
+ *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED =
AND ON=0A=
+ *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, =
OR TORT=0A=
+ *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE =
USE OF=0A=
+ *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH =
DAMAGE.=0A=
+ *=0A=
+ *  You should have received a copy of the  GNU General Public License =
along=0A=
+ *  with this program; if not, write  to the Free Software Foundation, =
Inc.,=0A=
+ *  675 Mass Ave, Cambridge, MA 02139, USA.=0A=
+ *=0A=
+ =
************************************************************************=
**=0A=
+ */=0A=
+=0A=
+#include <linux/config.h>=0A=
+=0A=
+#define RC32438_REG_BASE   0xb8000000=0A=
+#ifdef __MIPSEB__=0A=
+#define RC32438_UART0_BASE (RC32438_REG_BASE + 0x50003)=0A=
+#else=0A=
+#define RC32438_UART0_BASE (RC32438_REG_BASE + 0x50000)=0A=
+#endif=0A=
+=0A=
+#define BASE		   RC32438_UART0_BASE=0A=
+=0A=
+#define MAX_BAUD		(CONFIG_IDT_BOARD_FREQ / 16)=0A=
+#define REG_OFFSET		0x4=0A=
+=0A=
+/* =3D=3D=3D CONFIG =3D=3D=3D */=0A=
+=0A=
+/*=0A=
+ * #define BASE			0xb2001000=0A=
+ * #define MAX_BAUD		1152000=0A=
+ * #define REG_OFFSET		0x10=0A=
+ */=0A=
+#if (!defined(BASE) || !defined(MAX_BAUD) || !defined(REG_OFFSET))=0A=
+#error You must define BASE, MAX_BAUD and REG_OFFSET in the =
Makefile.=0A=
+#endif=0A=
+=0A=
+#ifndef INIT_SERIAL_PORT=0A=
+#define INIT_SERIAL_PORT	1=0A=
+#endif=0A=
+=0A=
+#ifndef DEFAULT_BAUD=0A=
+//#define DEFAULT_BAUD		UART16550_BAUD_115200=0A=
+#define DEFAULT_BAUD		UART16550_BAUD_9600=0A=
+#endif=0A=
+#ifndef DEFAULT_PARITY=0A=
+#define DEFAULT_PARITY		UART16550_PARITY_NONE=0A=
+#endif=0A=
+#ifndef DEFAULT_DATA=0A=
+#define DEFAULT_DATA		UART16550_DATA_8BIT=0A=
+#endif=0A=
+#ifndef DEFAULT_STOP=0A=
+#define DEFAULT_STOP		UART16550_STOP_1BIT=0A=
+#endif=0A=
+=0A=
+/* =3D=3D=3D END OF CONFIG =3D=3D=3D */=0A=
+=0A=
+typedef         unsigned char uint8;=0A=
+typedef         unsigned int  uint32;=0A=
+=0A=
+#define         UART16550_BAUD_2400             2400=0A=
+#define         UART16550_BAUD_4800             4800=0A=
+#define         UART16550_BAUD_9600             9600=0A=
+#define         UART16550_BAUD_19200            19200=0A=
+#define         UART16550_BAUD_38400            38400=0A=
+#define         UART16550_BAUD_57600            57600=0A=
+#define         UART16550_BAUD_115200           115200=0A=
+=0A=
+#define         UART16550_PARITY_NONE           0=0A=
+#define         UART16550_PARITY_ODD            0x08=0A=
+#define         UART16550_PARITY_EVEN           0x18=0A=
+#define         UART16550_PARITY_MARK           0x28=0A=
+#define         UART16550_PARITY_SPACE          0x38=0A=
+=0A=
+#define         UART16550_DATA_5BIT             0x0=0A=
+#define         UART16550_DATA_6BIT             0x1=0A=
+#define         UART16550_DATA_7BIT             0x2=0A=
+#define         UART16550_DATA_8BIT             0x3=0A=
+=0A=
+#define         UART16550_STOP_1BIT             0x0=0A=
+#define         UART16550_STOP_2BIT             0x4=0A=
+=0A=
+/* register offset */=0A=
+#define		OFS_RCV_BUFFER		(0*REG_OFFSET)=0A=
+#define		OFS_TRANS_HOLD		(0*REG_OFFSET)=0A=
+#define		OFS_SEND_BUFFER		(0*REG_OFFSET)=0A=
+#define		OFS_INTR_ENABLE		(1*REG_OFFSET)=0A=
+#define		OFS_INTR_ID		(2*REG_OFFSET)=0A=
+#define		OFS_DATA_FORMAT		(3*REG_OFFSET)=0A=
+#define		OFS_LINE_CONTROL	(3*REG_OFFSET)=0A=
+#define		OFS_MODEM_CONTROL	(4*REG_OFFSET)=0A=
+#define		OFS_RS232_OUTPUT	(4*REG_OFFSET)=0A=
+#define		OFS_LINE_STATUS		(5*REG_OFFSET)=0A=
+#define		OFS_MODEM_STATUS	(6*REG_OFFSET)=0A=
+#define		OFS_RS232_INPUT		(6*REG_OFFSET)=0A=
+#define		OFS_SCRATCH_PAD		(7*REG_OFFSET)=0A=
+=0A=
+#define		OFS_DIVISOR_LSB		(0*REG_OFFSET)=0A=
+#define		OFS_DIVISOR_MSB		(1*REG_OFFSET)=0A=
+=0A=
+#define		UART16550_READ(y)    (*((volatile uint8*)(BASE + y)))=0A=
+#define		UART16550_WRITE(y, z)  ((*((volatile uint8*)(BASE + y))) =3D =
z)=0A=
+=0A=
+static void Uart16550Init(uint32 baud, uint8 data, uint8 parity, uint8 =
stop)=0A=
+{=0A=
+	/* disable interrupts */=0A=
+	UART16550_WRITE(OFS_LINE_CONTROL, 0x0);=0A=
+	UART16550_WRITE(OFS_INTR_ENABLE, 0);=0A=
+=0A=
+	/* set up baud rate */=0A=
+	{=0A=
+		uint32 divisor;=0A=
+=0A=
+		/* set DIAB bit */=0A=
+		UART16550_WRITE(OFS_LINE_CONTROL, 0x80);=0A=
+=0A=
+		/* set divisor */=0A=
+		divisor =3D MAX_BAUD / baud;=0A=
+		UART16550_WRITE(OFS_DIVISOR_LSB, divisor & 0xff);=0A=
+		UART16550_WRITE(OFS_DIVISOR_MSB, (divisor & 0xff00)>>8);=0A=
+=0A=
+		/* clear DIAB bit */=0A=
+		UART16550_WRITE(OFS_LINE_CONTROL, 0x0);=0A=
+	}=0A=
+=0A=
+	/* set data format */=0A=
+	UART16550_WRITE(OFS_DATA_FORMAT, data | parity | stop);=0A=
+}=0A=
+=0A=
+=0A=
+void=0A=
+putc_init(void)=0A=
+{=0A=
+#if INIT_SERIAL_PORT=0A=
+	Uart16550Init(DEFAULT_BAUD, DEFAULT_DATA, DEFAULT_PARITY, =
DEFAULT_STOP);=0A=
+#endif=0A=
+}=0A=
+=0A=
+void=0A=
+putc(unsigned char c)=0A=
+{=0A=
+	while ((UART16550_READ(OFS_LINE_STATUS) &0x20) =3D=3D 0);=0A=
+	UART16550_WRITE(OFS_SEND_BUFFER, c);=0A=
+}=0A=
+=0A=
+#if 0=0A=
+unsigned char=0A=
+getc(void)=0A=
+{=0A=
+	while((UART16550_READ(OFS_LINE_STATUS) & 0x1) =3D=3D 0);=0A=
+	return UART16550_READ(OFS_RCV_BUFFER);=0A=
+}=0A=
+=0A=
+int=0A=
+tstc(void)=0A=
+{=0A=
+	return((UART16550_READ(OFS_LINE_STATUS) & 0x01) !=3D 0);=0A=
+}=0A=
+#endif=0A=
diff -uNr =
linux-2.6.16-rc5/arch/mips/idt-boards/rc32438/EB438/boot/zImage.lds =
acacia/arch/mips/idt-boards/rc32438/EB438/boot/zImage.lds=0A=
--- linux-2.6.16-rc5/arch/mips/idt-boards/rc32438/EB438/boot/zImage.lds	=
1969-12-31 16:00:00.000000000 -0800=0A=
+++ acacia/arch/mips/idt-boards/rc32438/EB438/boot/zImage.lds	=
2006-03-14 15:46:58.000000000 -0800=0A=
@@ -0,0 +1,31 @@=0A=
+OUTPUT_ARCH(mips)=0A=
+ENTRY(zstartup)=0A=
+SECTIONS=0A=
+{=0A=
+  /* Read-only sections, merged into text segment: */=0A=
+  . =3D 0x91000000;=0A=
+  .init          : { *(.init)		} =3D0=0A=
+  .text      :=0A=
+  {=0A=
+    _ftext =3D . ;=0A=
+    *(.text)=0A=
+    *(.rodata)=0A=
+    *(.rodata1)=0A=
+   . =3D ALIGN(4096);=0A=
+    input_data =3D .;=0A=
+    arch/mips/idt-boards/rc32438/EB438/boot/piggy.o=0A=
+    input_data_end =3D .;=0A=
+   . =3D ALIGN(4096);=0A=
+    *(.gnu.warning)=0A=
+  } =3D0=0A=
+=0A=
+  .reginfo : { *(.reginfo) }=0A=
+=0A=
+   . =3D 0x800A0000;=0A=
+  __bss_start =3D .;=0A=
+  .bss       :=0A=
+  {=0A=
+   *(.bss)=0A=
+  _end =3D . ;=0A=
+  }=0A=
+}=0A=
diff -uNr linux-2.6.16-rc5/arch/mips/idt-boards/rc32438/EB438/idtIRQ.S =
acacia/arch/mips/idt-boards/rc32438/EB438/idtIRQ.S=0A=
--- linux-2.6.16-rc5/arch/mips/idt-boards/rc32438/EB438/idtIRQ.S	=
1969-12-31 16:00:00.000000000 -0800=0A=
+++ acacia/arch/mips/idt-boards/rc32438/EB438/idtIRQ.S	2006-03-14 =
13:36:04.000000000 -0800=0A=
@@ -0,0 +1,72 @@=0A=
+/**********************************************************************=
****=0A=
+ *=0A=
+ *  BRIEF MODULE DESCRIPTION=0A=
+ *     Intterrupt dispatcher code for IDT boards=0A=
+ *=0A=
+ *  Copyright 2006 IDT Inc. (rischelp@idt.com)=0A=
+ *         =0A=
+ *  This program is free software; you can redistribute  it and/or =
modify it=0A=
+ *  under  the terms of  the GNU General  Public License as published =
by the=0A=
+ *  Free Software Foundation;  either version 2 of the  License, or =
(at your=0A=
+ *  option) any later version.=0A=
+ *=0A=
+ *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR =
IMPLIED=0A=
+ *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED =
WARRANTIES OF=0A=
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE =
DISCLAIMED.  IN=0A=
+ *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIR=
ECT,=0A=
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES =
(INCLUDING, BUT=0A=
+ *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; =
LOSS OF=0A=
+ *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED =
AND ON=0A=
+ *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, =
OR TORT=0A=
+ *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE =
USE OF=0A=
+ *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH =
DAMAGE.=0A=
+ *=0A=
+ *  You should have received a copy of the  GNU General Public License =
along=0A=
+ *  with this program; if not, write  to the Free Software Foundation, =
Inc.,=0A=
+ *  675 Mass Ave, Cambridge, MA 02139, USA.=0A=
+ *=0A=
+ *=0A=
+ =
************************************************************************=
**=0A=
+ */=0A=
+=0A=
+#include <linux/config.h>				=0A=
+#include <asm/asm.h>=0A=
+#include <asm/mipsregs.h>=0A=
+#include <asm/regdef.h>=0A=
+#include <asm/stackframe.h>=0A=
+=0A=
+	.text=0A=
+	.set	noreorder=0A=
+	.set	noat=0A=
+	.align	5=0A=
+	NESTED(idtIRQ, PT_SIZE, sp)=0A=
+	SAVE_ALL=0A=
+	CLI=0A=
+=0A=
+	.set	at=0A=
+	.set	noreorder=0A=
+=0A=
+	mfc0    t0, CP0_CAUSE=0A=
+	move	a1, sp=0A=
+								  =0A=
+	/* check for r4k counter/timer IRQ. */=0A=
+=0A=
+#ifdef CONFIG_RC32438_REVISION_ZA=0A=
+	andi    t1, t0, CAUSEF_IP2=0A=
+#else	=0A=
+	andi    t1, t0, CAUSEF_IP7=0A=
+#endif	=0A=
+	beqz    t1, 1f=0A=
+	nop=0A=
+=0A=
+	jal     idt_timer_interrupt=0A=
+	li	a0, 7=0A=
+	j	ret_from_irq=0A=
+	nop=0A=
+1:=0A=
+	jal	rc32438_irqdispatch=0A=
+	move	a0, t0=0A=
+	j	ret_from_irq=0A=
+	nop=0A=
+=0A=
+	END(idtIRQ)=0A=
diff -uNr linux-2.6.16-rc5/arch/mips/idt-boards/rc32438/EB438/irq.c =
acacia/arch/mips/idt-boards/rc32438/EB438/irq.c=0A=
--- linux-2.6.16-rc5/arch/mips/idt-boards/rc32438/EB438/irq.c	=
1969-12-31 16:00:00.000000000 -0800=0A=
+++ acacia/arch/mips/idt-boards/rc32438/EB438/irq.c	2006-03-14 =
13:36:04.000000000 -0800=0A=
@@ -0,0 +1,264 @@=0A=
+/**********************************************************************=
****=0A=
+ *=0A=
+ *  BRIEF MODULE DESCRIPTION=0A=
+ *     Interrupt routines for IDT EB438 boards=0A=
+ *=0A=
+ *  Copyright 2006 IDT Inc. (rischelp@idt.com)=0A=
+ *         =0A=
+ *  This program is free software; you can redistribute  it and/or =
modify it=0A=
+ *  under  the terms of  the GNU General  Public License as published =
by the=0A=
+ *  Free Software Foundation;  either version 2 of the  License, or =
(at your=0A=
+ *  option) any later version.=0A=
+ *=0A=
+ *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR =
IMPLIED=0A=
+ *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED =
WARRANTIES OF=0A=
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE =
DISCLAIMED.  IN=0A=
+ *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, =
INDIRECT,=0A=
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES =
(INCLUDING, BUT=0A=
+ *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; =
LOSS OF=0A=
+ *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED =
AND ON=0A=
+ *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, =
OR TORT=0A=
+ *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE =
USE OF=0A=
+ *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH =
DAMAGE.=0A=
+ *=0A=
+ *  You should have received a copy of the  GNU General Public License =
along=0A=
+ *  with this program; if not, write  to the Free Software Foundation, =
Inc.,=0A=
+ *  675 Mass Ave, Cambridge, MA 02139, USA.=0A=
+ *=0A=
+ *=0A=
+ =
************************************************************************=
**=0A=
+ */=0A=
+=0A=
+#include <linux/errno.h>=0A=
+#include <linux/init.h>=0A=
+#include <linux/kernel_stat.h>=0A=
+#include <linux/module.h>=0A=
+#include <linux/signal.h>=0A=
+#include <linux/sched.h>=0A=
+#include <linux/types.h>=0A=
+#include <linux/interrupt.h>=0A=
+#include <linux/ioport.h>=0A=
+#include <linux/timex.h>=0A=
+#include <linux/slab.h>=0A=
+#include <linux/random.h>=0A=
+#include <linux/delay.h>=0A=
+=0A=
+#include <asm/bitops.h>=0A=
+#include <asm/bootinfo.h>=0A=
+#include <asm/io.h>=0A=
+#include <asm/mipsregs.h>=0A=
+#include <asm/system.h>=0A=
+#include <asm/idt-boards/rc32438/rc32438.h>=0A=
+#include <asm/idt-boards/rc32438/rc32438_gpio.h>=0A=
+=0A=
+#include <asm/irq.h>=0A=
+=0A=
+#undef DEBUG_IRQ=0A=
+#ifdef DEBUG_IRQ=0A=
+/* note: prints function name for you */=0A=
+#define DPRINTK(fmt, args...) printk("%s: " fmt, __FUNCTION__ , ## =
args)=0A=
+#else=0A=
+#define DPRINTK(fmt, args...)=0A=
+#endif=0A=
+=0A=
+extern asmlinkage void idtIRQ(void);=0A=
+static unsigned int startup_irq(unsigned int irq);=0A=
+static void end_irq(unsigned int irq_nr);=0A=
+static void mask_and_ack_irq(unsigned int irq_nr);=0A=
+static void rc32438_enable_irq(unsigned int irq_nr);=0A=
+static void rc32438_disable_irq(unsigned int irq_nr);=0A=
+=0A=
+extern void __init init_generic_irq(void);=0A=
+=0A=
+typedef struct {=0A=
+  u32 mask;=0A=
+  volatile u32 *base_addr;=0A=
+} intr_group_t;=0A=
+=0A=
+static const intr_group_t intr_group[NUM_INTR_GROUPS] =3D {=0A=
+  { 0x0000efff, (u32 *)KSEG1ADDR(IC_GROUP0_PEND + 0 * IC_GROUP_OFFSET) =
},=0A=
+  { 0x00001fff, (u32 *)KSEG1ADDR(IC_GROUP0_PEND + 1 * IC_GROUP_OFFSET) =
},=0A=
+  { 0x00000007, (u32 *)KSEG1ADDR(IC_GROUP0_PEND + 2 * IC_GROUP_OFFSET) =
},=0A=
+  { 0x0003ffff, (u32 *)KSEG1ADDR(IC_GROUP0_PEND + 3 * IC_GROUP_OFFSET) =
},=0A=
+  { 0xffffffff, (u32 *)KSEG1ADDR(IC_GROUP0_PEND + 4 * IC_GROUP_OFFSET) =
}=0A=
+};=0A=
+=0A=
+#define READ_PEND(base) (*(base))=0A=
+#define READ_MASK(base) (*(base + 2))=0A=
+#define WRITE_MASK(base, val) (*(base + 2) =3D (val))=0A=
+=0A=
+static inline int irq_to_group(unsigned int irq_nr)=0A=
+{=0A=
+  return ((irq_nr - GROUP0_IRQ_BASE) >> 5);=0A=
+}=0A=
+=0A=
+static inline int group_to_ip(unsigned int group)=0A=
+{=0A=
+  return group + 2;=0A=
+}=0A=
+=0A=
+static inline void enable_local_irq(unsigned int ip)=0A=
+{=0A=
+  int ipnum =3D 0x100 << ip;=0A=
+  clear_c0_cause(ipnum);=0A=
+  set_c0_status(ipnum);=0A=
+}=0A=
+=0A=
+static inline void disable_local_irq(unsigned int ip)=0A=
+{=0A=
+  int ipnum =3D 0x100 << ip;=0A=
+  clear_c0_status(ipnum);=0A=
+}=0A=
+=0A=
+static inline void ack_local_irq(unsigned int ip)=0A=
+{=0A=
+  int ipnum =3D 0x100 << ip;=0A=
+  clear_c0_cause(ipnum);=0A=
+}=0A=
+static void rc32438_enable_irq(unsigned int irq_nr)=0A=
+{=0A=
+  int           ip =3D irq_nr - GROUP0_IRQ_BASE;=0A=
+  unsigned int  group, intr_bit;=0A=
+  volatile unsigned int  *addr;=0A=
+  if (ip < 0)=0A=
+    {=0A=
+      enable_local_irq(irq_nr);=0A=
+    }=0A=
+  else=0A=
+    {=0A=
+  // calculate group=0A=
+  group =3D ip >> 5;=0A=
+    =0A=
+  // calc interrupt bit within group=0A=
+  ip -=3D (group << 5);=0A=
+  intr_bit =3D 1 << ip;=0A=
+    =0A=
+  // first enable the IP mapped to this IRQ=0A=
+  enable_local_irq(group_to_ip(group));=0A=
+    =0A=
+  addr =3D intr_group[group].base_addr;=0A=
+  // unmask intr within group=0A=
+  WRITE_MASK(addr, READ_MASK(addr) & ~intr_bit);=0A=
+    }=0A=
+}=0A=
+=0A=
+static void rc32438_disable_irq(unsigned int irq_nr)=0A=
+{=0A=
+  int           ip =3D irq_nr - GROUP0_IRQ_BASE;=0A=
+  unsigned int  group, intr_bit, mask;=0A=
+  volatile unsigned int  *addr;=0A=
+=0A=
+  // calculate group=0A=
+  group =3D ip >> 5;=0A=
+=0A=
+  // calc interrupt bit within group=0A=
+  ip -=3D group << 5;=0A=
+  intr_bit =3D 1 << ip;=0A=
+    =0A=
+  addr =3D intr_group[group].base_addr;=0A=
+  // mask intr within group=0A=
+  mask =3D READ_MASK(addr);=0A=
+  mask |=3D intr_bit;=0A=
+  WRITE_MASK(addr, mask);=0A=
+    =0A=
+  /*=0A=
+    if there are no more interrupts enabled in this=0A=
+    group, disable corresponding IP=0A=
+  */=0A=
+  if (mask =3D=3D intr_group[group].mask)=0A=
+    disable_local_irq(group_to_ip(group));=0A=
+}=0A=
+static unsigned int startup_irq(unsigned int irq_nr)=0A=
+{=0A=
+  rc32438_enable_irq(irq_nr);=0A=
+  return 0; =0A=
+}=0A=
+=0A=
+static void shutdown_irq(unsigned int irq_nr)=0A=
+{=0A=
+  rc32438_disable_irq(irq_nr);=0A=
+  return;=0A=
+}=0A=
+=0A=
+static void mask_and_ack_irq(unsigned int irq_nr)=0A=
+{=0A=
+  rc32438_disable_irq(irq_nr);=0A=
+  ack_local_irq(group_to_ip(irq_to_group(irq_nr)));=0A=
+}=0A=
+=0A=
+static void end_irq(unsigned int irq_nr)=0A=
+{=0A=
+=0A=
+  int ip =3D irq_nr - GROUP0_IRQ_BASE;=0A=
+  unsigned int intr_bit, group;=0A=
+  volatile unsigned int *addr;=0A=
+=0A=
+  if (!(irq_desc[irq_nr].status & (IRQ_DISABLED | IRQ_INPROGRESS))) =
{=0A=
+    if (irq_nr =3D=3D GROUP4_IRQ_BASE + 27)=0A=
+      gpio->gpioistat =3D 0xf7ffffff;=0A=
+      =0A=
+    group =3D ip >> 5;=0A=
+=0A=
+    // calc interrupt bit within group=0A=
+    ip -=3D (group << 5);=0A=
+    intr_bit =3D 1 << ip;=0A=
+    =0A=
+    // first enable the IP mapped to this IRQ=0A=
+    enable_local_irq(group_to_ip(group));=0A=
+  =0A=
+    addr =3D intr_group[group].base_addr;=0A=
+    // unmask intr within group=0A=
+    WRITE_MASK(addr, READ_MASK(addr) & ~intr_bit);=0A=
+  } =0A=
+  else {=0A=
+    printk("warning: end_irq %d did not enable (%x)\n", =0A=
+	   irq_nr, irq_desc[irq_nr].status);=0A=
+  }=0A=
+}=0A=
+=0A=
+static struct hw_interrupt_type rc32438_irq_type =3D {=0A=
+  .typename =3D "IDT438",=0A=
+  .startup  =3D startup_irq,=0A=
+  .shutdown =3D shutdown_irq,=0A=
+  .enable   =3D rc32438_enable_irq,=0A=
+  .disable  =3D rc32438_disable_irq,=0A=
+  .ack      =3D mask_and_ack_irq,=0A=
+  .end      =3D end_irq,=0A=
+};=0A=
+=0A=
+void __init arch_init_irq(void)=0A=
+{=0A=
+  int i;=0A=
+  printk("Initializing IRQ's: %d out of %d\n", RC32438_NR_IRQS, =
NR_IRQS);  =0A=
+  memset(irq_desc, 0, sizeof(irq_desc));=0A=
+  set_except_vector(0, idtIRQ);=0A=
+  =0A=
+  for (i =3D 0; i < RC32438_NR_IRQS; i++) {=0A=
+    irq_desc[i].status =3D IRQ_DISABLED;=0A=
+    irq_desc[i].action =3D NULL;=0A=
+    irq_desc[i].depth =3D 1;=0A=
+    irq_desc[i].handler =3D &rc32438_irq_type;=0A=
+    spin_lock_init(&irq_desc[i].lock);=0A=
+  }=0A=
+}=0A=
+=0A=
+/* Main Interrupt dispatcher */=0A=
+void rc32438_irqdispatch(unsigned long cp0_cause, struct pt_regs =
*regs)=0A=
+{=0A=
+  unsigned int ip, pend, group;=0A=
+  volatile unsigned int *addr;=0A=
+=0A=
+  if ((ip =3D (cp0_cause & 0x7c00))) {=0A=
+    group =3D 21 - rc32438_clz(ip);=0A=
+=0A=
+    addr =3D intr_group[group].base_addr;=0A=
+=0A=
+    pend =3D READ_PEND(addr);=0A=
+    pend &=3D ~READ_MASK(addr); // only unmasked interrupts=0A=
+    pend =3D 39 - rc32438_clz(pend);=0A=
+    do_IRQ((group << 5) + pend, regs);=0A=
+    return;=0A=
+  } =0A=
+  else=0A=
+    return;=0A=
+}=0A=
diff -uNr linux-2.6.16-rc5/arch/mips/idt-boards/rc32438/EB438/Makefile =
acacia/arch/mips/idt-boards/rc32438/EB438/Makefile=0A=
--- linux-2.6.16-rc5/arch/mips/idt-boards/rc32438/EB438/Makefile	=
1969-12-31 16:00:00.000000000 -0800=0A=
+++ acacia/arch/mips/idt-boards/rc32438/EB438/Makefile	2006-03-14 =
13:36:04.000000000 -0800=0A=
@@ -0,0 +1,42 @@=0A=
+#######################################################################=
########=0A=
+#=0A=
+#  BRIEF MODULE DESCRIPTION=0A=
+#     Makefile for IDT EB438 board BSP=0A=
+#=0A=
+#  Copyright 2006 IDT Inc. (rischelp@idt.com)=0A=
+#=0A=
+#  This program is free software; you can redistribute  it and/or =
modify it=0A=
+#  under  the terms of  the GNU General  Public License as published =
by the=0A=
+#  Free Software Foundation;  either version 2 of the  License, or (at =
your=0A=
+#  option) any later version.=0A=
+#=0A=
+#  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR =
IMPLIED=0A=
+#  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED =
WARRANTIES OF=0A=
+#   MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE =
DISCLAIMED.  IN=0A=
+#   NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, =
INDIRECT,=0A=
+#   INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES =
(INCLUDING, BUT=0A=
+#   NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; =
LOSS OF=0A=
+#   USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED =
AND ON=0A=
+#   ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, =
OR TORT=0A=
+#   (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE =
USE OF=0A=
+#   THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH =
DAMAGE.=0A=
+#=0A=
+#   You should have received a copy of the  GNU General Public License =
along=0A=
+#   with this program; if not, write  to the Free Software Foundation, =
Inc.,=0A=
+#   675 Mass Ave, Cambridge, MA 02139, USA.=0A=
+# =0A=
+# =0A=
+#######################################################################=
########=0A=
+=0A=
+=0A=
+.S.s:=0A=
+	$(CPP) $(CFLAGS) $< -o $*.s=0A=
+.S.o:=0A=
+	$(CC) $(CFLAGS) -c $< -o $*.o=0A=
+=0A=
+obj-y	 :=3D irq.o prom.o time.o setup.o idtIRQ.o reset.o=0A=
+obj-$(CONFIG_KGDB)			+=3D serial_gdb.o=0A=
+obj-$(CONFIG_SERIAL_8250) 		+=3D serial.o=0A=
+subdir-$(CONFIG_IDT_BOOT_NVRAM)		+=3D nvram=0A=
+obj-$(CONFIG_IDT_BOOT_NVRAM)    	+=3D nvram/built-in.o=0A=
+=0A=
diff -uNr =
linux-2.6.16-rc5/arch/mips/idt-boards/rc32438/EB438/nvram/Makefile =
acacia/arch/mips/idt-boards/rc32438/EB438/nvram/Makefile=0A=
--- linux-2.6.16-rc5/arch/mips/idt-boards/rc32438/EB438/nvram/Makefile	=
1969-12-31 16:00:00.000000000 -0800=0A=
+++ acacia/arch/mips/idt-boards/rc32438/EB438/nvram/Makefile	2006-03-14 =
13:36:04.000000000 -0800=0A=
@@ -0,0 +1,42 @@=0A=
+#######################################################################=
########=0A=
+#=0A=
+#  BRIEF MODULE DESCRIPTION=0A=
+#     Makefile for IDT EB438 nvram access routines=0A=
+#=0A=
+#  Copyright 2006 IDT Inc. (rischelp@idt.com)=0A=
+#=0A=
+#  This program is free software; you can redistribute  it and/or =
modify it=0A=
+#  under  the terms of  the GNU General  Public License as published =
by the=0A=
+#  Free Software Foundation;  either version 2 of the  License, or (at =
your=0A=
+#  option) any later version.=0A=
+#=0A=
+#  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR =
IMPLIED=0A=
+#  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED =
WARRANTIES OF=0A=
+#   MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE =
DISCLAIMED.  IN=0A=
+#   NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, =
INDIRECT,=0A=
+#   INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES =
(INCLUDING, BUT=0A=
+#   NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; =
LOSS OF=0A=
+#   USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED =
AND ON=0A=
+#   ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, =
OR TORT=0A=
+#   (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE =
USE OF=0A=
+#   THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH =
DAMAGE.=0A=
+#=0A=
+#   You should have received a copy of the  GNU General Public License =
along=0A=
+#   with this program; if not, write  to the Free Software Foundation, =
Inc.,=0A=
+#   675 Mass Ave, Cambridge, MA 02139, USA.=0A=
+#=0A=
+#######################################################################=
########=0A=
+=0A=
+.S.s:   =0A=
+	$(CPP) $(CFLAGS) $< -o $*.s=0A=
+.S.o:   =0A=
+	$(CC) $(CFLAGS) -c $< -o $*.o=0A=
+=0A=
+obj-y   :=3D nvram438.o=0A=
+=0A=
+=0A=
+=0A=
+=0A=
+=0A=
+=0A=
+=0A=
diff -uNr =
linux-2.6.16-rc5/arch/mips/idt-boards/rc32438/EB438/nvram/nvram438.c =
acacia/arch/mips/idt-boards/rc32438/EB438/nvram/nvram438.c=0A=
--- =
linux-2.6.16-rc5/arch/mips/idt-boards/rc32438/EB438/nvram/nvram438.c	=
1969-12-31 16:00:00.000000000 -0800=0A=
+++ acacia/arch/mips/idt-boards/rc32438/EB438/nvram/nvram438.c	=
2006-03-14 13:36:04.000000000 -0800=0A=
@@ -0,0 +1,356 @@=0A=
+/**********************************************************************=
****=0A=
+ *=0A=
+ *  BRIEF MODULE DESCRIPTION=0A=
+ *     nvram interface routines.=0A=
+ *=0A=
+ *  Copyright 2006 IDT Inc. (rischelp@idt.com)=0A=
+ *         =0A=
+ *  This program is free software; you can redistribute  it and/or =
modify it=0A=
+ *  under  the terms of  the GNU General  Public License as published =
by the=0A=
+ *  Free Software Foundation;  either version 2 of the  License, or =
(at your=0A=
+ *  option) any later version.=0A=
+ *=0A=
+ *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR =
IMPLIED=0A=
+ *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED =
WARRANTIES OF=0A=
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE =
DISCLAIMED.  IN=0A=
+ *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, =
INDIRECT,=0A=
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES =
(INCLUDING, BUT=0A=
+ *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; =
LOSS OF=0A=
+ *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED =
AND ON=0A=
+ *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, =
OR TORT=0A=
+ *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE =
USE OF=0A=
+ *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH =
DAMAGE.=0A=
+ *=0A=
+ *  You should have received a copy of the  GNU General Public License =
along=0A=
+ *  with this program; if not, write  to the Free Software Foundation, =
Inc.,=0A=
+ *  675 Mass Ave, Cambridge, MA 02139, USA.=0A=
+ *=0A=
+  =
************************************************************************=
**=0A=
+ */=0A=
+=0A=
+#include <linux/ctype.h>=0A=
+#include <linux/string.h>=0A=
+#include "nvram438.h"=0A=
+#include "rtc.h"=0A=
+#define  NVRAM_BASE RTCLOCK_BASE=0A=
+=0A=
+extern void setenv (char *e, char *v, int rewrite);=0A=
+extern void unsetenv (char *e);=0A=
+extern void mapenv (int (*func)(char *, char *));=0A=
+extern char *getenv (char *s);=0A=
+extern void purgeenv(void);=0A=
+=0A=
+static void nvram_initenv(void);=0A=
+=0A=
+static unsigned char=0A=
+nvram_getbyte(int offs)=0A=
+{=0A=
+  return(*((unsigned char*)(NVRAM_BASE + offs)));=0A=
+}=0A=
+=0A=
+static void=0A=
+nvram_setbyte(int offs, unsigned char val)=0A=
+{=0A=
+  unsigned char* nvramDataPointer =3D (unsigned char*)(NVRAM_BASE + =
offs);=0A=
+=0A=
+  *nvramDataPointer =3D val;=0A=
+}=0A=
+=0A=
+static unsigned short=0A=
+nvram_getshort(int offs)=0A=
+{=0A=
+  return((nvram_getbyte(offs) << 8) | nvram_getbyte(offs + 1));=0A=
+}=0A=
+=0A=
+static void=0A=
+nvram_setshort(int offs, unsigned short val)=0A=
+{=0A=
+  nvram_setbyte(offs, (unsigned char)((val >> 8) & 0xff));=0A=
+  nvram_setbyte(offs + 1, (unsigned char)(val & 0xff));=0A=
+}=0A=
+/*=0A=
+ * calculate NVRAM checksum=0A=
+ */=0A=
+static unsigned short=0A=
+nvram_calcsum(void)=0A=
+{=0A=
+  unsigned short sum =3D NV_MAGIC;=0A=
+  int     i;=0A=
+=0A=
+  for (i =3D ENV_BASE; i < ENV_TOP; i +=3D 2)=0A=
+    sum +=3D nvram_getshort(i);=0A=
+  return(sum);=0A=
+}=0A=
+=0A=
+/*=0A=
+ * update the nvram checksum=0A=
+ */=0A=
+static void=0A=
+nvram_updatesum (void)=0A=
+{=0A=
+  nvram_setshort(NVOFF_CSUM, nvram_calcsum());=0A=
+}=0A=
+=0A=
+/*=0A=
+ * test validity of nvram by checksumming it=0A=
+ */=0A=
+static int=0A=
+nvram_isvalid(void)=0A=
+{=0A=
+  static int  is_valid;=0A=
+=0A=
+  if (is_valid)=0A=
+    return(1);=0A=
+=0A=
+  if (nvram_getshort(NVOFF_MAGIC) !=3D NV_MAGIC)=0A=
+    nvram_initenv();=0A=
+  is_valid =3D 1;=0A=
+  return(1);=0A=
+}=0A=
+=0A=
+/* return nvram address of environment string */=0A=
+static int=0A=
+nvram_matchenv(char *s)=0A=
+{=0A=
+  int envsize, envp, n, i, varsize;=0A=
+  char *var;=0A=
+=0A=
+  envsize =3D nvram_getshort(NVOFF_ENVSIZE);=0A=
+  if (envsize > ENV_AVAIL)=0A=
+    return(0);     /* sanity */=0A=
+    =0A=
+  envp =3D ENV_BASE;=0A=
+=0A=
+  if ((n =3D strlen (s)) > 255)=0A=
+    return(0);=0A=
+    =0A=
+  while (envsize > 0) {=0A=
+    varsize =3D nvram_getbyte(envp);=0A=
+    if (varsize =3D=3D 0 || (envp + varsize) > ENV_TOP)=0A=
+      return(0);   /* sanity */=0A=
+    for (i =3D envp + 1, var =3D s; i <=3D envp + n; i++, var++) {=0A=
+      char c1 =3D nvram_getbyte(i);=0A=
+      char c2 =3D *var;=0A=
+      if (islower(c1))=0A=
+        c1 =3D toupper(c1);=0A=
+      if (islower(c2))=0A=
+        c2 =3D toupper(c2);=0A=
+      if (c1 !=3D c2)=0A=
+        break;=0A=
+    }=0A=
+    if (i > envp + n) {       /* match so far */=0A=
+      if (n =3D=3D varsize - 1)   /* match on boolean */=0A=
+        return(envp);=0A=
+      if (nvram_getbyte(i) =3D=3D '=3D')  /* exact match on variable =
*/=0A=
+        return(envp);=0A=
+    }=0A=
+    envsize -=3D varsize;=0A=
+    envp +=3D varsize;=0A=
+  }=0A=
+  return(0);=0A=
+}=0A=
+=0A=
+static void nvram_initenv(void)=0A=
+{=0A=
+  nvram_setshort(NVOFF_MAGIC, NV_MAGIC);=0A=
+  nvram_setshort(NVOFF_ENVSIZE, 0);=0A=
+=0A=
+  nvram_updatesum();=0A=
+}=0A=
+=0A=
+static void=0A=
+nvram_delenv(char *s)=0A=
+{=0A=
+  int nenvp, envp, envsize, nbytes;=0A=
+=0A=
+  envp =3D nvram_matchenv(s);=0A=
+  if (envp =3D=3D 0)=0A=
+    return;=0A=
+=0A=
+  nenvp =3D envp + nvram_getbyte(envp);=0A=
+  envsize =3D nvram_getshort(NVOFF_ENVSIZE);=0A=
+  nbytes =3D envsize - (nenvp - ENV_BASE);=0A=
+  nvram_setshort(NVOFF_ENVSIZE, envsize - (nenvp - envp));=0A=
+  while (nbytes--) {=0A=
+    nvram_setbyte(envp, nvram_getbyte(nenvp));=0A=
+    envp++;=0A=
+    nenvp++;=0A=
+  }=0A=
+  nvram_updatesum();=0A=
+}=0A=
+=0A=
+static int=0A=
+nvram_setenv(char *s, char *v)=0A=
+{=0A=
+  int ns, nv, total;=0A=
+  int envp;=0A=
+=0A=
+  if (!nvram_isvalid())=0A=
+    return(-1);=0A=
+=0A=
+  nvram_delenv(s);=0A=
+  ns =3D strlen(s);=0A=
+  if (ns =3D=3D 0)=0A=
+    return (-1);=0A=
+  if (v && *v) {=0A=
+    nv =3D strlen(v);=0A=
+    total =3D ns + nv + 2;=0A=
+  }=0A=
+  else {=0A=
+    nv =3D 0;=0A=
+    total =3D ns + 1;=0A=
+  }=0A=
+  if (total > 255 || total > ENV_AVAIL - =
nvram_getshort(NVOFF_ENVSIZE))=0A=
+    return(-1);=0A=
+=0A=
+  envp =3D ENV_BASE + nvram_getshort(NVOFF_ENVSIZE);=0A=
+=0A=
+  nvram_setbyte(envp, (unsigned char) total); =0A=
+  envp++;=0A=
+=0A=
+  while (ns--) {=0A=
+    nvram_setbyte(envp, *s); =0A=
+    envp++; =0A=
+    s++;=0A=
+  }=0A=
+=0A=
+  if (nv) {=0A=
+    nvram_setbyte(envp, '=3D'); =0A=
+    envp++;=0A=
+    while (nv--) {=0A=
+      nvram_setbyte(envp, *v); =0A=
+      envp++; =0A=
+      v++;=0A=
+    }=0A=
+  }=0A=
+  nvram_setshort(NVOFF_ENVSIZE, envp-ENV_BASE);=0A=
+  nvram_updatesum();=0A=
+  return 0;=0A=
+}=0A=
+=0A=
+static char *=0A=
+nvram_getenv(char *s)=0A=
+{=0A=
+  static char buf[256];   /* FIXME: this cannot be static */=0A=
+  int envp, ns, nbytes, i;=0A=
+=0A=
+  if (!nvram_isvalid())=0A=
+    return((char *)0);=0A=
+=0A=
+  envp =3D nvram_matchenv(s);=0A=
+  if (envp =3D=3D 0)=0A=
+    return((char *)0);=0A=
+  ns =3D strlen(s);=0A=
+  if (nvram_getbyte(envp) =3D=3D ns + 1)  /* boolean */=0A=
+    buf[0] =3D '\0';=0A=
+  else {=0A=
+    nbytes =3D nvram_getbyte(envp) - (ns + 2);=0A=
+    envp +=3D ns + 2;=0A=
+    for (i =3D 0; i < nbytes; i++)=0A=
+      buf[i] =3D nvram_getbyte(envp++);=0A=
+    buf[i] =3D '\0';=0A=
+  }=0A=
+  return(buf);=0A=
+}=0A=
+=0A=
+static void=0A=
+nvram_unsetenv(char *s)=0A=
+{=0A=
+  if (!nvram_isvalid())=0A=
+    return;=0A=
+=0A=
+  nvram_delenv(s);=0A=
+}=0A=
+=0A=
+/*=0A=
+ * apply func to each string in environment=0A=
+ */=0A=
+static void=0A=
+nvram_mapenv(int (*func)(char *, char *))=0A=
+{=0A=
+  int envsize, envp, n, i, seeneql;=0A=
+  char name[256], value[256];=0A=
+  char c, *s;=0A=
+=0A=
+  if (!nvram_isvalid())=0A=
+    return;=0A=
+=0A=
+  envsize =3D nvram_getshort(NVOFF_ENVSIZE);=0A=
+  envp =3D ENV_BASE;=0A=
+=0A=
+  while (envsize > 0) {=0A=
+    value[0] =3D '\0';=0A=
+    seeneql =3D 0;=0A=
+    s =3D name;=0A=
+    n =3D nvram_getbyte(envp);=0A=
+    for (i =3D envp + 1; i < envp + n; i++) {=0A=
+      c =3D nvram_getbyte(i);=0A=
+      if ((c =3D=3D '=3D') && !seeneql) {=0A=
+        *s =3D '\0';=0A=
+        s =3D value;=0A=
+        seeneql =3D 1;=0A=
+        continue;=0A=
+      }=0A=
+      *s++ =3D c;=0A=
+    }=0A=
+    *s =3D '\0';=0A=
+    (*func)(name, value);=0A=
+    envsize -=3D n;=0A=
+    envp +=3D n;=0A=
+  }=0A=
+}=0A=
+#if 0=0A=
+static unsigned int=0A=
+digit(char c)=0A=
+{=0A=
+  if ('0' <=3D c && c <=3D '9')=0A=
+    return (c - '0');=0A=
+  if ('A' <=3D c && c <=3D 'Z')=0A=
+    return (10 + c - 'A');=0A=
+  if ('a' <=3D c && c <=3D 'z')=0A=
+    return (10 + c - 'a');=0A=
+  return (~0);=0A=
+}=0A=
+#endif=0A=
+/*=0A=
+ * Wrappers to allow 'special' environment variables to get =
processed=0A=
+ */=0A=
+void=0A=
+setenv(char *e, char *v, int rewrite)=0A=
+{=0A=
+  if (nvram_getenv(e) && !rewrite)=0A=
+    return;=0A=
+    =0A=
+  nvram_setenv(e, v);=0A=
+}=0A=
+=0A=
+char *=0A=
+getenv(char *e)=0A=
+{=0A=
+  return(nvram_getenv(e));=0A=
+}=0A=
+=0A=
+void=0A=
+unsetenv(char *e)=0A=
+{=0A=
+  nvram_unsetenv(e);=0A=
+}=0A=
+=0A=
+void=0A=
+purgeenv()=0A=
+{=0A=
+  int i;=0A=
+  unsigned char* nvramDataPointer =3D (unsigned char*)(NVRAM_BASE);=0A=
+  =0A=
+  for (i =3D ENV_BASE; i < ENV_TOP; i++)=0A=
+    *nvramDataPointer++ =3D 0;=0A=
+  nvram_setshort(NVOFF_MAGIC, NV_MAGIC);=0A=
+  nvram_setshort(NVOFF_ENVSIZE, 0);=0A=
+  nvram_setshort(NVOFF_CSUM, NV_MAGIC);=0A=
+}=0A=
+=0A=
+void=0A=
+mapenv(int (*func)(char *, char *))=0A=
+{=0A=
+  nvram_mapenv(func);=0A=
+}=0A=
diff -uNr =
linux-2.6.16-rc5/arch/mips/idt-boards/rc32438/EB438/nvram/nvram438.h =
acacia/arch/mips/idt-boards/rc32438/EB438/nvram/nvram438.h=0A=
--- =
linux-2.6.16-rc5/arch/mips/idt-boards/rc32438/EB438/nvram/nvram438.h	=
1969-12-31 16:00:00.000000000 -0800=0A=
+++ acacia/arch/mips/idt-boards/rc32438/EB438/nvram/nvram438.h	=
2006-03-14 13:36:04.000000000 -0800=0A=
@@ -0,0 +1,57 @@=0A=
+/**********************************************************************=
****=0A=
+ *=0A=
+ *  BRIEF MODULE DESCRIPTION=0A=
+ *     nvram definitions.=0A=
+ *=0A=
+ *  Copyright 2006 IDT Inc. (rischelp@idt.com)=0A=
+ *         =0A=
+ *  This program is free software; you can redistribute  it and/or =
modify it=0A=
+ *  under  the terms of  the GNU General  Public License as published =
by the=0A=
+ *  Free Software Foundation;  either version 2 of the  License, or =
(at your=0A=
+ *  option) any later version.=0A=
+ *=0A=
+ *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR =
IMPLIED=0A=
+ *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED =
WARRANTIES OF=0A=
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE =
DISCLAIMED.  IN=0A=
+ *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, =
INDIRECT,=0A=
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES =
(INCLUDING, BUT=0A=
+ *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; =
LOSS OF=0A=
+ *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED =
AND ON=0A=
+ *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, =
OR TORT=0A=
+ *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE =
USE OF=0A=
+ *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH =
DAMAGE.=0A=
+ *=0A=
+ *  You should have received a copy of the  GNU General Public License =
along=0A=
+ *  with this program; if not, write  to the Free Software Foundation, =
Inc.,=0A=
+ *  675 Mass Ave, Cambridge, MA 02139, USA.=0A=
+ *=0A=
+ =
************************************************************************=
**=0A=
+ */=0A=
+=0A=
+#ifndef __IDT_EB438_NVRAM_H__=0A=
+#define __IDT_EB438_NVRAM_H__=0A=
+#define NVOFFSET        0                 /* use all of NVRAM */=0A=
+=0A=
+/* Offsets to reserved locations */=0A=
+              /* size description */=0A=
+#define NVOFF_MAGIC     (NVOFFSET + 0)    /* 2 magic value */=0A=
+#define NVOFF_CSUM      (NVOFFSET + 2)    /* 2 NVRAM environment =
checksum */=0A=
+#define NVOFF_ENVSIZE   (NVOFFSET + 4)    /* 2 size of 'environment' =
*/=0A=
+#define NVOFF_TEST      (NVOFFSET + 5)    /* 1 cold start test byte =
*/=0A=
+#define NVOFF_ETHADDR   (NVOFFSET + 6)    /* 6 decoded ethernet =
address */=0A=
+#define NVOFF_UNUSED    (NVOFFSET + 12)   /* 0 current end of table =
*/=0A=
+=0A=
+#define NV_MAGIC        0xdeaf            /* nvram magic number */=0A=
+#define NV_RESERVED     32                /* number of reserved bytes =
*/=0A=
+=0A=
+#undef  NVOFF_ETHADDR=0A=
+#define NVOFF_ETHADDR   (NVOFFSET + NV_RESERVED - 6)=0A=
+=0A=
+/* number of bytes available for environment */=0A=
+#define ENV_BASE        (NVOFFSET + NV_RESERVED)=0A=
+#define ENV_TOP         TD_NVRAM_SIZE=0A=
+#define ENV_AVAIL       (ENV_TOP - ENV_BASE)=0A=
+=0A=
+#endif //__IDT_EB438_NVRAM_H__=0A=
+=0A=
+=0A=
diff -uNr =
linux-2.6.16-rc5/arch/mips/idt-boards/rc32438/EB438/nvram/rtc.h =
acacia/arch/mips/idt-boards/rc32438/EB438/nvram/rtc.h=0A=
--- linux-2.6.16-rc5/arch/mips/idt-boards/rc32438/EB438/nvram/rtc.h	=
1969-12-31 16:00:00.000000000 -0800=0A=
+++ acacia/arch/mips/idt-boards/rc32438/EB438/nvram/rtc.h	2006-03-14 =
13:36:04.000000000 -0800=0A=
@@ -0,0 +1,74 @@=0A=
+/**********************************************************************=
****
+ *
+ *  BRIEF MODULE DESCRIPTION
+ *     DS1553(Dallas Semiconductor) Real Time Clock and Non-Volatile =
RAM.
+ *
+ *  Copyright 2006 IDT Inc. (rischelp@idt.com)
+ *        =20
+ *  This program is free software; you can redistribute  it and/or =
modify it
+ *  under  the terms of  the GNU General  Public License as published =
by the
+ *  Free Software Foundation;  either version 2 of the  License, or =
(at your
+ *  option) any later version.
+ *
+ *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR =
IMPLIED
+ *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED =
WARRANTIES OF
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE =
DISCLAIMED.  IN
+ *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, =
INDIRECT,
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES =
(INCLUDING, BUT
+ *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; =
LOSS OF
+ *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED =
AND ON
+ *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, =
OR TORT
+ *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE =
USE OF
+ *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ *  You should have received a copy of the  GNU General Public License =
along
+ *  with this program; if not, write  to the Free Software Foundation, =
Inc.,
+ *  675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ =
************************************************************************=
**
+ */
+
+#ifndef __IDT_EB438_RTC_H__
+#define __IDT_EB438_RTC_H__
+#define RTCLOCK_BASE    0xAC080000
+
+/*
+ * To maintain endianess independence, make all accesses as 32-bit
+ * words with appropriate shifting.
+ */
+#define TD_NVRAM_SIZE 0x2000
+
+typedef struct td_clock {
+  unsigned char ram[0x1FF0];
+  unsigned char flags;
+  unsigned char dummy;
+  unsigned char alarm_secs;
+  unsigned char alarm_mins;
+  unsigned char alarm_hours;
+  unsigned char alarm_date;
+  unsigned char interrupts;
+  unsigned char watchdog;
+  unsigned char century;
+  unsigned char secs;
+  unsigned char mins;
+  unsigned char hours;
+  unsigned char weekday;
+  unsigned char date;
+  unsigned char month;
+  unsigned char year;
+} RTC;
+
+#define rtc (*((volatile RTC *)RTCLOCK_BASE))
+
+/*
+ * Control register bit definitions
+ */
+#define TDC_ENA_READ      0x40
+#define TDC_DIS_READ      0xbf
+
+#define TDC_ENA_WRITE     0x80
+#define TDC_DIS_WRITE     0x7f
+
+#define TDC_RUN_OSC       0x80
+
+#endif //__IDT_EB438_RTC_H__
diff -uNr =
linux-2.6.16-rc5/arch/mips/idt-boards/rc32438/EB438/nvram438.c =
acacia/arch/mips/idt-boards/rc32438/EB438/nvram438.c=0A=
--- linux-2.6.16-rc5/arch/mips/idt-boards/rc32438/EB438/nvram438.c	=
1969-12-31 16:00:00.000000000 -0800=0A=
+++ acacia/arch/mips/idt-boards/rc32438/EB438/nvram438.c	2006-03-14 =
13:36:04.000000000 -0800=0A=
@@ -0,0 +1,348 @@=0A=
+/**********************************************************************=
****=0A=
+ *=0A=
+ *  BRIEF MODULE DESCRIPTION=0A=
+ *     Routines to access the NVRAM on IDT EB438 board=0A=
+ *=0A=
+ *  Copyright 2006 IDT Inc. (rischelp@idt.com)=0A=
+ *         =0A=
+ *  This program is free software; you can redistribute  it and/or =
modify it=0A=
+ *  under  the terms of  the GNU General  Public License as published =
by the=0A=
+ *  Free Software Foundation;  either version 2 of the  License, or =
(at your=0A=
+ *  option) any later version.=0A=
+ *=0A=
+ *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR =
IMPLIED=0A=
+ *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED =
WARRANTIES OF=0A=
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE =
DISCLAIMED.  IN=0A=
+ *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, =
INDIRECT,=0A=
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES =
(INCLUDING, BUT=0A=
+ *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; =
LOSS OF=0A=
+ *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED =
AND ON=0A=
+ *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, =
OR TORT=0A=
+ *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE =
USE OF=0A=
+ *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH =
DAMAGE.=0A=
+ *=0A=
+ *  You should have received a copy of the  GNU General Public License =
along=0A=
+ *  with this program; if not, write  to the Free Software Foundation, =
Inc.,=0A=
+ *  675 Mass Ave, Cambridge, MA 02139, USA.=0A=
+ *=0A=
+ *=0A=
+ =
************************************************************************=
**=0A=
+ */=0A=
+=0A=
+#include <linux/string.h>=0A=
+#include <linux/ctype.h>=0A=
+=0A=
+#include "nvram438.h"=0A=
+#include "rtc.h"=0A=
+#define  NVRAM_BASE RTCLOCK_BASE=0A=
+=0A=
+extern void setenv (char *e, char *v, int rewrite);=0A=
+extern void unsetenv (char *e);=0A=
+extern void mapenv (int (*func)(char *, char *));=0A=
+extern char *getenv (char *s);=0A=
+extern void purgeenv(void);=0A=
+=0A=
+static void nvram_initenv(void);=0A=
+=0A=
+static unsigned char=0A=
+nvram_getbyte(int offs)=0A=
+{=0A=
+  return(*((unsigned char*)(NVRAM_BASE + offs)));=0A=
+}=0A=
+=0A=
+static void=0A=
+nvram_setbyte(int offs, unsigned char val)=0A=
+{=0A=
+  unsigned char* nvramDataPointer =3D (unsigned char*)(NVRAM_BASE + =
offs);=0A=
+=0A=
+  *nvramDataPointer =3D val;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * BigEndian!=0A=
+ */=0A=
+static unsigned short=0A=
+nvram_getshort(int offs)=0A=
+{=0A=
+  return((nvram_getbyte(offs) << 8) | nvram_getbyte(offs + 1));=0A=
+}=0A=
+=0A=
+static void=0A=
+nvram_setshort(int offs, unsigned short val)=0A=
+{=0A=
+  nvram_setbyte(offs, (unsigned char)((val >> 8) & 0xff));=0A=
+  nvram_setbyte(offs + 1, (unsigned char)(val & 0xff));=0A=
+}=0A=
+/*=0A=
+ * calculate NVRAM checksum=0A=
+ */=0A=
+static unsigned short=0A=
+nvram_calcsum(void)=0A=
+{=0A=
+  unsigned short sum =3D NV_MAGIC;=0A=
+  int     i;=0A=
+=0A=
+  for (i =3D ENV_BASE; i < ENV_TOP; i +=3D 2)=0A=
+    sum +=3D nvram_getshort(i);=0A=
+  return(sum);=0A=
+}=0A=
+=0A=
+/*=0A=
+ * update the nvram checksum=0A=
+ */=0A=
+static void=0A=
+nvram_updatesum (void)=0A=
+{=0A=
+  nvram_setshort(NVOFF_CSUM, nvram_calcsum());=0A=
+}=0A=
+=0A=
+/*=0A=
+ * test validity of nvram by checksumming it=0A=
+ */=0A=
+static int=0A=
+nvram_isvalid(void)=0A=
+{=0A=
+  static int  is_valid;=0A=
+=0A=
+  if (is_valid)=0A=
+    return(1);=0A=
+=0A=
+  if (nvram_getshort(NVOFF_MAGIC) !=3D NV_MAGIC)=0A=
+    nvram_initenv();=0A=
+  is_valid =3D 1;=0A=
+  return(1);=0A=
+}=0A=
+=0A=
+/* return nvram address of environment string */=0A=
+static int=0A=
+nvram_matchenv(char *s)=0A=
+{=0A=
+  int envsize, envp, n, i, varsize;=0A=
+  char *var;=0A=
+=0A=
+  envsize =3D nvram_getshort(NVOFF_ENVSIZE);=0A=
+  if (envsize > ENV_AVAIL)=0A=
+    return(0);     /* sanity */=0A=
+    =0A=
+  envp =3D ENV_BASE;=0A=
+=0A=
+  if ((n =3D strlen (s)) > 255)=0A=
+    return(0);=0A=
+    =0A=
+  while (envsize > 0) {=0A=
+    varsize =3D nvram_getbyte(envp);=0A=
+    if (varsize =3D=3D 0 || (envp + varsize) > ENV_TOP)=0A=
+      return(0);   /* sanity */=0A=
+    for (i =3D envp + 1, var =3D s; i <=3D envp + n; i++, var++) {=0A=
+      char c1 =3D nvram_getbyte(i);=0A=
+      char c2 =3D *var;=0A=
+      if (islower(c1))=0A=
+        c1 =3D toupper(c1);=0A=
+      if (islower(c2))=0A=
+        c2 =3D toupper(c2);=0A=
+      if (c1 !=3D c2)=0A=
+        break;=0A=
+    }=0A=
+    if (i > envp + n) {       /* match so far */=0A=
+      if (n =3D=3D varsize - 1)   /* match on boolean */=0A=
+        return(envp);=0A=
+      if (nvram_getbyte(i) =3D=3D '=3D')  /* exact match on variable =
*/=0A=
+        return(envp);=0A=
+    }=0A=
+    envsize -=3D varsize;=0A=
+    envp +=3D varsize;=0A=
+  }=0A=
+  return(0);=0A=
+}=0A=
+=0A=
+static void nvram_initenv(void)=0A=
+{=0A=
+  nvram_setshort(NVOFF_MAGIC, NV_MAGIC);=0A=
+  nvram_setshort(NVOFF_ENVSIZE, 0);=0A=
+=0A=
+  nvram_updatesum();=0A=
+}=0A=
+=0A=
+static void=0A=
+nvram_delenv(char *s)=0A=
+{=0A=
+  int nenvp, envp, envsize, nbytes;=0A=
+=0A=
+  envp =3D nvram_matchenv(s);=0A=
+  if (envp =3D=3D 0)=0A=
+    return;=0A=
+=0A=
+  nenvp =3D envp + nvram_getbyte(envp);=0A=
+  envsize =3D nvram_getshort(NVOFF_ENVSIZE);=0A=
+  nbytes =3D envsize - (nenvp - ENV_BASE);=0A=
+  nvram_setshort(NVOFF_ENVSIZE, envsize - (nenvp - envp));=0A=
+  while (nbytes--) {=0A=
+    nvram_setbyte(envp, nvram_getbyte(nenvp));=0A=
+    envp++;=0A=
+    nenvp++;=0A=
+  }=0A=
+  nvram_updatesum();=0A=
+}=0A=
+=0A=
+static int=0A=
+nvram_setenv(char *s, char *v)=0A=
+{=0A=
+  int ns, nv, total;=0A=
+  int envp;=0A=
+=0A=
+  if (!nvram_isvalid())=0A=
+    return(-1);=0A=
+=0A=
+  nvram_delenv(s);=0A=
+  ns =3D strlen(s);=0A=
+  if (ns =3D=3D 0)=0A=
+    return (-1);=0A=
+  if (v && *v) {=0A=
+    nv =3D strlen(v);=0A=
+    total =3D ns + nv + 2;=0A=
+  }=0A=
+  else {=0A=
+    nv =3D 0;=0A=
+    total =3D ns + 1;=0A=
+  }=0A=
+  if (total > 255 || total > ENV_AVAIL - =
nvram_getshort(NVOFF_ENVSIZE))=0A=
+    return(-1);=0A=
+=0A=
+  envp =3D ENV_BASE + nvram_getshort(NVOFF_ENVSIZE);=0A=
+=0A=
+  nvram_setbyte(envp, (unsigned char) total); =0A=
+  envp++;=0A=
+=0A=
+  while (ns--) {=0A=
+    nvram_setbyte(envp, *s); =0A=
+    envp++; =0A=
+    s++;=0A=
+  }=0A=
+=0A=
+  if (nv) {=0A=
+    nvram_setbyte(envp, '=3D'); =0A=
+    envp++;=0A=
+    while (nv--) {=0A=
+      nvram_setbyte(envp, *v); =0A=
+      envp++; =0A=
+      v++;=0A=
+    }=0A=
+  }=0A=
+  nvram_setshort(NVOFF_ENVSIZE, envp-ENV_BASE);=0A=
+  nvram_updatesum();=0A=
+  return 0;=0A=
+}=0A=
+=0A=
+static char *=0A=
+nvram_getenv(char *s)=0A=
+{=0A=
+  static char buf[256];   /* FIXME: this cannot be static */=0A=
+  int envp, ns, nbytes, i;=0A=
+=0A=
+  if (!nvram_isvalid())=0A=
+    return((char *)0);=0A=
+=0A=
+  envp =3D nvram_matchenv(s);=0A=
+  if (envp =3D=3D 0)=0A=
+    return((char *)0);=0A=
+  ns =3D strlen(s);=0A=
+  if (nvram_getbyte(envp) =3D=3D ns + 1)  /* boolean */=0A=
+    buf[0] =3D '\0';=0A=
+  else {=0A=
+    nbytes =3D nvram_getbyte(envp) - (ns + 2);=0A=
+    envp +=3D ns + 2;=0A=
+    for (i =3D 0; i < nbytes; i++)=0A=
+      buf[i] =3D nvram_getbyte(envp++);=0A=
+    buf[i] =3D '\0';=0A=
+  }=0A=
+  return(buf);=0A=
+}=0A=
+=0A=
+static void=0A=
+nvram_unsetenv(char *s)=0A=
+{=0A=
+  if (!nvram_isvalid())=0A=
+    return;=0A=
+=0A=
+  nvram_delenv(s);=0A=
+}=0A=
+=0A=
+/*=0A=
+ * apply func to each string in environment=0A=
+ */=0A=
+static void=0A=
+nvram_mapenv(int (*func)(char *, char *))=0A=
+{=0A=
+  int envsize, envp, n, i, seeneql;=0A=
+  char name[256], value[256];=0A=
+  char c, *s;=0A=
+=0A=
+  if (!nvram_isvalid())=0A=
+    return;=0A=
+=0A=
+  envsize =3D nvram_getshort(NVOFF_ENVSIZE);=0A=
+  envp =3D ENV_BASE;=0A=
+=0A=
+  while (envsize > 0) {=0A=
+    value[0] =3D '\0';=0A=
+    seeneql =3D 0;=0A=
+    s =3D name;=0A=
+    n =3D nvram_getbyte(envp);=0A=
+    for (i =3D envp + 1; i < envp + n; i++) {=0A=
+      c =3D nvram_getbyte(i);=0A=
+      if ((c =3D=3D '=3D') && !seeneql) {=0A=
+        *s =3D '\0';=0A=
+        s =3D value;=0A=
+        seeneql =3D 1;=0A=
+        continue;=0A=
+      }=0A=
+      *s++ =3D c;=0A=
+    }=0A=
+    *s =3D '\0';=0A=
+    (*func)(name, value);=0A=
+    envsize -=3D n;=0A=
+    envp +=3D n;=0A=
+  }=0A=
+}=0A=
+/*=0A=
+ * Wrappers to allow 'special' environment variables to get =
processed=0A=
+ */=0A=
+void=0A=
+setenv(char *e, char *v, int rewrite)=0A=
+{=0A=
+  if (nvram_getenv(e) && !rewrite)=0A=
+    return;=0A=
+    =0A=
+  nvram_setenv(e, v);=0A=
+}=0A=
+=0A=
+char *=0A=
+getenv(char *e)=0A=
+{=0A=
+  return(nvram_getenv(e));=0A=
+}=0A=
+=0A=
+void=0A=
+unsetenv(char *e)=0A=
+{=0A=
+  nvram_unsetenv(e);=0A=
+}=0A=
+=0A=
+void=0A=
+purgeenv()=0A=
+{=0A=
+  int i;=0A=
+  unsigned char* nvramDataPointer =3D (unsigned char*)(NVRAM_BASE);=0A=
+  =0A=
+  for (i =3D ENV_BASE; i < ENV_TOP; i++)=0A=
+    *nvramDataPointer++ =3D 0;=0A=
+  nvram_setshort(NVOFF_MAGIC, NV_MAGIC);=0A=
+  nvram_setshort(NVOFF_ENVSIZE, 0);=0A=
+  nvram_setshort(NVOFF_CSUM, NV_MAGIC);=0A=
+}=0A=
+=0A=
+void=0A=
+mapenv(int (*func)(char *, char *))=0A=
+{=0A=
+  nvram_mapenv(func);=0A=
+}=0A=
diff -uNr =
linux-2.6.16-rc5/arch/mips/idt-boards/rc32438/EB438/nvram438.h =
acacia/arch/mips/idt-boards/rc32438/EB438/nvram438.h=0A=
--- linux-2.6.16-rc5/arch/mips/idt-boards/rc32438/EB438/nvram438.h	=
1969-12-31 16:00:00.000000000 -0800=0A=
+++ acacia/arch/mips/idt-boards/rc32438/EB438/nvram438.h	2006-03-14 =
13:36:04.000000000 -0800=0A=
@@ -0,0 +1,54 @@=0A=
+/**********************************************************************=
****=0A=
+ *=0A=
+ *  BRIEF MODULE DESCRIPTION=0A=
+ *     Definitions for NVRAM on IDT EB438 board=0A=
+ *=0A=
+ *  Copyright 2006 IDT Inc. (rischelp@idt.com)=0A=
+ *         =0A=
+ *  This program is free software; you can redistribute  it and/or =
modify it=0A=
+ *  under  the terms of  the GNU General  Public License as published =
by the=0A=
+ *  Free Software Foundation;  either version 2 of the  License, or =
(at your=0A=
+ *  option) any later version.=0A=
+ *=0A=
+ *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR =
IMPLIED=0A=
+ *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED =
WARRANTIES OF=0A=
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE =
DISCLAIMED.  IN=0A=
+ *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, =
INDIRECT,=0A=
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES =
(INCLUDING, BUT=0A=
+ *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; =
LOSS OF=0A=
+ *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED =
AND ON=0A=
+ *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, =
OR TORT=0A=
+ *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE =
USE OF=0A=
+ *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH =
DAMAGE.=0A=
+ *=0A=
+ *  You should have received a copy of the  GNU General Public License =
along=0A=
+ *  with this program; if not, write  to the Free Software Foundation, =
Inc.,=0A=
+ *  675 Mass Ave, Cambridge, MA 02139, USA.=0A=
+ *=0A=
+ =
************************************************************************=
**=0A=
+ */=0A=
+=0A=
+=0A=
+#define NVOFFSET        0                 /* use all of NVRAM */=0A=
+=0A=
+/* Offsets to reserved locations */=0A=
+              /* size description */=0A=
+#define NVOFF_MAGIC     (NVOFFSET + 0)    /* 2 magic value */=0A=
+#define NVOFF_CSUM      (NVOFFSET + 2)    /* 2 NVRAM environment =
checksum */=0A=
+#define NVOFF_ENVSIZE   (NVOFFSET + 4)    /* 2 size of 'environment' =
*/=0A=
+#define NVOFF_TEST      (NVOFFSET + 5)    /* 1 cold start test byte =
*/=0A=
+#define NVOFF_ETHADDR   (NVOFFSET + 6)    /* 6 decoded ethernet =
address */=0A=
+#define NVOFF_UNUSED    (NVOFFSET + 12)   /* 0 current end of table =
*/=0A=
+=0A=
+#define NV_MAGIC        0xdeaf            /* nvram magic number */=0A=
+#define NV_RESERVED     32                /* number of reserved bytes =
*/=0A=
+=0A=
+#undef  NVOFF_ETHADDR=0A=
+#define NVOFF_ETHADDR   (NVOFFSET + NV_RESERVED - 6)=0A=
+=0A=
+/* number of bytes available for environment */=0A=
+#define ENV_BASE        (NVOFFSET + NV_RESERVED)=0A=
+#define ENV_TOP         TD_NVRAM_SIZE=0A=
+#define ENV_AVAIL       (ENV_TOP - ENV_BASE)=0A=
+=0A=
+=0A=
diff -uNr linux-2.6.16-rc5/arch/mips/idt-boards/rc32438/EB438/prom.c =
acacia/arch/mips/idt-boards/rc32438/EB438/prom.c=0A=
--- linux-2.6.16-rc5/arch/mips/idt-boards/rc32438/EB438/prom.c	=
1969-12-31 16:00:00.000000000 -0800=0A=
+++ acacia/arch/mips/idt-boards/rc32438/EB438/prom.c	2006-03-14 =
13:36:04.000000000 -0800=0A=
@@ -0,0 +1,138 @@=0A=
+/**********************************************************************=
****=0A=
+ *=0A=
+ *  BRIEF MODULE DESCRIPTION=0A=
+ *     prom interface routines=0A=
+ *=0A=
+ *  Copyright 2006 IDT Inc. (rischelp@idt.com)=0A=
+ *         =0A=
+ *  This program is free software; you can redistribute  it and/or =
modify it=0A=
+ *  under  the terms of  the GNU General  Public License as published =
by the=0A=
+ *  Free Software Foundation;  either version 2 of the  License, or =
(at your=0A=
+ *  option) any later version.=0A=
+ *=0A=
+ *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR =
IMPLIED=0A=
+ *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED =
WARRANTIES OF=0A=
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE =
DISCLAIMED.  IN=0A=
+ *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, =
INDIRECT,=0A=
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES =
(INCLUDING, BUT=0A=
+ *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; =
LOSS OF=0A=
+ *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED =
AND ON=0A=
+ *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, =
OR TORT=0A=
+ *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE =
USE OF=0A=
+ *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH =
DAMAGE.=0A=
+ *=0A=
+ *  You should have received a copy of the  GNU General Public License =
along=0A=
+ *  with this program; if not, write  to the Free Software Foundation, =
Inc.,=0A=
+ *  675 Mass Ave, Cambridge, MA 02139, USA.=0A=
+ =
************************************************************************=
**=0A=
+ */=0A=
+=0A=
+#include <linux/config.h>=0A=
+#include <linux/init.h>=0A=
+#include <linux/mm.h>=0A=
+#include <linux/module.h>=0A=
+#include <linux/string.h>=0A=
+#include <linux/console.h>=0A=
+#include <asm/bootinfo.h>=0A=
+#include <linux/bootmem.h>=0A=
+#include <linux/ioport.h>=0A=
+#include <linux/serial.h>=0A=
+#include <linux/serialP.h>=0A=
+#include <asm/serial.h>=0A=
+#include <linux/ioport.h>=0A=
+=0A=
+unsigned int idt_cpu_freq =3D CONFIG_IDT_BOARD_FREQ;=0A=
+EXPORT_SYMBOL(idt_cpu_freq);=0A=
+=0A=
+extern void setup_serial_port(void);=0A=
+#ifdef CONFIG_IDT_BOOT_NVRAM=0A=
+extern void mapenv(int (*func)(char *, char *));=0A=
+static int make_bootparm(char *name,char *val)=0A=
+{ =0A=
+/*=0A=
+ * The bootparameters are obtained from NVRAM and formatted here.=0A=
+ * For e.g.=0A=
+ *=0A=
+ *    netaddr=3D10.0.1.95=0A=
+ *    bootaddr=3D10.0.0.139=0A=
+ *    bootfile=3Dvmlinus=0A=
+ *    bootparm1=3Droot=3D/dev/nfs=0A=
+ *    bootparm2=3Dip=3D10.0.1.95=0A=
+ *=0A=
+ * is parsed to:=0A=
+ *=0A=
+ *      root=3D/dev/nfs ip=3D10.0.1.95=0A=
+ *=0A=
+ * in arcs_cmdline[].=0A=
+ */=0A=
+  if (strncmp(name, "bootparm", 8) =3D=3D 0) {=0A=
+    strcat(arcs_cmdline,val);=0A=
+    strcat(arcs_cmdline," ");=0A=
+  }=0A=
+  else if(strncmp(name, "HZ", 2) =3D=3D 0) {=0A=
+    idt_cpu_freq =3D simple_strtoul(val, 0, 10);=0A=
+    printk("CPU Clock at %d Hz (from HZ environment variable)\n",=0A=
+           idt_cpu_freq);=0A=
+  }=0A=
+  return 0;=0A=
+}=0A=
+static void prom_init_cmdline(void)=0A=
+{ =0A=
+  memset(arcs_cmdline,0,sizeof(arcs_cmdline));=0A=
+  mapenv(&make_bootparm);=0A=
+}=0A=
+#else=0A=
+/* Kernel Boot parameters */=0A=
+//static unsigned char =
bootparm[]=3D"ip=3D157.165.29.36:157.165.29.18::255.255.0.0::eth0";=0A=
+static unsigned char bootparm[]=3D"console=3DttyS0,9600";=0A=
+#endif=0A=
+extern unsigned long mips_machgroup;=0A=
+extern unsigned long mips_machtype;=0A=
+=0A=
+/* IDT 79EB438 memory map -- we really should be auto sizing it */=0A=
+=0A=
+#define RAM_FIRST       0x80000400  /* Leave room for interrupt =
vectors */=0A=
+#define RAM_SIZE        60*1024*1024=0A=
+#define RAM_END         (0x80000000 + RAM_SIZE)     =0A=
+struct resource rc32438_res_ram =3D {=0A=
+	"RAM",=0A=
+	0,=0A=
+	RAM_SIZE,=0A=
+	IORESOURCE_MEM=0A=
+};=0A=
+=0A=
+char * __init prom_getcmdline(void)=0A=
+{ =0A=
+  return &(arcs_cmdline[0]);=0A=
+}=0A=
+=0A=
+=0A=
+void __init prom_init(void)=0A=
+{=0A=
+#ifdef CONFIG_IDT_BOOT_NVRAM=0A=
+	/* set up command line */=0A=
+	prom_init_cmdline();=0A=
+#else=0A=
+	sprintf(arcs_cmdline,"%s",bootparm);=0A=
+#endif=0A=
+=0A=
+	/* set our arch type */=0A=
+=0A=
+	setup_serial_port();=0A=
+=0A=
+	mips_machgroup =3D MACH_GROUP_IDT;=0A=
+	mips_machtype =3D MACH_IDT_EB438;=0A=
+=0A=
+	/*=0A=
+	 * give all RAM to boot allocator,=0A=
+	 * except where the kernel was loaded=0A=
+	 */=0A=
+	add_memory_region(0,=0A=
+			  rc32438_res_ram.end - rc32438_res_ram.start,=0A=
+			  BOOT_MEM_RAM);=0A=
+}=0A=
+=0A=
+void prom_free_prom_memory(void)=0A=
+{=0A=
+	printk("stubbed prom_free_prom_memory()\n");=0A=
+}=0A=
diff -uNr linux-2.6.16-rc5/arch/mips/idt-boards/rc32438/EB438/reset.c =
acacia/arch/mips/idt-boards/rc32438/EB438/reset.c=0A=
--- linux-2.6.16-rc5/arch/mips/idt-boards/rc32438/EB438/reset.c	=
1969-12-31 16:00:00.000000000 -0800=0A=
+++ acacia/arch/mips/idt-boards/rc32438/EB438/reset.c	2006-03-14 =
13:36:04.000000000 -0800=0A=
@@ -0,0 +1,64 @@=0A=
+/**********************************************************************=
****=0A=
+ *=0A=
+ *  BRIEF MODULE DESCRIPTION=0A=
+ *     Reset EB438 board.=0A=
+ *=0A=
+ *  Copyright 2006 IDT Inc. (rischelp@idt.com)=0A=
+ *         =0A=
+ *  This program is free software; you can redistribute  it and/or =
modify it=0A=
+ *  under  the terms of  the GNU General  Public License as published =
by the=0A=
+ *  Free Software Foundation;  either version 2 of the  License, or =
(at your=0A=
+ *  option) any later version.=0A=
+ *=0A=
+ *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR =
IMPLIED=0A=
+ *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED =
WARRANTIES OF=0A=
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE =
DISCLAIMED.  IN=0A=
+ *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, =
INDIRECT,=0A=
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES =
(INCLUDING, BUT=0A=
+ *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; =
LOSS OF=0A=
+ *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED =
AND ON=0A=
+ *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, =
OR TORT=0A=
+ *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE =
USE OF=0A=
+ *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH =
DAMAGE.=0A=
+ *=0A=
+ *  You should have received a copy of the  GNU General Public License =
along=0A=
+ *  with this program; if not, write  to the Free Software Foundation, =
Inc.,=0A=
+ *  675 Mass Ave, Cambridge, MA 02139, USA.=0A=
+ *=0A=
+ =
************************************************************************=
**=0A=
+ */=0A=
+=0A=
+#include <linux/init.h>=0A=
+#include <linux/mm.h>=0A=
+#include <linux/sched.h>=0A=
+#include <linux/irq.h>=0A=
+#include <asm/bootinfo.h>=0A=
+#include <asm/io.h>=0A=
+#include <linux/ioport.h>=0A=
+#include <asm/mipsregs.h>=0A=
+#include <asm/pgtable.h>=0A=
+#include <linux/mc146818rtc.h>=0A=
+#include <asm/reboot.h>=0A=
+#include <asm/addrspace.h>    =0A=
+=0A=
+extern void (*flush_cache_all)(void);=0A=
+=0A=
+void idt_reset(void)=0A=
+{=0A=
+=0A=
+  set_c0_status((ST0_BEV | ST0_ERL));=0A=
+  set_c0_config(CONF_CM_UNCACHED);=0A=
+  flush_cache_all();=0A=
+  write_c0_wired(0);=0A=
+=0A=
+  /* Errata item #13 */=0A=
+=0A=
+  *((volatile u32 *)KSEG1ADDR(0x18080000)) =3D 0x0;=0A=
+  *((volatile u32 *)KSEG1ADDR(0x18080018)) =3D 0x0;=0A=
+  *((volatile u32 *)KSEG1ADDR(0x18080024)) =3D 0x0;=0A=
+  *((volatile u32 *)KSEG1ADDR(0x18080030)) =3D 0x0;=0A=
+  *((volatile u32 *)KSEG1ADDR(0x1808003c)) =3D 0x0;=0A=
+=0A=
+  /* Reset*/=0A=
+  *((volatile u32 *)KSEG1ADDR(0x18008000)) =3D 0x80000001;=0A=
+}=0A=
diff -uNr linux-2.6.16-rc5/arch/mips/idt-boards/rc32438/EB438/serial.c =
acacia/arch/mips/idt-boards/rc32438/EB438/serial.c=0A=
--- linux-2.6.16-rc5/arch/mips/idt-boards/rc32438/EB438/serial.c	=
1969-12-31 16:00:00.000000000 -0800=0A=
+++ acacia/arch/mips/idt-boards/rc32438/EB438/serial.c	2006-03-14 =
13:36:04.000000000 -0800=0A=
@@ -0,0 +1,84 @@=0A=
+/**********************************************************************=
****=0A=
+ *=0A=
+ *  BRIEF MODULE DESCRIPTION=0A=
+ *     Serial port initialisation.=0A=
+ *=0A=
+ *  Copyright 2006 IDT Inc. (rischelp@idt.com)=0A=
+ *         =0A=
+ *  This program is free software; you can redistribute  it and/or =
modify it=0A=
+ *  under  the terms of  the GNU General  Public License as published =
by the=0A=
+ *  Free Software Foundation;  either version 2 of the  License, or =
(at your=0A=
+ *  option) any later version.=0A=
+ *=0A=
+ *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR =
IMPLIED=0A=
+ *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED =
WARRANTIES OF=0A=
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE =
DISCLAIMED.  IN=0A=
+ *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, =
INDIRECT,=0A=
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES =
(INCLUDING, BUT=0A=
+ *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; =
LOSS OF=0A=
+ *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED =
AND ON=0A=
+ *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, =
OR TORT=0A=
+ *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE =
USE OF=0A=
+ *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH =
DAMAGE.=0A=
+ *=0A=
+ *  You should have received a copy of the  GNU General Public License =
along=0A=
+ *  with this program; if not, write  to the Free Software Foundation, =
Inc.,=0A=
+ *  675 Mass Ave, Cambridge, MA 02139, USA.=0A=
+ *=0A=
+ =
************************************************************************=
**=0A=
+ */=0A=
+=0A=
+#include <linux/config.h>=0A=
+#include <linux/init.h>=0A=
+#include <linux/sched.h>=0A=
+#include <linux/pci.h>=0A=
+#include <linux/interrupt.h>=0A=
+#include <linux/tty.h>=0A=
+#include <linux/serial.h>=0A=
+#include <linux/serial_core.h>=0A=
+=0A=
+#include <asm/time.h>=0A=
+#include <asm/cpu.h>=0A=
+#include <asm/bootinfo.h>=0A=
+#include <asm/irq.h>=0A=
+#include <asm/serial.h>=0A=
+=0A=
+#include <asm/idt-boards/rc32438/rc32438.h>=0A=
+extern int __init early_serial_setup(struct uart_port *port);=0A=
+=0A=
+#define BASE_BAUD (1843200 / 16)=0A=
+=0A=
+extern unsigned int idt_cpu_freq;=0A=
+extern int __init setup_serial_port(void)=0A=
+{=0A=
+  static struct uart_port serial_req[2];=0A=
+=0A=
+  memset(serial_req, 0, sizeof(serial_req));=0A=
+  serial_req[0].type       =3D PORT_16550A;=0A=
+  serial_req[0].line       =3D 0;=0A=
+  serial_req[0].irq        =3D RC32438_UART0_IRQ;=0A=
+  serial_req[0].flags      =3D STD_COM_FLAGS;=0A=
+  serial_req[0].uartclk    =3D idt_cpu_freq;=0A=
+  serial_req[0].iotype     =3D SERIAL_IO_MEM;=0A=
+  serial_req[0].membase    =3D (char *) =
KSEG1ADDR(RC32438_UART0_BASE);=0A=
+=0A=
+  serial_req[0].mapbase   =3D KSEG1ADDR(RC32438_UART0_BASE);=0A=
+  serial_req[0].regshift   =3D 2;=0A=
+=0A=
+  serial_req[1].type       =3D PORT_16550A;=0A=
+  serial_req[1].line       =3D 1;=0A=
+  serial_req[1].irq        =3D RC32438_UART1_IRQ;=0A=
+  serial_req[1].flags      =3D STD_COM_FLAGS;=0A=
+  serial_req[1].uartclk    =3D idt_cpu_freq;=0A=
+  serial_req[1].iotype     =3D SERIAL_IO_MEM;=0A=
+  serial_req[1].membase    =3D (char *) =
KSEG1ADDR(RC32438_UART1_BASE);=0A=
+=0A=
+  serial_req[1].regshift   =3D 2;=0A=
+  serial_req[1].mapbase   =3D KSEG1ADDR(RC32438_UART1_BASE);=0A=
+=0A=
+  early_serial_setup(&serial_req[0]);=0A=
+  early_serial_setup(&serial_req[1]);=0A=
+=0A=
+  return(0);=0A=
+}=0A=
+//early_initcall(setup_serial_port);=0A=
diff -uNr =
linux-2.6.16-rc5/arch/mips/idt-boards/rc32438/EB438/serial_gdb.c =
acacia/arch/mips/idt-boards/rc32438/EB438/serial_gdb.c=0A=
--- linux-2.6.16-rc5/arch/mips/idt-boards/rc32438/EB438/serial_gdb.c	=
1969-12-31 16:00:00.000000000 -0800=0A=
+++ acacia/arch/mips/idt-boards/rc32438/EB438/serial_gdb.c	2006-03-14 =
13:36:04.000000000 -0800=0A=
@@ -0,0 +1,272 @@=0A=
+/**********************************************************************=
****=0A=
+ *=0A=
+ *  BRIEF MODULE DESCRIPTION=0A=
+ *      EB438 specific polling driver for 16550 UART.=0A=
+ *=0A=
+ *  Copyright 2006 IDT Inc. (rischelp@idt.com)=0A=
+ *         =0A=
+ *  This program is free software; you can redistribute  it and/or =
modify it=0A=
+ *  under  the terms of  the GNU General  Public License as published =
by the=0A=
+ *  Free Software Foundation;  either version 2 of the  License, or =
(at your=0A=
+ *  option) any later version.=0A=
+ *=0A=
+ *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR =
IMPLIED=0A=
+ *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED =
WARRANTIES OF=0A=
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE =
DISCLAIMED.  IN=0A=
+ *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, =
INDIRECT,=0A=
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES =
(INCLUDING, BUT=0A=
+ *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; =
LOSS OF=0A=
+ *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED =
AND ON=0A=
+ *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, =
OR TORT=0A=
+ *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE =
USE OF=0A=
+ *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH =
DAMAGE.=0A=
+ *=0A=
+ *  You should have received a copy of the  GNU General Public License =
along=0A=
+ *  with this program; if not, write  to the Free Software Foundation, =
Inc.,=0A=
+ *  675 Mass Ave, Cambridge, MA 02139, USA.=0A=
+ *=0A=
+ =
************************************************************************=
***=0A=
+ */=0A=
+=0A=
+#include <linux/serial_reg.h>=0A=
+=0A=
+/* set remote gdb baud rate at 115200 */=0A=
+=0A=
+#define GDB_BAUD 115200=0A=
+#define CONS_BAUD 9600=0A=
+=0A=
+extern unsigned int idt_cpu_freq;=0A=
+=0A=
+=0A=
+/* turn this on to watch the debug protocol echoed on the console port =
*/=0A=
+#undef DEBUG_REMOTE_DEBUG=0A=
+=0A=
+#ifdef __MIPSEB__=0A=
+#define CONS_PORT 0xb8050003u=0A=
+#define GDB_PORT  0xb8050023u=0A=
+#else=0A=
+#define CONS_PORT 0xb8050000u=0A=
+#define GDB_PORT  0xb8050020u=0A=
+#endif=0A=
+           =0A=
+volatile unsigned char *ports[2] =3D {=0A=
+	(volatile unsigned char *)CONS_PORT,=0A=
+	(volatile unsigned char *)GDB_PORT=0A=
+};=0A=
+=0A=
+=0A=
+void reset_gdb_port(void);=0A=
+void cons_putc(char c);=0A=
+int port_getc(int port);=0A=
+void port_putc(int port, char c);=0A=
+=0A=
+int cons_getc(void)=0A=
+{=0A=
+	return port_getc(0);=0A=
+}=0A=
+=0A=
+void cons_putc(char c)=0A=
+{=0A=
+	port_putc(0, c);=0A=
+}=0A=
+=0A=
+void cons_puts(char *s)=0A=
+{=0A=
+	while(*s) {=0A=
+		if(*s =3D=3D '\n') cons_putc('\r');=0A=
+		cons_putc(*s);=0A=
+		s++;=0A=
+	}=0A=
+}=0A=
+=0A=
+void cons_do_putn(int n)=0A=
+{=0A=
+	if(n) {=0A=
+		cons_do_putn(n / 10);=0A=
+		cons_putc(n % 10 + '0');=0A=
+	}=0A=
+}=0A=
+=0A=
+void cons_putn(int n)=0A=
+{=0A=
+	if(n < 0) {=0A=
+		cons_putc('-');=0A=
+		n =3D -n;=0A=
+	}=0A=
+=0A=
+	if (n =3D=3D 0) {=0A=
+		cons_putc('0');=0A=
+	} else {=0A=
+		cons_do_putn(n);=0A=
+	}=0A=
+}=0A=
+=0A=
+#ifdef DEBUG_REMOTE_DEBUG=0A=
+static enum {HUH, SENDING, GETTING} state;=0A=
+=0A=
+static void sent(int c)=0A=
+{=0A=
+	switch(state) {=0A=
+	case HUH:=0A=
+	case GETTING:=0A=
+		cons_puts("\nSNT ");=0A=
+		state =3D SENDING;=0A=
+		/* fall through */=0A=
+	case SENDING:=0A=
+		cons_putc(c);=0A=
+		break;=0A=
+	}       =0A=
+}=0A=
+=0A=
+static void got(int c)=0A=
+{=0A=
+	switch(state) {=0A=
+	case HUH:=0A=
+	case SENDING:=0A=
+		cons_puts("\nGOT ");=0A=
+		state =3D GETTING;=0A=
+		/* fall through */=0A=
+	case GETTING:=0A=
+		cons_putc(c);=0A=
+		break;=0A=
+	}       =0A=
+}=0A=
+#endif /* DEBUG_REMOTE_DEBUG */=0A=
+=0A=
+static int first =3D 1;=0A=
+=0A=
+int getDebugChar(void)=0A=
+{=0A=
+	int c;=0A=
+=0A=
+	if(first) reset_gdb_port();=0A=
+=0A=
+	c =3D port_getc(1);=0A=
+=0A=
+#ifdef DEBUG_REMOTE_DEBUG=0A=
+	got(c);=0A=
+#endif=0A=
+=0A=
+	return c;=0A=
+}=0A=
+=0A=
+int port_getc(int p)=0A=
+{=0A=
+	volatile unsigned char *port =3D ports[p];=0A=
+	int c;=0A=
+=0A=
+	while((*(port + UART_LSR * 4) & UART_LSR_DR) =3D=3D 0) {=0A=
+		continue;=0A=
+	}       	=0A=
+=0A=
+	c =3D *(port + UART_RX * 4);=0A=
+=0A=
+	return c;=0A=
+}=0A=
+=0A=
+int port_getc_ready(int p)=0A=
+{=0A=
+	volatile unsigned char *port =3D ports[p];=0A=
+=0A=
+	return *(port + UART_LSR * 4) & UART_LSR_DR;=0A=
+}=0A=
+=0A=
+int isDebugReady(void)=0A=
+{=0A=
+	return port_getc_ready(1);=0A=
+}=0A=
+=0A=
+void putDebugChar(char c)=0A=
+{=0A=
+	if(first) reset_gdb_port();=0A=
+=0A=
+#ifdef DEBUG_REMOTE_DEBUG=0A=
+	sent(c);=0A=
+#endif=0A=
+=0A=
+	port_putc(1, c);=0A=
+}=0A=
+=0A=
+#define OK_TO_XMT (UART_LSR_TEMT | UART_LSR_THRE)=0A=
+=0A=
+void port_putc(int p, char c)=0A=
+{=0A=
+	volatile unsigned char *port =3D ports[p];=0A=
+	volatile unsigned char *lsr =3D port + UART_LSR * 4;=0A=
+=0A=
+	while((*lsr & OK_TO_XMT) !=3D OK_TO_XMT) {=0A=
+		continue;=0A=
+	}=0A=
+=0A=
+	*(port + UART_TX * 4) =3D c;=0A=
+}=0A=
+=0A=
+void reset_gdb_port(void)=0A=
+{=0A=
+	volatile unsigned char *port =3D ports[1];=0A=
+	unsigned int DIVISOR =3D (idt_cpu_freq / 16 / GDB_BAUD);=0A=
+=0A=
+	first =3D 0;=0A=
+=0A=
+#ifdef DEBUG_REMOTE_DEBUG=0A=
+	cons_puts("reset_gdb_port: initializing remote debug serial port =
(internal UART 1, ");=0A=
+	cons_putn(GDB_BAUD);=0A=
+	cons_puts("baud, MHz=3D");=0A=
+	cons_putn(idt_cpu_freq);=0A=
+	cons_puts(", divisor=3D");=0A=
+	cons_putn(DIVISOR);=0A=
+	cons_puts(")\n");=0A=
+#endif=0A=
+=0A=
+	/* reset the port */=0A=
+	*(port + UART_CSR * 4) =3D 0;=0A=
+=0A=
+	/* clear and enable the FIFOs */=0A=
+	*(port + UART_FCR * 4) =3D UART_FCR_ENABLE_FIFO | UART_FCR_CLEAR_RCVR =
| =0A=
+		UART_FCR_CLEAR_XMIT | UART_FCR_TRIGGER_14;=0A=
+=0A=
+	/* set the baud rate */=0A=
+	*(port + UART_LCR * 4) =3D UART_LCR_DLAB;		/* enable DLL, DLM =
registers */=0A=
+	*(port + UART_DLL * 4) =3D DIVISOR;=0A=
+	*(port + UART_DLM * 4) =3D DIVISOR >> 8;=0A=
+=0A=
+	/* set the line control stuff and disable DLL, DLM regs */=0A=
+=0A=
+	*(port + UART_LCR * 4) =3D UART_LCR_STOP | 	/* 2 stop bits */=0A=
+		UART_LCR_WLEN8;				/* 8 bit word length */=0A=
+	=0A=
+	/* leave interrupts off */=0A=
+	*(port + UART_IER * 4) =3D 0;=0A=
+=0A=
+	/* the modem controls don't leave the chip on this port, so leave =
them alone */=0A=
+	*(port + UART_MCR * 4) =3D 0;=0A=
+}=0A=
+=0A=
+void reset_cons_port(void)=0A=
+{=0A=
+	volatile unsigned char *port =3D ports[0];=0A=
+	  unsigned int DIVISOR =3D (idt_cpu_freq / 16 / CONS_BAUD);=0A=
+=0A=
+	/* reset the port */=0A=
+	*(port + UART_CSR * 4) =3D 0;=0A=
+=0A=
+	/* clear and enable the FIFOs */=0A=
+	*(port + UART_FCR * 4) =3D UART_FCR_ENABLE_FIFO | UART_FCR_CLEAR_RCVR =
| =0A=
+		UART_FCR_CLEAR_XMIT | UART_FCR_TRIGGER_14;=0A=
+=0A=
+	/* set the baud rate */=0A=
+	*(port + UART_LCR * 4) =3D UART_LCR_DLAB;		/* enable DLL, DLM =
registers */=0A=
+=0A=
+	*(port + UART_DLL * 4) =3D DIVISOR;=0A=
+	*(port + UART_DLM * 4) =3D DIVISOR >> 8;=0A=
+	/* set the line control stuff and disable DLL, DLM regs */=0A=
+=0A=
+	*(port + UART_LCR * 4) =3D UART_LCR_STOP | 	/* 2 stop bits */=0A=
+		UART_LCR_WLEN8;				/* 8 bit word length */=0A=
+	=0A=
+	/* leave interrupts off */=0A=
+	*(port + UART_IER * 4) =3D 0;=0A=
+=0A=
+	/* the modem controls don't leave the chip on this port, so leave =
them alone */=0A=
+	*(port + UART_MCR * 4) =3D 0;=0A=
+}=0A=
diff -uNr linux-2.6.16-rc5/arch/mips/idt-boards/rc32438/EB438/setup.c =
acacia/arch/mips/idt-boards/rc32438/EB438/setup.c=0A=
--- linux-2.6.16-rc5/arch/mips/idt-boards/rc32438/EB438/setup.c	=
1969-12-31 16:00:00.000000000 -0800=0A=
+++ acacia/arch/mips/idt-boards/rc32438/EB438/setup.c	2006-03-14 =
13:37:38.000000000 -0800=0A=
@@ -0,0 +1,171 @@=0A=
+/**********************************************************************=
****=0A=
+ *=0A=
+ *  BRIEF MODULE DESCRIPTION=0A=
+ *     setup routines for IDT EB438 boards=0A=
+ *=0A=
+ *  Copyright 2006 IDT Inc. (rischelp@idt.com)=0A=
+ *         =0A=
+ *  This program is free software; you can redistribute  it and/or =
modify it=0A=
+ *  under  the terms of  the GNU General  Public License as published =
by the=0A=
+ *  Free Software Foundation;  either version 2 of the  License, or =
(at your=0A=
+ *  option) any later version.=0A=
+ *=0A=
+ *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR =
IMPLIED=0A=
+ *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED =
WARRANTIES OF=0A=
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE =
DISCLAIMED.  IN=0A=
+ *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, =
INDIRECT,=0A=
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES =
(INCLUDING, BUT=0A=
+ *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; =
LOSS OF=0A=
+ *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED =
AND ON=0A=
+ *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, =
OR TORT=0A=
+ *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE =
USE OF=0A=
+ *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH =
DAMAGE.=0A=
+ *=0A=
+ *  You should have received a copy of the  GNU General Public License =
along=0A=
+ *  with this program; if not, write  to the Free Software Foundation, =
Inc.,=0A=
+ *  675 Mass Ave, Cambridge, MA 02139, USA.=0A=
+ *=0A=
+ =
************************************************************************=
**=0A=
+ */=0A=
+=0A=
+#include <linux/init.h>=0A=
+#include <linux/mm.h>=0A=
+#include <linux/pm.h>=0A=
+#include <linux/sched.h>=0A=
+#include <linux/irq.h>=0A=
+#include <asm/bootinfo.h>=0A=
+#include <asm/io.h>=0A=
+#include <linux/ioport.h>=0A=
+#include <asm/mipsregs.h>=0A=
+#include <asm/pgtable.h>=0A=
+#include <linux/mc146818rtc.h>=0A=
+#include <asm/reboot.h>=0A=
+#include <asm/addrspace.h>    =0A=
+#include <asm/idt-boards/rc32438/rc32438.h>=0A=
+=0A=
+extern char * __init prom_getcmdline(void);=0A=
+=0A=
+extern void (*board_time_init)(void);=0A=
+extern void (*board_timer_setup)(struct irqaction *irq);=0A=
+extern void rc32438_time_init(void);=0A=
+extern void rc32438_timer_setup(struct irqaction *irq);=0A=
+#ifdef CONFIG_RTC_DS1553=0A=
+extern unsigned long (*rtc_get_time)(void);=0A=
+extern int (*rtc_set_time)(unsigned long);=0A=
+extern unsigned long rtc_ds1553_get_time(void);=0A=
+extern int rtc_ds1553_set_time(unsigned long t);=0A=
+#endif  =0A=
+extern void idt_reset(void);=0A=
+void idt_disp_str(char *s);=0A=
+=0A=
+#define DIG_CLEAR ((volatile unsigned char *)0xAC000000)=0A=
+#define DIG0 ((volatile unsigned char *)0xAC040003)=0A=
+#define DIG1 ((volatile unsigned char *)0xAC040002)=0A=
+#define DIG2 ((volatile unsigned char *)0xAC040001)=0A=
+#define DIG3 ((volatile unsigned char *)0xAC040000)=0A=
+=0A=
+void idt_disp_char(int i, char c)=0A=
+{=0A=
+  switch(i) {=0A=
+  case 0: *DIG0 =3D c; break;=0A=
+  case 1: *DIG1 =3D c; break;=0A=
+  case 2: *DIG2 =3D c; break;=0A=
+  case 3: *DIG3 =3D c; break;=0A=
+  default: *DIG0 =3D '?'; break;=0A=
+  }=0A=
+}=0A=
+=0A=
+void idt_disp_str(char *s)=0A=
+{=0A=
+  if(s =3D=3D 0) {=0A=
+    char c;=0A=
+    c =3D *DIG_CLEAR;=0A=
+  } else {=0A=
+    int i;=0A=
+    for(i =3D 0; i < 4; i++) {=0A=
+      if(s[i]) idt_disp_char(i, s[i]);=0A=
+    }=0A=
+  }=0A=
+}=0A=
+=0A=
+=0A=
+static void idt_machine_restart(char *command)=0A=
+{=0A=
+  printk("idt_machine_restart: command=3D%s\n", command);=0A=
+  =0A=
+  idt_reset();=0A=
+}=0A=
+=0A=
+static void idt_machine_halt(void)=0A=
+{=0A=
+  printk("idt_machine_halt:  halted\n");=0A=
+  for(;;) continue;=0A=
+}=0A=
+=0A=
+static void idt_machine_power_off(void)=0A=
+{=0A=
+  printk("idt_machine_power_off:  It is now safe to turn off the =
power\n");=0A=
+  for(;;) continue;=0A=
+}=0A=
+static int __init idt_setup(void)=0A=
+{=0A=
+  char* argptr;=0A=
+  =0A=
+  idt_disp_str("unix");=0A=
+  =0A=
+  argptr =3D prom_getcmdline();=0A=
+=0A=
+#ifdef CONFIG_SERIAL_CONSOLE=0A=
+  if ((argptr =3D strstr(argptr, "console=3D")) =3D=3D NULL) {=0A=
+    argptr =3D prom_getcmdline();=0A=
+    strcat(argptr, " console=3DttyS0,9600");=0A=
+  }=0A=
+#endif=0A=
+=0A=
+=0A=
+  board_time_init =3D rc32438_time_init;=0A=
+  board_timer_setup =3D rc32438_timer_setup;=0A=
+=0A=
+  =0A=
+#ifdef CONFIG_RTC_DS1553=0A=
+  rtc_get_time =3D rtc_ds1553_get_time;=0A=
+  rtc_set_time =3D rtc_ds1553_set_time;=0A=
+=0A=
+#endif  =0A=
+  _machine_restart =3D idt_machine_restart;=0A=
+  _machine_halt =3D idt_machine_halt;=0A=
+  pm_power_off =3D idt_machine_power_off;=0A=
+  set_io_port_base(KSEG1);=0A=
+  write_c0_wired(0);=0A=
+  return 0;=0A=
+  =0A=
+}=0A=
+=0A=
+=0A=
+void __init plat_setup(void){=0A=
+  idt_setup();=0A=
+}=0A=
+=0A=
+int page_is_ram(unsigned long pagenr)=0A=
+{=0A=
+  return 1;=0A=
+}=0A=
+=0A=
+const char *get_system_type(void)=0A=
+{=0A=
+  return "MIPS IDT32438";=0A=
+}=0A=
+=0A=
+=0A=
+=0A=
+=0A=
+=0A=
+=0A=
+=0A=
+=0A=
+=0A=
+=0A=
+=0A=
+=0A=
+=0A=
+=0A=
diff -uNr linux-2.6.16-rc5/arch/mips/idt-boards/rc32438/EB438/time.c =
acacia/arch/mips/idt-boards/rc32438/EB438/time.c=0A=
--- linux-2.6.16-rc5/arch/mips/idt-boards/rc32438/EB438/time.c	=
1969-12-31 16:00:00.000000000 -0800=0A=
+++ acacia/arch/mips/idt-boards/rc32438/EB438/time.c	2006-03-14 =
13:36:04.000000000 -0800=0A=
@@ -0,0 +1,174 @@=0A=
+/**********************************************************************=
****=0A=
+ *=0A=
+ *  BRIEF MODULE DESCRIPTION=0A=
+ *     timer routines for IDT EB438 boards=0A=
+ *=0A=
+ *  Copyright 2006 IDT Inc. (rischelp@idt.com)=0A=
+ *         =0A=
+ *  This program is free software; you can redistribute  it and/or =
modify it=0A=
+ *  under  the terms of  the GNU General  Public License as published =
by the=0A=
+ *  Free Software Foundation;  either version 2 of the  License, or =
(at your=0A=
+ *  option) any later version.=0A=
+ *=0A=
+ *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR =
IMPLIED=0A=
+ *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED =
WARRANTIES OF=0A=
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE =
DISCLAIMED.  IN=0A=
+ *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, =
INDIRECT,=0A=
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES =
(INCLUDING, BUT=0A=
+ *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; =
LOSS OF=0A=
+ *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED =
AND ON=0A=
+ *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, =
OR TORT=0A=
+ *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE =
USE OF=0A=
+ *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH =
DAMAGE.=0A=
+ *=0A=
+ *  You should have received a copy of the  GNU General Public License =
along=0A=
+ *  with this program; if not, write  to the Free Software Foundation, =
Inc.,=0A=
+ *  675 Mass Ave, Cambridge, MA 02139, USA.=0A=
+ *=0A=
+ =
************************************************************************=
**=0A=
+ */=0A=
+=0A=
+#include <linux/config.h>=0A=
+#include <linux/init.h>=0A=
+#include <linux/kernel_stat.h>=0A=
+#include <linux/sched.h>=0A=
+#include <linux/spinlock.h>=0A=
+#include <linux/mc146818rtc.h>=0A=
+#include <linux/irq.h>=0A=
+#include <linux/timex.h>=0A=
+=0A=
+#include <linux/param.h>=0A=
+#include <asm/mipsregs.h>=0A=
+#include <asm/ptrace.h>=0A=
+#include <asm/time.h>=0A=
+#include <asm/hardirq.h>=0A=
+=0A=
+=0A=
+#include <asm/mipsregs.h>=0A=
+#include <asm/ptrace.h>=0A=
+#include <asm/debug.h>=0A=
+#include <asm/time.h>=0A=
+#include <asm/idt-boards/rc32438/rc32438.h>=0A=
+#include  <asm/idt-boards/rc32438/rc32438_timer.h>=0A=
+=0A=
+static unsigned long r4k_offset;=0A=
+extern unsigned int idt_cpu_freq;=0A=
+=0A=
+#if defined(CONFIG_IDT_79EB438) && defined(CONFIG_MIPS_RTC)=0A=
+extern void rtc_ds1553_init(void);=0A=
+#endif=0A=
+=0A=
+#ifdef CONFIG_RC32438_REVISION_ZA  =0A=
+/* how many counter cycles in a jiffy */=0A=
+static unsigned long cycles_per_jiffy;=0A=
+/* expirelo is the count value for next CPU timer interrupt */=0A=
+static unsigned int expirelo;=0A=
+=0A=
+=0A=
+static void idt_timer_ack(void)=0A=
+{=0A=
+	unsigned int count ;=0A=
+        count =3D idttimer->tim[0].count;=0A=
+        idttimer->tim[0].compare =3D (count + cycles_per_jiffy);=0A=
+        idttimer->tim[0].ctc =3D  0x1;=0A=
+}=0A=
+=0A=
+static unsigned int idt_hpt_read(void)=0A=
+{=0A=
+	return idttimer->tim[0].count;=0A=
+}=0A=
+=0A=
+=0A=
+static void idt_hpt_timer_init(unsigned int count)=0A=
+{=0A=
+        count =3D idttimer->tim[0].count - count;=0A=
+        expirelo =3D (count / cycles_per_jiffy + 1) * =
cycles_per_jiffy;=0A=
+        idttimer->tim[0].count =3D (expirelo - cycles_per_jiffy);=0A=
+        idttimer->tim[0].compare =3D expirelo;=0A=
+        idttimer->tim[0].count =3D count;=0A=
+}=0A=
+#endif=0A=
+=0A=
+static unsigned long __init cal_r4koff(void)=0A=
+{=0A=
+	mips_hpt_frequency =3D idt_cpu_freq * IDT_CLOCK_MULT / 2;=0A=
+	return (mips_hpt_frequency / HZ);=0A=
+}=0A=
+=0A=
+void __init rc32438_time_init(void)=0A=
+{=0A=
+        unsigned int est_freq, flags;=0A=
+=0A=
+	local_irq_save(flags);=0A=
+=0A=
+	printk("calculating r4koff... ");=0A=
+	r4k_offset =3D cal_r4koff();=0A=
+	printk("%08lx(%d)\n", r4k_offset, (int) r4k_offset);=0A=
+=0A=
+	est_freq =3D 2*r4k_offset*HZ;	=0A=
+	est_freq +=3D 5000;    /* round */=0A=
+	est_freq -=3D est_freq%10000;=0A=
+	printk("CPU frequency %d.%02d MHz\n", est_freq/1000000, =0A=
+	       (est_freq%1000000)*100/1000000);=0A=
+=0A=
+#ifdef CONFIG_RC32438_REVISION_ZA=0A=
+	printk("Enabling workaround for ZA part.\n");=0A=
+	cycles_per_jiffy =3D (mips_hpt_frequency + HZ / 2) / HZ;=0A=
+	mips_hpt_read =3D idt_hpt_read;=0A=
+	mips_hpt_init =3D idt_hpt_timer_init;=0A=
+	mips_timer_ack =3D idt_timer_ack;=0A=
+#endif	=0A=
+#if defined(CONFIG_IDT_79EB438) && defined(CONFIG_MIPS_RTC)=0A=
+	rtc_ds1553_init();=0A=
+#endif=0A=
+	local_irq_restore(flags);=0A=
+=0A=
+}=0A=
+=0A=
+void __init rc32438_timer_setup(struct irqaction *irq)=0A=
+{=0A=
+#ifdef CONFIG_RC32438_REVISION_ZA=0A=
+        setup_irq(8, irq);=0A=
+        idttimer->tim[0].count =3D 0;=0A=
+        idttimer->tim[0].compare =3D cycles_per_jiffy;=0A=
+        idttimer->tim[0].ctc =3D 0x1;=0A=
+#else=0A=
+	static unsigned long r4k_cur; =0A=
+	setup_irq(MIPS_CPU_TIMER_IRQ, irq);=0A=
+  =0A=
+	/* to generate the first timer interrupt */=0A=
+	r4k_cur =3D (read_c0_count() + r4k_offset);=0A=
+	write_c0_compare(r4k_cur);=0A=
+#endif=0A=
+  =0A=
+}=0A=
+=0A=
+extern void idt_disp_char(int i,char c);=0A=
+=0A=
+asmlinkage void idt_timer_interrupt(int irq,struct pt_regs *regs)=0A=
+{=0A=
+#ifdef CONFIG_KGDB=0A=
+	void kgdb_check(void);=0A=
+#endif=0A=
+=0A=
+	static unsigned int timerCount =3D 0;=0A=
+	static int toggle =3D 0;=0A=
+=0A=
+	irq_enter();=0A=
+	kstat_this_cpu.irqs[irq]++;=0A=
+=0A=
+	if( (timerCount++ % HZ) =3D=3D 0)=0A=
+	{ =0A=
+		toggle ^=3D 1;=0A=
+		idt_disp_char(0,toggle ? 'u' :'U');=0A=
+	}=0A=
+	timer_interrupt(irq, NULL, regs);=0A=
+=0A=
+	irq_exit();=0A=
+=0A=
+#ifdef CONFIG_KGDB=0A=
+	kgdb_check();=0A=
+#endif=0A=
+}=0A=
+=0A=
+=0A=
diff -uNr linux-2.6.16-rc5/arch/mips/Kconfig =
acacia/arch/mips/Kconfig=0A=
--- linux-2.6.16-rc5/arch/mips/Kconfig	2006-02-27 02:56:56.000000000 =
-0800=0A=
+++ acacia/arch/mips/Kconfig	2006-03-14 13:59:42.000000000 -0800=0A=
@@ -210,6 +210,13 @@=0A=
 	  located at <http://www.globespan.net/>. Say Y here if you wish =
to=0A=
 	  build a kernel for this platform.=0A=
 =0A=
+config IDT_BOARDS=0A=
+        bool "Support for IDT evaluation boards"=0A=
+        help=0A=
+         IDT evaluation boards for the Interprise family of Integrated =
Processors=0A=
+         based on the 4KC.=0A=
+	 More information can be found at =
<http://www.idt.com/?catID=3D58532>=0A=
+=0A=
 config MIPS_ITE8172=0A=
 	bool "Support for ITE 8172G board"=0A=
 	select DMA_NONCOHERENT=0A=
@@ -787,6 +794,8 @@=0A=
 source "arch/mips/tx4938/Kconfig"=0A=
 source "arch/mips/vr41xx/Kconfig"=0A=
 source "arch/mips/philips/pnx8550/common/Kconfig"=0A=
+source "arch/mips/idt-boards/Kconfig"=0A=
+=0A=
 =0A=
 endmenu=0A=
 =0A=
diff -uNr linux-2.6.16-rc5/arch/mips/Makefile =
acacia/arch/mips/Makefile=0A=
--- linux-2.6.16-rc5/arch/mips/Makefile	2006-02-27 02:56:56.000000000 =
-0800=0A=
+++ acacia/arch/mips/Makefile	2006-03-14 14:07:55.000000000 -0800=0A=
@@ -739,6 +739,17 @@=0A=
 core-$(CONFIG_TOSHIBA_RBTX4938) +=3D arch/mips/tx4938/common/=0A=
 load-$(CONFIG_TOSHIBA_RBTX4938) +=3D 0xffffffff80100000=0A=
 =0A=
+=0A=
+=0A=
+=0A=
+#=0A=
+# IDT EB438 board=0A=
+#=0A=
+core-$(CONFIG_IDT_EB438)	+=3D arch/mips/idt-boards/rc32438/EB438/=0A=
+cflags-$(CONFIG_IDT_EB438)	+=3D -Iinclude/asm-mips/mach-idt=0A=
+load-$(CONFIG_IDT_EB438)	+=3D 0x80100000=0A=
+=0A=
+=0A=
 cflags-y			+=3D -Iinclude/asm-mips/mach-generic=0A=
 drivers-$(CONFIG_PCI)		+=3D arch/mips/pci/=0A=
 =0A=
@@ -794,6 +805,12 @@=0A=
 vmlinux.32: vmlinux=0A=
 	$(OBJCOPY) -O $(32bit-bfd) $(OBJCOPYFLAGS) $< $@=0A=
 =0A=
+ifdef CONFIG_IDT_BOARDS=0A=
+zImage rImage: vmlinux $(TOPDIR)/.config=0A=
+ifdef CONFIG_IDT_EB438=0A=
+	$(Q)$(MAKE) $(build)=3Darch/mips/idt-boards/rc32438/EB438/boot $@=0A=
+endif=0A=
+endif=0A=
 #=0A=
 # The 64-bit ELF tools are pretty broken so at this time we generate =
64-bit=0A=
 # ELF files from 32-bit files by conversion.=0A=
diff -uNr linux-2.6.16-rc5/arch/mips/pci/fixup-rc32438.c =
acacia/arch/mips/pci/fixup-rc32438.c=0A=
--- linux-2.6.16-rc5/arch/mips/pci/fixup-rc32438.c	1969-12-31 =
16:00:00.000000000 -0800=0A=
+++ acacia/arch/mips/pci/fixup-rc32438.c	2006-03-14 10:47:33.000000000 =
-0800=0A=
@@ -0,0 +1,84 @@=0A=
+/**********************************************************************=
****=0A=
+ *=0A=
+ *  BRIEF MODULE DESCRIPTION=0A=
+ *     PCI fixups for IDT EB438 board=0A=
+ *=0A=
+ *  Copyright 2006 IDT Inc. (rischelp@idt.com)=0A=
+ *         =0A=
+ *  This program is free software; you can redistribute  it and/or =
modify it=0A=
+ *  under  the terms of  the GNU General  Public License as published =
by the=0A=
+ *  Free Software Foundation;  either version 2 of the  License, or =
(at your=0A=
+ *  option) any later version.=0A=
+ *=0A=
+ *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR =
IMPLIED=0A=
+ *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED =
WARRANTIES OF=0A=
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE =
DISCLAIMED.  IN=0A=
+ *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, =
INDIRECT,=0A=
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES =
(INCLUDING, BUT=0A=
+ *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; =
LOSS OF=0A=
+ *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED =
AND ON=0A=
+ *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, =
OR TORT=0A=
+ *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE =
USE OF=0A=
+ *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH =
DAMAGE.=0A=
+ *=0A=
+ *  You should have received a copy of the  GNU General Public License =
along=0A=
+ *  with this program; if not, write  to the Free Software Foundation, =
Inc.,=0A=
+ *  675 Mass Ave, Cambridge, MA 02139, USA.=0A=
+ *=0A=
+ *=0A=
+ =
************************************************************************=
**=0A=
+ */=0A=
+=0A=
+#include <linux/config.h>=0A=
+#include <linux/types.h>=0A=
+#include <linux/pci.h>=0A=
+#include <linux/kernel.h>=0A=
+#include <linux/init.h>=0A=
+=0A=
+#include <asm/idt-boards/rc32438/rc32438.h>=0A=
+#include <asm/idt-boards/rc32438/rc32438_pci.h>=0A=
+#include <asm/idt-boards/rc32438/rc32438_pci_v.h>=0A=
+=0A=
+int __init pcibios_map_irq(struct pci_dev *dev, u8 slot, u8 pin)=0A=
+{=0A=
+=0A=
+  if (dev->bus->number !=3D 0) {=0A=
+    return 0;=0A=
+  }=0A=
+=0A=
+  slot =3D PCI_SLOT(dev->devfn);=0A=
+  dev->irq =3D 0;=0A=
+=0A=
+  if (slot > 0 && slot <=3D 5) {=0A=
+    unsigned char pin;=0A=
+    pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);=0A=
+=0A=
+    switch (pin) {=0A=
+    case 1: /* INTA*/=0A=
+      dev->irq =3D GROUP4_IRQ_BASE + 27;=0A=
+      break;=0A=
+    case 2: /* INTB */=0A=
+      dev->irq =3D GROUP4_IRQ_BASE + 27;=0A=
+      break;=0A=
+    case 3: /* INTC */=0A=
+      dev->irq =3D GROUP4_IRQ_BASE + 27;=0A=
+      break;=0A=
+    case 4: /* INTD */=0A=
+      dev->irq =3D GROUP4_IRQ_BASE + 27;=0A=
+      break;=0A=
+    default:=0A=
+      dev->irq =3D 0xff; =0A=
+      break;=0A=
+    }=0A=
+#ifdef DEBUG=0A=
+    printk("irq fixup: slot %d, pin %d, irq %d\n",=0A=
+	   slot, pin, dev->irq);=0A=
+#endif=0A=
+    pci_write_config_byte(dev, PCI_INTERRUPT_LINE,dev->irq);=0A=
+  }=0A=
+  return (dev->irq);=0A=
+}=0A=
+=0A=
+struct pci_fixup pcibios_fixups[] =3D {=0A=
+  {0}=0A=
+};=0A=
diff -uNr linux-2.6.16-rc5/arch/mips/pci/Makefile =
acacia/arch/mips/pci/Makefile=0A=
--- linux-2.6.16-rc5/arch/mips/pci/Makefile	2006-02-27 =
02:56:56.000000000 -0800=0A=
+++ acacia/arch/mips/pci/Makefile	2006-03-14 14:01:49.000000000 =
-0800=0A=
@@ -57,3 +57,5 @@=0A=
 obj-$(CONFIG_TOSHIBA_RBTX4938)	+=3D fixup-tx4938.o ops-tx4938.o=0A=
 obj-$(CONFIG_VICTOR_MPC30X)	+=3D fixup-mpc30x.o=0A=
 obj-$(CONFIG_ZAO_CAPCELLA)	+=3D fixup-capcella.o=0A=
+=0A=
+obj-$(CONFIG_IDT_EB438)         +=3D pci-rc32438.o ops-rc32438.o =
fixup-rc32438.o=0A=
diff -uNr linux-2.6.16-rc5/arch/mips/pci/ops-rc32438.c =
acacia/arch/mips/pci/ops-rc32438.c=0A=
--- linux-2.6.16-rc5/arch/mips/pci/ops-rc32438.c	1969-12-31 =
16:00:00.000000000 -0800=0A=
+++ acacia/arch/mips/pci/ops-rc32438.c	2006-03-14 10:47:33.000000000 =
-0800=0A=
@@ -0,0 +1,195 @@=0A=
+/**********************************************************************=
****=0A=
+ *=0A=
+ *  BRIEF MODULE DESCRIPTION=0A=
+ *     pci_ops for IDT EB438 board=0A=
+ *=0A=
+ *  Copyright 2006 IDT Inc. (rischelp@idt.com)=0A=
+ *         =0A=
+ *  This program is free software; you can redistribute  it and/or =
modify it=0A=
+ *  under  the terms of  the GNU General  Public License as published =
by the=0A=
+ *  Free Software Foundation;  either version 2 of the  License, or =
(at your=0A=
+ *  option) any later version.=0A=
+ *=0A=
+ *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR =
IMPLIED=0A=
+ *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED =
WARRANTIES OF=0A=
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE =
DISCLAIMED.  IN=0A=
+ *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, =
INDIRECT,=0A=
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES =
(INCLUDING, BUT=0A=
+ *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; =
LOSS OF=0A=
+ *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED =
AND ON=0A=
+ *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, =
OR TORT=0A=
+ *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE =
USE OF=0A=
+ *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH =
DAMAGE.=0A=
+ *=0A=
+ *  You should have received a copy of the  GNU General Public License =
along=0A=
+ *  with this program; if not, write  to the Free Software Foundation, =
Inc.,=0A=
+ *  675 Mass Ave, Cambridge, MA 02139, USA.=0A=
+ *=0A=
+ *=0A=
+ *=0A=
+ =
************************************************************************=
**=0A=
+ */=0A=
+=0A=
+#include <linux/config.h>=0A=
+#include <linux/init.h>=0A=
+#include <linux/pci.h>=0A=
+#include <linux/types.h>=0A=
+#include <linux/delay.h>=0A=
+=0A=
+#include <asm/cpu.h>=0A=
+#include <asm/io.h>=0A=
+=0A=
+#include <asm/idt-boards/rc32438/rc32438.h>=0A=
+#include <asm/idt-boards/rc32438/rc32438_pci.h>=0A=
+#include <asm/idt-boards/rc32438/rc32438_pci_v.h>=0A=
+=0A=
+#define PCI_ACCESS_READ  0=0A=
+#define PCI_ACCESS_WRITE 1=0A=
+=0A=
+=0A=
+#define PCI_CFG_SET(slot,func,off) \=0A=
+	(rc32438_pci->pcicfga =3D (0x80000000 | ((slot)<<11) | \=0A=
+			    ((func)<<8) | (off)))=0A=
+=0A=
+static int config_access(unsigned char access_type, struct pci_bus =
*bus,=0A=
+                         unsigned int devfn, unsigned char where,=0A=
+                         u32 * data)=0A=
+{ =0A=
+  /*=0A=
+   * config cycles are on 4 byte boundary only=0A=
+   */=0A=
+  unsigned int slot =3D PCI_SLOT(devfn);=0A=
+  u8 func =3D PCI_FUNC(devfn);=0A=
+=0A=
+  if (slot < 2 || slot > 5) {=0A=
+    *data =3D 0xFFFFFFFF;=0A=
+    return -1;=0A=
+  }=0A=
+  /* Setup address */=0A=
+  PCI_CFG_SET(slot, func, where);=0A=
+  rc32438_sync();=0A=
+=0A=
+  if (access_type =3D=3D PCI_ACCESS_WRITE)=0A=
+    rc32438_pci->pcicfgd =3D *data;=0A=
+=0A=
+  else=0A=
+    *data =3D rc32438_pci->pcicfgd;=0A=
+=0A=
+  rc32438_sync();=0A=
+=0A=
+  /*=0A=
+   * Revisit: check for master or target abort.=0A=
+   */=0A=
+  return 0;=0A=
+}=0A=
+=0A=
+=0A=
+/*=0A=
+ * We can't address 8 and 16 bit words directly.  Instead we have =
to=0A=
+ * read/write a 32bit word and mask/modify the data we actually =
want.=0A=
+ */=0A=
+static int read_config_byte(struct pci_bus *bus, unsigned int =
devfn,=0A=
+                            int where, u8 * val)=0A=
+{=0A=
+  u32 data;=0A=
+  int ret;=0A=
+=0A=
+  ret =3D config_access(PCI_ACCESS_READ, bus, devfn, where, &data);=0A=
+  *val =3D (data >> ((where & 3) << 3)) & 0xff;=0A=
+  return ret;=0A=
+}=0A=
+=0A=
+static int read_config_word(struct pci_bus *bus, unsigned int =
devfn,=0A=
+                            int where, u16 * val)=0A=
+{=0A=
+  u32 data;=0A=
+  int ret;=0A=
+=0A=
+  ret =3D config_access(PCI_ACCESS_READ, bus, devfn, where, &data);=0A=
+  *val =3D (data >> ((where & 3) << 3)) & 0xffff;=0A=
+  return ret;=0A=
+}=0A=
+=0A=
+static int read_config_dword(struct pci_bus *bus, unsigned int =
devfn,=0A=
+                             int where, u32 * val)=0A=
+{=0A=
+  int ret;=0A=
+=0A=
+  ret =3D config_access(PCI_ACCESS_READ, bus, devfn, where, val);=0A=
+  return ret;=0A=
+}=0A=
+static int=0A=
+write_config_byte(struct pci_bus *bus, unsigned int devfn, int =
where,=0A=
+                  u8 val)=0A=
+{=0A=
+  u32 data =3D 0;=0A=
+=0A=
+  if (config_access(PCI_ACCESS_READ, bus, devfn, where, &data))=0A=
+    return -1;=0A=
+=0A=
+  data =3D (data & ~(0xff << ((where & 3) << 3))) |=0A=
+    (val << ((where & 3) << 3));=0A=
+=0A=
+  if (config_access(PCI_ACCESS_WRITE, bus, devfn, where, &data))=0A=
+    return -1;=0A=
+=0A=
+  return PCIBIOS_SUCCESSFUL;=0A=
+}=0A=
+static int=0A=
+write_config_word(struct pci_bus *bus, unsigned int devfn, int =
where,=0A=
+                  u16 val)=0A=
+{=0A=
+  u32 data =3D 0;=0A=
+=0A=
+  if (config_access(PCI_ACCESS_READ, bus, devfn, where, &data))=0A=
+    return -1;=0A=
+=0A=
+  data =3D (data & ~(0xffff << ((where & 3) << 3))) |=0A=
+    (val << ((where & 3) << 3));=0A=
+=0A=
+  if (config_access(PCI_ACCESS_WRITE, bus, devfn, where, &data))=0A=
+    return -1;=0A=
+=0A=
+=0A=
+  return PCIBIOS_SUCCESSFUL;=0A=
+}=0A=
+static int=0A=
+write_config_dword(struct pci_bus *bus, unsigned int devfn, int =
where,=0A=
+                   u32 val)=0A=
+{=0A=
+  if (config_access(PCI_ACCESS_WRITE, bus, devfn, where, &val))=0A=
+    return -1;=0A=
+=0A=
+  return PCIBIOS_SUCCESSFUL;=0A=
+}=0A=
+=0A=
+static int pci_config_read(struct pci_bus *bus, unsigned int devfn,=0A=
+                       int where, int size, u32 * val)=0A=
+{=0A=
+   switch (size) {=0A=
+  case 1: =0A=
+   return read_config_byte(bus, devfn, where, (u8 *) val);=0A=
+  case 2: =0A=
+    return read_config_word(bus, devfn, where, (u16 *) val);=0A=
+  default:=0A=
+    return read_config_dword(bus, devfn, where, val);=0A=
+  }=0A=
+}=0A=
+=0A=
+static int pci_config_write(struct pci_bus *bus, unsigned int =
devfn,=0A=
+                        int where, int size, u32 val)=0A=
+{=0A=
+  switch (size) {=0A=
+  case 1: =0A=
+    return write_config_byte(bus, devfn, where, (u8) val);=0A=
+  case 2: =0A=
+    return write_config_word(bus, devfn, where, (u16) val);=0A=
+  default:=0A=
+    return write_config_dword(bus, devfn, where, val);=0A=
+  }=0A=
+}=0A=
+=0A=
+struct pci_ops rc32438_pci_ops =3D {=0A=
+  .read =3D  pci_config_read,=0A=
+  .write =3D pci_config_write,=0A=
+};=0A=
diff -uNr linux-2.6.16-rc5/arch/mips/pci/pci-rc32438.c =
acacia/arch/mips/pci/pci-rc32438.c=0A=
--- linux-2.6.16-rc5/arch/mips/pci/pci-rc32438.c	1969-12-31 =
16:00:00.000000000 -0800=0A=
+++ acacia/arch/mips/pci/pci-rc32438.c	2006-03-14 10:47:33.000000000 =
-0800=0A=
@@ -0,0 +1,344 @@=0A=
+/**********************************************************************=
****=0A=
+ *=0A=
+ *  BRIEF MODULE DESCRIPTION=0A=
+ *     PCI initialization for IDT EB438 board=0A=
+ *=0A=
+ *  Copyright 2006 IDT Inc. (rischelp@idt.com)=0A=
+ *         =0A=
+ *  This program is free software; you can redistribute  it and/or =
modify it=0A=
+ *  under  the terms of  the GNU General  Public License as published =
by the=0A=
+ *  Free Software Foundation;  either version 2 of the  License, or =
(at your=0A=
+ *  option) any later version.=0A=
+ *=0A=
+ *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR =
IMPLIED=0A=
+ *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED =
WARRANTIES OF=0A=
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE =
DISCLAIMED.  IN=0A=
+ *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, =
INDIRECT,=0A=
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES =
(INCLUDING, BUT=0A=
+ *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; =
LOSS OF=0A=
+ *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED =
AND ON=0A=
+ *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, =
OR TORT=0A=
+ *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE =
USE OF=0A=
+ *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH =
DAMAGE.=0A=
+ *=0A=
+ *  You should have received a copy of the  GNU General Public License =
along=0A=
+ *  with this program; if not, write  to the Free Software Foundation, =
Inc.,=0A=
+ *  675 Mass Ave, Cambridge, MA 02139, USA.=0A=
+ *=0A=
+ *=0A=
+ =
************************************************************************=
**=0A=
+ */=0A=
+=0A=
+#include <linux/config.h>=0A=
+#include <linux/types.h>=0A=
+#include <linux/pci.h>=0A=
+#include <linux/kernel.h>=0A=
+#include <linux/init.h>=0A=
+#include <asm/idt-boards/rc32438/rc32438.h>=0A=
+#include <asm/idt-boards/rc32438/rc32438_pci.h>=0A=
+#include <asm/idt-boards/rc32438/rc32438_pci_v.h>=0A=
+#include <asm/idt-boards/rc32438/rc32438_dma_v.h>=0A=
+#include <linux/interrupt.h>=0A=
+=0A=
+#define PCI_ACCESS_READ  0=0A=
+#define PCI_ACCESS_WRITE 1=0A=
+=0A=
+/* define an unsigned array for the PCI registers */=0A=
+unsigned int acaciaCnfgRegs[25] =3D {=0A=
+  ACACIA_CNFG1,	 ACACIA_CNFG2,  ACACIA_CNFG3,  ACACIA_CNFG4,=0A=
+  ACACIA_CNFG5,	 ACACIA_CNFG6,  ACACIA_CNFG7,  ACACIA_CNFG8,=0A=
+  ACACIA_CNFG9,	 ACACIA_CNFG10, ACACIA_CNFG11, ACACIA_CNFG12,=0A=
+  ACACIA_CNFG13, ACACIA_CNFG14, ACACIA_CNFG15, ACACIA_CNFG16,=0A=
+  ACACIA_CNFG17, ACACIA_CNFG18, ACACIA_CNFG19, ACACIA_CNFG20,=0A=
+  ACACIA_CNFG21, ACACIA_CNFG22, ACACIA_CNFG23, ACACIA_CNFG24=0A=
+};=0A=
+static struct resource rc32438_res_pci_mem1 =3D {=0A=
+  .name =3D "PCI MEM1",=0A=
+  .start =3D 0x50000000,=0A=
+  .end =3D 0x5FFFFFFF,=0A=
+  .flags =3D IORESOURCE_MEM,=0A=
+};=0A=
+static struct resource rc32438_res_pci_io1 =3D {=0A=
+  .name =3D "PCI I/O1",=0A=
+  .start =3D 0x18800000,=0A=
+  .end =3D 0x188FFFFF,=0A=
+  .flags =3D IORESOURCE_IO,=0A=
+};=0A=
+=0A=
+extern struct pci_ops rc32438_pci_ops;=0A=
+=0A=
+struct pci_controller rc32438_controller =3D {=0A=
+  .pci_ops =3D &rc32438_pci_ops,=0A=
+  .mem_resource =3D &rc32438_res_pci_mem1,=0A=
+  .io_resource =3D &rc32438_res_pci_io1,=0A=
+  .mem_offset     =3D 0x00000000UL,=0A=
+  .io_offset      =3D 0x00000000UL,=0A=
+};=0A=
+=0A=
+static int __init rc32438_pcibridge_init(void)=0A=
+{=0A=
+=0A=
+  unsigned int pciConfigAddr =3D 0;/*used for writing pci config =
values */=0A=
+  int	     loopCount=3D0    ;/*used for the loop */=0A=
+=0A=
+  unsigned int pcicValue, pcicData=3D0;=0A=
+  unsigned int dummyRead, pciCntlVal =3D 0;=0A=
+  printk("PCI: Initializing PCI\n");=0A=
+=0A=
+  /* Disable the IP bus error for PCI scaning */=0A=
+  pciCntlVal=3Drc32438_pci->pcic;=0A=
+  pciCntlVal &=3D 0xFFFFFF7;=0A=
+  rc32438_pci->pcic =3D pciCntlVal;=0A=
+=0A=
+  ioport_resource.start =3D rc32438_res_pci_io1.start;=0A=
+  ioport_resource.end =3D rc32438_res_pci_io1.end;=0A=
+/*=0A=
+  iomem_resource.start =3D rc32438_res_pci_mem1.start;=0A=
+  iomem_resource.end =3D rc32438_res_pci_mem1.end;=0A=
+*/=0A=
+=0A=
+  pcicValue =3D rc32438_pci->pcic;=0A=
+  pcicValue =3D (pcicValue >> PCIM_SHFT) & PCIM_BIT_LEN;=0A=
+  if (!((pcicValue =3D=3D PCIM_H_EA) ||=0A=
+	(pcicValue =3D=3D PCIM_H_IA_FIX) ||=0A=
+	(pcicValue =3D=3D PCIM_H_IA_RR))) {=0A=
+    /* Not in Host Mode, return ERROR */=0A=
+    return -1;=0A=
+  }=0A=
+=0A=
+  /* Enables the Idle Grant mode, Arbiter Parking */=0A=
+  pcicData |=3D(PCIC_igm_m|PCIC_eap_m|PCIC_en_m);=0A=
+  rc32438_pci->pcic =3D pcicData; /* Enable the PCI bus Interface =
*/=0A=
+  /* Zero out the PCI status & PCI Status Mask */=0A=
+  for(;;)=0A=
+    {=0A=
+      pcicData =3D rc32438_pci->pcis;=0A=
+      if (!(pcicData & PCIS_rip_m))=0A=
+	break;=0A=
+    }=0A=
+=0A=
+  rc32438_pci->pcis =3D 0;=0A=
+  rc32438_pci->pcism =3D 0xFFFFFFFF;=0A=
+  /* Zero out the PCI decoupled registers */=0A=
+  rc32438_pci->pcidac=3D0; /* disable PCI decoupled accesses at =
initialization */=0A=
+  rc32438_pci->pcidas=3D0; /* clear the status */=0A=
+  rc32438_pci->pcidasm=3D0x0000007F; /* Mask all the interrupts */=0A=
+  /* Mask PCI Messaging Interrupts */=0A=
+  rc32438_pci_msg->pciiic =3D 0;=0A=
+  rc32438_pci_msg->pciiim =3D 0xFFFFFFFF;=0A=
+  rc32438_pci_msg->pciioic =3D 0;=0A=
+  rc32438_pci_msg->pciioim =3D 0;=0A=
+=0A=
+  /* Setup PCILB0 as Memory Window */=0A=
+  rc32438_pci->pcilba[0].a =3D (unsigned int) (PCI_ADDR_START);=0A=
+=0A=
+  /* setup the PCI map address as same as the local address */=0A=
+=0A=
+  rc32438_pci->pcilba[0].m =3D (unsigned int) (PCI_ADDR_START);=0A=
+=0A=
+  /* Setup PCILBA1 as MEM */=0A=
+#ifdef __MIPSEB__=0A=
+  rc32438_pci->pcilba[0].c =3D ( ((SIZE_16MB & 0x1f) << =
PCILBAC_size_b) | PCILBAC_sb_m);=0A=
+#else=0A=
+  rc32438_pci->pcilba[0].c =3D ( ((SIZE_16MB & 0x1f) << =
PCILBAC_size_b));=0A=
+#endif=0A=
+  dummyRead =3D rc32438_pci->pcilba[0].c; /* flush the CPU write =
Buffers */=0A=
+=0A=
+  rc32438_pci->pcilba[1].a =3D 0x60000000;=0A=
+  =0A=
+  rc32438_pci->pcilba[1].m =3D 0x60000000;=0A=
+  /* setup PCILBA2 as IO Window*/=0A=
+#ifdef __MIPSEB__=0A=
+  rc32438_pci->pcilba[1].c =3D ( ((SIZE_256MB & 0x1f) << =
PCILBAC_size_b) |  PCILBAC_sb_m);=0A=
+#else=0A=
+  rc32438_pci->pcilba[1].c =3D ((SIZE_256MB & 0x1f) << =
PCILBAC_size_b);=0A=
+#endif=0A=
+  dummyRead =3D rc32438_pci->pcilba[1].c; /* flush the CPU write =
Buffers */=0A=
+  rc32438_pci->pcilba[2].a =3D 0x18C00000;=0A=
+    =0A=
+  rc32438_pci->pcilba[2].m =3D 0x18FFFFFF;=0A=
+  /* setup PCILBA2 as IO Window*/=0A=
+#ifdef __MIPSEB__=0A=
+  rc32438_pci->pcilba[2].c =3D ( ((SIZE_4MB & 0x1f) << PCILBAC_size_b) =
 |  PCILBAC_sb_m);=0A=
+#else=0A=
+  rc32438_pci->pcilba[2].c =3D ((SIZE_4MB & 0x1f) << =
PCILBAC_size_b);=0A=
+#endif  =0A=
+  =0A=
+  dummyRead =3D rc32438_pci->pcilba[2].c; /* flush the CPU write =
Buffers */=0A=
+=0A=
+=0A=
+  rc32438_pci->pcilba[3].a =3D 0x18800000;=0A=
+=0A=
+  rc32438_pci->pcilba[3].m =3D 0x18800000;=0A=
+  /* Setup PCILBA3 as IO Window */=0A=
+=0A=
+#ifdef __MIPSEB__=0A=
+  rc32438_pci->pcilba[3].c =3D ( (((SIZE_1MB & 0x1ff) << =
PCILBAC_size_b) | PCILBAC_msi_m)   |  PCILBAC_sb_m);=0A=
+#else=0A=
+  rc32438_pci->pcilba[3].c =3D (((SIZE_1MB & 0x1ff) << PCILBAC_size_b) =
| PCILBAC_msi_m);=0A=
+#endif=0A=
+  dummyRead =3D rc32438_pci->pcilba[2].c; /* flush the CPU write =
Buffers */=0A=
+=0A=
+  pciConfigAddr=3D(unsigned int)(0x80000004);=0A=
+  for(loopCount=3D0;loopCount<24;loopCount++){=0A=
+    rc32438_pci->pcicfga=3DpciConfigAddr;=0A=
+    dummyRead=3Drc32438_pci->pcicfga;=0A=
+    rc32438_pci->pcicfgd =3D acaciaCnfgRegs[loopCount];=0A=
+    dummyRead=3Drc32438_pci->pcicfgd;=0A=
+    pciConfigAddr +=3D 4;=0A=
+  }=0A=
+  rc32438_pci->pcitc=3D(unsigned int)((PCITC_RTIMER_VAL&0xff) << =
PCITC_rtimer_b) |=0A=
+    ((PCITC_DTIMER_VAL&0xff)<<PCITC_dtimer_b);=0A=
+=0A=
+  pciCntlVal=3Drc32438_pci->pcic;=0A=
+  pciCntlVal &=3D~(PCIC_tnr_m);=0A=
+  rc32438_pci->pcic =3D pciCntlVal;=0A=
+  pciCntlVal=3Drc32438_pci->pcic;=0A=
+=0A=
+  register_pci_controller(&rc32438_controller);=0A=
+=0A=
+  rc32438_sync();  =0A=
+  return 0;=0A=
+}=0A=
+arch_initcall(rc32438_pcibridge_init);=0A=
+=0A=
+/* Do platform specific device initialization at pci_enable_device() =
time */=0A=
+int pcibios_plat_dev_init(struct pci_dev *dev)=0A=
+{=0A=
+        return 0;=0A=
+}=0A=
+=0A=
+unsigned char rc32438_pci_inb(unsigned long port, int slow)=0A=
+{=0A=
+	volatile DMA_Chan_t pci_dma_regs =3D (DMA_Chan_t)(DMA0_VirtualAddress =
+ DMACH_pciToMem * DMA_CHAN_OFFSET);=0A=
+	volatile struct DMAD_s desc;=0A=
+	DMAD_t pdesc =3D (DMAD_t)KSEG1ADDR(&desc);=0A=
+	u32 data;=0A=
+	volatile u32 *pdata =3D (u32 *)KSEG1ADDR(&data);=0A=
+	unsigned long flags;=0A=
+=0A=
+	*pdata =3D 0;=0A=
+	pdesc->control =3D 0x01c00001;=0A=
+	pdesc->ca      =3D CPHYSADDR(pdata);=0A=
+	pdesc->devcs   =3D port;=0A=
+	pdesc->link    =3D 0;=0A=
+=0A=
+	local_irq_save(flags);=0A=
+	while (pci_dma_regs->dmac & DMAC_run_m);=0A=
+=0A=
+	pci_dma_regs->dmas =3D 0;=0A=
+	pci_dma_regs->dmandptr =3D 0;=0A=
+	pci_dma_regs->dmadptr =3D CPHYSADDR(pdesc);=0A=
+=0A=
+	while (!pci_dma_regs->dmas);=0A=
+	local_irq_restore(flags);=0A=
+=0A=
+	if (slow) SLOW_DOWN_IO;=0A=
+=0A=
+#if defined(__MIPSEB__)=0A=
+	return (unsigned char)(*pdata >> 24);=0A=
+#else=0A=
+	return (unsigned char)(*pdata);=0A=
+#endif=0A=
+}=0A=
+=0A=
+void rc32438_pci_outb(unsigned char val, unsigned long port, int =
slow)=0A=
+{=0A=
+	volatile DMA_Chan_t pci_dma_regs =3D (DMA_Chan_t)(DMA0_VirtualAddress =
+ DMACH_memToPci * DMA_CHAN_OFFSET);=0A=
+	volatile struct DMAD_s desc;=0A=
+	DMAD_t pdesc =3D (DMAD_t)KSEG1ADDR(&desc);=0A=
+	u32 data;=0A=
+	volatile u32 *pdata =3D (u32 *)KSEG1ADDR(&data);=0A=
+	unsigned long flags;=0A=
+=0A=
+#if defined(__MIPSEB__)=0A=
+	*pdata =3D val << 24;=0A=
+#else=0A=
+	*pdata =3D val;=0A=
+#endif=0A=
+	pdesc->control =3D 0x01c00001;=0A=
+	pdesc->ca      =3D CPHYSADDR(pdata);=0A=
+	pdesc->devcs   =3D port;=0A=
+	pdesc->link    =3D 0;=0A=
+=0A=
+	local_irq_save(flags);=0A=
+	while (pci_dma_regs->dmac & DMAC_run_m);=0A=
+=0A=
+	pci_dma_regs->dmas =3D 0;=0A=
+	pci_dma_regs->dmandptr =3D 0;=0A=
+	pci_dma_regs->dmadptr =3D CPHYSADDR(pdesc);=0A=
+=0A=
+	while (!pci_dma_regs->dmas);=0A=
+	local_irq_restore(flags);=0A=
+=0A=
+	if (slow) SLOW_DOWN_IO;=0A=
+}=0A=
+=0A=
+unsigned short rc32438_pci_inw(unsigned long port, int slow)=0A=
+{=0A=
+	volatile DMA_Chan_t pci_dma_regs =3D (DMA_Chan_t)(DMA0_VirtualAddress =
+ DMACH_pciToMem * DMA_CHAN_OFFSET);=0A=
+	volatile struct DMAD_s desc;=0A=
+	DMAD_t pdesc =3D (DMAD_t)KSEG1ADDR(&desc);=0A=
+	u32 data;=0A=
+	volatile u32 *pdata =3D (u32 *)KSEG1ADDR(&data);=0A=
+	unsigned long flags;=0A=
+=0A=
+	*pdata =3D 0;=0A=
+	pdesc->control =3D 0x01c00002;=0A=
+	pdesc->ca      =3D CPHYSADDR(pdata);=0A=
+	pdesc->devcs   =3D port;=0A=
+	pdesc->link    =3D 0;=0A=
+=0A=
+	local_irq_save(flags);=0A=
+	while (pci_dma_regs->dmac & DMAC_run_m);=0A=
+=0A=
+	pci_dma_regs->dmas =3D 0;=0A=
+	pci_dma_regs->dmandptr =3D 0;=0A=
+	pci_dma_regs->dmadptr =3D CPHYSADDR(pdesc);=0A=
+=0A=
+	while (!pci_dma_regs->dmas);=0A=
+	local_irq_restore(flags);=0A=
+=0A=
+	if (slow) SLOW_DOWN_IO;=0A=
+=0A=
+#if defined(__MIPSEB__)=0A=
+//	return (unsigned short)((*pdata >> 24) | ((*pdata >> 8) & =
0x0000ff00));=0A=
+	return (unsigned short)(*pdata >> 16);=0A=
+#else=0A=
+	return (unsigned short)(*pdata);=0A=
+#endif=0A=
+}=0A=
+=0A=
+void rc32438_pci_outw(unsigned short val, unsigned long port, int =
slow)=0A=
+{=0A=
+	volatile DMA_Chan_t pci_dma_regs =3D (DMA_Chan_t)(DMA0_VirtualAddress =
+ DMACH_memToPci * DMA_CHAN_OFFSET);=0A=
+	volatile struct DMAD_s desc;=0A=
+	DMAD_t pdesc =3D (DMAD_t)KSEG1ADDR(&desc);=0A=
+	u32 data;=0A=
+	volatile u32 *pdata =3D (u32 *)KSEG1ADDR(&data);=0A=
+	unsigned long flags;=0A=
+=0A=
+#if defined(__MIPSEB__)=0A=
+//	*pdata =3D (val << 24) | ((val << 8) & 0x00ff0000);=0A=
+	*pdata =3D (val << 16);=0A=
+#else=0A=
+	*pdata =3D val;=0A=
+#endif=0A=
+	pdesc->control =3D 0x01c00002;=0A=
+	pdesc->ca      =3D CPHYSADDR(pdata);=0A=
+	pdesc->devcs   =3D port;=0A=
+	pdesc->link    =3D 0;=0A=
+=0A=
+	local_irq_save(flags);=0A=
+	while (pci_dma_regs->dmac & DMAC_run_m);=0A=
+=0A=
+	pci_dma_regs->dmas =3D 0;=0A=
+	pci_dma_regs->dmandptr =3D 0;=0A=
+	pci_dma_regs->dmadptr =3D CPHYSADDR(pdesc);=0A=
+=0A=
+	while (!pci_dma_regs->dmas);=0A=
+	local_irq_restore(flags);=0A=
+=0A=
+	if (slow) SLOW_DOWN_IO;=0A=
+}=0A=
+=0A=
diff -uNr linux-2.6.16-rc5/Documentation/mips/IDT_RC32xxx.README =
acacia/Documentation/mips/IDT_RC32xxx.README=0A=
--- linux-2.6.16-rc5/Documentation/mips/IDT_RC32xxx.README	1969-12-31 =
16:00:00.000000000 -0800=0A=
+++ acacia/Documentation/mips/IDT_RC32xxx.README	2006-03-14 =
14:00:59.000000000 -0800=0A=
@@ -0,0 +1,74 @@=0A=
+README for arch/mips/idt-boards directory and sub directories=0A=
+=0A=
+Rakesh Tiwari, rtiwari@idt.com=0A=
+March 2006=0A=
+=0A=
+=0A=
+1. ABOUT=0A=
+----------=0A=
+This file contains information about IDT Evaluation Boards based =0A=
+on the Interprise family of Integrated Processors.=0A=
+=0A=
+=0A=
+2. PROCESSOR AND EVALUATION BOARD=0A=
+--------------------------------=0A=
+=0A=
+IDT's Interprise family consists of the following MIPS based =
processors.=0A=
+=0A=
+Core 	Processor	Eval Board   	PCI   ETHERNET	DEFAULT_CONFIG*=0A=
+-----	---------	-----------	---   --------	----------------=0A=
+4KC    	RC32438		EB438		yes	yes	rc32438_defconfig=0A=
+=0A=
+*All default configurations are located in ~arch/mips/configs/ =
directory.=0A=
+=0A=
+=0A=
+3. LINUX BOOT MODE SUPPORT=0A=
+--------------------------=0A=
+All the evaluation boards support the following boot mode=0A=
+=0A=
+	a. Initramfs=0A=
+	b. NFS=0A=
+	c. Flash Boot (make zImage, required bootloader)=0A=
+	d. Self-Boot  (make rImage, doesn't need additional bootloader)=0A=
+=0A=
+=0A=
+4. I2C DRIVERS=0A=
+--------------=0A=
+Some boards supports I2C interface and the drivers=0A=
+can be found in the ~driver/i2c/busses/i2c_rc32xxx.x=0A=
+=0A=
+=0A=
+5. ETHERNET DRIVERS=0A=
+-------------------=0A=
+The processors on-board Ethernet interface drivers are located=0A=
+in ~drivers/net/rc32xxx.x=0A=
+=0A=
+=0A=
+6. ADDITIONAL INFORMATION=0A=
+-------------------------=0A=
+Additional information regarding IDT Interprise Processors and=0A=
+Evaluation boards can be obtained from=0A=
+=0A=
+Website: http://www.idt.com/?catID=3D58532=0A=
+Email: rischelp@idt.com=0A=
+=0A=
+=0A=
+=0A=
+7. ACKNOWLEDGEMENTS=0A=
+--------------------=0A=
+The following people have been involved in the development/testing=0A=
+of Linux on IDT development boards. Many thanks to all of them..=0A=
+=0A=
+Nebojsa Bjegovic=0A=
+Haofeng Kou=0A=
+Bernard Maruthanayagam=0A=
+Sadik Pallathu=0A=
+Kiran Rao=0A=
+Steve Shih=0A=
+Harpinder Singh=0A=
+Adisak Srinakarin=0A=
+Rakesh Tiwari=0A=
+Brandon Wong=0A=
+Calvin Young =0A=
+=0A=
+=0A=
diff -uNr linux-2.6.16-rc5/drivers/i2c/busses/i2c-rc32438.c =
acacia/drivers/i2c/busses/i2c-rc32438.c=0A=
--- linux-2.6.16-rc5/drivers/i2c/busses/i2c-rc32438.c	1969-12-31 =
16:00:00.000000000 -0800=0A=
+++ acacia/drivers/i2c/busses/i2c-rc32438.c	2006-03-14 =
10:47:12.000000000 -0800=0A=
@@ -0,0 +1,331 @@=0A=
+/**********************************************************************=
****=0A=
+ *=0A=
+ *  BRIEF MODULE DESCRIPTION=0A=
+ *     I2C driver IDT EB434 board=0A=
+ *=0A=
+ *  Copyright 2006 IDT Inc. (rischelp@idt.com)=0A=
+ *         =0A=
+ *  This program is free software; you can redistribute  it and/or =
modify it=0A=
+ *  under  the terms of  the GNU General  Public License as published =
by the=0A=
+ *  Free Software Foundation;  either version 2 of the  License, or =
(at your=0A=
+ *  option) any later version.=0A=
+ *=0A=
+ *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR =
IMPLIED=0A=
+ *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED =
WARRANTIES OF=0A=
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE =
DISCLAIMED.  IN=0A=
+ *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, =
INDIRECT,=0A=
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES =
(INCLUDING, BUT=0A=
+ *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; =
LOSS OF=0A=
+ *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED =
AND ON=0A=
+ *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, =
OR TORT=0A=
+ *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE =
USE OF=0A=
+ *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH =
DAMAGE.=0A=
+ *=0A=
+ *  You should have received a copy of the  GNU General Public License =
along=0A=
+ *  with this program; if not, write  to the Free Software Foundation, =
Inc.,=0A=
+ *  675 Mass Ave, Cambridge, MA 02139, USA.=0A=
+ *=0A=
+ *=0A=
+ =
************************************************************************=
**=0A=
+ */=0A=
+=0A=
+=0A=
+=0A=
+#include <linux/module.h>=0A=
+#include <linux/config.h>=0A=
+#include <linux/version.h>=0A=
+#include <linux/kernel.h>=0A=
+#include <linux/ioport.h>=0A=
+#include <linux/pci.h>=0A=
+#include <linux/types.h>=0A=
+#include <linux/delay.h>=0A=
+#include <linux/i2c.h>=0A=
+#include <linux/init.h>=0A=
+#include <linux/mm.h>=0A=
+#include <linux/timer.h>=0A=
+#include <linux/spinlock.h>=0A=
+#include <linux/completion.h>=0A=
+#include <linux/devfs_fs_kernel.h>=0A=
+#include <linux/i2c-dev.h>=0A=
+#include <asm/io.h>=0A=
+=0A=
+#include "i2c-rc32xxx.h"=0A=
+=0A=
+MODULE_AUTHOR("idt");=0A=
+MODULE_DESCRIPTION("I2C driver for IDT's 79RC32438 board");=0A=
+MODULE_LICENSE("GPL");=0A=
+=0A=
+=0A=
+static i2c_rc32xxx_iface 	*iface;=0A=
+static struct resource 		*region;=0A=
+=0A=
+=0A=
+static u32 i2c_rc32xxx_func(struct i2c_adapter *adapter)=0A=
+{=0A=
+	return I2C_FUNC_I2C;=0A=
+}=0A=
+=0A=
+static void i2c_rc32xxx_master(void)=0A=
+{=0A=
+  	u32	i2cms =3D i2c->i2cms;=0A=
+=0A=
+	if (!(i2cms & I2CMS_D))=0A=
+		return;=0A=
+=0A=
+	iface->d_ints++;=0A=
+=0A=
+  	if (i2cms & I2CMS_LA) =0A=
+	{=0A=
+		iface->la_ints++;=0A=
+    		printk ("\nI2C Master LA Detected!\n");=0A=
+  	}=0A=
+=0A=
+  	if (i2cms & I2CMS_ERR) =0A=
+	{=0A=
+		iface->err_ints++;=0A=
+    		printk("\nI2C Master ERR Detected!\n");=0A=
+  	}=0A=
+=0A=
+  	switch (iface->state) =0A=
+	{=0A=
+    		case I2C_STATE_IDLE:=0A=
+    		// No need to do anything...=0A=
+      			break;=0A=
+=0A=
+		case I2C_STATE_START:=0A=
+    		// DONE sending START, begin sending address=0A=
+      			i2c->i2cdo =3D I2CDO_DATA(iface->addr);=0A=
+      			i2c->i2cmcmd =3D I2CMCMD_CMD(I2CMCMD_WD);=0A=
+			iface->state =3D I2C_STATE_ADDR;=0A=
+      			break;=0A=
+=0A=
+		case I2C_STATE_ADDR:=0A=
+    		// Count ACKs & NAKs - note, an ACK occurs when the ACK bit is =
cleared=0A=
+    		// (Because SDA is driven low)=0A=
+			if (i2cms & I2CMS_NA)=0A=
+				iface->num_naks++;=0A=
+			else=0A=
+				iface->num_acks++;=0A=
+=0A=
+      			// If No Slave ACknowledged the Address byte or=0A=
+		  	// Data Length is zero, then skip Write / Read Stage=0A=
+			if ((i2cms & I2CMS_NA) || !iface->len)=0A=
+			{=0A=
+        			if (iface->stop) =0A=
+				{=0A=
+          				i2c->i2cmcmd =3D I2CMCMD_CMD(I2CMCMD_STOP);=0A=
+          				iface->state =3D I2C_STATE_STOP;=0A=
+        			}=0A=
+        			else =0A=
+				{=0A=
+  					// No STOP desired, so go to IDLE and set global variable=0A=
+          				iface->state =3D I2C_STATE_IDLE;=0A=
+        			}=0A=
+        			break;=0A=
+			}=0A=
+=0A=
+			iface->len--;=0A=
+			if (iface->xfer =3D=3D I2C_XFER_WRITE) =0A=
+			{=0A=
+		  		// DONE sending address, now send data=0A=
+		        	i2c->i2cdo =3D  I2CDO_DATA(*(iface->buf++));=0A=
+		        	i2c->i2cmcmd =3D I2CMCMD_CMD(I2CMCMD_WD);=0A=
+		        	iface->state =3D I2C_STATE_WRITE_DATA;=0A=
+		        	iface->tx_bytes++;=0A=
+		      	}=0A=
+		      	else =0A=
+			{=0A=
+		  		// DONE sending address, now read data=0A=
+				if (iface->len > 0)=0A=
+		    			// Read Another Data Byte (And ACK)=0A=
+		          		i2c->i2cmcmd =3D I2CMCMD_CMD(I2CMCMD_RDACK);=0A=
+				else=0A=
+		    			// Almost done reading data, now send RD (not RDACK!)=0A=
+		          		i2c->i2cmcmd =3D I2CMCMD_CMD(I2CMCMD_RD);=0A=
+		        	iface->state =3D I2C_STATE_READ_DATA;=0A=
+		      	}=0A=
+		      	break;=0A=
+			=0A=
+	    	case I2C_STATE_WRITE_DATA:=0A=
+    			// Count ACKs & NAKs - note, an ACK occurs when the ACK bit is =
cleared=0A=
+    			// (Because SDA is driven low)=0A=
+      			if (i2cms & I2CMS_NA)=0A=
+        			iface->num_naks++;=0A=
+      			else=0A=
+        			iface->num_acks++;=0A=
+=0A=
+      			if (iface->len-- > 0) =0A=
+			{=0A=
+				// Send next data byte=0A=
+		        	i2c->i2cdo =3D  I2CDO_DATA(*(iface->buf++));=0A=
+				i2c->i2cmcmd =3D I2CMCMD_CMD(I2CMCMD_WD);=0A=
+				iface->tx_bytes++;=0A=
+      			}=0A=
+      			else =0A=
+			{=0A=
+  				// done sending data, now send STOP if desired.=0A=
+        			if (iface->stop) =0A=
+				{=0A=
+					i2c->i2cmcmd =3D I2CMCMD_CMD(I2CMCMD_STOP);=0A=
+					iface->state =3D I2C_STATE_STOP;=0A=
+        			}=0A=
+        			else =0A=
+				{=0A=
+					// No STOP desired, so go to IDLE and set global variable=0A=
+					iface->state =3D I2C_STATE_IDLE;=0A=
+        			}=0A=
+      			}=0A=
+			break;=0A=
+			 =0A=
+		case I2C_STATE_READ_DATA:=0A=
+    			// Write Incoming Read data to buffer=0A=
+			*iface->buf++ =3D I2CDI_DATA(i2c->i2cdi);=0A=
+      			iface->rx_bytes++;=0A=
+=0A=
+    			// Count ACKs & NAKs - note, an ACK occurs when the ACK bit is =
cleared=0A=
+    			// (Because SDA is driven low)=0A=
+      			if (i2cms & I2CMS_NA)=0A=
+        			iface->num_naks++;=0A=
+      			else=0A=
+        			iface->num_acks++;=0A=
+				=0A=
+			if (iface->len > 0)=0A=
+			{=0A=
+        			if (iface->len-- > 1) =0A=
+				{=0A=
+					// Read Another Data Byte (And ACK)=0A=
+					i2c->i2cmcmd =3D I2CMCMD_CMD(I2CMCMD_RDACK);=0A=
+        			}=0A=
+        			else =0A=
+				{=0A=
+      					// Almost done reading data, now send RD (not RDACK!)=0A=
+          				i2c->i2cmcmd =3D I2CMCMD_CMD(I2CMCMD_RD);=0A=
+        			}=0A=
+			}=0A=
+      			else=0A=
+			{=0A=
+				// done sending data, now send STOP if desired.=0A=
+        			if (iface->stop) =0A=
+				{=0A=
+          				i2c->i2cmcmd =3D I2CMCMD_CMD(I2CMCMD_STOP);=0A=
+          				iface->state =3D I2C_STATE_STOP;=0A=
+        			}=0A=
+        			else =0A=
+				{=0A=
+	  				// No STOP desired, so go to IDLE and set global variable=0A=
+	          			iface->state =3D I2C_STATE_IDLE;=0A=
+	        		}=0A=
+      			}=0A=
+      			break;=0A=
+=0A=
+    		case I2C_STATE_STOP:=0A=
+    			// Done with packet, set global variable, write NOP command, =
and go to idle=0A=
+      			i2c->i2cmcmd =3D I2CMCMD_CMD(I2CMCMD_NOP);=0A=
+      			iface->state =3D I2C_STATE_IDLE;=0A=
+      			break;=0A=
+		=0A=
+    		default:=0A=
+      			printk ("\nErr in Default\n");=0A=
+      			break;=0A=
+  	}=0A=
+}=0A=
+=0A=
+static int i2c_rc32xxx_xfer(struct i2c_adapter *adap, struct i2c_msg =
*msg, int num)=0A=
+{=0A=
+	int	i;=0A=
+=0A=
+	for (i =3D 0; i < num; i++, msg++) =0A=
+	{=0A=
+		if (msg->flags & I2C_M_TEN) =0A=
+		{=0A=
+			printk(KERN_ERR "i2c-rc32438: 10 bits addr not supported!\n");=0A=
+			break;=0A=
+		}=0A=
+=0A=
+		if (msg->flags & I2C_M_RD)=0A=
+		{=0A=
+			iface->xfer =3D I2C_XFER_READ;=0A=
+			iface->addr =3D I2CDO_ADDR(I2C_SLAVE_ADDR) | I2CDO_RD;=0A=
+		}=0A=
+		else=0A=
+		{=0A=
+			iface->xfer =3D I2C_XFER_WRITE;=0A=
+			iface->addr =3D I2CDO_ADDR(I2C_SLAVE_ADDR);=0A=
+		}=0A=
+		iface->len =3D msg->len;=0A=
+		iface->buf =3D msg->buf;=0A=
+		iface->stop =3D TRUE;=0A=
+=0A=
+		// Update Master State=0A=
+		i2c->i2cmcmd =3D I2CMCMD_CMD(I2CMCMD_START);=0A=
+		iface->state =3D I2C_STATE_START;=0A=
+=0A=
+	  	while (iface->state !=3D I2C_STATE_IDLE) =0A=
+		{=0A=
+			if (i2c->i2cms & I2CMS_D)=0A=
+				i2c_rc32xxx_master();=0A=
+	 	}=0A=
+	}=0A=
+=0A=
+	return i;=0A=
+}=0A=
+=0A=
+int __init i2c_rc32438_init(void)=0A=
+{=0A=
+	int	rc;=0A=
+=0A=
+	printk("i2c-rc32438: loading driver module\n");=0A=
+=0A=
+	region =3D request_region(I2C_BASE, I2C_REGION, "rc32438-i2c IO");=0A=
+	=0A=
+	iface =3D (i2c_rc32xxx_iface *)kmalloc(sizeof(i2c_rc32xxx_iface), =
GFP_KERNEL);=0A=
+	if (!iface) =0A=
+	{=0A=
+		release_region(I2C_BASE, I2C_REGION);=0A=
+		printk(KERN_ERR "i2c-rc32438: can't allocate inteface!\n");=0A=
+		return -ENOMEM;=0A=
+	}=0A=
+	memset(iface, 0, sizeof(i2c_rc32xxx_iface));=0A=
+=0A=
+	iface->algo.functionality =3D i2c_rc32xxx_func;=0A=
+	iface->algo.master_xfer =3D i2c_rc32xxx_xfer;=0A=
+=0A=
+	sprintf(iface->adap.name, "%s", "RC32438 I2C");=0A=
+	iface->adap.algo =3D &iface->algo;=0A=
+	i2c_set_adapdata(&iface->adap, iface);=0A=
+=0A=
+	rc =3D i2c_add_adapter(&iface->adap);=0A=
+	if (rc)=0A=
+	{=0A=
+		kfree(iface);=0A=
+		release_region(I2C_BASE, I2C_REGION);=0A=
+		printk(KERN_ERR "i2c-rc32438: can't add adapter!\n");=0A=
+		return rc;=0A=
+	}=0A=
+	=0A=
+	iface->state =3D I2C_STATE_IDLE;=0A=
+=0A=
+    	// Initialize master interface=0A=
+  	i2c->i2cc =3D I2CC_MEN;=0A=
+  	i2c->i2ccp =3D  I2CCP_DIV(I2C_PRESCALER);=0A=
+	i2c->i2cmcmd =3D I2CMCMD_CMD(I2CMCMD_NOP);=0A=
+  	i2c->i2cmsm =3D I2CMS_MASK;=0A=
+  	i2c->i2cssm =3D I2CSS_MASK;=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
+void __exit i2c_rc32438_exit(void)=0A=
+{=0A=
+	printk("i2c-rc32438: unloading driver module\n");=0A=
+=0A=
+	i2c_del_adapter(&iface->adap);=0A=
+	kfree(iface);		=0A=
+	if (region)=0A=
+		release_region(I2C_BASE, I2C_REGION);=0A=
+}=0A=
+=0A=
+=0A=
+module_init(i2c_rc32438_init);=0A=
+module_exit(i2c_rc32438_exit);=0A=
+=0A=
diff -uNr linux-2.6.16-rc5/drivers/i2c/busses/i2c-rc32xxx.h =
acacia/drivers/i2c/busses/i2c-rc32xxx.h=0A=
--- linux-2.6.16-rc5/drivers/i2c/busses/i2c-rc32xxx.h	1969-12-31 =
16:00:00.000000000 -0800=0A=
+++ acacia/drivers/i2c/busses/i2c-rc32xxx.h	2006-03-14 =
10:47:12.000000000 -0800=0A=
@@ -0,0 +1,237 @@=0A=
+/**********************************************************************=
****=0A=
+ *=0A=
+ *  BRIEF MODULE DESCRIPTION=0A=
+ *     Low level driver for 79RC32xxx=0A=
+ *=0A=
+ *  Copyright 2006 IDT Inc. (rischelp@idt.com)=0A=
+ *         =0A=
+ *  This program is free software; you can redistribute  it and/or =
modify it=0A=
+ *  under  the terms of  the GNU General  Public License as published =
by the=0A=
+ *  Free Software Foundation;  either version 2 of the  License, or =
(at your=0A=
+ *  option) any later version.=0A=
+ *=0A=
+ *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR =
IMPLIED=0A=
+ *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED =
WARRANTIES OF=0A=
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE =
DISCLAIMED.  IN=0A=
+ *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, =
INDIRECT,=0A=
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES =
(INCLUDING, BUT=0A=
+ *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; =
LOSS OF=0A=
+ *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED =
AND ON=0A=
+ *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, =
OR TORT=0A=
+ *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE =
USE OF=0A=
+ *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH =
DAMAGE.=0A=
+ *=0A=
+ *  You should have received a copy of the  GNU General Public License =
along=0A=
+ *  with this program; if not, write  to the Free Software Foundation, =
Inc.,=0A=
+ *  675 Mass Ave, Cambridge, MA 02139, USA.=0A=
+ *=0A=
+ *=0A=
+ =
************************************************************************=
**=0A=
+ */=0A=
+=0A=
+#ifndef _I2C_RC32xxx_=0A=
+#define _I2C_RC32xxx_=0A=
+#ifdef __cplusplus=0A=
+extern "C" {=0A=
+#endif=0A=
+=0A=
+=0A=
+/*	NOTE:!!!=0A=
+ *	Please assign your I2C device's Slave Adress here, =0A=
+ *	otherwise it will use the default values=0A=
+ */=0A=
+#ifdef CONFIG_I2C_RC32438=0A=
+#define	I2C_SLAVE_ADDR		0x50=0A=
+#define I2C_PRESCALER		110=0A=
+#define I2C_BASE		0xb8070000=0A=
+#endif=0A=
+=0A=
+=0A=
+#ifdef CONFIG_I2C_RC32434=0A=
+#define	I2C_SLAVE_ADDR		0x50=0A=
+#define I2C_PRESCALER		250=0A=
+#define I2C_BASE		0xb8068000=0A=
+#endif=0A=
+=0A=
+#ifdef CONFIG_I2C_RC32355=0A=
+#define I2C_SLAVE_ADDR		0x57=0A=
+#define I2C_PRESCALER		63=0A=
+#define I2C_BASE		0xb8070000=0A=
+#endif=0A=
+=0A=
+=0A=
+/********************************************************************=0A=
+ * RC355 GPIO/I2C Interface=0A=
+ =
********************************************************************/=0A=
+#define RC355_GPIOFUNC		0xb8040000=0A=
+=0A=
+#define RC355_GPIOFUNC_ALT_CSN4	0x00010000=0A=
+#define RC355_GPIOFUNC_I2C_PINS	0x0000c000=0A=
+=0A=
+#define rc355_gpiofunc 		(*(volatile u32*)RC355_GPIOFUNC)=0A=
+=0A=
+=0A=
+/********************************************************************=0A=
+ * I2C Interface=0A=
+ =
********************************************************************/=0A=
+#ifndef TRUE=0A=
+#define TRUE 1=0A=
+#endif=0A=
+#ifndef FALSE=0A=
+#define FALSE 0=0A=
+#endif=0A=
+=0A=
+typedef enum {=0A=
+	I2C_STATE_IDLE,=0A=
+	I2C_STATE_START,=0A=
+	I2C_STATE_ADDR,=0A=
+	I2C_STATE_READ_DATA,=0A=
+	I2C_STATE_WRITE_DATA,=0A=
+	I2C_STATE_STOP=0A=
+} I2C_STATE;=0A=
+=0A=
+typedef enum {=0A=
+	I2C_XFER_READ,=0A=
+	I2C_XFER_WRITE=0A=
+} I2C_XFER;=0A=
+=0A=
+typedef struct {=0A=
+	struct i2c_algorithm	algo;=0A=
+	struct i2c_adapter	adap;=0A=
+	I2C_STATE		state;=0A=
+	I2C_XFER		xfer;=0A=
+	unsigned		addr;=0A=
+	int			len;=0A=
+	u8			*buf;=0A=
+	int			stop;=0A=
+	unsigned		d_ints;=0A=
+	unsigned		la_ints;=0A=
+	unsigned		err_ints;=0A=
+	unsigned		num_acks;=0A=
+	unsigned		num_naks;=0A=
+	unsigned		tx_bytes;=0A=
+	unsigned		rx_bytes;=0A=
+} i2c_rc32xxx_iface;=0A=
+=0A=
+=0A=
+/********************************************************************=0A=
+ * I2C Registers=0A=
+ =
********************************************************************/=0A=
+#define I2CC			0x00000000=0A=
+#define I2CDI			0x00000004=0A=
+#define I2CDO			0x00000008=0A=
+#define I2CCP			0x0000000c=0A=
+#define I2CMCMD			0x00000010=0A=
+#define I2CMS			0x00000014=0A=
+#define I2CMSM			0x00000018=0A=
+#define I2CSS			0x0000001c=0A=
+#define I2CSSM			0x00000020=0A=
+#define I2CSADDR		0x00000024=0A=
+#define I2CSACK			0x00000028=0A=
+=0A=
+#define I2C_REGION		0x00008000=0A=
+=0A=
+typedef struct {=0A=
+	u32	i2cc;=0A=
+	u32	i2cdi;=0A=
+	u32	i2cdo;=0A=
+	u32	i2ccp;=0A=
+	u32	i2cmcmd;=0A=
+	u32	i2cms;=0A=
+	u32	i2cmsm;=0A=
+	u32	i2css;=0A=
+	u32	i2cssm;=0A=
+	u32	i2csaddr;=0A=
+	u32	i2csack;=0A=
+} I2C;=0A=
+=0A=
+#define i2c 			((volatile I2C*)I2C_BASE)=0A=
+=0A=
+=0A=
+/********************************************************************=0A=
+ * I2CC Register=0A=
+ =
********************************************************************/=0A=
+#define I2CC_MEN		(1<<0)=0A=
+#define I2CC_SEN		(1<<1)=0A=
+#define I2CC_IOM		(1<<2)=0A=
+=0A=
+=0A=
+/********************************************************************=0A=
+ * I2CDI Register=0A=
+ =
********************************************************************/=0A=
+#define I2CDI_DATA(v)		((u8)((v) & 0x000000ff))=0A=
+=0A=
+=0A=
+/********************************************************************=0A=
+ * I2CDO Register=0A=
+ =
********************************************************************/=0A=
+#define I2CDO_DATA(v)		((v) & 0x000000ff)=0A=
+=0A=
+#define I2CDO_ADDR(v)		((v) << 1)=0A=
+#define I2CDO_RD		1=0A=
+=0A=
+=0A=
+/********************************************************************=0A=
+ * I2CCP Register=0A=
+ =
********************************************************************/=0A=
+#define I2CCP_DIV(v)		((v) & 0x0000ffff)=0A=
+=0A=
+=0A=
+/********************************************************************=0A=
+ * I2CMCMD Register=0A=
+ =
********************************************************************/=0A=
+#define I2CMCMD_CMD(v)		((v) & 0x0000000f)=0A=
+=0A=
+#define I2CMCMD_NOP		0=0A=
+#define I2CMCMD_START		1=0A=
+#define I2CMCMD_STOP		2=0A=
+#define I2CMCMD_RD		4=0A=
+#define I2CMCMD_RDACK		5=0A=
+#define I2CMCMD_WD		6=0A=
+#define I2CMCMD_WDACK		7=0A=
+=0A=
+=0A=
+/********************************************************************=0A=
+ * I2CMS Register=0A=
+ =
********************************************************************/=0A=
+#define I2CMS_D			(1<<0)=0A=
+#define I2CMS_NA		(1<<1)=0A=
+#define I2CMS_LA		(1<<2)=0A=
+#define I2CMS_ERR		(1<<3)=0A=
+=0A=
+#define I2CMS_MASK		0x0000000f=0A=
+=0A=
+=0A=
+/********************************************************************=0A=
+ * I2CSS Register=0A=
+ =
********************************************************************/=0A=
+#define I2CSS_RR		(1<<0)=0A=
+#define I2CSS_WR		(1<<1)=0A=
+#define I2CSS_SA		(1<<2)=0A=
+#define I2CSS_TF		(1<<3)=0A=
+#define I2CSS_GC		(1<<4)=0A=
+#define I2CSS_NA		(1<<5)=0A=
+#define I2CSS_ERR		(1<<6)=0A=
+=0A=
+#define I2CSS_MASK		0x0000007f=0A=
+=0A=
+=0A=
+/********************************************************************=0A=
+ * I2CSADDR Register=0A=
+ =
********************************************************************/=0A=
+#define I2CSADDR_ADDR(v)	((v) & 0x000003ff)=0A=
+#define I2CSADDR_GC		(1<<10)=0A=
+#define I2CSADDR_A10		(1<<11)=0A=
+=0A=
+=0A=
+/********************************************************************=0A=
+ * I2CSACK Register=0A=
+ =
********************************************************************/=0A=
+#define I2CSACK_ACK		(1<<0)=0A=
+=0A=
+=0A=
+#ifdef __cplusplus=0A=
+}=0A=
+#endif=0A=
+#endif /* _I2C_RC32xxx_ */=0A=
+=0A=
diff -uNr linux-2.6.16-rc5/drivers/i2c/busses/Kconfig =
acacia/drivers/i2c/busses/Kconfig=0A=
--- linux-2.6.16-rc5/drivers/i2c/busses/Kconfig	2006-02-27 =
02:56:56.000000000 -0800=0A=
+++ acacia/drivers/i2c/busses/Kconfig	2006-03-14 13:51:13.000000000 =
-0800=0A=
@@ -511,4 +511,10 @@=0A=
 	  This driver can also be built as a module.  If so, the module=0A=
 	  will be called i2c-mv64xxx.=0A=
 =0A=
+config I2C_RC32438=0A=
+        tristate "I2C IDT RC32438 interface"=0A=
+        depends on I2C_CHARDEV=0A=
+        depends on IDT_EB438=0A=
+	default y=0A=
+=0A=
 endmenu=0A=
diff -uNr linux-2.6.16-rc5/drivers/i2c/busses/Makefile =
acacia/drivers/i2c/busses/Makefile=0A=
--- linux-2.6.16-rc5/drivers/i2c/busses/Makefile	2006-02-27 =
02:56:56.000000000 -0800=0A=
+++ acacia/drivers/i2c/busses/Makefile	2006-03-14 13:51:26.000000000 =
-0800=0A=
@@ -42,6 +42,7 @@=0A=
 obj-$(CONFIG_I2C_VOODOO3)	+=3D i2c-voodoo3.o=0A=
 obj-$(CONFIG_SCx200_ACB)	+=3D scx200_acb.o=0A=
 obj-$(CONFIG_SCx200_I2C)	+=3D scx200_i2c.o=0A=
+obj-$(CONFIG_I2C_RC32438)       +=3D i2c-rc32438.o=0A=
 =0A=
 ifeq ($(CONFIG_I2C_DEBUG_BUS),y)=0A=
 EXTRA_CFLAGS +=3D -DDEBUG=0A=
diff -uNr linux-2.6.16-rc5/drivers/net/Kconfig =
acacia/drivers/net/Kconfig=0A=
--- linux-2.6.16-rc5/drivers/net/Kconfig	2006-02-27 02:56:56.000000000 =
-0800=0A=
+++ acacia/drivers/net/Kconfig	2006-03-14 13:52:19.000000000 -0800=0A=
@@ -185,6 +185,14 @@=0A=
 	  or internal device.  It is safe to say Y or M here even if your=0A=
 	  ethernet card lack MII.=0A=
 =0A=
+config IDT_RC32438_ETH=0A=
+        tristate "IDT RC32438 Local Ethernet support"=0A=
+        depends on NET_ETHERNET && (IDT_EB438 || IDT_PMC438)=0A=
+	default y=0A=
+        help=0A=
+        IDT RC32438 has two local ethernet ports. Say Y here to enable =
them.=0A=
+        To compile this driver as a module, choose M here.=0A=
+=0A=
 source "drivers/net/arm/Kconfig"=0A=
 =0A=
 config MACE=0A=
diff -uNr linux-2.6.16-rc5/drivers/net/Makefile =
acacia/drivers/net/Makefile=0A=
--- linux-2.6.16-rc5/drivers/net/Makefile	2006-02-27 02:56:56.000000000 =
-0800=0A=
+++ acacia/drivers/net/Makefile	2006-03-14 13:52:48.000000000 -0800=0A=
@@ -74,6 +74,8 @@=0A=
 # end link order section=0A=
 #=0A=
 =0A=
+obj-$(CONFIG_IDT_RC32438_ETH) +=3D rc32438_eth.o=0A=
+=0A=
 obj-$(CONFIG_MII) +=3D mii.o=0A=
 obj-$(CONFIG_PHYLIB) +=3D phy/=0A=
 =0A=
diff -uNr linux-2.6.16-rc5/drivers/net/rc32438_eth.c =
acacia/drivers/net/rc32438_eth.c=0A=
--- linux-2.6.16-rc5/drivers/net/rc32438_eth.c	1969-12-31 =
16:00:00.000000000 -0800=0A=
+++ acacia/drivers/net/rc32438_eth.c	2006-03-14 14:38:22.000000000 =
-0800=0A=
@@ -0,0 +1,1379 @@=0A=
+/**********************************************************************=
****=0A=
+ *=0A=
+ *  BRIEF MODULE DESCRIPTION=0A=
+ *     Driver for the IDT RC32438 on-chip ethernet controller.=0A=
+ *=0A=
+ *  Copyright 2006 IDT Inc. (rischelp@idt.com)=0A=
+ *=0A=
+ *  This program is free software; you can redistribute  it and/or =
modify it=0A=
+ *  under  the terms of  the GNU General  Public License as published =
by the=0A=
+ *  Free Software Foundation;  either version 2 of the  License, or =
(at your=0A=
+ *  option) any later version.=0A=
+ *=0A=
+ *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR =
IMPLIED=0A=
+ *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED =
WARRANTIES OF=0A=
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE =
DISCLAIMED.  IN=0A=
+ *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, =
INDIRECT,=0A=
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES =
(INCLUDING, BUT=0A=
+ *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; =
LOSS OF=0A=
+ *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED =
AND ON=0A=
+ *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, =
OR TORT=0A=
+ *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE =
USE OF=0A=
+ *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH =
DAMAGE.=0A=
+ *=0A=
+ *  You should have received a copy of the  GNU General Public License =
along=0A=
+ *  with this program; if not, write  to the Free Software Foundation, =
Inc.,=0A=
+ *  675 Mass Ave, Cambridge, MA 02139, USA.=0A=
+ *=0A=
+ *=0A=
+ =
************************************************************************=
**=0A=
+ */=0A=
+#include <linux/config.h>=0A=
+#include <linux/module.h>=0A=
+#include <linux/kernel.h>=0A=
+#include <linux/sched.h>=0A=
+#include <linux/string.h>=0A=
+#include <linux/timer.h>=0A=
+#include <linux/errno.h>=0A=
+#include <linux/proc_fs.h>=0A=
+#include <linux/in.h>=0A=
+#include <linux/ioport.h>=0A=
+#include <linux/slab.h>=0A=
+#include <linux/interrupt.h>=0A=
+#include <linux/init.h>=0A=
+#include <linux/netdevice.h>=0A=
+#include <linux/etherdevice.h>=0A=
+#include <linux/ethtool.h>=0A=
+#include <linux/skbuff.h>=0A=
+#include <linux/delay.h>=0A=
+#include <linux/ctype.h>=0A=
+#include <linux/mii.h>=0A=
+=0A=
+#include <asm/irq.h>=0A=
+#include <asm/bitops.h>=0A=
+#include <asm/io.h>=0A=
+#include <asm/uaccess.h>=0A=
+=0A=
+#include "rc32438_eth.h"=0A=
+#define DRIVER_VERSION "(July04)"=0A=
+=0A=
+#define DRIVER_NAME "rc32438 Ethernet driver. " DRIVER_VERSION=0A=
+=0A=
+=0A=
+#define STATION_ADDRESS_HIGH(dev) (((dev)->dev_addr[0] << 8) | \=0A=
+			           ((dev)->dev_addr[1]))=0A=
+#define STATION_ADDRESS_LOW(dev)  (((dev)->dev_addr[2] << 24) | \=0A=
+				   ((dev)->dev_addr[3] << 16) | \=0A=
+				   ((dev)->dev_addr[4] << 8)  | \=0A=
+				   ((dev)->dev_addr[5]))=0A=
+=0A=
+#define MII_CLOCK 1250000 				/* no more than 2.5MHz */=0A=
+static char mac0[18] =3D "08:00:06:05:40:01";=0A=
+static char mac1[18] =3D "08:00:06:05:50:01";=0A=
+=0A=
+MODULE_PARM(mac0, "c18");=0A=
+MODULE_PARM(mac1, "c18");=0A=
+MODULE_PARM_DESC(mac0, "MAC address for RC32438 ethernet0");=0A=
+MODULE_PARM_DESC(mac1, "MAC address for RC32438 ethernet1");=0A=
+=0A=
+static struct rc32438_if_t {=0A=
+	char *name;=0A=
+	struct net_device *dev;=0A=
+	int weight;=0A=
+	char* mac_str;=0A=
+	u32 iobase;=0A=
+	u32 rxdmabase;=0A=
+	u32 txdmabase;=0A=
+	int rx_dma_irq;=0A=
+	int tx_dma_irq;=0A=
+	int rx_ovr_irq;=0A=
+	int tx_und_irq;=0A=
+} rc32438_iflist[] =3D=0A=
+{=0A=
+	{=0A=
+		"rc32438_eth0",=0A=
+		NULL,=0A=
+		300,=0A=
+		mac0,=0A=
+		ETH0_PhysicalAddress,=0A=
+		ETH0_RX_DMA_ADDR,=0A=
+		ETH0_TX_DMA_ADDR,=0A=
+		ETH0_DMA_RX_IRQ,=0A=
+		ETH0_DMA_TX_IRQ,=0A=
+		ETH0_RX_OVR_IRQ,=0A=
+		ETH0_TX_UND_IRQ=0A=
+	},=0A=
+	{=0A=
+		"rc32438_eth1",=0A=
+		NULL,=0A=
+		300,=0A=
+		mac1,=0A=
+		ETH1_PhysicalAddress,=0A=
+		ETH1_RX_DMA_ADDR,=0A=
+		ETH1_TX_DMA_ADDR,=0A=
+		ETH1_DMA_RX_IRQ,=0A=
+		ETH1_DMA_TX_IRQ,=0A=
+		ETH1_RX_OVR_IRQ,=0A=
+		ETH1_TX_UND_IRQ=0A=
+	}=0A=
+};=0A=
+=0A=
+=0A=
+static int parse_mac_addr(struct net_device *dev, char* macstr)=0A=
+{=0A=
+	int i, j;=0A=
+	unsigned char result, value;=0A=
+=0A=
+	for (i=3D0; i<6; i++)=0A=
+	{=0A=
+		result =3D 0;=0A=
+		if (i !=3D 5 && *(macstr+2) !=3D ':')=0A=
+		{=0A=
+			ERR("invalid mac address format: %d %c\n",=0A=
+			    i, *(macstr+2));=0A=
+			return -EINVAL;=0A=
+		}=0A=
+		for (j=3D0; j<2; j++)=0A=
+		{=0A=
+			if (isxdigit(*macstr) && (value =3D isdigit(*macstr) ? *macstr-'0' =
:=0A=
+						  toupper(*macstr)-'A'+10) < 16)=0A=
+			{=0A=
+				result =3D result*16 + value;=0A=
+				macstr++;=0A=
+			}=0A=
+			else=0A=
+			{=0A=
+				ERR("invalid mac address "=0A=
+				    "character: %c\n", *macstr);=0A=
+				return -EINVAL;=0A=
+			}=0A=
+		}=0A=
+=0A=
+		macstr++;=0A=
+		dev->dev_addr[i] =3D result;=0A=
+	}=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+static inline void rc32438_abort_tx(struct net_device *dev)=0A=
+{=0A=
+	struct rc32438_local *lp =3D netdev_priv(dev);=0A=
+=0A=
+	rc32438_abort_dma(dev, lp->tx_dma_regs);=0A=
+=0A=
+}=0A=
+=0A=
+static inline void rc32438_abort_rx(struct net_device *dev)=0A=
+{=0A=
+	struct rc32438_local *lp =3D netdev_priv(dev);=0A=
+=0A=
+	rc32438_abort_dma(dev, lp->rx_dma_regs);=0A=
+=0A=
+}=0A=
+=0A=
+static inline void rc32438_start_tx(struct rc32438_local *lp,  =
volatile DMAD_t td)=0A=
+{=0A=
+	rc32438_start_dma(lp->tx_dma_regs, CPHYSADDR(td));=0A=
+}=0A=
+=0A=
+static inline void rc32438_start_rx(struct rc32438_local *lp, volatile =
DMAD_t rd)=0A=
+{=0A=
+	rc32438_start_dma(lp->rx_dma_regs, CPHYSADDR(rd));=0A=
+}=0A=
+=0A=
+static inline void rc32438_chain_tx(struct rc32438_local *lp, volatile =
DMAD_t td)=0A=
+{=0A=
+	rc32438_chain_dma(lp->tx_dma_regs, CPHYSADDR(td));=0A=
+}=0A=
+static inline void rc32438_chain_rx(struct rc32438_local *lp, volatile =
DMAD_t rd)=0A=
+{=0A=
+	rc32438_chain_dma(lp->rx_dma_regs, CPHYSADDR(rd));=0A=
+}=0A=
+=0A=
+#ifdef RC32438_PROC_DEBUG=0A=
+static int rc32438_read_proc(char *buf, char **start, off_t fpos,=0A=
+			     int length, int *eof, void *data)=0A=
+{=0A=
+	struct net_device *dev =3D (struct net_device *)data;=0A=
+=0A=
+	struct rc32438_local *lp =3D netdev_priv(dev);=0A=
+=0A=
+	int len =3D 0;=0A=
+=0A=
+	/* print out header */=0A=
+	len +=3D sprintf(buf + len, "\n\tRC32438 Ethernet Debug\n\n");=0A=
+=0A=
+ 	len +=3D sprintf (buf + len,=0A=
+			"DMA halt count  =3D %10d, DMA ovr count  =3D %10d\n",=0A=
+			lp->dma_halt_cnt,lp->dma_ovr_count);=0A=
+=0A=
+=0A=
+        len +=3D sprintf (buf + len,=0A=
+			"note_done_cnt   =3D %10d, DMA halt_nd_count =3D %10d\n",=0A=
+			lp->not_done_cnt,lp->dma_halt_nd_cnt);=0A=
+=0A=
+        len +=3D sprintf (buf + len,=0A=
+			"budget          =3D %10d, quota             =3D %10d\n",=0A=
+			lp->ibudget,lp->iquota);=0A=
+=0A=
+        len +=3D sprintf (buf + len,=0A=
+			"tx_stopped          =3D %10d, quota             =3D %10d\n",=0A=
+			lp->tx_stopped,lp->iquota);=0A=
+=0A=
+	if (fpos >=3D len)=0A=
+	{=0A=
+		*start =3D buf;=0A=
+		*eof =3D 1;=0A=
+		return 0;=0A=
+	}=0A=
+	*start =3D buf + fpos;=0A=
+=0A=
+	if ((len -=3D fpos) > length)=0A=
+		return length;=0A=
+	*eof =3D 1;=0A=
+=0A=
+	return len;=0A=
+=0A=
+}=0A=
+#endif=0A=
+=0A=
+/*=0A=
+ * Restart the RC32438 ethernet controller.=0A=
+ */=0A=
+static int rc32438_restart(struct net_device *dev)=0A=
+{=0A=
+	struct rc32438_local *lp =3D netdev_priv(dev);=0A=
+=0A=
+	/*=0A=
+	 * Disable interrupts=0A=
+	 */=0A=
+	disable_irq(lp->rx_irq);=0A=
+	disable_irq(lp->tx_irq);=0A=
+=0A=
+	/* Mask F E bit in Tx DMA */=0A=
+	rc32438_writel(rc32438_readl(&lp->tx_dma_regs->dmasm) | DMASM_f_m | =
DMASM_e_m, &lp->tx_dma_regs->dmasm);=0A=
+	/* Mask D H E bit in Rx DMA */=0A=
+	rc32438_writel(rc32438_readl(&lp->rx_dma_regs->dmasm) | DMASM_d_m | =
DMASM_h_m | DMASM_e_m, &lp->rx_dma_regs->dmasm);=0A=
+=0A=
+	rc32438_init(dev);=0A=
+	rc32438_multicast_list(dev);=0A=
+=0A=
+	enable_irq(lp->tx_irq);=0A=
+	enable_irq(lp->rx_irq);=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+int rc32438_init_module(void)=0A=
+{=0A=
+	int retval;=0A=
+=0A=
+	printk(KERN_INFO DRIVER_NAME " \n");=0A=
+=0A=
+	retval  =3D rc32438_probe(0);=0A=
+	retval |=3D rc32438_probe(1);=0A=
+=0A=
+	return retval;=0A=
+}=0A=
+=0A=
+static int rc32438_probe(int port_num)=0A=
+{=0A=
+	struct rc32438_if_t *bif =3D &rc32438_iflist[port_num];=0A=
+	struct rc32438_local *lp =3D NULL;=0A=
+	struct net_device *dev =3D NULL;=0A=
+	int i, retval,err;=0A=
+=0A=
+	dev =3D alloc_etherdev(sizeof(struct rc32438_local));=0A=
+	if(!dev)=0A=
+	{=0A=
+		ERR("rc32438_eth: alloc_etherdev failed\n");=0A=
+		return -1;=0A=
+	}=0A=
+=0A=
+	SET_MODULE_OWNER(dev);=0A=
+=0A=
+	bif->dev =3D dev;=0A=
+=0A=
+	if ((retval =3D parse_mac_addr(dev, bif->mac_str)))=0A=
+	{=0A=
+		ERR("MAC address parse failed\n");=0A=
+		free_netdev(dev);=0A=
+		return -1;=0A=
+	}=0A=
+=0A=
+	/* Initialize the device structure. */=0A=
+	if (dev->priv =3D=3D NULL)=0A=
+	{=0A=
+		lp =3D (struct rc32438_local *)kmalloc(sizeof(*lp), GFP_KERNEL);=0A=
+		memset(lp, 0, sizeof(struct rc32438_local));=0A=
+	}=0A=
+	else=0A=
+	{=0A=
+		lp =3D (struct rc32438_local *)dev->priv;=0A=
+	}=0A=
+=0A=
+	lp->rx_irq =3D bif->rx_dma_irq;=0A=
+	lp->tx_irq =3D bif->tx_dma_irq;=0A=
+=0A=
+	lp->weight =3D bif->weight;=0A=
+=0A=
+	lp->eth_regs =3D ioremap_nocache(bif->iobase, =
sizeof(*lp->eth_regs));=0A=
+=0A=
+	if (!lp->eth_regs)=0A=
+	{=0A=
+		ERR("Can't remap eth registers\n");=0A=
+		retval =3D -ENXIO;=0A=
+		goto probe_err_out;=0A=
+	}=0A=
+=0A=
+	lp->rx_dma_regs =3D ioremap_nocache(bif->rxdmabase, sizeof(struct =
DMA_Chan_s));=0A=
+=0A=
+	if (!lp->rx_dma_regs)=0A=
+	{=0A=
+		ERR("Can't remap Rx DMA registers\n");=0A=
+		retval =3D -ENXIO;=0A=
+		goto probe_err_out;=0A=
+	}=0A=
+	lp->tx_dma_regs =3D ioremap_nocache(bif->txdmabase,sizeof(struct =
DMA_Chan_s));=0A=
+=0A=
+	if (!lp->tx_dma_regs)=0A=
+	{=0A=
+		ERR("Can't remap Tx DMA registers\n");=0A=
+		retval =3D -ENXIO;=0A=
+		goto probe_err_out;=0A=
+	}=0A=
+=0A=
+#ifdef RC32438_PROC_DEBUG=0A=
+	lp->ps =3D create_proc_read_entry (bif->name, 0, proc_net,=0A=
+					 rc32438_read_proc, dev);=0A=
+#endif=0A=
+=0A=
+	lp->td_ring =3D	(DMAD_t)kmalloc(TD_RING_SIZE + RD_RING_SIZE, =
GFP_KERNEL);=0A=
+	if (!lp->td_ring)=0A=
+	{=0A=
+		ERR("Can't allocate descriptors\n");=0A=
+		retval =3D -ENOMEM;=0A=
+		goto probe_err_out;=0A=
+	}=0A=
+=0A=
+	dma_cache_inv((unsigned long)(lp->td_ring), TD_RING_SIZE + =
RD_RING_SIZE);=0A=
+=0A=
+	/* now convert TD_RING pointer to KSEG1 */=0A=
+	lp->td_ring =3D (DMAD_t )KSEG1ADDR(lp->td_ring);=0A=
+	lp->rd_ring =3D &lp->td_ring[RC32438_NUM_TDS];=0A=
+=0A=
+#ifdef CONFIG_SMP=0A=
+	spin_lock_init(&lp->lock);=0A=
+#endif=0A=
+	dev->base_addr =3D bif->iobase;=0A=
+	/* just use the rx dma irq */=0A=
+	dev->irq =3D bif->rx_dma_irq;=0A=
+=0A=
+	dev->priv =3D lp;=0A=
+=0A=
+	dev->open =3D rc32438_open;=0A=
+	dev->stop =3D rc32438_close;=0A=
+	dev->hard_start_xmit =3D rc32438_send_packet;=0A=
+	dev->get_stats	=3D rc32438_get_stats;=0A=
+	dev->set_multicast_list =3D &rc32438_multicast_list;=0A=
+	dev->tx_timeout =3D rc32438_tx_timeout;=0A=
+	dev->watchdog_timeo =3D RC32438_TX_TIMEOUT;=0A=
+=0A=
+	dev->poll =3D rc32438_poll;=0A=
+	dev->weight =3D lp->weight;=0A=
+=0A=
+	lp->tx_tasklet =3D kmalloc(sizeof(struct tasklet_struct), =
GFP_KERNEL);=0A=
+	tasklet_init(lp->tx_tasklet, rc32438_tx_tasklet, (unsigned =
long)dev);=0A=
+=0A=
+#ifdef CONFIG_RC32438_REVISION_ZA=0A=
+	lp->ovr_und_tasklet =3D kmalloc(sizeof(struct tasklet_struct), =
GFP_KERNEL);=0A=
+	tasklet_init(lp->ovr_und_tasklet, rc32438_ovr_und_tasklet, (unsigned =
long)dev);=0A=
+#endif=0A=
+=0A=
+	if ((err =3D register_netdev(dev))) {=0A=
+		printk(KERN_ERR "rc32438 ethernet. Cannot register net device %d\n", =
err);=0A=
+		free_netdev(dev);=0A=
+		retval =3D -EINVAL;=0A=
+		goto probe_err_out;=0A=
+	}=0A=
+=0A=
+	INFO("Rx IRQ %d, Tx IRQ %d, TDS %d RDS %d weight %d ",=0A=
+	     bif->rx_dma_irq, bif->tx_dma_irq,RC32438_NUM_TDS, =
RC32438_NUM_RDS,dev->weight);=0A=
+	for (i =3D 0; i < 6; i++)=0A=
+	{=0A=
+		printk("%2.2x", dev->dev_addr[i]);=0A=
+		if (i<5)=0A=
+			printk(":");=0A=
+	}=0A=
+	printk("\n");=0A=
+=0A=
+	return 0;=0A=
+=0A=
+ probe_err_out:=0A=
+	rc32438_cleanup_module();=0A=
+	ERR(" failed.  Returns %d\n", retval);=0A=
+	return retval;=0A=
+=0A=
+}=0A=
+=0A=
+=0A=
+static void rc32438_cleanup_module(void)=0A=
+{=0A=
+	int i;=0A=
+=0A=
+	for (i =3D 0; rc32438_iflist[i].iobase; i++)=0A=
+	{=0A=
+		struct rc32438_if_t * bif =3D &rc32438_iflist[i];=0A=
+		if (bif->dev !=3D NULL)=0A=
+		{=0A=
+			struct rc32438_local *lp =3D (struct rc32438_local =
*)bif->dev->priv;=0A=
+			if (lp !=3D NULL)=0A=
+			{=0A=
+				if (lp->eth_regs)=0A=
+					iounmap((void*)lp->eth_regs);=0A=
+				if (lp->rx_dma_regs)=0A=
+					iounmap((void*)lp->rx_dma_regs);=0A=
+				if (lp->tx_dma_regs)=0A=
+					iounmap((void*)lp->tx_dma_regs);=0A=
+				if (lp->td_ring)=0A=
+					kfree((void*)KSEG0ADDR(lp->td_ring));=0A=
+=0A=
+#ifdef RC32438_PROC_DEBUG=0A=
+				if (lp->ps)=0A=
+				{=0A=
+					remove_proc_entry(bif->name, proc_net);=0A=
+				}=0A=
+#endif=0A=
+				kfree(lp);=0A=
+			}=0A=
+=0A=
+			unregister_netdev(bif->dev);=0A=
+			free_netdev(bif->dev);=0A=
+			kfree(bif->dev);=0A=
+		}=0A=
+	}=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Open/initialize the RC32438 controller.=0A=
+ *=0A=
+ * This routine should set everything up anew at each open, even=0A=
+ *  registers that "should" only need to be set once at boot, so =
that=0A=
+ *  there is non-reboot way to recover if something goes wrong.=0A=
+ */=0A=
+=0A=
+static int rc32438_open(struct net_device *dev)=0A=
+{=0A=
+	struct rc32438_local *lp =3D netdev_priv(dev);=0A=
+=0A=
+	/* Initialize */=0A=
+	if (rc32438_init(dev))=0A=
+	{=0A=
+		ERR("Erroe: cannot open the Ethernet device\n");=0A=
+		return -EAGAIN;=0A=
+	}=0A=
+=0A=
+	/* Install the interrupt handler that handles the Done Finished Ovr =
and Und Events */=0A=
+	if (request_irq(lp->rx_irq, &rc32438_rx_dma_interrupt,=0A=
+			SA_INTERRUPT,=0A=
+			"rc32438 ethernet Rx", dev))=0A=
+	{=0A=
+		ERR(": unable to get Rx DMA IRQ %d\n",=0A=
+		    lp->rx_irq);=0A=
+		return -EAGAIN;=0A=
+	}=0A=
+	if (request_irq(lp->tx_irq, &rc32438_tx_dma_interrupt,=0A=
+			SA_INTERRUPT,=0A=
+			"rc32438 ethernet Tx", dev))=0A=
+	{=0A=
+		ERR(": unable to get Tx DMA IRQ %d\n",=0A=
+		    lp->tx_irq);=0A=
+		free_irq(lp->rx_irq, dev);=0A=
+		return -EAGAIN;=0A=
+	}=0A=
+=0A=
+	/*Start MII-PHY Timer*/=0A=
+	//Not enabled this feature at this time.=0A=
+	/*=0A=
+	  init_timer(&lp->mii_phy_timer);=0A=
+	  lp->mii_phy_timer.expires =3D jiffies + 10 * HZ;=0A=
+	  lp->mii_phy_timer.data =3D (unsigned long)dev;=0A=
+	  lp->mii_phy_timer.function	 =3D rc32438_mii_handler;=0A=
+	  add_timer(&lp->mii_phy_timer);=0A=
+	*/=0A=
+=0A=
+#ifdef RC32438_PROC_DEBUG=0A=
+	lp->dma_halt_cnt =3D 0;=0A=
+      	lp->dma_halt_nd_cnt =3D 0;=0A=
+	lp->not_done_cnt =3D 0;=0A=
+        lp->ibudget =3D 0;=0A=
+        lp->iquota  =3D 0;=0A=
+        lp->done_cnt    =3D0;=0A=
+        lp->firstTime =3D 0;=0A=
+	lp->tx_stopped =3D 0;=0A=
+#endif=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Close the RC32438 device=0A=
+ */=0A=
+static int rc32438_close(struct net_device *dev)=0A=
+{=0A=
+	struct rc32438_local *lp =3D netdev_priv(dev);=0A=
+	u32 tmp;=0A=
+=0A=
+	/* Disable interrupts */=0A=
+	disable_irq(lp->rx_irq);=0A=
+	disable_irq(lp->tx_irq);=0A=
+=0A=
+	tmp =3D rc32438_readl(&lp->tx_dma_regs->dmasm);=0A=
+	tmp =3D tmp | DMASM_f_m | DMASM_e_m;=0A=
+	rc32438_writel(tmp, &lp->tx_dma_regs->dmasm);=0A=
+=0A=
+	tmp =3D rc32438_readl(&lp->rx_dma_regs->dmasm);=0A=
+	tmp =3D tmp | DMASM_d_m | DMASM_h_m | DMASM_e_m;=0A=
+	rc32438_writel(tmp, &lp->rx_dma_regs->dmasm);=0A=
+=0A=
+	free_irq(lp->rx_irq, dev);=0A=
+	free_irq(lp->tx_irq, dev);=0A=
+=0A=
+	//Not enabled this feature at this time.=0A=
+	//del_timer(&lp->mii_phy_timer);=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+=0A=
+/* transmit packet */=0A=
+static int rc32438_send_packet(struct sk_buff *skb, struct net_device =
*dev)=0A=
+{=0A=
+	struct rc32438_local *lp =3D netdev_priv(dev);=0A=
+	unsigned long 			flags;=0A=
+	u32				length;=0A=
+	volatile DMAD_t				td;=0A=
+=0A=
+#ifdef CONFIG_SMP=0A=
+	spin_lock_irqsave(&lp->lock, flags);=0A=
+#else=0A=
+	local_irq_save(flags);=0A=
+#endif=0A=
+	td =3D &lp->td_ring[lp->tx_chain_tail];=0A=
+=0A=
+	/* stop queue when full, drop pkts if queue already full */=0A=
+	if(lp->tx_count >=3D (RC32438_NUM_TDS - 2))=0A=
+	{=0A=
+		lp->tx_full =3D 1;=0A=
+=0A=
+		if(lp->tx_count =3D=3D (RC32438_NUM_TDS - 2))=0A=
+		{=0A=
+			/* this pkt is about to fill the queue*/=0A=
+			lp->tx_stopped++;=0A=
+			netif_stop_queue(dev);=0A=
+		}=0A=
+		else=0A=
+		{=0A=
+			/* this pkt cannot be added to the full queue */=0A=
+			printk("Tx ring full, packet dropped\n");=0A=
+			lp->stats.tx_dropped++;=0A=
+			dev_kfree_skb_any(skb);=0A=
+#ifdef CONFIG_SMP=0A=
+			spin_unlock_irqrestore(&lp->lock, flags);=0A=
+#else=0A=
+			local_irq_restore(flags);=0A=
+#endif=0A=
+			return 1;=0A=
+		}=0A=
+	}=0A=
+=0A=
+	lp->tx_count ++;=0A=
+=0A=
+	lp->tx_skb[lp->tx_chain_tail] =3D skb;=0A=
+=0A=
+	length =3D skb->len;=0A=
+=0A=
+	/* Setup the transmit descriptor. */=0A=
+	td->ca =3D CPHYSADDR(skb->data);=0A=
+=0A=
+	if(rc32438_readl(&(lp->tx_dma_regs->dmandptr)) =3D=3D 0)=0A=
+	{=0A=
+		if( lp->tx_chain_status =3D=3D empty )=0A=
+		{=0A=
+			td->control =3D DMA_COUNT(length) |DMAD_cof_m |DMAD_iof_m;          =
                      /*  Update tail      */=0A=
+			lp->tx_chain_tail =3D (lp->tx_chain_tail + 1) & RC32438_TDS_MASK;   =
                       /*   Move tail       */=0A=
+			rc32438_writel(CPHYSADDR(&lp->td_ring[lp->tx_chain_head]), =
&(lp->tx_dma_regs->dmandptr)); /* Write to NDPTR    */=0A=
+			lp->tx_chain_head =3D lp->tx_chain_tail;                            =
                      /* Move head to tail */=0A=
+		}=0A=
+		else=0A=
+		{=0A=
+			td->control =3D DMA_COUNT(length) |DMAD_cof_m|DMAD_iof_m;           =
                      /* Update tail */=0A=
+			lp->td_ring[(lp->tx_chain_tail-1)& RC32438_TDS_MASK].control &=3D  =
~(DMAD_cof_m);          /* Link to prev */=0A=
+			lp->td_ring[(lp->tx_chain_tail-1)& RC32438_TDS_MASK].link =3D  =
CPHYSADDR(td);              /* Link to prev */=0A=
+			lp->tx_chain_tail =3D (lp->tx_chain_tail + 1) & RC32438_TDS_MASK;   =
                       /* Move tail */=0A=
+			rc32438_writel(CPHYSADDR(&lp->td_ring[lp->tx_chain_head]), =
&(lp->tx_dma_regs->dmandptr)); /* Write to NDPTR */=0A=
+			lp->tx_chain_head =3D lp->tx_chain_tail;                            =
                      /* Move head to tail */=0A=
+			lp->tx_chain_status =3D empty;=0A=
+		}=0A=
+	}=0A=
+	else=0A=
+	{=0A=
+		if( lp->tx_chain_status =3D=3D empty )=0A=
+		{=0A=
+			td->control =3D DMA_COUNT(length) |DMAD_cof_m |DMAD_iof_m;          =
                      /* Update tail */=0A=
+			lp->tx_chain_tail =3D (lp->tx_chain_tail + 1) & RC32438_TDS_MASK;   =
                       /* Move tail */=0A=
+			lp->tx_chain_status =3D filled;=0A=
+		}=0A=
+		else=0A=
+		{=0A=
+			td->control =3D DMA_COUNT(length) |DMAD_cof_m |DMAD_iof_m;          =
                      /* Update tail */=0A=
+			lp->td_ring[(lp->tx_chain_tail-1)& RC32438_TDS_MASK].control &=3D  =
~(DMAD_cof_m);          /* Link to prev */=0A=
+			lp->td_ring[(lp->tx_chain_tail-1)& RC32438_TDS_MASK].link =3D  =
CPHYSADDR(td);              /* Link to prev */=0A=
+			lp->tx_chain_tail =3D (lp->tx_chain_tail + 1) & RC32438_TDS_MASK;   =
                       /* Move tail */=0A=
+		}=0A=
+	}=0A=
+=0A=
+	dev->trans_start =3D jiffies;=0A=
+=0A=
+#ifdef CONFIG_SMP=0A=
+	spin_unlock_irqrestore(&lp->lock, flags);=0A=
+#else=0A=
+	local_irq_restore(flags);=0A=
+#endif=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+//Experimental, not enables right now=0A=
+=0A=
+#if 0=0A=
+/* Ethernet MII-PHY Handler */=0A=
+static void rc32438_mii_handler(unsigned long data)=0A=
+{=0A=
+	struct net_device *dev =3D (struct net_device *)data;=0A=
+	struct rc32438_local *lp =3D netdev_priv(dev);=0A=
+	unsigned long 	flags;=0A=
+	unsigned long duplex_status;=0A=
+	int port_addr =3D (lp->rx_irq =3D=3D 0x2c? 1:0) << 8;=0A=
+=0A=
+#ifdef CONFIG_SMP=0A=
+	spin_lock_irqsave(&lp->lock, flags);=0A=
+#else=0A=
+	local_irq_save(flags);=0A=
+#endif=0A=
+=0A=
+	/* Two ports are using the same MII, the difference is the PHY =
address */=0A=
+	rc32438_writel(0, &rc32438_eth0_regs->miimcfg);=0A=
+	rc32438_writel(0, &rc32438_eth0_regs->miimcmd);=0A=
+	rc32438_writel(port_addr |0x05, &rc32438_eth0_regs->miimaddr);=0A=
+	rc32438_writel(MIIMCMD_scn_m, &rc32438_eth0_regs->miimcmd);=0A=
+	while(rc32438_readl(&rc32438_eth0_regs->miimind) & MIIMIND_nv_m);=0A=
+=0A=
+	ERR("irq:%x		port_addr:%x	RDD:%x\n",=0A=
+	    lp->rx_irq, port_addr, =
rc32438_readl(&rc32438_eth0_regs->miimrdd));=0A=
+	duplex_status =3D (rc32438_readl(&rc32438_eth0_regs->miimrdd) & =
0x140)? ETHMAC2_fd_m: 0;=0A=
+	if(duplex_status !=3D lp->duplex_mode)=0A=
+	{=0A=
+		ERR("The MII-PHY is Auto-negotiated to %s-Duplex mode for Eth-%x\n", =
duplex_status? "Full":"Half", lp->rx_irq =3D=3D 0x2c? 1:0);=0A=
+		lp->duplex_mode =3D duplex_status;=0A=
+		rc32438_restart(dev);=0A=
+	}=0A=
+=0A=
+	lp->mii_phy_timer.expires =3D jiffies + 10 * HZ;=0A=
+	add_timer(&lp->mii_phy_timer);=0A=
+=0A=
+#ifdef CONFIG_SMP=0A=
+	spin_unlock_irqrestore(&lp->lock, flags);=0A=
+#else=0A=
+	local_irq_restore(flags);=0A=
+#endif=0A=
+=0A=
+}=0A=
+#endif=0A=
+=0A=
+=0A=
+#ifdef CONFIG_RC32438_REVISION_ZA=0A=
+static void rc32438_ovr_und_tasklet(unsigned long dev_id)=0A=
+{=0A=
+	struct net_device *dev =3D (struct net_device *)dev_id;=0A=
+	struct rc32438_local *lp =3D netdev_priv(dev);=0A=
+=0A=
+	unsigned int status;=0A=
+	unsigned long flags;=0A=
+=0A=
+	ASSERT(dev !=3D NULL);=0A=
+#ifdef CONFIG_SMP=0A=
+	spin_lock_irqsave(&lp->lock,flags);=0A=
+#else=0A=
+	local_irq_save(flags);=0A=
+#endif=0A=
+	status =3D rc32438_readl(&lp->eth_regs->ethintfc);=0A=
+=0A=
+	lp->dma_ovr_count++;=0A=
+	if(status & (ETHINTFC_und_m | ETHINTFC_ovr_m) )=0A=
+	{=0A=
+		netif_stop_queue(dev);=0A=
+=0A=
+		/* clear OVR bit */=0A=
+		rc32438_writel((status & ~(ETHINTFC_und_m | ETHINTFC_ovr_m)), =
&lp->eth_regs->ethintfc);=0A=
+=0A=
+		/* Restart interface */=0A=
+		rc32438_restart(dev);=0A=
+	}=0A=
+#ifdef CONFIG_SMP=0A=
+	spin_unlock_irqrestore(&lp->lock,flags);=0A=
+#else=0A=
+	local_irq_restore(flags);=0A=
+#endif=0A=
+}=0A=
+#endif=0A=
+/* Ethernet Rx DMA interrupt */=0A=
+static irqreturn_t=0A=
+rc32438_rx_dma_interrupt(int irq, void *dev_id, struct pt_regs * =
regs)=0A=
+{=0A=
+	struct net_device *dev =3D (struct net_device *)dev_id;=0A=
+	struct rc32438_local *lp =3D netdev_priv(dev);=0A=
+	volatile u32 dmas,dmasm;=0A=
+	irqreturn_t retval =3D IRQ_NONE;=0A=
+=0A=
+	ASSERT(dev !=3D NULL);=0A=
+=0A=
+#ifdef CONFIG_SMP=0A=
+	spin_lock(&lp->lock);=0A=
+#endif=0A=
+	dmas =3D rc32438_readl(&lp->rx_dma_regs->dmas);=0A=
+	if(dmas & (DMAS_d_m|DMAS_h_m|DMAS_e_m))=0A=
+	{=0A=
+		/* Mask D H E bit in Rx DMA */=0A=
+		dmasm =3D rc32438_readl(&lp->rx_dma_regs->dmasm);=0A=
+		rc32438_writel(dmasm | (DMASM_d_m | DMASM_h_m | DMASM_e_m), =
&lp->rx_dma_regs->dmasm);=0A=
+=0A=
+		if (dmas & DMAS_h_m){=0A=
+		  printk("DMA Halted\n");=0A=
+		  rc32438_restart(dev);=0A=
+		}=0A=
+		if(netif_rx_schedule_prep(dev))=0A=
+		  __netif_rx_schedule(dev);=0A=
+		=0A=
+		if (dmas & DMAS_e_m)=0A=
+		  ERR(": DMA error\n");=0A=
+=0A=
+		retval =3D IRQ_HANDLED;=0A=
+	}=0A=
+#ifdef CONFIG_SMP=0A=
+	spin_unlock(&lp->lock);=0A=
+#endif=0A=
+	return retval;=0A=
+}=0A=
+=0A=
+static int rc32438_poll(struct net_device *dev, int *budget)=0A=
+{=0A=
+	struct rc32438_local* lp =3D netdev_priv(dev);=0A=
+	volatile DMAD_t  rd;=0A=
+	u32 rx_next_done;=0A=
+	struct sk_buff *skb, *skb_new;=0A=
+	u8* pkt_buf;=0A=
+	u32 count, pkt_len, pktuncrc_len;=0A=
+	volatile u32 dmas,devcs;=0A=
+#ifdef CONFIG_RC32438_REVISION_ZA=0A=
+	volatile u32 ovr_und;=0A=
+#endif=0A=
+	u32 received =3D 0;=0A=
+	int rx_work_limit =3D 0;=0A=
+=0A=
+	rx_next_done  =3D lp->rx_next_done;=0A=
+	rd =3D &lp->rd_ring[rx_next_done];=0A=
+=0A=
+	rx_work_limit =3D min(*budget,dev->quota);=0A=
+=0A=
+        while ( (count =3D RC32438_RBSIZE - =
(u32)DMA_COUNT(rd->control)) !=3D 0)=0A=
+        {=0A=
+                if(--rx_work_limit <0)=0A=
+                {=0A=
+#ifdef RC32438_PROC_DEBUG=0A=
+                        if(lp->firstTime =3D=3D 0)=0A=
+                        {=0A=
+                                lp->ibudget =3D *budget;=0A=
+                                lp->iquota  =3D dev->quota;=0A=
+                                lp->firstTime =3D 1;=0A=
+                        }=0A=
+#endif=0A=
+			break;=0A=
+                }=0A=
+                /* init the var. used for the later operations within =
the while loop */=0A=
+                skb_new =3D NULL;=0A=
+                devcs =3D rd->devcs;=0A=
+                pkt_len =3D RCVPKT_LENGTH(devcs);=0A=
+		skb =3D lp->rx_skb[rx_next_done];=0A=
+=0A=
+		if ((devcs & ( ETHRX_ld_m)) !=3D	ETHRX_ld_m)=0A=
+		{=0A=
+			/* check that this is a whole packet */=0A=
+			/* WARNING: DMA_FD bit incorrectly set in Rc32438 (errata ref #077) =
*/=0A=
+			lp->stats.rx_errors++;=0A=
+			lp->stats.rx_dropped++;=0A=
+		}=0A=
+		else if (pkt_len < 64)=0A=
+		{=0A=
+			lp->stats.rx_errors++;=0A=
+			lp->stats.rx_dropped++;=0A=
+		}=0A=
+		else if ( (devcs & ETHRX_rok_m)  )=0A=
+		{=0A=
+			/* must be the (first and) last descriptor then */=0A=
+			pkt_buf =3D (u8*)lp->rx_skb[rx_next_done]->data;=0A=
+=0A=
+			pktuncrc_len =3D pkt_len - 4;=0A=
+			/* invalidate the cache */=0A=
+			dma_cache_inv((unsigned long)pkt_buf, pktuncrc_len);=0A=
+=0A=
+			/* Malloc up new buffer. */=0A=
+			skb_new =3D dev_alloc_skb(RC32438_RBSIZE + 2);=0A=
+=0A=
+			if (skb_new !=3D NULL)=0A=
+			{=0A=
+				/* Make room */=0A=
+				skb_put(skb, pktuncrc_len);=0A=
+=0A=
+				skb->protocol =3D eth_type_trans(skb, dev);=0A=
+=0A=
+				/* pass the packet to upper layers */=0A=
+				netif_receive_skb(skb);=0A=
+				dev->last_rx =3D jiffies;=0A=
+				lp->stats.rx_packets++;=0A=
+				lp->stats.rx_bytes +=3D pktuncrc_len;=0A=
+=0A=
+				if (IS_RCV_MP(devcs))=0A=
+					lp->stats.multicast++;=0A=
+=0A=
+				/* 16 bit align */=0A=
+				skb_reserve(skb_new, 2);=0A=
+=0A=
+				skb_new->dev =3D dev;=0A=
+				lp->rx_skb[rx_next_done] =3D skb_new;=0A=
+				received++;=0A=
+			}=0A=
+			else=0A=
+			{=0A=
+				ERR("no memory, dropping rx packet.\n");=0A=
+				lp->stats.rx_errors++;=0A=
+				lp->stats.rx_dropped++;=0A=
+			}=0A=
+		}=0A=
+		else=0A=
+		{=0A=
+			/* This should only happen if we enable accepting broken packets =
*/=0A=
+			lp->stats.rx_errors++;=0A=
+			lp->stats.rx_dropped++;=0A=
+=0A=
+			/* add statistics counters */=0A=
+			if (IS_RCV_CRC_ERR(devcs))=0A=
+			{=0A=
+				DBG(2, "RX CRC error\n");=0A=
+				lp->stats.rx_crc_errors++;=0A=
+			}=0A=
+			else if (IS_RCV_LOR_ERR(devcs))=0A=
+			{=0A=
+				DBG(2, "RX LOR error\n");=0A=
+				lp->stats.rx_length_errors++;=0A=
+			}=0A=
+			else if (IS_RCV_LE_ERR(devcs))=0A=
+			{=0A=
+				DBG(2, "RX LE error\n");=0A=
+				lp->stats.rx_length_errors++;=0A=
+			}=0A=
+			else if (IS_RCV_OVR_ERR(devcs))=0A=
+			{=0A=
+				/*=0A=
+				 * The overflow errors are handled through=0A=
+				 * an interrupt handler.=0A=
+				 */=0A=
+				lp->stats.rx_over_errors++;=0A=
+			}=0A=
+			else if (IS_RCV_CV_ERR(devcs))=0A=
+			{=0A=
+				/* code violation */=0A=
+				DBG(2, "RX CV error\n");=0A=
+				lp->stats.rx_frame_errors++;=0A=
+			}=0A=
+			else if (IS_RCV_CES_ERR(devcs))=0A=
+			{=0A=
+				DBG(2, "RX Preamble error\n");=0A=
+			}=0A=
+		}=0A=
+=0A=
+		rd->devcs =3D 0;=0A=
+=0A=
+		/* restore descriptor's curr_addr */=0A=
+		if(skb_new)=0A=
+			rd->ca =3D CPHYSADDR(skb_new->data);=0A=
+		else=0A=
+			rd->ca =3D CPHYSADDR(skb->data);=0A=
+=0A=
+		rd->control =3D DMA_COUNT(RC32438_RBSIZE) |DMAD_cod_m =
|DMAD_iod_m;=0A=
+=0A=
+		/* There is a race condition here. See below */=0A=
+		lp->rd_ring[(rx_next_done-1)& RC32438_RDS_MASK].control &=3D  =
~(DMAD_cod_m);=0A=
+=0A=
+		rx_next_done =3D (rx_next_done + 1) & RC32438_RDS_MASK;=0A=
+		rd =3D &lp->rd_ring[rx_next_done];=0A=
+		rc32438_writel(~DMAS_d_m, &lp->rx_dma_regs->dmas);=0A=
+	}=0A=
+=0A=
+	dev->quota -=3D received;=0A=
+	*budget =3D- received;=0A=
+=0A=
+	lp->rx_next_done =3D rx_next_done;=0A=
+	if(rx_work_limit < 0)=0A=
+		goto not_done;=0A=
+=0A=
+	dmas =3D rc32438_readl(&lp->rx_dma_regs->dmas);=0A=
+=0A=
+#if 0=0A=
+	if(dmas & DMAS_h_m)=0A=
+	{=0A=
+#ifdef CONFIG_RC32438_REVISION_ZA=0A=
+		ovr_und =3D rc32438_readl(&lp->eth_regs->ethintfc);=0A=
+		if(ovr_und & (ETHINTFC_ovr_m | ETHINTFC_und_m))=0A=
+			goto over_under_flow;=0A=
+#endif=0A=
+=0A=
+#ifdef RC32438_PROC_DEBUG=0A=
+		lp->dma_halt_cnt++;=0A=
+#endif=0A=
+=0A=
+/**********************************************************************=
*************=0A=
+  There is a race condition here. Imagine software completed =
processing 0 descriptor=0A=
+  and is updating the control field of N-1 descriptor. At the same =
time, DMA =0A=
+  processed N-1 descriptor and is also updating the descriptor. If =
Software is=0A=
+  updating the descriptor after DMA, the D bit in the descriptor gets =
cleared,=0A=
+  though DMA has set it and halted. Now, when Software arrives to N-1, =
it sees=0A=
+  D bit not being set. However, it finds the DMA halted. The Software, =
in order=0A=
+  to start the DMA again, loads this descriptor. Though the control =
field of=0A=
+  this descriptor is fine, the devcs and ca fields are wrong. Hence, =
the software=0A=
+  needs to update those fields before loading DMA.=0A=
+***********************************************************************=
************/=0A=
+		rd->devcs =3D 0;=0A=
+		skb =3D lp->rx_skb[rx_next_done];=0A=
+		rd->ca =3D CPHYSADDR(skb->data);=0A=
+		rc32438_chain_rx(lp,rd);=0A=
+	}=0A=
+#endif=0A=
+=0A=
+	rc32438_writel( ~(DMAS_h_m | DMAS_e_m), &lp->rx_dma_regs->dmas);=0A=
+=0A=
+	netif_rx_complete(dev);=0A=
+	/* Enable D H E bit in Rx DMA */=0A=
+	rc32438_writel(rc32438_readl(&lp->rx_dma_regs->dmasm) & ~(DMASM_d_m | =
DMASM_h_m |DMASM_e_m), &lp->rx_dma_regs->dmasm);=0A=
+=0A=
+	return 0;=0A=
+=0A=
+ not_done:=0A=
+#ifdef RC32438_PROC_DEBUG=0A=
+	lp->not_done_cnt++;=0A=
+#endif=0A=
+	return 1;=0A=
+=0A=
+#ifdef CONFIG_RC32438_REVISION_ZA=0A=
+ over_under_flow:=0A=
+ 	netif_rx_complete(dev);=0A=
+	tasklet_hi_schedule(lp->ovr_und_tasklet);=0A=
+	return 0;=0A=
+#endif=0A=
+}=0A=
+=0A=
+/* Ethernet Tx DMA interrupt */=0A=
+static irqreturn_t=0A=
+rc32438_tx_dma_interrupt(int irq, void *dev_id, struct pt_regs * =
regs)=0A=
+{=0A=
+	struct net_device *dev =3D (struct net_device *)dev_id;=0A=
+	struct rc32438_local *lp =3D netdev_priv(dev);=0A=
+	volatile u32 dmas,dmasm;=0A=
+	irqreturn_t retval =3D IRQ_NONE;=0A=
+=0A=
+	ASSERT(dev !=3D NULL);=0A=
+=0A=
+//	spin_lock(&lp->lock);=0A=
+=0A=
+	dmas =3D rc32438_readl(&lp->tx_dma_regs->dmas);=0A=
+=0A=
+	if (dmas & (DMAS_f_m | DMAS_e_m))=0A=
+	{=0A=
+		dmasm =3D rc32438_readl(&lp->tx_dma_regs->dmasm);=0A=
+		/* Mask F E bit in Tx DMA */=0A=
+		rc32438_writel(dmasm | (DMASM_f_m | DMASM_e_m), =
&lp->tx_dma_regs->dmasm);=0A=
+=0A=
+		tasklet_schedule(lp->tx_tasklet);=0A=
+=0A=
+		if(lp->tx_chain_status =3D=3D filled && =
(rc32438_readl(&(lp->tx_dma_regs->dmandptr)) =3D=3D 0))=0A=
+		{=0A=
+			rc32438_writel(CPHYSADDR(&lp->td_ring[lp->tx_chain_head]), =
&(lp->tx_dma_regs->dmandptr));=0A=
+			lp->tx_chain_status =3D empty;=0A=
+			lp->tx_chain_head =3D lp->tx_chain_tail;=0A=
+			dev->trans_start =3D jiffies;=0A=
+		}=0A=
+=0A=
+		if (dmas & DMAS_e_m)=0A=
+			ERR(": DMA error\n");=0A=
+=0A=
+		retval =3D IRQ_HANDLED;=0A=
+	}=0A=
+=0A=
+//	spin_unlock(&lp->lock);=0A=
+=0A=
+	return retval;=0A=
+}=0A=
+=0A=
+static void rc32438_tx_tasklet(unsigned long tx_data_dev)=0A=
+{=0A=
+        struct net_device *dev =3D (struct net_device =
*)tx_data_dev;=0A=
+	struct rc32438_local *lp =3D netdev_priv(dev);=0A=
+        volatile DMAD_t td =3D &lp->td_ring[lp->tx_next_done];=0A=
+        unsigned long   flags;=0A=
+        volatile u32 dmas;=0A=
+        volatile u32 devcs;=0A=
+=0A=
+	u32 tx_next_done =3D lp->tx_next_done;=0A=
+#ifdef CONFIG_SMP=0A=
+        spin_lock_irqsave(&lp->lock, flags);=0A=
+#else=0A=
+	local_irq_save(flags);=0A=
+#endif=0A=
+=0A=
+        /* process all desc that are done */=0A=
+        while(IS_DMA_FINISHED(td->control))=0A=
+        {=0A=
+                if(lp->tx_full =3D=3D 1)=0A=
+                {=0A=
+                        netif_wake_queue(dev);=0A=
+                        lp->tx_full =3D 0;=0A=
+                }=0A=
+=0A=
+                devcs =3D lp->td_ring[tx_next_done].devcs;=0A=
+                if ((devcs & (ETHTX_fd_m | ETHTX_ld_m)) !=3D =
(ETHTX_fd_m | ETHTX_ld_m))=0A=
+                {=0A=
+                        lp->stats.tx_errors++;=0A=
+                        lp->stats.tx_dropped++;=0A=
+=0A=
+                        /* should never happen */=0A=
+                        DBG(1, __FUNCTION__ ": split tx =
ignored\n");=0A=
+                }=0A=
+                else if (IS_TX_TOK(devcs))=0A=
+                {=0A=
+                        /* transmit OK */=0A=
+                        lp->stats.tx_packets++;=0A=
+                }=0A=
+                else=0A=
+                {=0A=
+                        lp->stats.tx_errors++;=0A=
+                        lp->stats.tx_dropped++;=0A=
+=0A=
+                        /* underflow */=0A=
+                        if (IS_TX_UND_ERR(devcs))=0A=
+                                lp->stats.tx_fifo_errors++;=0A=
+=0A=
+                        /* oversized frame */=0A=
+                        if (IS_TX_OF_ERR(devcs))=0A=
+                                lp->stats.tx_aborted_errors++;=0A=
+=0A=
+                        /* excessive deferrals */=0A=
+                        if (IS_TX_ED_ERR(devcs))=0A=
+                                lp->stats.tx_carrier_errors++;=0A=
+=0A=
+                        /* collisions: medium busy */=0A=
+                        if (IS_TX_EC_ERR(devcs))=0A=
+                                lp->stats.collisions++;=0A=
+=0A=
+                        /* late collision */=0A=
+                        if (IS_TX_LC_ERR(devcs))=0A=
+                                lp->stats.tx_window_errors++;=0A=
+=0A=
+                }=0A=
+=0A=
+                /* We must always free the original skb */=0A=
+                if (lp->tx_skb[tx_next_done] !=3D NULL)=0A=
+                {=0A=
+                        =
dev_kfree_skb_any(lp->tx_skb[tx_next_done]);=0A=
+                        lp->tx_skb[tx_next_done] =3D NULL;=0A=
+                }=0A=
+=0A=
+                lp->td_ring[tx_next_done].control =3D DMAD_iof_m;=0A=
+                lp->td_ring[tx_next_done].devcs =3D ETHTX_fd_m | =
ETHTX_ld_m;=0A=
+                lp->td_ring[tx_next_done].link =3D 0;=0A=
+                lp->td_ring[tx_next_done].ca =3D 0;=0A=
+                lp->tx_count --;=0A=
+=0A=
+                /* go on to next transmission */=0A=
+                tx_next_done =3D (tx_next_done + 1) & =
RC32438_TDS_MASK;=0A=
+                td =3D &lp->td_ring[tx_next_done];=0A=
+=0A=
+        }=0A=
+	lp->tx_next_done =3D tx_next_done;=0A=
+        dmas =3D rc32438_readl(&lp->tx_dma_regs->dmas);=0A=
+	rc32438_writel( ~dmas, &lp->tx_dma_regs->dmas);=0A=
+=0A=
+        /* Enable F E bit in Tx DMA */=0A=
+        rc32438_writel(rc32438_readl(&lp->tx_dma_regs->dmasm) & =
~(DMASM_f_m | DMASM_e_m), &lp->tx_dma_regs->dmasm);=0A=
+#ifdef CONFIG_SMP=0A=
+        spin_unlock_irqrestore(&lp->lock, flags);=0A=
+#else=0A=
+	local_irq_restore(flags);=0A=
+#endif=0A=
+}=0A=
+/*=0A=
+ * Get the current statistics.=0A=
+ * This may be called with the device open or closed.=0A=
+ */=0A=
+static struct net_device_stats * rc32438_get_stats(struct net_device =
*dev)=0A=
+{=0A=
+	struct rc32438_local *lp =3D netdev_priv(dev);=0A=
+	return &lp->stats;=0A=
+}=0A=
+=0A=
+=0A=
+/*=0A=
+ * Set or clear the multicast filter for this adaptor.=0A=
+ */=0A=
+static void rc32438_multicast_list(struct net_device *dev)=0A=
+{=0A=
+	/* listen to broadcasts always and to treat 	*/=0A=
+	/*       IFF bits independantly	*/=0A=
+=0A=
+	struct rc32438_local *lp =3D netdev_priv(dev);=0A=
+	unsigned long flags;=0A=
+	u32 recognise =3D ETHARC_ab_m; 		/* always accept broadcasts */=0A=
+=0A=
+	if (dev->flags & IFF_PROMISC)         		/* set promiscuous mode */=0A=
+		recognise |=3D ETHARC_pro_m;=0A=
+=0A=
+	if ((dev->flags & IFF_ALLMULTI) || (dev->mc_count > 15))=0A=
+		recognise |=3D ETHARC_am_m;    	  	/* all multicast & bcast */=0A=
+	else if (dev->mc_count > 0)=0A=
+	{=0A=
+		DBG(2, __FUNCTION__ ": mc_count %d\n", dev->mc_count);=0A=
+		recognise |=3D ETHARC_am_m;    	  	/* for the time being */=0A=
+	}=0A=
+=0A=
+#ifdef CONFIG_SMP=0A=
+	spin_lock_irqsave(&lp->lock, flags);=0A=
+#else=0A=
+	local_irq_save(flags);=0A=
+#endif=0A=
+	rc32438_writel(recognise, &lp->eth_regs->etharc);=0A=
+#ifdef CONFIG_SMP=0A=
+	spin_unlock_irqrestore(&lp->lock, flags);=0A=
+#else=0A=
+	local_irq_restore(flags);=0A=
+#endif=0A=
+}=0A=
+=0A=
+=0A=
+static void rc32438_tx_timeout(struct net_device *dev)=0A=
+{=0A=
+	unsigned long flags;=0A=
+=0A=
+#ifdef CONFIG_SMP=0A=
+	struct rc32438_local *lp =3D netdev_priv(dev);=0A=
+	spin_lock_irqsave(&lp->lock, flags);=0A=
+#else=0A=
+	local_irq_save(flags);=0A=
+#endif=0A=
+	rc32438_restart(dev);=0A=
+#ifdef CONFIG_SMP=0A=
+	spin_unlock_irqrestore(&lp->lock, flags);=0A=
+#else=0A=
+	local_irq_restore(flags);=0A=
+#endif=0A=
+=0A=
+}=0A=
+=0A=
+=0A=
+/*=0A=
+ * Initialize the RC32438 ethernet controller.=0A=
+ */=0A=
+static int rc32438_init(struct net_device *dev)=0A=
+{=0A=
+	struct rc32438_local *lp =3D netdev_priv(dev);=0A=
+	int i, j;=0A=
+=0A=
+	/* Disable DMA */=0A=
+	rc32438_abort_tx(dev);=0A=
+	rc32438_abort_rx(dev);=0A=
+=0A=
+	/* reset ethernet logic */=0A=
+	rc32438_writel(0, &lp->eth_regs->ethintfc);=0A=
+	while((rc32438_readl(&lp->eth_regs->ethintfc) & ETHINTFC_rip_m))=0A=
+		dev->trans_start =3D jiffies;=0A=
+=0A=
+	/* Enable Ethernet Interface */=0A=
+	rc32438_writel(ETHINTFC_en_m, &lp->eth_regs->ethintfc);=0A=
+#ifdef CONFIG_RC32438_REVISION_ZA=0A=
+	tasklet_disable(lp->ovr_und_tasklet);=0A=
+#endif=0A=
+	tasklet_disable(lp->tx_tasklet);=0A=
+=0A=
+	/* Initialize the transmit Descriptors */=0A=
+	for (i =3D 0; i < RC32438_NUM_TDS; i++)=0A=
+	{=0A=
+		lp->td_ring[i].control =3D DMAD_iof_m;=0A=
+		lp->td_ring[i].devcs =3D ETHTX_fd_m | ETHTX_ld_m;=0A=
+		lp->td_ring[i].ca =3D 0;=0A=
+		lp->td_ring[i].link =3D 0;=0A=
+		if (lp->tx_skb[i] !=3D NULL)=0A=
+		{=0A=
+			/* free dangling skb */=0A=
+			dev_kfree_skb_any(lp->tx_skb[i]);=0A=
+			lp->tx_skb[i] =3D NULL;=0A=
+		}=0A=
+	}=0A=
+	lp->tx_next_done =3D lp->tx_chain_head =3D lp->tx_chain_tail =3D 	=
lp->tx_full =3D lp->tx_count =3D 0;=0A=
+	lp->tx_chain_status =3D empty;=0A=
+=0A=
+	/*=0A=
+	 * Initialize the receive descriptors so that they=0A=
+	 * become a circular linked list, ie. let the last=0A=
+	 * descriptor point to the first again.=0A=
+	 */=0A=
+	for (i=3D0; i<RC32438_NUM_RDS; i++)=0A=
+	{=0A=
+		struct sk_buff *skb =3D lp->rx_skb[i];=0A=
+=0A=
+		if (lp->rx_skb[i] =3D=3D NULL)=0A=
+		{=0A=
+			skb =3D dev_alloc_skb(RC32438_RBSIZE + 2);=0A=
+			if (skb =3D=3D NULL)=0A=
+			{=0A=
+				ERR("No memory in the system\n");=0A=
+				for (j =3D 0; j < RC32438_NUM_RDS; j ++)=0A=
+					if (lp->rx_skb[j] !=3D NULL)=0A=
+						dev_kfree_skb_any(lp->rx_skb[j]);=0A=
+=0A=
+				return 1;=0A=
+			}=0A=
+			else=0A=
+			{=0A=
+				skb->dev =3D dev;=0A=
+				skb_reserve(skb, 2);=0A=
+				lp->rx_skb[i] =3D skb;=0A=
+				lp->rd_ring[i].ca =3D CPHYSADDR(skb->data);=0A=
+=0A=
+			}=0A=
+		}=0A=
+		lp->rd_ring[i].control =3D	DMAD_iod_m | =
DMA_COUNT(RC32438_RBSIZE);=0A=
+		lp->rd_ring[i].devcs =3D 0;=0A=
+		lp->rd_ring[i].ca =3D CPHYSADDR(skb->data);=0A=
+		lp->rd_ring[i].link =3D CPHYSADDR(&lp->rd_ring[i+1]);=0A=
+=0A=
+	}=0A=
+	/* loop back */=0A=
+	lp->rd_ring[RC32438_NUM_RDS-1].link =3D =
CPHYSADDR(&lp->rd_ring[0]);=0A=
+	lp->rx_next_done   =3D 0;=0A=
+=0A=
+	lp->rd_ring[RC32438_NUM_RDS-1].control |=3D DMAD_cod_m;=0A=
+	lp->rx_chain_head =3D 0;=0A=
+	lp->rx_chain_tail =3D 0;=0A=
+	lp->rx_chain_status =3D empty;=0A=
+=0A=
+	rc32438_writel(0, &lp->rx_dma_regs->dmas);=0A=
+	/* Start Rx DMA */=0A=
+	rc32438_start_rx(lp, &lp->rd_ring[0]);=0A=
+=0A=
+	/* Enable F E bit in Tx DMA */=0A=
+	rc32438_writel(rc32438_readl(&lp->tx_dma_regs->dmasm) & ~(DMASM_f_m | =
DMASM_e_m), &lp->tx_dma_regs->dmasm);=0A=
+	/* Enable D H E bit in Rx DMA */=0A=
+	rc32438_writel(rc32438_readl(&lp->rx_dma_regs->dmasm) & ~(DMASM_d_m | =
DMASM_h_m | DMASM_e_m), &lp->rx_dma_regs->dmasm);=0A=
+=0A=
+	/* Accept only packets destined for this Ethernet device address =
*/=0A=
+	rc32438_writel(ETHARC_ab_m, &lp->eth_regs->etharc);=0A=
+=0A=
+	/* Set all Ether station address registers to their initial values =
*/=0A=
+	rc32438_writel(STATION_ADDRESS_LOW(dev), &lp->eth_regs->ethsal0);=0A=
+	rc32438_writel(STATION_ADDRESS_HIGH(dev), &lp->eth_regs->ethsah0);=0A=
+=0A=
+	rc32438_writel(STATION_ADDRESS_LOW(dev), &lp->eth_regs->ethsal1);=0A=
+	rc32438_writel(STATION_ADDRESS_HIGH(dev), &lp->eth_regs->ethsah1);=0A=
+=0A=
+	rc32438_writel(STATION_ADDRESS_LOW(dev), &lp->eth_regs->ethsal2);=0A=
+	rc32438_writel(STATION_ADDRESS_HIGH(dev), &lp->eth_regs->ethsah2);=0A=
+=0A=
+	rc32438_writel(STATION_ADDRESS_LOW(dev), &lp->eth_regs->ethsal3);=0A=
+	rc32438_writel(STATION_ADDRESS_HIGH(dev), &lp->eth_regs->ethsah3);=0A=
+=0A=
+=0A=
+	/* Frame Length Checking, Pad Enable, CRC Enable, Full Duplex set =
*/=0A=
+	rc32438_writel(ETHMAC2_pe_m | ETHMAC2_cen_m | ETHMAC2_fd_m, =
&lp->eth_regs->ethmac2);=0A=
+	//ETHMAC2_flc_m		ETHMAC2_fd_m	lp->duplex_mode=0A=
+=0A=
+	/* Back to back inter-packet-gap */=0A=
+	rc32438_writel(0x15, &lp->eth_regs->ethipgt);=0A=
+	/* Non - Back to back inter-packet-gap */=0A=
+	rc32438_writel(0x12, &lp->eth_regs->ethipgr);=0A=
+=0A=
+	/* Management Clock Prescaler Divisor */=0A=
+	/* Clock independent setting */=0A=
+	rc32438_writel(((idt_cpu_freq)/MII_CLOCK+1) & ~1,=0A=
+		       &lp->eth_regs->ethmcp);=0A=
+=0A=
+	/* don't transmit until fifo contains 48b */=0A=
+	rc32438_writel(48, &lp->eth_regs->ethfifott);=0A=
+=0A=
+	rc32438_writel(ETHMAC1_re_m, &lp->eth_regs->ethmac1);=0A=
+=0A=
+#ifdef CONFIG_RC32438_REVISION_ZA=0A=
+	tasklet_enable(lp->ovr_und_tasklet);=0A=
+#endif=0A=
+	tasklet_enable(lp->tx_tasklet);=0A=
+=0A=
+	netif_start_queue(dev);=0A=
+=0A=
+=0A=
+	return 0;=0A=
+=0A=
+}=0A=
+=0A=
+=0A=
+#ifndef MODULE=0A=
+=0A=
+static int __init rc32438_setup(char *options)=0A=
+{=0A=
+	/* no options yet */=0A=
+	return 1;=0A=
+}=0A=
+=0A=
+static int __init rc32438_setup_ethaddr0(char *options)=0A=
+{=0A=
+	memcpy(mac0, options, 17);=0A=
+	mac0[17]=3D '\0';=0A=
+	return 1;=0A=
+}=0A=
+=0A=
+static int __init rc32438_setup_ethaddr1(char *options)=0A=
+{=0A=
+	memcpy(mac1, options, 17);=0A=
+	mac1[17]=3D '\0';=0A=
+	return 1;=0A=
+}=0A=
+=0A=
+__setup("rc32438eth=3D", rc32438_setup);=0A=
+__setup("ethaddr0=3D", rc32438_setup_ethaddr0);=0A=
+__setup("ethaddr1=3D", rc32438_setup_ethaddr1);=0A=
+=0A=
+=0A=
+#endif /* MODULE */=0A=
+=0A=
+module_init(rc32438_init_module);=0A=
+module_exit(rc32438_cleanup_module);=0A=
+=0A=
+=0A=
+=0A=
+=0A=
+=0A=
+=0A=
+=0A=
+=0A=
+=0A=
+=0A=
+=0A=
+=0A=
+=0A=
+=0A=
diff -uNr linux-2.6.16-rc5/drivers/net/rc32438_eth.h =
acacia/drivers/net/rc32438_eth.h=0A=
--- linux-2.6.16-rc5/drivers/net/rc32438_eth.h	1969-12-31 =
16:00:00.000000000 -0800=0A=
+++ acacia/drivers/net/rc32438_eth.h	2006-03-14 14:38:23.000000000 =
-0800=0A=
@@ -0,0 +1,183 @@=0A=
+/**********************************************************************=
****=0A=
+ *=0A=
+ *  BRIEF MODULE DESCRIPTION=0A=
+ *     Definitions for IDT RC32438 on-chip ethernet controller.=0A=
+ *=0A=
+ *  Copyright 2006 IDT Inc. (rischelp@idt.com)=0A=
+ *=0A=
+ *  This program is free software; you can redistribute  it and/or =
modify it=0A=
+ *  under  the terms of  the GNU General  Public License as published =
by the=0A=
+ *  Free Software Foundation;  either version 2 of the  License, or =
(at your=0A=
+ *  option) any later version.=0A=
+ *=0A=
+ *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR =
IMPLIED=0A=
+ *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED =
WARRANTIES OF=0A=
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE =
DISCLAIMED.  IN=0A=
+ *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, =
INDIRECT,=0A=
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES =
(INCLUDING, BUT=0A=
+ *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; =
LOSS OF=0A=
+ *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED =
AND ON=0A=
+ *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, =
OR TORT=0A=
+ *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE =
USE OF=0A=
+ *  THIS SOFTWARE, EVEN IF ADVISED OF THEg POSSIBILITY OF SUCH =
DAMAGE.=0A=
+ *=0A=
+ *  You should have received a copy of the  GNU General Public License =
along=0A=
+ *  with this program; if not, write  to the Free Software Foundation, =
Inc.,=0A=
+ *  675 Mass Ave, Cambridge, MA 02139, USA.=0A=
+ *=0A=
+ *=0A=
+ =
************************************************************************=
**=0A=
+ */=0A=
+=0A=
+#include  <asm/idt-boards/rc32438/rc32438.h>=0A=
+#include  <asm/idt-boards/rc32438/rc32438_dma_v.h>=0A=
+#include  <asm/idt-boards/rc32438/rc32438_eth_v.h>=0A=
+=0A=
+#define RC32438_PROC_DEBUG=0A=
+//#define RC32438_DEBUG	2=0A=
+=0A=
+#ifdef RC32438_DEBUG=0A=
+=0A=
+/* use 0 for production, 1 for verification, >2 for debug */=0A=
+static int rc32438_debug =3D RC32438_DEBUG;=0A=
+#define ASSERT(expr) \=0A=
+	if(!(expr)) {	\=0A=
+		printk( "Assertion failed! %s,%s,%s,line=3D%d\n",	\=0A=
+		#expr,__FILE__,__FUNCTION__,__LINE__);		}=0A=
+#define DBG(lvl, format, arg...) if (rc32438_debug > lvl) =
printk(KERN_INFO "%s: " format, dev->name , ## arg)=0A=
+#else=0A=
+#define ASSERT(expr) do {} while (0)=0A=
+#define DBG(lvl, format, arg...) do {} while (0)=0A=
+#endif=0A=
+=0A=
+#define INFO(format, arg...) printk(KERN_INFO "%s: " format, dev->name =
, ## arg)=0A=
+#define ERR(format, arg...) printk(KERN_ERR "%s: " format, dev->name , =
## arg)=0A=
+#define WARN(format, arg...) printk(KERN_WARNING "%s: " format, =
dev->name , ## arg)=0A=
+=0A=
+#define ETH0_DMA_RX_IRQ   GROUP1_IRQ_BASE + 2=0A=
+#define ETH0_DMA_TX_IRQ   GROUP1_IRQ_BASE + 3=0A=
+#define ETH0_RX_OVR_IRQ   GROUP3_IRQ_BASE + 12=0A=
+#define ETH0_TX_UND_IRQ   GROUP3_IRQ_BASE + 13=0A=
+#define ETH1_DMA_RX_IRQ   GROUP1_IRQ_BASE + 4=0A=
+#define ETH1_DMA_TX_IRQ   GROUP1_IRQ_BASE + 5=0A=
+#define ETH1_RX_OVR_IRQ   GROUP3_IRQ_BASE + 15=0A=
+#define ETH1_TX_UND_IRQ   GROUP3_IRQ_BASE + 16=0A=
+=0A=
+#define ETH0_RX_DMA_ADDR  (DMA0_PhysicalAddress + =
2*DMA_CHAN_OFFSET)=0A=
+#define ETH0_TX_DMA_ADDR  (DMA0_PhysicalAddress + =
3*DMA_CHAN_OFFSET)=0A=
+#define ETH1_RX_DMA_ADDR  (DMA0_PhysicalAddress + =
4*DMA_CHAN_OFFSET)=0A=
+#define ETH1_TX_DMA_ADDR  (DMA0_PhysicalAddress + =
5*DMA_CHAN_OFFSET)=0A=
+=0A=
+/* the following must be powers of two */=0A=
+#define RC32438_NUM_RDS    64    		/* number of receive descriptors =
*/=0A=
+#define RC32438_NUM_TDS    64    		/* number of transmit descriptors =
*/=0A=
+=0A=
+#define RC32438_RBSIZE     1536  		/* size of one resource buffer =3D =
Ether MTU */=0A=
+#define RC32438_RDS_MASK   (RC32438_NUM_RDS-1)=0A=
+#define RC32438_TDS_MASK   (RC32438_NUM_TDS-1)=0A=
+#define RD_RING_SIZE (RC32438_NUM_RDS * sizeof(struct DMAD_s))=0A=
+#define TD_RING_SIZE (RC32438_NUM_TDS * sizeof(struct DMAD_s))=0A=
+=0A=
+#define RC32438_TX_TIMEOUT HZ * 100=0A=
+=0A=
+#define rc32438_eth0_regs ((ETH_t)(ETH0_VirtualAddress))=0A=
+#define rc32438_eth1_regs ((ETH_t)(ETH1_VirtualAddress))=0A=
+=0A=
+enum status	{ filled,	empty};=0A=
+#define IS_DMA_FINISHED(X)   (((X) & (DMAD_f_m)) !=3D 0)=0A=
+#define IS_DMA_DONE(X)   (((X) & (DMAD_d_m)) !=3D 0)=0A=
+=0A=
+=0A=
+/* Information that need to be kept for each board. */=0A=
+struct rc32438_local {=0A=
+	ETH_t  eth_regs;=0A=
+	DMA_Chan_t  rx_dma_regs;=0A=
+	DMA_Chan_t  tx_dma_regs;=0A=
+	volatile DMAD_t   td_ring;			/* transmit descriptor ring */=0A=
+	volatile DMAD_t   rd_ring;			/* receive descriptor ring  */=0A=
+=0A=
+	struct sk_buff* tx_skb[RC32438_NUM_TDS]; 	/* skbuffs for pkt to trans =
*/=0A=
+	struct sk_buff* rx_skb[RC32438_NUM_RDS]; 	/* skbuffs for pkt to trans =
*/=0A=
+=0A=
+	int weight;=0A=
+#ifdef CONFIG_RC32438_REVISION_ZA=0A=
+	struct tasklet_struct * ovr_und_tasklet;=0A=
+#endif=0A=
+	struct tasklet_struct * tx_tasklet;=0A=
+=0A=
+	int	rx_next_done;=0A=
+	int	rx_chain_head;=0A=
+	int	rx_chain_tail;=0A=
+	enum status	rx_chain_status;=0A=
+=0A=
+	int	tx_next_done;=0A=
+	int	tx_chain_head;=0A=
+	int	tx_chain_tail;=0A=
+	enum status	tx_chain_status;=0A=
+	int tx_count;=0A=
+	int	tx_full;=0A=
+=0A=
+	struct timer_list    mii_phy_timer;=0A=
+	unsigned long duplex_mode;=0A=
+=0A=
+	int   	rx_irq;=0A=
+	int    tx_irq;=0A=
+	int    ovr_irq;=0A=
+	int    und_irq;=0A=
+=0A=
+	struct net_device_stats stats;=0A=
+#ifdef CONFIG_SMP=0A=
+	spinlock_t lock;=0A=
+#endif=0A=
+=0A=
+	/* debug /proc entry */=0A=
+	struct proc_dir_entry *ps;=0A=
+	int dma_halt_cnt;=0A=
+        int ibudget;=0A=
+        int iquota;=0A=
+        int done_cnt;=0A=
+        int firstTime;=0A=
+        int not_done_cnt;=0A=
+        int dma_halt_nd_cnt;=0A=
+        int dma_ovr_count;=0A=
+        int dma_und_count;=0A=
+	int tx_stopped;=0A=
+};=0A=
+=0A=
+extern unsigned int idt_cpu_freq;=0A=
+=0A=
+/* Index to functions, as function prototypes. */=0A=
+static int rc32438_open(struct net_device *dev);=0A=
+static int rc32438_send_packet(struct sk_buff *skb, struct net_device =
*dev);=0A=
+//static void rc32438_mii_handler(unsigned long data);=0A=
+static irqreturn_t rc32438_rx_dma_interrupt(int irq, void *dev_id, =
struct pt_regs * regs);=0A=
+static irqreturn_t rc32438_tx_dma_interrupt(int irq, void *dev_id, =
struct pt_regs * regs);=0A=
+static int rc32438_poll(struct net_device *dev, int *budget);=0A=
+static int  rc32438_close(struct net_device *dev);=0A=
+static struct net_device_stats *rc32438_get_stats(struct net_device =
*dev);=0A=
+static void rc32438_multicast_list(struct net_device *dev);=0A=
+static int  rc32438_init(struct net_device *dev);=0A=
+static void rc32438_tx_timeout(struct net_device *dev);=0A=
+static void rc32438_tx_tasklet(unsigned long dev_id);=0A=
+#ifdef CONFIG_RC32438_REVISION_ZA=0A=
+static void rc32438_ovr_und_tasklet(unsigned long dev_id);=0A=
+#endif=0A=
+static void rc32438_cleanup_module(void);=0A=
+static int rc32438_probe(int port_num);=0A=
+int rc32438_init_module(void);=0A=
+=0A=
+static inline void rc32438_abort_dma(struct net_device *dev, =
DMA_Chan_t ch)=0A=
+{=0A=
+	if (rc32438_readl(&ch->dmac) & DMAC_run_m)=0A=
+	{=0A=
+		rc32438_writel(0x10, &ch->dmac);=0A=
+=0A=
+		while (!(rc32438_readl(&ch->dmas) & DMAS_h_m))=0A=
+			dev->trans_start =3D jiffies;=0A=
+=0A=
+		rc32438_writel(0, &ch->dmas);=0A=
+	}=0A=
+=0A=
+	rc32438_writel(0, &ch->dmadptr);=0A=
+	rc32438_writel(0, &ch->dmandptr);=0A=
+}=0A=
diff -uNr linux-2.6.16-rc5/.gitignore acacia/.gitignore=0A=
--- linux-2.6.16-rc5/.gitignore	2006-02-27 02:56:56.000000000 -0800=0A=
+++ acacia/.gitignore	1969-12-31 16:00:00.000000000 -0800=0A=
@@ -1,37 +0,0 @@=0A=
-#=0A=
-# NOTE! Don't add files that are generated in specific=0A=
-# subdirectories here. Add them in the ".gitignore" file=0A=
-# in that subdirectory instead.=0A=
-#=0A=
-# Normal rules=0A=
-#=0A=
-.*=0A=
-*.o=0A=
-*.a=0A=
-*.s=0A=
-*.ko=0A=
-*.so=0A=
-*.mod.c=0A=
-=0A=
-#=0A=
-# Top-level generic files=0A=
-#=0A=
-vmlinux*=0A=
-System.map=0A=
-Module.symvers=0A=
-=0A=
-#=0A=
-# Generated include files=0A=
-#=0A=
-include/asm=0A=
-include/asm-*/asm-offsets.h=0A=
-include/config=0A=
-include/linux/autoconf.h=0A=
-include/linux/compile.h=0A=
-include/linux/version.h=0A=
-include/asm-*/asm-offsets.h=0A=
-=0A=
-#=0A=
-# Quilt=0A=
-#=0A=
-patches=0A=
diff -uNr linux-2.6.16-rc5/include/asm-mips/bootinfo.h =
acacia/include/asm-mips/bootinfo.h=0A=
--- linux-2.6.16-rc5/include/asm-mips/bootinfo.h	2006-02-27 =
02:56:56.000000000 -0800=0A=
+++ acacia/include/asm-mips/bootinfo.h	2006-03-14 13:54:49.000000000 =
-0800=0A=
@@ -218,6 +218,14 @@=0A=
 #define MACH_GROUP_TITAN       22	/* PMC-Sierra Titan		*/=0A=
 #define  MACH_TITAN_YOSEMITE	1	/* PMC-Sierra Yosemite		*/=0A=
 =0A=
+=0A=
+/*=0A=
+ * Valid machtype for group TITAN=0A=
+ */=0A=
+#define MACH_GROUP_IDT         23       /* IDT chips */=0A=
+#define MACH_IDT_EB438          0       /* EB438 */=0A=
+=0A=
+=0A=
 #define CL_SIZE			COMMAND_LINE_SIZE=0A=
 =0A=
 const char *get_system_type(void);=0A=
diff -uNr =
linux-2.6.16-rc5/include/asm-mips/idt-boards/rc32438/rc32438_dma.h =
acacia/include/asm-mips/idt-boards/rc32438/rc32438_dma.h=0A=
--- linux-2.6.16-rc5/include/asm-mips/idt-boards/rc32438/rc32438_dma.h	=
1969-12-31 16:00:00.000000000 -0800=0A=
+++ acacia/include/asm-mips/idt-boards/rc32438/rc32438_dma.h	2006-03-14 =
10:47:28.000000000 -0800=0A=
@@ -0,0 +1,224 @@=0A=
+/**********************************************************************=
****=0A=
+ *=0A=
+ *  BRIEF MODULE DESCRIPTION=0A=
+ *   Register definitions for  IDT RC32438 DMA.=0A=
+ *=0A=
+ *  Copyright 2006 IDT Inc. (rischelp@idt.com)=0A=
+ *         =0A=
+ *  This program is free software; you can redistribute  it and/or =
modify it=0A=
+ *  under  the terms of  the GNU General  Public License as published =
by the=0A=
+ *  Free Software Foundation;  either version 2 of the  License, or =
(at your=0A=
+ *  option) any later version.=0A=
+ *=0A=
+ *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR =
IMPLIED=0A=
+ *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED =
WARRANTIES OF=0A=
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE =
DISCLAIMED.  IN=0A=
+ *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, =
INDIRECT,=0A=
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES =
(INCLUDING, BUT=0A=
+ *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; =
LOSS OF=0A=
+ *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED =
AND ON=0A=
+ *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, =
OR TORT=0A=
+ *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE =
USE OF=0A=
+ *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH =
DAMAGE.=0A=
+ *=0A=
+ *  You should have received a copy of the  GNU General Public License =
along=0A=
+ *  with this program; if not, write  to the Free Software Foundation, =
Inc.,=0A=
+ *  675 Mass Ave, Cambridge, MA 02139, USA.=0A=
+ *=0A=
+ *=0A=
+ =
************************************************************************=
**=0A=
+ */=0A=
+#ifndef __IDT_RC32438_DMA_H__=0A=
+#define __IDT_RC32438_DMA_H__=0A=
+enum=0A=
+{=0A=
+	DMA0_PhysicalAddress	=3D 0x18040000,=0A=
+	DMA_PhysicalAddress	=3D DMA0_PhysicalAddress,		// Default=0A=
+=0A=
+	DMA0_VirtualAddress	=3D 0xb8040000,=0A=
+	DMA_VirtualAddress	=3D DMA0_VirtualAddress,		// Default=0A=
+} ;=0A=
+=0A=
+/*=0A=
+ * DMA descriptor (in physical memory).=0A=
+ */=0A=
+=0A=
+typedef struct DMAD_s=0A=
+{=0A=
+	u32			control ;	// Control. use DMAD_*=0A=
+	u32			ca ;		// Current Address.=0A=
+	u32			devcs ; 	// Device control and status.=0A=
+	u32			link ;		// Next descriptor in chain.=0A=
+} volatile *DMAD_t ;=0A=
+=0A=
+enum=0A=
+{=0A=
+	DMAD_size		=3D sizeof (struct DMAD_s),=0A=
+	DMAD_count_b		=3D 0,		// in DMAD_t -> control=0A=
+	DMAD_count_m		=3D 0x0003ffff,	// in DMAD_t -> control=0A=
+	DMAD_ds_b		=3D 20,		// in DMAD_t -> control=0A=
+	DMAD_ds_m		=3D 0x00300000,	// in DMAD_t -> control=0A=
+		DMAD_ds_extToMem0_v	=3D 0,=0A=
+		DMAD_ds_memToExt0_v	=3D 1,=0A=
+		DMAD_ds_extToMem1_v	=3D 0,=0A=
+		DMAD_ds_memToExt1_v	=3D 1,=0A=
+		DMAD_ds_ethRcv0_v	=3D 0,=0A=
+		DMAD_ds_ethXmt0_v	=3D 0,=0A=
+		DMAD_ds_ethRcv1_v	=3D 0,=0A=
+		DMAD_ds_ethXmt2_v	=3D 0,=0A=
+		DMAD_ds_memToFifo_v	=3D 0,=0A=
+		DMAD_ds_fifoToMem_v	=3D 0,=0A=
+		DMAD_ds_rng_de_v	   =3D 1,//randomNumberGenerator on LC/DE=0A=
+		DMAD_ds_pciToMem_v	=3D 0,=0A=
+		DMAD_ds_memToPci_v	=3D 0,=0A=
+		DMAD_ds_securityInput_v =3D 0,=0A=
+		DMAD_ds_securityOutput_v =3D 0,=0A=
+		DMAD_ds_rng_se_v	=3D 0,//randomNumberGenerator on SE=0A=
+	=0A=
+	DMAD_devcmd_b		=3D 22,		// in DMAD_t -> control=0A=
+	DMAD_devcmd_m		=3D 0x01c00000,	// in DMAD_t -> control=0A=
+		DMAD_devcmd_byte_v	=3D 0,	//memory-to-memory=0A=
+		DMAD_devcmd_halfword_v	=3D 1,	//memory-to-memory=0A=
+		DMAD_devcmd_word_v	=3D 2,	//memory-to-memory=0A=
+		DMAD_devcmd_2words_v	=3D 3,	//memory-to-memory=0A=
+		DMAD_devcmd_4words_v	=3D 4,	//memory-to-memory=0A=
+		DMAD_devcmd_6words_v	=3D 5,	//memory-to-memory=0A=
+		DMAD_devcmd_8words_v	=3D 6,	//memory-to-memory=0A=
+		DMAD_devcmd_16words_v	=3D 7,	//memory-to-memory=0A=
+	DMAD_cof_b		=3D 25,		// chain on finished=0A=
+	DMAD_cof_m		=3D 0x02000000,	// =0A=
+	DMAD_cod_b		=3D 26,		// chain on done=0A=
+	DMAD_cod_m		=3D 0x04000000,	// =0A=
+	DMAD_iof_b		=3D 27,		// interrupt on finished=0A=
+	DMAD_iof_m		=3D 0x08000000,	// =0A=
+	DMAD_iod_b		=3D 28,		// interrupt on done=0A=
+	DMAD_iod_m		=3D 0x10000000,	// =0A=
+	DMAD_t_b		=3D 29,		// terminated=0A=
+	DMAD_t_m		=3D 0x20000000,	// =0A=
+	DMAD_d_b		=3D 30,		// done=0A=
+	DMAD_d_m		=3D 0x40000000,	// =0A=
+	DMAD_f_b		=3D 31,		// finished=0A=
+	DMAD_f_m		=3D 0x80000000,	// =0A=
+} ;=0A=
+=0A=
+/*=0A=
+ * DMA register (within Internal Register Map).=0A=
+ */=0A=
+=0A=
+struct DMA_Chan_s=0A=
+{=0A=
+	u32		dmac ;		// Control.=0A=
+	u32		dmas ;		// Status.	=0A=
+	u32		dmasm ; 	// Mask.=0A=
+	u32		dmadptr ;	// Descriptor pointer.=0A=
+	u32		dmandptr ;	// Next descriptor pointer.=0A=
+};=0A=
+=0A=
+typedef struct DMA_Chan_s volatile *DMA_Chan_t ;=0A=
+=0A=
+//DMA_Channels	  use DMACH_count instead=0A=
+=0A=
+enum=0A=
+{=0A=
+	DMAC_run_b	=3D 0,		// =0A=
+	DMAC_run_m	=3D 0x00000001,	// =0A=
+	DMAC_dm_b	=3D 1,		// done mask=0A=
+	DMAC_dm_m	=3D 0x00000002,	// =0A=
+	DMAC_mode_b	=3D 2,		// =0A=
+	DMAC_mode_m	=3D 0x0000000c,	// =0A=
+		DMAC_mode_auto_v	=3D 0,=0A=
+		DMAC_mode_burst_v	=3D 1,=0A=
+		DMAC_mode_transfer_v	=3D 2, //usually used=0A=
+		DMAC_mode_reserved_v	=3D 3,=0A=
+	DMAC_a_b	=3D 4,		// =0A=
+	DMAC_a_m	=3D 0x00000010,	// =0A=
+=0A=
+	DMAS_f_b	=3D 0,		// finished (sticky) =0A=
+	DMAS_f_m	=3D 0x00000001,	//		     =0A=
+	DMAS_d_b	=3D 1,		// done (sticky)     =0A=
+	DMAS_d_m	=3D 0x00000002,	//		     =0A=
+	DMAS_c_b	=3D 2,		// chain (sticky)    =0A=
+	DMAS_c_m	=3D 0x00000004,	//		     =0A=
+	DMAS_e_b	=3D 3,		// error (sticky)    =0A=
+	DMAS_e_m	=3D 0x00000008,	//		     =0A=
+	DMAS_h_b	=3D 4,		// halt (sticky)     =0A=
+	DMAS_h_m	=3D 0x00000010,	//		     =0A=
+=0A=
+	DMASM_f_b	=3D 0,		// finished (1=3Dmask)=0A=
+	DMASM_f_m	=3D 0x00000001,	// =0A=
+	DMASM_d_b	=3D 1,		// done (1=3Dmask)=0A=
+	DMASM_d_m	=3D 0x00000002,	// =0A=
+	DMASM_c_b	=3D 2,		// chain (1=3Dmask)=0A=
+	DMASM_c_m	=3D 0x00000004,	// =0A=
+	DMASM_e_b	=3D 3,		// error (1=3Dmask)=0A=
+	DMASM_e_m	=3D 0x00000008,	// =0A=
+	DMASM_h_b	=3D 4,		// halt (1=3Dmask)=0A=
+	DMASM_h_m	=3D 0x00000010,	// =0A=
+} ;=0A=
+=0A=
+/*=0A=
+ * DMA channel definitions=0A=
+ */=0A=
+=0A=
+enum=0A=
+{=0A=
+	DMACH_extToMem0 =3D 0,=0A=
+	DMACH_memToExt0 =3D 0,=0A=
+	DMACH_extToMem1 =3D 1,=0A=
+	DMACH_memToExt1 =3D 1,=0A=
+	DMACH_ethRcv0 =3D 2,=0A=
+	DMACH_ethXmt0 =3D 3,=0A=
+	DMACH_ethRcv1 =3D 4,=0A=
+	DMACH_ethXmt2 =3D 5,=0A=
+	DMACH_memToFifo =3D 6,=0A=
+	DMACH_fifoToMem =3D 7,=0A=
+	DMACH_rng_de =3D 7,//randomNumberGenerator on LC/DE=0A=
+	DMACH_pciToMem =3D 8,=0A=
+	DMACH_memToPci =3D 9,=0A=
+	DMACH_securityInput =3D 10,=0A=
+	DMACH_securityOutput =3D 11,=0A=
+	DMACH_rng_se =3D 12, //randomNumberGenerator on SE=0A=
+	=0A=
+	DMACH_count //must be last=0A=
+};=0A=
+=0A=
+=0A=
+typedef struct DMAC_s=0A=
+{=0A=
+	struct DMA_Chan_s ch [DMACH_count] ; //use ch[DMACH_]=0A=
+} volatile *DMA_t ;=0A=
+=0A=
+=0A=
+/*=0A=
+ * External DMA parameters=0A=
+*/=0A=
+=0A=
+enum=0A=
+{=0A=
+	DMADEVCMD_ts_b	=3D 0,		// ts field in devcmd=0A=
+	DMADEVCMD_ts_m	=3D 0x00000007,	// ts field in devcmd=0A=
+		DMADEVCMD_ts_byte_v	=3D 0,=0A=
+		DMADEVCMD_ts_halfword_v	=3D 1,=0A=
+		DMADEVCMD_ts_word_v	=3D 2,=0A=
+		DMADEVCMD_ts_2word_v	=3D 3,=0A=
+		DMADEVCMD_ts_4word_v	=3D 4,=0A=
+		DMADEVCMD_ts_6word_v	=3D 5,=0A=
+		DMADEVCMD_ts_8word_v	=3D 6,=0A=
+		DMADEVCMD_ts_16word_v	=3D 7=0A=
+};=0A=
+=0A=
+=0A=
+#if 1	// aws - Compatibility.=0A=
+#	define	EXTDMA_ts_b		DMADEVCMD_ts_b=0A=
+#	define	EXTDMA_ts_m		DMADEVCMD_ts_m=0A=
+#	define	EXTDMA_ts_byte_v	DMADEVCMD_ts_byte_v=0A=
+#	define	EXTDMA_ts_halfword_v	DMADEVCMD_ts_halfword_v=0A=
+#	define	EXTDMA_ts_word_v	DMADEVCMD_ts_word_v=0A=
+#	define	EXTDMA_ts_2word_v	DMADEVCMD_ts_2word_v=0A=
+#	define	EXTDMA_ts_4word_v	DMADEVCMD_ts_4word_v=0A=
+#	define	EXTDMA_ts_6word_v	DMADEVCMD_ts_6word_v=0A=
+#	define	EXTDMA_ts_8word_v	DMADEVCMD_ts_8word_v=0A=
+#	define	EXTDMA_ts_16word_v	DMADEVCMD_ts_16word_v=0A=
+#endif	// aws - Compatibility.=0A=
+=0A=
+#endif //__IDT_RC32438_DMA_H__=0A=
diff -uNr =
linux-2.6.16-rc5/include/asm-mips/idt-boards/rc32438/rc32438_dma_v.h =
acacia/include/asm-mips/idt-boards/rc32438/rc32438_dma_v.h=0A=
--- =
linux-2.6.16-rc5/include/asm-mips/idt-boards/rc32438/rc32438_dma_v.h	=
1969-12-31 16:00:00.000000000 -0800=0A=
+++ acacia/include/asm-mips/idt-boards/rc32438/rc32438_dma_v.h	=
2006-03-14 10:47:28.000000000 -0800=0A=
@@ -0,0 +1,76 @@=0A=
+/**********************************************************************=
****=0A=
+ *=0A=
+ *  BRIEF MODULE DESCRIPTION=0A=
+ *   DMA operations for IDT RC32438.=0A=
+ *=0A=
+ *  Copyright 2006 IDT Inc. (rischelp@idt.com)=0A=
+ *         =0A=
+ *  This program is free software; you can redistribute  it and/or =
modify it=0A=
+ *  under  the terms of  the GNU General  Public License as published =
by the=0A=
+ *  Free Software Foundation;  either version 2 of the  License, or =
(at your=0A=
+ *  option) any later version.=0A=
+ *=0A=
+ *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR =
IMPLIED=0A=
+ *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED =
WARRANTIES OF=0A=
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE =
DISCLAIMED.  IN=0A=
+ *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, =
INDIRECT,=0A=
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES =
(INCLUDING, BUT=0A=
+ *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; =
LOSS OF=0A=
+ *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED =
AND ON=0A=
+ *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, =
OR TORT=0A=
+ *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE =
USE OF=0A=
+ *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH =
DAMAGE.=0A=
+ *=0A=
+ *  You should have received a copy of the  GNU General Public License =
along=0A=
+ *  with this program; if not, write  to the Free Software Foundation, =
Inc.,=0A=
+ *  675 Mass Ave, Cambridge, MA 02139, USA.=0A=
+ *=0A=
+ *=0A=
+ *=0A=
+ =
************************************************************************=
**=0A=
+ */=0A=
+=0A=
+#ifndef __IDT_RC32438_DMA_V_H__=0A=
+#define __IDT_RC32438_DMA_V_H__=0A=
+#include  <asm/idt-boards/rc32438/rc32438_dma.h> =0A=
+=0A=
+#define DMA_CHAN_OFFSET  0x14=0A=
+#define IS_DMA_USED(X) (((X) & (DMAD_f_m | DMAD_d_m | DMAD_t_m)) !=3D =
0)=0A=
+#define DMA_COUNT(count)   \=0A=
+  ((count) & DMAD_count_m)=0A=
+=0A=
+#define DMA_HALT_TIMEOUT 500=0A=
+=0A=
+=0A=
+static inline int rc32438_halt_dma(DMA_Chan_t ch)=0A=
+{=0A=
+	int timeout=3D1;=0A=
+	if (rc32438_readl(&ch->dmac) & DMAC_run_m) {=0A=
+		rc32438_writel(0, &ch->dmac); =0A=
+		=0A=
+		for (timeout =3D DMA_HALT_TIMEOUT; timeout > 0; timeout--) {=0A=
+			if (rc32438_readl(&ch->dmas) & DMAS_h_m) {=0A=
+				rc32438_writel(0, &ch->dmas);  =0A=
+				break;=0A=
+			}=0A=
+		}=0A=
+=0A=
+	}=0A=
+	=0A=
+	return timeout ? 0 : 1;=0A=
+}=0A=
+=0A=
+=0A=
+=0A=
+=0A=
+static inline void rc32438_start_dma(DMA_Chan_t ch, u32 dma_addr)=0A=
+{=0A=
+	rc32438_writel(0, &ch->dmandptr); =0A=
+	rc32438_writel(dma_addr, &ch->dmadptr);=0A=
+}=0A=
+=0A=
+static inline void rc32438_chain_dma(DMA_Chan_t ch, u32 dma_addr)=0A=
+{=0A=
+	rc32438_writel(dma_addr, &ch->dmandptr);=0A=
+}=0A=
+#endif //__IDT_RC32438_DMA_V_H__=0A=
diff -uNr =
linux-2.6.16-rc5/include/asm-mips/idt-boards/rc32438/rc32438_eth.h =
acacia/include/asm-mips/idt-boards/rc32438/rc32438_eth.h=0A=
--- linux-2.6.16-rc5/include/asm-mips/idt-boards/rc32438/rc32438_eth.h	=
1969-12-31 16:00:00.000000000 -0800=0A=
+++ acacia/include/asm-mips/idt-boards/rc32438/rc32438_eth.h	2006-03-14 =
10:47:28.000000000 -0800=0A=
@@ -0,0 +1,321 @@=0A=
+/**********************************************************************=
****=0A=
+ *=0A=
+ *  BRIEF MODULE DESCRIPTION=0A=
+ *   Definitions for IDT EB438 ethernet=0A=
+ *=0A=
+ *  Copyright 2006 IDT Inc. (rischelp@idt.com)=0A=
+ *         =0A=
+ *  This program is free software; you can redistribute  it and/or =
modify it=0A=
+ *  under  the terms of  the GNU General  Public License as published =
by the=0A=
+ *  Free Software Foundation;  either version 2 of the  License, or =
(at your=0A=
+ *  option) any later version.=0A=
+ *=0A=
+ *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR =
IMPLIED=0A=
+ *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED =
WARRANTIES OF=0A=
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE =
DISCLAIMED.  IN=0A=
+ *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, =
INDIRECT,=0A=
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES =
(INCLUDING, BUT=0A=
+ *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; =
LOSS OF=0A=
+ *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED =
AND ON=0A=
+ *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, =
OR TORT=0A=
+ *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE =
USE OF=0A=
+ *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH =
DAMAGE.=0A=
+ *=0A=
+ *  You should have received a copy of the  GNU General Public License =
along=0A=
+ *  with this program; if not, write  to the Free Software Foundation, =
Inc.,=0A=
+ *  675 Mass Ave, Cambridge, MA 02139, USA.=0A=
+ *=0A=
+ *=0A=
+ =
************************************************************************=
**=0A=
+ */=0A=
+=0A=
+#ifndef __IDT_RC32438_ETH_H__=0A=
+#define __IDT_RC32438_ETH_H__=0A=
+enum=0A=
+{=0A=
+	ETH0_PhysicalAddress	=3D 0x18058000,=0A=
+	ETH_PhysicalAddress	=3D ETH0_PhysicalAddress,		// Default=0A=
+=0A=
+	ETH0_VirtualAddress	=3D 0xb8058000,=0A=
+	ETH_VirtualAddress	=3D ETH0_VirtualAddress,		// Default=0A=
+	ETH1_PhysicalAddress	=3D 0x18060000,=0A=
+	ETH1_VirtualAddress	=3D 0xb8060000,			// Default=0A=
+} ;=0A=
+=0A=
+typedef struct=0A=
+{=0A=
+	u32 ethintfc		;=0A=
+	u32 ethfifott		;=0A=
+	u32 etharc		;=0A=
+	u32 ethhash0		;=0A=
+	u32 ethhash1		;=0A=
+	u32 ethu0 [4]		;	// Reserved.	=0A=
+	u32 ethpfs		;=0A=
+	u32 ethmcp		;=0A=
+	u32 eth_u1 [10]		;	// Reserved.=0A=
+	u32 ethspare		;=0A=
+	u32 eth_u2 [42]		;	// Reserved. =0A=
+	u32 ethsal0		;=0A=
+	u32 ethsah0		;=0A=
+	u32 ethsal1		;=0A=
+	u32 ethsah1		;=0A=
+	u32 ethsal2		;=0A=
+	u32 ethsah2		;=0A=
+	u32 ethsal3		;=0A=
+	u32 ethsah3		;=0A=
+	u32 ethrbc		;=0A=
+	u32 ethrpc		;=0A=
+	u32 ethrupc		;=0A=
+	u32 ethrfc		;=0A=
+	u32 ethtbc		;=0A=
+	u32 ethgpf		;=0A=
+	u32 eth_u9 [50]		;	// Reserved.	=0A=
+	u32 ethmac1		;=0A=
+	u32 ethmac2		;=0A=
+	u32 ethipgt		;=0A=
+	u32 ethipgr		;=0A=
+	u32 ethclrt		;=0A=
+	u32 ethmaxf		;=0A=
+	u32 eth_u10		;	// Reserved.	=0A=
+	u32 ethmtest		;=0A=
+	u32 miimcfg		;=0A=
+	u32 miimcmd		;=0A=
+	u32 miimaddr		;=0A=
+	u32 miimwtd		;=0A=
+	u32 miimrdd		;=0A=
+	u32 miimind		;=0A=
+	u32 eth_u11		;	// Reserved.=0A=
+	u32 eth_u12		;	// Reserved.=0A=
+	u32 ethcfsa0		;=0A=
+	u32 ethcfsa1		;=0A=
+	u32 ethcfsa2		;=0A=
+} volatile *ETH_t;=0A=
+=0A=
+enum=0A=
+{=0A=
+	ETHINTFC_en_b		=3D 0,=0A=
+	ETHINTFC_en_m		=3D 0x00000001,=0A=
+	ETHINTFC_its_b		=3D 1,=0A=
+	ETHINTFC_its_m		=3D 0x00000002,=0A=
+	ETHINTFC_rip_b		=3D 2,=0A=
+	ETHINTFC_rip_m		=3D 0x00000004,=0A=
+	ETHINTFC_jam_b		=3D 3,=0A=
+	ETHINTFC_jam_m		=3D 0x00000008,=0A=
+	ETHINTFC_ovr_b		=3D 4,=0A=
+	ETHINTFC_ovr_m		=3D 0x00000010,=0A=
+	ETHINTFC_und_b		=3D 5,=0A=
+	ETHINTFC_und_m		=3D 0x00000020,=0A=
+=0A=
+	ETHFIFOTT_tth_b		=3D 0,=0A=
+	ETHFIFOTT_tth_m		=3D 0x0000007f,=0A=
+=0A=
+	ETHARC_pro_b		=3D 0,=0A=
+	ETHARC_pro_m		=3D 0x00000001,=0A=
+	ETHARC_am_b		=3D 1,=0A=
+	ETHARC_am_m		=3D 0x00000002,=0A=
+	ETHARC_afm_b		=3D 2,=0A=
+	ETHARC_afm_m		=3D 0x00000004,=0A=
+	ETHARC_ab_b		=3D 3,=0A=
+	ETHARC_ab_m		=3D 0x00000008,=0A=
+=0A=
+	ETHSAL_byte5_b		=3D 0,=0A=
+	ETHSAL_byte5_m		=3D 0x000000ff,=0A=
+	ETHSAL_byte4_b		=3D 8,=0A=
+	ETHSAL_byte4_m		=3D 0x0000ff00,=0A=
+	ETHSAL_byte3_b		=3D 16,=0A=
+	ETHSAL_byte3_m		=3D 0x00ff0000,=0A=
+	ETHSAL_byte2_b		=3D 24,=0A=
+	ETHSAL_byte2_m		=3D 0xff000000,=0A=
+=0A=
+	ETHSAH_byte1_b		=3D 0,=0A=
+	ETHSAH_byte1_m		=3D 0x000000ff,=0A=
+	ETHSAH_byte0_b		=3D 8,=0A=
+	ETHSAH_byte0_m		=3D 0x0000ff00,=0A=
+	=0A=
+	ETHGPF_ptv_b		=3D 0,=0A=
+	ETHGPF_ptv_m		=3D 0x0000ffff,=0A=
+=0A=
+	ETHPFS_pfd_b		=3D 0,=0A=
+	ETHPFS_pfd_m		=3D 0x00000001,=0A=
+=0A=
+	ETHCFSA0_cfsa4_b	=3D 0,=0A=
+	ETHCFSA0_cfsa4_m	=3D 0x000000ff,=0A=
+	ETHCFSA0_cfsa5_b	=3D 8,=0A=
+	ETHCFSA0_cfsa5_m	=3D 0x0000ff00,=0A=
+=0A=
+	ETHCFSA1_cfsa2_b	=3D 0,=0A=
+	ETHCFSA1_cfsa2_m	=3D 0x000000ff,=0A=
+	ETHCFSA1_cfsa3_b	=3D 8,=0A=
+	ETHCFSA1_cfsa3_m	=3D 0x0000ff00,=0A=
+=0A=
+	ETHCFSA2_cfsa0_b	=3D 0,=0A=
+	ETHCFSA2_cfsa0_m	=3D 0x000000ff,=0A=
+	ETHCFSA2_cfsa1_b	=3D 8,=0A=
+	ETHCFSA2_cfsa1_m	=3D 0x0000ff00,=0A=
+=0A=
+	ETHMAC1_re_b		=3D 0,=0A=
+	ETHMAC1_re_m		=3D 0x00000001,=0A=
+	ETHMAC1_paf_b		=3D 1,=0A=
+	ETHMAC1_paf_m		=3D 0x00000002,=0A=
+	ETHMAC1_rfc_b		=3D 2,=0A=
+	ETHMAC1_rfc_m		=3D 0x00000004,=0A=
+	ETHMAC1_tfc_b		=3D 3,=0A=
+	ETHMAC1_tfc_m		=3D 0x00000008,=0A=
+	ETHMAC1_lb_b		=3D 4,=0A=
+	ETHMAC1_lb_m		=3D 0x00000010,=0A=
+	ETHMAC1_mr_b		=3D 31,=0A=
+	ETHMAC1_mr_m		=3D 0x80000000,=0A=
+=0A=
+	ETHMAC2_fd_b		=3D 0,=0A=
+	ETHMAC2_fd_m		=3D 0x00000001,=0A=
+	ETHMAC2_flc_b		=3D 1,=0A=
+	ETHMAC2_flc_m		=3D 0x00000002,=0A=
+	ETHMAC2_hfe_b		=3D 2,=0A=
+	ETHMAC2_hfe_m		=3D 0x00000004,=0A=
+	ETHMAC2_dc_b		=3D 3,=0A=
+	ETHMAC2_dc_m		=3D 0x00000008,=0A=
+	ETHMAC2_cen_b		=3D 4,=0A=
+	ETHMAC2_cen_m		=3D 0x00000010,=0A=
+	ETHMAC2_pe_b		=3D 5,=0A=
+	ETHMAC2_pe_m		=3D 0x00000020,=0A=
+	ETHMAC2_vpe_b		=3D 6,=0A=
+	ETHMAC2_vpe_m		=3D 0x00000040,=0A=
+	ETHMAC2_ape_b		=3D 7,=0A=
+	ETHMAC2_ape_m		=3D 0x00000080,=0A=
+	ETHMAC2_ppe_b		=3D 8,=0A=
+	ETHMAC2_ppe_m		=3D 0x00000100,=0A=
+	ETHMAC2_lpe_b		=3D 9,=0A=
+	ETHMAC2_lpe_m		=3D 0x00000200,=0A=
+	ETHMAC2_nb_b		=3D 12,=0A=
+	ETHMAC2_nb_m		=3D 0x00001000,=0A=
+	ETHMAC2_bp_b		=3D 13,=0A=
+	ETHMAC2_bp_m		=3D 0x00002000,=0A=
+	ETHMAC2_ed_b		=3D 14,=0A=
+	ETHMAC2_ed_m		=3D 0x00004000,=0A=
+=0A=
+	ETHIPGT_ipgt_b		=3D 0,=0A=
+	ETHIPGT_ipgt_m		=3D 0x0000007f,=0A=
+=0A=
+	ETHIPGR_ipgr2_b		=3D 0,=0A=
+	ETHIPGR_ipgr2_m		=3D 0x0000007f,=0A=
+	ETHIPGR_ipgr1_b		=3D 8,=0A=
+	ETHIPGR_ipgr1_m		=3D 0x00007f00,=0A=
+=0A=
+	ETHCLRT_maxret_b	=3D 0,=0A=
+	ETHCLRT_maxret_m	=3D 0x0000000f,=0A=
+	ETHCLRT_colwin_b	=3D 8,=0A=
+	ETHCLRT_colwin_m	=3D 0x00003f00,=0A=
+=0A=
+	ETHMAXF_maxf_b		=3D 0,=0A=
+	ETHMAXF_maxf_m		=3D 0x0000ffff,=0A=
+=0A=
+	ETHMTEST_tb_b		=3D 2,=0A=
+	ETHMTEST_tb_m		=3D 0x00000004,=0A=
+=0A=
+	ETHMCP_div_b		=3D 0,=0A=
+	ETHMCP_div_m		=3D 0x000000ff,=0A=
+	=0A=
+	MIIMCFG_rsv_b		=3D 0,=0A=
+	MIIMCFG_rsv_m		=3D 0x0000000c,=0A=
+=0A=
+	MIIMCMD_rd_b		=3D 0,=0A=
+	MIIMCMD_rd_m		=3D 0x00000001,=0A=
+	MIIMCMD_scn_b		=3D 1,=0A=
+	MIIMCMD_scn_m		=3D 0x00000002,=0A=
+=0A=
+	MIIMADDR_regaddr_b	=3D 0,=0A=
+	MIIMADDR_regaddr_m	=3D 0x0000001f,=0A=
+	MIIMADDR_phyaddr_b	=3D 8,=0A=
+	MIIMADDR_phyaddr_m	=3D 0x00001f00,=0A=
+=0A=
+	MIIMWTD_wdata_b		=3D 0,=0A=
+	MIIMWTD_wdata_m		=3D 0x0000ffff,=0A=
+=0A=
+	MIIMRDD_rdata_b		=3D 0,=0A=
+	MIIMRDD_rdata_m		=3D 0x0000ffff,=0A=
+=0A=
+	MIIMIND_bsy_b		=3D 0,=0A=
+	MIIMIND_bsy_m		=3D 0x00000001,=0A=
+	MIIMIND_scn_b		=3D 1,=0A=
+	MIIMIND_scn_m		=3D 0x00000002,=0A=
+	MIIMIND_nv_b		=3D 2,=0A=
+	MIIMIND_nv_m		=3D 0x00000004,=0A=
+=0A=
+} ;=0A=
+=0A=
+/*=0A=
+ * Values for the DEVCS field of the Ethernet DMA Rx and Tx =
descriptors.=0A=
+ */=0A=
+enum=0A=
+{=0A=
+	ETHRX_fd_b		=3D 0,=0A=
+	ETHRX_fd_m		=3D 0x00000001,=0A=
+	ETHRX_ld_b		=3D 1,=0A=
+	ETHRX_ld_m		=3D 0x00000002,=0A=
+	ETHRX_rok_b		=3D 2,=0A=
+	ETHRX_rok_m		=3D 0x00000004,=0A=
+	ETHRX_fm_b		=3D 3,=0A=
+	ETHRX_fm_m		=3D 0x00000008,=0A=
+	ETHRX_mp_b		=3D 4,=0A=
+	ETHRX_mp_m		=3D 0x00000010,=0A=
+	ETHRX_bp_b		=3D 5,=0A=
+	ETHRX_bp_m		=3D 0x00000020,=0A=
+	ETHRX_vlt_b		=3D 6,=0A=
+	ETHRX_vlt_m		=3D 0x00000040,=0A=
+	ETHRX_cf_b		=3D 7,=0A=
+	ETHRX_cf_m		=3D 0x00000080,=0A=
+	ETHRX_ovr_b		=3D 8,=0A=
+	ETHRX_ovr_m		=3D 0x00000100,=0A=
+	ETHRX_crc_b		=3D 9,=0A=
+	ETHRX_crc_m		=3D 0x00000200,=0A=
+	ETHRX_cv_b		=3D 10,=0A=
+	ETHRX_cv_m		=3D 0x00000400,=0A=
+	ETHRX_db_b		=3D 11,=0A=
+	ETHRX_db_m		=3D 0x00000800,=0A=
+	ETHRX_le_b		=3D 12,=0A=
+	ETHRX_le_m		=3D 0x00001000,=0A=
+	ETHRX_lor_b		=3D 13,=0A=
+	ETHRX_lor_m		=3D 0x00002000,=0A=
+	ETHRX_ces_b		=3D 14,=0A=
+	ETHRX_ces_m		=3D 0x00004000,=0A=
+	ETHRX_length_b		=3D 16,=0A=
+	ETHRX_length_m		=3D 0xffff0000,=0A=
+=0A=
+	ETHTX_fd_b		=3D 0,=0A=
+	ETHTX_fd_m		=3D 0x00000001,=0A=
+	ETHTX_ld_b		=3D 1,=0A=
+	ETHTX_ld_m		=3D 0x00000002,=0A=
+	ETHTX_oen_b		=3D 2,=0A=
+	ETHTX_oen_m		=3D 0x00000004,=0A=
+	ETHTX_pen_b		=3D 3,=0A=
+	ETHTX_pen_m		=3D 0x00000008,=0A=
+	ETHTX_cen_b		=3D 4,=0A=
+	ETHTX_cen_m		=3D 0x00000010,=0A=
+	ETHTX_hen_b		=3D 5,=0A=
+	ETHTX_hen_m		=3D 0x00000020,=0A=
+	ETHTX_tok_b		=3D 6,=0A=
+	ETHTX_tok_m		=3D 0x00000040,=0A=
+	ETHTX_mp_b		=3D 7,=0A=
+	ETHTX_mp_m		=3D 0x00000080,=0A=
+	ETHTX_bp_b		=3D 8,=0A=
+	ETHTX_bp_m		=3D 0x00000100,=0A=
+	ETHTX_und_b		=3D 9,=0A=
+	ETHTX_und_m		=3D 0x00000200,=0A=
+	ETHTX_of_b		=3D 10,=0A=
+	ETHTX_of_m		=3D 0x00000400,=0A=
+	ETHTX_ed_b		=3D 11,=0A=
+	ETHTX_ed_m		=3D 0x00000800,=0A=
+	ETHTX_ec_b		=3D 12,=0A=
+	ETHTX_ec_m		=3D 0x00001000,=0A=
+	ETHTX_lc_b		=3D 13,=0A=
+	ETHTX_lc_m		=3D 0x00002000,=0A=
+	ETHTX_td_b		=3D 14,=0A=
+	ETHTX_td_m		=3D 0x00004000,=0A=
+	ETHTX_crc_b		=3D 15,=0A=
+	ETHTX_crc_m		=3D 0x00008000,=0A=
+	ETHTX_le_b		=3D 16,=0A=
+	ETHTX_le_m		=3D 0x00010000,=0A=
+	ETHTX_cc_b		=3D 17,=0A=
+	ETHTX_cc_m		=3D 0x001E0000,=0A=
+} ;=0A=
+#endif //__IDT_RC32438_ETH_H__=0A=
diff -uNr =
linux-2.6.16-rc5/include/asm-mips/idt-boards/rc32438/rc32438_eth_v.h =
acacia/include/asm-mips/idt-boards/rc32438/rc32438_eth_v.h=0A=
--- =
linux-2.6.16-rc5/include/asm-mips/idt-boards/rc32438/rc32438_eth_v.h	=
1969-12-31 16:00:00.000000000 -0800=0A=
+++ acacia/include/asm-mips/idt-boards/rc32438/rc32438_eth_v.h	=
2006-03-14 10:47:28.000000000 -0800=0A=
@@ -0,0 +1,64 @@=0A=
+/**********************************************************************=
****=0A=
+ *=0A=
+ *  BRIEF MODULE DESCRIPTION=0A=
+ *   macros for IDT EB438 ethernet=0A=
+ *=0A=
+ *  Copyright 2006 IDT Inc. (rischelp@idt.com)=0A=
+ *         =0A=
+ *  This program is free software; you can redistribute  it and/or =
modify it=0A=
+ *  under  the terms of  the GNU General  Public License as published =
by the=0A=
+ *  Free Software Foundation;  either version 2 of the  License, or =
(at your=0A=
+ *  option) any later version.=0A=
+ *=0A=
+ *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR =
IMPLIED=0A=
+ *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED =
WARRANTIES OF=0A=
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE =
DISCLAIMED.  IN=0A=
+ *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, =
INDIRECT,=0A=
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES =
(INCLUDING, BUT=0A=
+ *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; =
LOSS OF=0A=
+ *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED =
AND ON=0A=
+ *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, =
OR TORT=0A=
+ *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE =
USE OF=0A=
+ *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH =
DAMAGE.=0A=
+ *=0A=
+ *  You should have received a copy of the  GNU General Public License =
along=0A=
+ *  with this program; if not, write  to the Free Software Foundation, =
Inc.,=0A=
+ *  675 Mass Ave, Cambridge, MA 02139, USA.=0A=
+ *=0A=
+ =
************************************************************************=
**=0A=
+ */=0A=
+=0A=
+#ifndef __IDT_RC32438_ETH_V_H__=0A=
+#define __IDT_RC32438_ETH_V_H__=0A=
+#include  <asm/idt-boards/rc32438/rc32438_eth.h> =0A=
+=0A=
+#define IS_TX_TOK(X)         (((X) & (1<<ETHTX_tok_b)) >> ETHTX_tok_b =
)   /* Transmit Okay    */=0A=
+#define IS_TX_MP(X)          (((X) & (1<<ETHTX_mp_b))  >> ETHTX_mp_b ) =
   /* Multicast        */=0A=
+#define IS_TX_BP(X)          (((X) & (1<<ETHTX_bp_b))  >> ETHTX_bp_b ) =
   /* Broadcast        */=0A=
+#define IS_TX_UND_ERR(X)     (((X) & (1<<ETHTX_und_b)) >> ETHTX_und_b =
)   /* Transmit FIFO Underflow */=0A=
+#define IS_TX_OF_ERR(X)      (((X) & (1<<ETHTX_of_b))  >> ETHTX_of_b ) =
   /* Oversized frame  */=0A=
+#define IS_TX_ED_ERR(X)      (((X) & (1<<ETHTX_ed_b))  >> ETHTX_ed_b ) =
   /* Excessive deferral  */=0A=
+#define IS_TX_EC_ERR(X)      (((X) & (1<<ETHTX_ec_b))  >> ETHTX_ec_b)  =
   /* Excessive collisions  */=0A=
+#define IS_TX_LC_ERR(X)      (((X) & (1<<ETHTX_lc_b))  >> ETHTX_lc_b ) =
   /* Late Collision   */=0A=
+#define IS_TX_TD_ERR(X)      (((X) & (1<<ETHTX_td_b))  >> ETHTX_td_b ) =
   /* Transmit deferred*/=0A=
+#define IS_TX_CRC_ERR(X)     (((X) & (1<<ETHTX_crc_b)) >> ETHTX_crc_b =
)   /* CRC Error        */=0A=
+#define IS_TX_LE_ERR(X)      (((X) & (1<<ETHTX_le_b))  >>  ETHTX_le_b =
)    /* Length Error     */=0A=
+=0A=
+#define TX_COLLISION_COUNT(X) (((X) & ETHTX_cc_m)>>ETHTX_cc_b)  /* =
Collision Count  */=0A=
+=0A=
+#define IS_RCV_ROK(X)        (((X) & (1<<ETHRX_rok_b)) >> ETHRX_rok_b) =
   /* Receive Okay     */=0A=
+#define IS_RCV_FM(X)         (((X) & (1<<ETHRX_fm_b))  >> ETHRX_fm_b)  =
   /* Is Filter Match  */=0A=
+#define IS_RCV_MP(X)         (((X) & (1<<ETHRX_mp_b))  >> ETHRX_mp_b)  =
   /* Is it MP         */=0A=
+#define IS_RCV_BP(X)         (((X) & (1<<ETHRX_bp_b))  >> ETHRX_bp_b)  =
   /* Is it BP         */=0A=
+#define IS_RCV_VLT(X)        (((X) & (1<<ETHRX_vlt_b)) >> ETHRX_vlt_b) =
   /* VLAN Tag Detect  */=0A=
+#define IS_RCV_CF(X)         (((X) & (1<<ETHRX_cf_b))  >> ETHRX_cf_b)  =
   /* Control Frame    */=0A=
+#define IS_RCV_OVR_ERR(X)    (((X) & (1<<ETHRX_ovr_b)) >> ETHRX_ovr_b) =
   /* Receive Overflow */=0A=
+#define IS_RCV_CRC_ERR(X)    (((X) & (1<<ETHRX_crc_b)) >> ETHRX_crc_b) =
   /* CRC Error        */=0A=
+#define IS_RCV_CV_ERR(X)     (((X) & (1<<ETHRX_cv_b))  >> ETHRX_cv_b)  =
   /* Code Violation   */=0A=
+#define IS_RCV_DB_ERR(X)     (((X) & (1<<ETHRX_db_b))  >> ETHRX_db_b)  =
   /* Dribble Bits     */=0A=
+#define IS_RCV_LE_ERR(X)     (((X) & (1<<ETHRX_le_b))  >> ETHRX_le_b)  =
   /* Length error     */=0A=
+#define IS_RCV_LOR_ERR(X)    (((X) & (1<<ETHRX_lor_b)) >> ETHRX_lor_b) =
   /* Length Out of Range */=0A=
+#define IS_RCV_CES_ERR(X)    (((X) & (1<<ETHRX_ces_b)) >> ETHRX_ces_b) =
 /* Preamble error   */=0A=
+#define RCVPKT_LENGTH(X)     (((X) & ETHRX_length_m) >> =
ETHRX_length_b)   /* Length of the received packet */=0A=
+=0A=
+#endif //__IDT_RC32438_ETH_V_H__=0A=
diff -uNr =
linux-2.6.16-rc5/include/asm-mips/idt-boards/rc32438/rc32438_gpio.h =
acacia/include/asm-mips/idt-boards/rc32438/rc32438_gpio.h=0A=
--- linux-2.6.16-rc5/include/asm-mips/idt-boards/rc32438/rc32438_gpio.h	=
1969-12-31 16:00:00.000000000 -0800=0A=
+++ acacia/include/asm-mips/idt-boards/rc32438/rc32438_gpio.h	=
2006-03-14 10:47:28.000000000 -0800=0A=
@@ -0,0 +1,249 @@=0A=
+/**********************************************************************=
****=0A=
+ *=0A=
+ *  BRIEF MODULE DESCRIPTION=0A=
+ *   Definitions for IDT RC32438 GPIO.=0A=
+ *=0A=
+ *  Copyright 2006 IDT Inc. (rischelp@idt.com)=0A=
+ *         =0A=
+ *  This program is free software; you can redistribute  it and/or =
modify it=0A=
+ *  under  the terms of  the GNU General  Public License as published =
by the=0A=
+ *  Free Software Foundation;  either version 2 of the  License, or =
(at your=0A=
+ *  option) any later version.=0A=
+ *=0A=
+ *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR =
IMPLIED=0A=
+ *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED =
WARRANTIES OF=0A=
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE =
DISCLAIMED.  IN=0A=
+ *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, =
INDIRECT,=0A=
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES =
(INCLUDING, BUT=0A=
+ *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; =
LOSS OF=0A=
+ *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED =
AND ON=0A=
+ *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, =
OR TORT=0A=
+ *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE =
USE OF=0A=
+ *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH =
DAMAGE.=0A=
+ *=0A=
+ *  You should have received a copy of the  GNU General Public License =
along=0A=
+ *  with this program; if not, write  to the Free Software Foundation, =
Inc.,=0A=
+ *  675 Mass Ave, Cambridge, MA 02139, USA.=0A=
+ *=0A=
+ =
************************************************************************=
**=0A=
+ */=0A=
+#ifndef __IDT_RC32438_GPIO_H__=0A=
+#define __IDT_RC32438_GPIO_H__ =0A=
+enum=0A=
+{=0A=
+	GPIO0_PhysicalAddress	=3D 0x18048000,=0A=
+	GPIO_PhysicalAddress	=3D GPIO0_PhysicalAddress,	// Default=0A=
+=0A=
+	GPIO0_VirtualAddress	=3D 0xb8048000,=0A=
+	GPIO_VirtualAddress	=3D GPIO0_VirtualAddress,		// Default=0A=
+} ;=0A=
+=0A=
+typedef struct=0A=
+{=0A=
+	u32   gpiofunc;   /* GPIO Function Register=0A=
+			   * gpiofunc[x]=3D=3D0 bit =3D gpio=0A=
+			   * func[x]=3D=3D1  bit =3D altfunc=0A=
+			   */=0A=
+	u32   gpiocfg;	  /* GPIO Configuration Register=0A=
+			   * gpiocfg[x]=3D=3D0 bit =3D input=0A=
+			   * gpiocfg[x]=3D=3D1 bit =3D output=0A=
+			   */=0A=
+	u32   gpiod;	  /* GPIO Data Register=0A=
+			   * gpiod[x] read/write gpio pinX status=0A=
+			   */=0A=
+	u32   gpioilevel; /* GPIO Interrupt Status Register=0A=
+			   * interrupt level (see gpioistat)=0A=
+			   */=0A=
+	u32   gpioistat;  /* Gpio Interrupt Status Register=0A=
+			   * istat[x] =3D (gpiod[x] =3D=3D level[x])=0A=
+			   * cleared in ISR (STICKY bits)=0A=
+			   */=0A=
+	u32   gpionmien;  /* GPIO Non-maskable Interrupt Enable Register =
*/=0A=
+} volatile * GPIO_t ;=0A=
+=0A=
+typedef enum=0A=
+{=0A=
+	GPIO_gpio_v		=3D 0,		// gpiofunc use pin as GPIO.=0A=
+	GPIO_alt_v		=3D 1,		// gpiofunc use pin as alt.=0A=
+	GPIO_input_v		=3D 0,		// gpiocfg use pin as input.=0A=
+	GPIO_output_v		=3D 1,		// gpiocfg use pin as output.=0A=
+	GPIO_pin0_b		=3D 0,=0A=
+	GPIO_pin0_m		=3D 0x00000001,=0A=
+	GPIO_pin1_b		=3D 1,=0A=
+	GPIO_pin1_m		=3D 0x00000002,=0A=
+	GPIO_pin2_b		=3D 2,=0A=
+	GPIO_pin2_m		=3D 0x00000004,=0A=
+	GPIO_pin3_b		=3D 3,=0A=
+	GPIO_pin3_m		=3D 0x00000008,=0A=
+	GPIO_pin4_b		=3D 4,=0A=
+	GPIO_pin4_m		=3D 0x00000010,=0A=
+	GPIO_pin5_b		=3D 5,=0A=
+	GPIO_pin5_m		=3D 0x00000020,=0A=
+	GPIO_pin6_b		=3D 6,=0A=
+	GPIO_pin6_m		=3D 0x00000040,=0A=
+	GPIO_pin7_b		=3D 7,=0A=
+	GPIO_pin7_m		=3D 0x00000080,=0A=
+	GPIO_pin8_b		=3D 8,=0A=
+	GPIO_pin8_m		=3D 0x00000100,=0A=
+	GPIO_pin9_b		=3D 9,=0A=
+	GPIO_pin9_m		=3D 0x00000200,=0A=
+	GPIO_pin10_b		=3D 10,=0A=
+	GPIO_pin10_m		=3D 0x00000400,=0A=
+	GPIO_pin11_b		=3D 11,=0A=
+	GPIO_pin11_m		=3D 0x00000800,=0A=
+	GPIO_pin12_b		=3D 12,=0A=
+	GPIO_pin12_m		=3D 0x00001000,=0A=
+	GPIO_pin13_b		=3D 13,=0A=
+	GPIO_pin13_m		=3D 0x00002000,=0A=
+	GPIO_pin14_b		=3D 14,=0A=
+	GPIO_pin14_m		=3D 0x00004000,=0A=
+	GPIO_pin15_b		=3D 15,=0A=
+	GPIO_pin15_m		=3D 0x00008000,=0A=
+	GPIO_pin16_b		=3D 16,=0A=
+	GPIO_pin16_m		=3D 0x00010000,=0A=
+	GPIO_pin17_b		=3D 17,=0A=
+	GPIO_pin17_m		=3D 0x00020000,=0A=
+	GPIO_pin18_b		=3D 18,=0A=
+	GPIO_pin18_m		=3D 0x00040000,=0A=
+	GPIO_pin19_b		=3D 19,=0A=
+	GPIO_pin19_m		=3D 0x00080000,=0A=
+	GPIO_pin20_b		=3D 20,=0A=
+	GPIO_pin20_m		=3D 0x00100000,=0A=
+	GPIO_pin21_b		=3D 21,=0A=
+	GPIO_pin21_m		=3D 0x00200000,=0A=
+	GPIO_pin22_b		=3D 22,=0A=
+	GPIO_pin22_m		=3D 0x00400000,=0A=
+	GPIO_pin23_b		=3D 23,=0A=
+	GPIO_pin23_m		=3D 0x00800000,=0A=
+	GPIO_pin24_b		=3D 24,=0A=
+	GPIO_pin24_m		=3D 0x01000000,=0A=
+	GPIO_pin25_b		=3D 25,=0A=
+	GPIO_pin25_m		=3D 0x02000000,=0A=
+	GPIO_pin26_b		=3D 26,=0A=
+	GPIO_pin26_m		=3D 0x04000000,=0A=
+	GPIO_pin27_b		=3D 27,=0A=
+	GPIO_pin27_m		=3D 0x08000000,=0A=
+	GPIO_pin28_b		=3D 28,=0A=
+	GPIO_pin28_m		=3D 0x10000000,=0A=
+	GPIO_pin29_b		=3D 29,=0A=
+	GPIO_pin29_m		=3D 0x20000000,=0A=
+	GPIO_pin30_b		=3D 30,=0A=
+	GPIO_pin30_m		=3D 0x40000000,=0A=
+	GPIO_pin31_b		=3D 31,=0A=
+	GPIO_pin31_m		=3D 0x80000000,=0A=
+=0A=
+// Alternate function pins.  Corrsponding gpiofunc bit set to =
GPIO_alt_v.=0A=
+=0A=
+	GPIO_u0sout_b		=3D GPIO_pin0_b,		// UART 0 serial out.=0A=
+	GPIO_u0sout_m		=3D GPIO_pin0_m,=0A=
+		GPIO_u0sout_cfg_v	=3D GPIO_output_v,=0A=
+	GPIO_u0sinp_b	=3D GPIO_pin1_b,			// UART 0 serial in.=0A=
+	GPIO_u0sinp_m	=3D GPIO_pin1_m,=0A=
+		GPIO_u0sinp_cfg_v	=3D GPIO_input_v,=0A=
+	GPIO_u0rin_b	=3D GPIO_pin2_b,			// UART 0 ring indic.=0A=
+	GPIO_u0rin_m	=3D GPIO_pin2_m,=0A=
+		GPIO_u0rin_cfg_v	=3D GPIO_input_v,=0A=
+	GPIO_u0dcdn_b	=3D GPIO_pin3_b,			// UART 0 data carr.det.=0A=
+	GPIO_u0dcdn_m	=3D GPIO_pin3_m,=0A=
+		GPIO_u0dcdn_cfg_v	=3D GPIO_input_v,=0A=
+	GPIO_u0dtrn_b	=3D GPIO_pin4_b,			// UART 0 data term rdy.=0A=
+	GPIO_u0dtrn_m	=3D GPIO_pin4_m,=0A=
+		GPIO_u0dtrn_cfg_v	=3D GPIO_output_v,=0A=
+	GPIO_u0dsrn_b	=3D GPIO_pin5_b,			// UART 0 data set rdy.=0A=
+	GPIO_u0dsrn_m	=3D GPIO_pin5_m,=0A=
+		GPIO_u0dsrn_cfg_v	=3D GPIO_input_v,=0A=
+	GPIO_u0rtsn_b	=3D GPIO_pin6_b,			// UART 0 req. to send.=0A=
+	GPIO_u0rtsn_m	=3D GPIO_pin6_m,=0A=
+		GPIO_u0rtsn_cfg_v	=3D GPIO_output_v,=0A=
+	GPIO_u0ctsn_b	=3D GPIO_pin7_b,			// UART 0 clear to send.=0A=
+	GPIO_u0ctsn_m	=3D GPIO_pin7_m,=0A=
+		GPIO_u0ctsn_cfg_v	=3D GPIO_input_v,=0A=
+=0A=
+	GPIO_u1sout_b		=3D GPIO_pin8_b,		// UART 1 serial out.=0A=
+	GPIO_u1sout_m		=3D GPIO_pin8_m,=0A=
+		GPIO_u1sout_cfg_v	=3D GPIO_output_v,=0A=
+	GPIO_u1sinp_b		=3D GPIO_pin9_b,		// UART 1 serial in.=0A=
+	GPIO_u1sinp_m		=3D GPIO_pin9_m,=0A=
+		GPIO_u1sinp_cfg_v	=3D GPIO_input_v,=0A=
+	GPIO_u1dtrn_b		=3D GPIO_pin10_b, 	// UART 1 data term rdy.=0A=
+	GPIO_u1dtrn_m		=3D GPIO_pin10_m,=0A=
+		GPIO_u1dtrn_cfg_v	=3D GPIO_output_v,=0A=
+	GPIO_u1dsrn_b		=3D GPIO_pin11_b, 	// UART 1 data set rdy.=0A=
+	GPIO_u1dsrn_m		=3D GPIO_pin11_m,=0A=
+		GPIO_u1dsrn_cfg_v	=3D GPIO_input_v,=0A=
+	GPIO_u1rtsn_b		=3D GPIO_pin12_b, 	// UART 1 req. to send.=0A=
+	GPIO_u1rtsn_m		=3D GPIO_pin12_m,=0A=
+		GPIO_u1rtsn_cfg_v	=3D GPIO_output_v,=0A=
+	GPIO_u1ctsn_b		=3D GPIO_pin13_b, 	// UART 1 clear to send.=0A=
+	GPIO_u1ctsn_m		=3D GPIO_pin13_m,=0A=
+		GPIO_u1ctsn_cfg_v	=3D GPIO_input_v,=0A=
+=0A=
+	GPIO_dmareqn0_b 	=3D GPIO_pin14_b, 	// Ext. DMA 0 request=0A=
+	GPIO_dmareqn0_m 	=3D GPIO_pin14_m,=0A=
+		GPIO_dmareqn0_cfg_v	=3D GPIO_input_v,=0A=
+=0A=
+	GPIO_dmareqn1_b 	=3D GPIO_pin15_b, 	// Ext. DMA 1 request=0A=
+	GPIO_dmareqn1_m 	=3D GPIO_pin15_m,=0A=
+		GPIO_dmareqn1_cfg_v	=3D GPIO_input_v,=0A=
+=0A=
+	GPIO_dmadonen0_b	=3D GPIO_pin16_b, 	// Ext. DMA 0 done=0A=
+	GPIO_dmadonen0_m	=3D GPIO_pin16_m,=0A=
+		GPIO_dmadonen0_cfg_v	=3D GPIO_input_v,=0A=
+=0A=
+	GPIO_dmadonen1_b	=3D GPIO_pin17_b, 	// Ext. DMA 1 done=0A=
+	GPIO_dmadonen1_m	=3D GPIO_pin17_m,=0A=
+		GPIO_dmadonen1_cfg_v	=3D GPIO_input_v,=0A=
+=0A=
+	GPIO_dmafinn0_b 	=3D GPIO_pin18_b, 	// Ext. DMA 0 finished=0A=
+	GPIO_dmafinn0_m 	=3D GPIO_pin18_m,=0A=
+		GPIO_dmafinn0_cfg_v	=3D GPIO_output_v,=0A=
+=0A=
+	GPIO_dmafinn1_b 	=3D GPIO_pin19_b, 	// Ext. DMA 1 finished=0A=
+	GPIO_dmafinn1_m 	=3D GPIO_pin19_m,=0A=
+		GPIO_dmafinn1_cfg_v	=3D GPIO_output_v,=0A=
+=0A=
+	GPIO_maddr22_b		=3D GPIO_pin20_b, 	// M&P bus bit 22.=0A=
+	GPIO_maddr22_m		=3D GPIO_pin20_m,=0A=
+		GPIO_maddr22_cfg_v	=3D GPIO_output_v,=0A=
+=0A=
+	GPIO_maddr23_b		=3D GPIO_pin21_b, 	// M&P bus bit 23.=0A=
+	GPIO_maddr23_m		=3D GPIO_pin21_m,=0A=
+		GPIO_maddr23_cfg_v	=3D GPIO_output_v,=0A=
+=0A=
+	GPIO_maddr24_b		=3D GPIO_pin22_b, 	// M&P bus bit 24.=0A=
+	GPIO_maddr24_m		=3D GPIO_pin22_m,=0A=
+		GPIO_maddr24_cfg_v	=3D GPIO_output_v,=0A=
+=0A=
+	GPIO_maddr25_b		=3D GPIO_pin23_b, 	// M&P bus bit 25.=0A=
+	GPIO_maddr25_m		=3D GPIO_pin23_m,=0A=
+		GPIO_maddr25_cfg_v	=3D GPIO_output_v,=0A=
+=0A=
+	GPIO_afspare6_b 	=3D GPIO_pin24_b, 	// reserved.=0A=
+	GPIO_afspare6_m 	=3D GPIO_pin24_m,=0A=
+		GPIO_afspare6_cfg_v	=3D GPIO_input_v,=0A=
+	GPIO_afspare5_b 	=3D GPIO_pin25_b, 	// reserved.=0A=
+	GPIO_afspare5_m 	=3D GPIO_pin25_m,=0A=
+		GPIO_afspare5_cfg_v	=3D GPIO_input_v,=0A=
+	GPIO_afspare4_b 	=3D GPIO_pin26_b, 	// reserved.=0A=
+	GPIO_afspare4_m 	=3D GPIO_pin26_m,=0A=
+		GPIO_afspare4_cfg_v	=3D GPIO_input_v,=0A=
+	GPIO_afspare3_b 	=3D GPIO_pin27_b, 	// reserved.=0A=
+	GPIO_afspare3_m 	=3D GPIO_pin27_m,=0A=
+		GPIO_afspare3_cfg_v	=3D GPIO_input_v,=0A=
+	GPIO_afspare2_b 	=3D GPIO_pin28_b, 	// reserved.=0A=
+	GPIO_afspare2_m 	=3D GPIO_pin28_m,=0A=
+		GPIO_afspare2_cfg_v	=3D GPIO_input_v,=0A=
+	GPIO_afspare1_b 	=3D GPIO_pin29_b, 	// reserved.=0A=
+	GPIO_afspare1_m 	=3D GPIO_pin29_m,=0A=
+		GPIO_afspare1_cfg_v	=3D GPIO_input_v,=0A=
+=0A=
+	GPIO_pcimuintn_b	=3D GPIO_pin30_b, 	// PCI messaging int.=0A=
+	GPIO_pcimuintn_m	=3D GPIO_pin30_m,=0A=
+		GPIO_pcimuintn_cfg_v	=3D GPIO_output_v,=0A=
+=0A=
+	GPIO_rngclk_b		=3D GPIO_pin31_b, 	// RNG external clock=0A=
+	GPIO_rngclk_m		=3D GPIO_pin31_m,=0A=
+		GPIO_rncclk_cfg_v	=3D GPIO_input_v,=0A=
+} GPIO_DEFS_t;=0A=
+=0A=
+#endif //__IDT_RC32438_GPIO_H__=0A=
diff -uNr =
linux-2.6.16-rc5/include/asm-mips/idt-boards/rc32438/rc32438.h =
acacia/include/asm-mips/idt-boards/rc32438/rc32438.h=0A=
--- linux-2.6.16-rc5/include/asm-mips/idt-boards/rc32438/rc32438.h	=
1969-12-31 16:00:00.000000000 -0800=0A=
+++ acacia/include/asm-mips/idt-boards/rc32438/rc32438.h	2006-03-14 =
10:47:28.000000000 -0800=0A=
@@ -0,0 +1,144 @@=0A=
+/**********************************************************************=
****=0A=
+ *=0A=
+ *  BRIEF MODULE DESCRIPTION=0A=
+ *   Definitions for IDT RC32438 CPU.=0A=
+ *=0A=
+ *  Copyright 2006 IDT Inc. (rischelp@idt.com)=0A=
+ *         =0A=
+ *  This program is free software; you can redistribute  it and/or =
modify it=0A=
+ *  under  the terms of  the GNU General  Public License as published =
by the=0A=
+ *  Free Software Foundation;  either version 2 of the  License, or =
(at your=0A=
+ *  option) any later version.=0A=
+ *=0A=
+ *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR =
IMPLIED=0A=
+ *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED =
WARRANTIES OF=0A=
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE =
DISCLAIMED.  IN=0A=
+ *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, =
INDIRECT,=0A=
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES =
(INCLUDING, BUT=0A=
+ *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; =
LOSS OF=0A=
+ *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED =
AND ON=0A=
+ *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, =
OR TORT=0A=
+ *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE =
USE OF=0A=
+ *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH =
DAMAGE.=0A=
+ *=0A=
+ *  You should have received a copy of the  GNU General Public License =
along=0A=
+ *  with this program; if not, write  to the Free Software Foundation, =
Inc.,=0A=
+ *  675 Mass Ave, Cambridge, MA 02139, USA.=0A=
+ *=0A=
+ =
************************************************************************=
**=0A=
+ */=0A=
+=0A=
+#ifndef __IDT_RC32438_H__=0A=
+#define  __IDT_RC32438_H__=0A=
+#include <linux/config.h>=0A=
+#include <linux/delay.h>=0A=
+#include <asm/io.h>=0A=
+#include <asm/idt-boards/rc32438/rc32438_timer.h>=0A=
+=0A=
+#define RC32438_REG_BASE   0x18000000=0A=
+=0A=
+#define interrupt ((volatile INT_t ) INT0_VirtualAddress)=0A=
+#define idttimer     ((volatile TIM_t)  TIM0_VirtualAddress)=0A=
+#define gpio	  ((volatile GPIO_t) GPIO0_VirtualAddress)=0A=
+=0A=
+#define IDT_CLOCK_MULT 2=0A=
+#define MIPS_CPU_TIMER_IRQ 7=0A=
+/* Interrupt Controller */=0A=
+#define IC_GROUP0_PEND     (RC32438_REG_BASE + 0x38000)=0A=
+#define IC_GROUP0_MASK     (RC32438_REG_BASE + 0x38008)=0A=
+#define IC_GROUP_OFFSET    0x0C=0A=
+#define RTC_BASE           0xAC0801FF0=0A=
+=0A=
+#define NUM_INTR_GROUPS    5=0A=
+/* 16550 UARTs */=0A=
+=0A=
+#define GROUP0_IRQ_BASE 8		/* GRP2 IRQ numbers start here */=0A=
+#define GROUP1_IRQ_BASE (GROUP0_IRQ_BASE + 32) /* GRP3 IRQ numbers =
start here */=0A=
+#define GROUP2_IRQ_BASE (GROUP1_IRQ_BASE + 32) /* GRP4 IRQ numbers =
start here */=0A=
+#define GROUP3_IRQ_BASE (GROUP2_IRQ_BASE + 32)	/* GRP5 IRQ numbers =
start here */=0A=
+#define GROUP4_IRQ_BASE (GROUP3_IRQ_BASE + 32)=0A=
+=0A=
+#ifdef __MIPSEB__=0A=
+#define RC32438_UART0_BASE (RC32438_REG_BASE + 0x50003)=0A=
+#define RC32438_UART1_BASE (RC32438_REG_BASE + 0x50023)=0A=
+#else=0A=
+#define RC32438_UART0_BASE (RC32438_REG_BASE + 0x50000)=0A=
+#define RC32438_UART1_BASE (RC32438_REG_BASE + 0x50020)=0A=
+#endif=0A=
+=0A=
+#define RC32438_UART0_IRQ  GROUP3_IRQ_BASE + 0=0A=
+#define RC32438_UART1_IRQ  GROUP3_IRQ_BASE + 3=0A=
+=0A=
+#define RC32438_NR_IRQS  (GROUP4_IRQ_BASE + 32)=0A=
+=0A=
+=0A=
+=0A=
+/* cpu pipeline flush */=0A=
+static inline void rc32438_sync(void)=0A=
+{=0A=
+        __asm__ volatile ("sync");=0A=
+}=0A=
+=0A=
+static inline void rc32438_sync_udelay(int us)=0A=
+{=0A=
+        __asm__ volatile ("sync");=0A=
+        udelay(us);=0A=
+}=0A=
+=0A=
+static inline void rc32438_sync_delay(int ms)=0A=
+{=0A=
+        __asm__ volatile ("sync");=0A=
+        mdelay(ms);=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Macros to access internal RC32438 registers. No byte=0A=
+ * swapping should be done when accessing the internal=0A=
+ * registers.=0A=
+ */=0A=
+=0A=
+#define rc32438_readb __raw_readb=0A=
+#define rc32438_readw __raw_readw=0A=
+#define rc32438_readl __raw_readl=0A=
+=0A=
+#define rc32438_writeb __raw_writeb=0A=
+#define rc32438_writew __raw_writew=0A=
+#define rc32438_writel __raw_writel=0A=
+=0A=
+/*=0A=
+ * C access to CLZ and CLO instructions=0A=
+ * (count leading zeroes/ones).=0A=
+ */=0A=
+static inline int rc32438_clz(unsigned long val)=0A=
+{=0A=
+	int ret;=0A=
+        __asm__ volatile (=0A=
+		".set\tnoreorder\n\t"=0A=
+		".set\tnoat\n\t"=0A=
+		".set\tmips32\n\t"=0A=
+		"clz\t%0,%1\n\t"=0A=
+                ".set\tmips0\n\t"=0A=
+                ".set\tat\n\t"=0A=
+                ".set\treorder"=0A=
+                : "=3Dr" (ret)=0A=
+		: "r" (val));=0A=
+=0A=
+	return ret;=0A=
+}=0A=
+static inline int rc32438_clo(unsigned long val)=0A=
+{=0A=
+	int ret;=0A=
+        __asm__ volatile (=0A=
+		".set\tnoreorder\n\t"=0A=
+		".set\tnoat\n\t"=0A=
+		".set\tmips32\n\t"=0A=
+		"clo\t%0,%1\n\t"=0A=
+                ".set\tmips0\n\t"=0A=
+                ".set\tat\n\t"=0A=
+                ".set\treorder"=0A=
+                : "=3Dr" (ret)=0A=
+		: "r" (val));=0A=
+=0A=
+	return ret;=0A=
+}=0A=
+#endif //__IDT_RC32438_H__=0A=
diff -uNr =
linux-2.6.16-rc5/include/asm-mips/idt-boards/rc32438/rc32438_pci.h =
acacia/include/asm-mips/idt-boards/rc32438/rc32438_pci.h=0A=
--- linux-2.6.16-rc5/include/asm-mips/idt-boards/rc32438/rc32438_pci.h	=
1969-12-31 16:00:00.000000000 -0800=0A=
+++ acacia/include/asm-mips/idt-boards/rc32438/rc32438_pci.h	2006-03-14 =
10:47:28.000000000 -0800=0A=
@@ -0,0 +1,502 @@=0A=
+/**********************************************************************=
****=0A=
+ *=0A=
+ *  BRIEF MODULE DESCRIPTION=0A=
+ *   Definitions for IDT RC32438 PCI.=0A=
+ *=0A=
+ *  Copyright 2006 IDT Inc. (rischelp@idt.com)=0A=
+ *         =0A=
+ *  This program is free software; you can redistribute  it and/or =
modify it=0A=
+ *  under  the terms of  the GNU General  Public License as published =
by the=0A=
+ *  Free Software Foundation;  either version 2 of the  License, or =
(at your=0A=
+ *  option) any later version.=0A=
+ *=0A=
+ *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR =
IMPLIED=0A=
+ *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED =
WARRANTIES OF=0A=
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE =
DISCLAIMED.  IN=0A=
+ *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, =
INDIRECT,=0A=
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES =
(INCLUDING, BUT=0A=
+ *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; =
LOSS OF=0A=
+ *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED =
AND ON=0A=
+ *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, =
OR TORT=0A=
+ *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE =
USE OF=0A=
+ *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH =
DAMAGE.=0A=
+ *=0A=
+ *  You should have received a copy of the  GNU General Public License =
along=0A=
+ *  with this program; if not, write  to the Free Software Foundation, =
Inc.,=0A=
+ *  675 Mass Ave, Cambridge, MA 02139, USA.=0A=
+ *=0A=
+ =
************************************************************************=
**=0A=
+ */=0A=
+=0A=
+enum=0A=
+{=0A=
+	PCI0_PhysicalAddress	=3D 0x18080000,=0A=
+	PCI_PhysicalAddress	=3D PCI0_PhysicalAddress,=0A=
+=0A=
+	PCI0_VirtualAddress	=3D 0xb8080000,=0A=
+	PCI_VirtualAddress	=3D PCI0_VirtualAddress,=0A=
+} ;=0A=
+=0A=
+enum=0A=
+{=0A=
+	PCI_LbaCount	=3D 4,		// Local base addresses.=0A=
+} ;=0A=
+=0A=
+typedef struct=0A=
+{=0A=
+	u32	a ;		// Address.=0A=
+	u32	c ;		// Control.=0A=
+	u32	m ;		// mapping.=0A=
+} PCI_Map_s ;=0A=
+=0A=
+typedef struct=0A=
+{=0A=
+	u32		pcic ;=0A=
+	u32		pcis ;=0A=
+	u32		pcism ;=0A=
+	u32		pcicfga ;=0A=
+	u32		pcicfgd ;=0A=
+	PCI_Map_s	pcilba [PCI_LbaCount] ;=0A=
+	u32		pcidac ;=0A=
+	u32		pcidas ;=0A=
+	u32		pcidasm ;=0A=
+	u32		pcidad ;=0A=
+	u32		pcidma8c ;=0A=
+	u32		pcidma9c ;=0A=
+	u32		pcitc ;=0A=
+} volatile *PCI_t ;=0A=
+=0A=
+// PCI messaging unit.=0A=
+enum=0A=
+{=0A=
+	PCIM_Count	=3D 2,=0A=
+} ;=0A=
+typedef struct=0A=
+{=0A=
+	u32		pciim [PCIM_Count] ;=0A=
+	u32		pciom [PCIM_Count] ;=0A=
+	u32		pciid ;=0A=
+	u32		pciiic ;=0A=
+	u32		pciiim ;=0A=
+	u32		pciiod ;=0A=
+	u32		pciioic ;=0A=
+	u32		pciioim ;=0A=
+} volatile *PCIM_t ;=0A=
+=0A=
+/**********************************************************************=
*********=0A=
+ *=0A=
+ * PCI Control Register=0A=
+ *=0A=
+ =
************************************************************************=
******/=0A=
+enum=0A=
+{=0A=
+	PCIC_en_b	=3D 0,=0A=
+	PCIC_en_m	=3D 0x00000001,=0A=
+	PCIC_tnr_b	=3D 1,=0A=
+	PCIC_tnr_m	=3D 0x00000002,=0A=
+	PCIC_sce_b	=3D 2,=0A=
+	PCIC_sce_m	=3D 0x00000004,=0A=
+	PCIC_ien_b	=3D 3,=0A=
+	PCIC_ien_m	=3D 0x00000008,=0A=
+	PCIC_aaa_b	=3D 4,=0A=
+	PCIC_aaa_m	=3D 0x00000010,=0A=
+	PCIC_eap_b	=3D 5,=0A=
+	PCIC_eap_m	=3D 0x00000020,=0A=
+	PCIC_pcim_b	=3D 6,=0A=
+	PCIC_pcim_m	=3D 0x000001c0,=0A=
+		PCIC_pcim_disabled_v	=3D 0,=0A=
+		PCIC_pcim_tnr_v 	=3D 1,	// Satellite - target not ready=0A=
+		PCIC_pcim_suspend_v	=3D 2,	// Satellite - suspended CPU.=0A=
+		PCIC_pcim_extern_v	=3D 3,	// Host - external arbiter.=0A=
+		PCIC_pcim_fixed_v	=3D 4,	// Host - fixed priority arb.=0A=
+		PCIC_pcim_roundrobin_v	=3D 5,	// Host - round robin priority.=0A=
+		PCIC_pcim_reserved6_v	=3D 6,=0A=
+		PCIC_pcim_reserved7_v	=3D 7,=0A=
+	PCIC_igm_b	=3D 9,=0A=
+	PCIC_igm_m	=3D 0x00000200,=0A=
+} ;=0A=
+=0A=
+/**********************************************************************=
*********=0A=
+ *=0A=
+ * PCI Status Register=0A=
+ *=0A=
+ =
************************************************************************=
******/=0A=
+enum {=0A=
+	PCIS_eed_b	=3D 0,=0A=
+	PCIS_eed_m	=3D 0x00000001,=0A=
+	PCIS_wr_b	=3D 1,=0A=
+	PCIS_wr_m	=3D 0x00000002,=0A=
+	PCIS_nmi_b	=3D 2,=0A=
+	PCIS_nmi_m	=3D 0x00000004,=0A=
+	PCIS_ii_b	=3D 3,=0A=
+	PCIS_ii_m	=3D 0x00000008,=0A=
+	PCIS_cwe_b	=3D 4,=0A=
+	PCIS_cwe_m	=3D 0x00000010,=0A=
+	PCIS_cre_b	=3D 5,=0A=
+	PCIS_cre_m	=3D 0x00000020,=0A=
+	PCIS_mdpe_b	=3D 6,=0A=
+	PCIS_mdpe_m	=3D 0x00000040,=0A=
+	PCIS_sta_b	=3D 7,=0A=
+	PCIS_sta_m	=3D 0x00000080,=0A=
+	PCIS_rta_b	=3D 8,=0A=
+	PCIS_rta_m	=3D 0x00000100,=0A=
+	PCIS_rma_b	=3D 9,=0A=
+	PCIS_rma_m	=3D 0x00000200,=0A=
+	PCIS_sse_b	=3D 10,=0A=
+	PCIS_sse_m	=3D 0x00000400,=0A=
+	PCIS_ose_b	=3D 11,=0A=
+	PCIS_ose_m	=3D 0x00000800,=0A=
+	PCIS_pe_b	=3D 12,=0A=
+	PCIS_pe_m	=3D 0x00001000,=0A=
+	PCIS_tae_b	=3D 13,=0A=
+	PCIS_tae_m	=3D 0x00002000,=0A=
+	PCIS_rle_b	=3D 14,=0A=
+	PCIS_rle_m	=3D 0x00004000,=0A=
+	PCIS_bme_b	=3D 15,=0A=
+	PCIS_bme_m	=3D 0x00008000,=0A=
+	PCIS_prd_b	=3D 16,=0A=
+	PCIS_prd_m	=3D 0x00010000,=0A=
+	PCIS_rip_b	=3D 17,=0A=
+	PCIS_rip_m	=3D 0x00020000,=0A=
+} ;=0A=
+=0A=
+/**********************************************************************=
*********=0A=
+ *=0A=
+ * PCI Status Mask Register=0A=
+ *=0A=
+ =
************************************************************************=
******/=0A=
+enum {=0A=
+	PCISM_eed_b		=3D 0,=0A=
+	PCISM_eed_m		=3D 0x00000001,=0A=
+	PCISM_wr_b		=3D 1,=0A=
+	PCISM_wr_m		=3D 0x00000002,=0A=
+	PCISM_nmi_b		=3D 2,=0A=
+	PCISM_nmi_m		=3D 0x00000004,=0A=
+	PCISM_ii_b		=3D 3,=0A=
+	PCISM_ii_m		=3D 0x00000008,=0A=
+	PCISM_cwe_b		=3D 4,=0A=
+	PCISM_cwe_m		=3D 0x00000010,=0A=
+	PCISM_cre_b		=3D 5,=0A=
+	PCISM_cre_m		=3D 0x00000020,=0A=
+	PCISM_mdpe_b		=3D 6,=0A=
+	PCISM_mdpe_m		=3D 0x00000040,=0A=
+	PCISM_sta_b		=3D 7,=0A=
+	PCISM_sta_m		=3D 0x00000080,=0A=
+	PCISM_rta_b		=3D 8,=0A=
+	PCISM_rta_m		=3D 0x00000100,=0A=
+	PCISM_rma_b		=3D 9,=0A=
+	PCISM_rma_m		=3D 0x00000200,=0A=
+	PCISM_sse_b		=3D 10,=0A=
+	PCISM_sse_m		=3D 0x00000400,=0A=
+	PCISM_ose_b		=3D 11,=0A=
+	PCISM_ose_m		=3D 0x00000800,=0A=
+	PCISM_pe_b		=3D 12,=0A=
+	PCISM_pe_m		=3D 0x00001000,=0A=
+	PCISM_tae_b		=3D 13,=0A=
+	PCISM_tae_m		=3D 0x00002000,=0A=
+	PCISM_rle_b		=3D 14,=0A=
+	PCISM_rle_m		=3D 0x00004000,=0A=
+	PCISM_bme_b		=3D 15,=0A=
+	PCISM_bme_m		=3D 0x00008000,=0A=
+	PCISM_prd_b		=3D 16,=0A=
+	PCISM_prd_m		=3D 0x00010000,=0A=
+	PCISM_rip_b		=3D 17,=0A=
+	PCISM_rip_m		=3D 0x00020000,=0A=
+} ;=0A=
+=0A=
+/**********************************************************************=
*********=0A=
+ *=0A=
+ * PCI Configuration Address Register=0A=
+ *=0A=
+ =
************************************************************************=
******/=0A=
+enum {=0A=
+	PCICFGA_reg_b		=3D 2,=0A=
+	PCICFGA_reg_m		=3D 0x000000fc,=0A=
+		PCICFGA_reg_id_v	=3D 0x00>>2, //use PCFGID_=0A=
+		PCICFGA_reg_04_v	=3D 0x04>>2, //use PCFG04_=0A=
+		PCICFGA_reg_08_v	=3D 0x08>>2, //use PCFG08_=0A=
+		PCICFGA_reg_0C_v	=3D 0x0C>>2, //use PCFG0C_=0A=
+		PCICFGA_reg_pba0_v	=3D 0x10>>2, //use PCIPBA_=0A=
+		PCICFGA_reg_pba1_v	=3D 0x14>>2, //use PCIPBA_=0A=
+		PCICFGA_reg_pba2_v	=3D 0x18>>2, //use PCIPBA_=0A=
+		PCICFGA_reg_pba3_v	=3D 0x1c>>2, //use PCIPBA_=0A=
+		PCICFGA_reg_subsystem_v =3D 0x2c>>2, //use PCFGSS_=0A=
+		PCICFGA_reg_3C_v	=3D 0x3C>>2, //use PCFG3C_=0A=
+		PCICFGA_reg_pba0c_v	=3D 0x44>>2, //use PCIPBAC_=0A=
+		PCICFGA_reg_pba0m_v	=3D 0x48>>2,=0A=
+		PCICFGA_reg_pba1c_v	=3D 0x4c>>2, //use PCIPBAC_=0A=
+		PCICFGA_reg_pba1m_v	=3D 0x50>>2,=0A=
+		PCICFGA_reg_pba2c_v	=3D 0x54>>2, //use PCIPBAC_=0A=
+		PCICFGA_reg_pba2m_v	=3D 0x58>>2,=0A=
+		PCICFGA_reg_pba3c_v	=3D 0x5c>>2, //use PCIPBAC_=0A=
+		PCICFGA_reg_pba3m_v	=3D 0x60>>2,=0A=
+		PCICFGA_reg_pmgt_v	=3D 0x64>>2,=0A=
+	PCICFGA_func_b		=3D 8,=0A=
+	PCICFGA_func_m		=3D 0x00000700,=0A=
+	PCICFGA_dev_b		=3D 11,=0A=
+	PCICFGA_dev_m		=3D 0x0000f800,=0A=
+		PCICFGA_dev_internal_v	=3D 0,=0A=
+	PCICFGA_bus_b		=3D 16,=0A=
+	PCICFGA_bus_m		=3D 0x00ff0000,=0A=
+		PCICFGA_bus_type0_v	=3D 0,	//local bus=0A=
+	PCICFGA_en_b		=3D 31,		// read only=0A=
+	PCICFGA_en_m		=3D 0x80000000,=0A=
+} ;=0A=
+=0A=
+enum {=0A=
+	PCFGID_vendor_b 	=3D 0,=0A=
+	PCFGID_vendor_m 	=3D 0x0000ffff,=0A=
+		PCFGID_vendor_IDT_v		=3D 0x111d,=0A=
+	PCFGID_device_b 	=3D 16,=0A=
+	PCFGID_device_m 	=3D 0xffff0000,=0A=
+		PCFGID_device_Acaciade_v	=3D 0x0207,=0A=
+=0A=
+	PCFG04_command_ioena_b		=3D 1,=0A=
+	PCFG04_command_ioena_m		=3D 0x00000001,=0A=
+	PCFG04_command_memena_b 	=3D 2,=0A=
+	PCFG04_command_memena_m 	=3D 0x00000002,=0A=
+	PCFG04_command_bmena_b		=3D 3,=0A=
+	PCFG04_command_bmena_m		=3D 0x00000004,=0A=
+	PCFG04_command_mwinv_b		=3D 5,=0A=
+	PCFG04_command_mwinv_m		=3D 0x00000010,=0A=
+	PCFG04_command_parena_b 	=3D 7,=0A=
+	PCFG04_command_parena_m 	=3D 0x00000040,=0A=
+	PCFG04_command_serrena_b	=3D 9,=0A=
+	PCFG04_command_serrena_m	=3D 0x00000100,=0A=
+	PCFG04_command_fastbbena_b	=3D 10,=0A=
+	PCFG04_command_fastbbena_m	=3D 0x00000200,=0A=
+	PCFG04_status_b 		=3D 16,=0A=
+	PCFG04_status_m 		=3D 0xffff0000,=0A=
+	PCFG04_status_66MHz_b		=3D 21,	// 66 MHz enable=0A=
+	PCFG04_status_66MHz_m		=3D 0x00200000,=0A=
+	PCFG04_status_fbb_b		=3D 23,=0A=
+	PCFG04_status_fbb_m		=3D 0x00800000,=0A=
+	PCFG04_status_mdpe_b		=3D 24,=0A=
+	PCFG04_status_mdpe_m		=3D 0x01000000,=0A=
+	PCFG04_status_dst_b		=3D 25,=0A=
+	PCFG04_status_dst_m		=3D 0x06000000,=0A=
+	PCFG04_status_sta_b		=3D 27,=0A=
+	PCFG04_status_sta_m		=3D 0x08000000,=0A=
+	PCFG04_status_rta_b		=3D 28,=0A=
+	PCFG04_status_rta_m		=3D 0x10000000,=0A=
+	PCFG04_status_rma_b		=3D 29,=0A=
+	PCFG04_status_rma_m		=3D 0x20000000,=0A=
+	PCFG04_status_sse_b		=3D 30,=0A=
+	PCFG04_status_sse_m		=3D 0x40000000,=0A=
+	PCFG04_status_pe_b		=3D 31,=0A=
+	PCFG04_status_pe_m		=3D 0x40000000,=0A=
+=0A=
+	PCFG08_revId_b			=3D 0,=0A=
+	PCFG08_revId_m			=3D 0x000000ff,=0A=
+	PCFG08_classCode_b		=3D 0,=0A=
+	PCFG08_classCode_m		=3D 0xffffff00,=0A=
+		PCFG08_classCode_bridge_v	=3D 06,=0A=
+		PCFG08_classCode_proc_v 	=3D 0x0b3000, // processor-MIPS=0A=
+	PCFG0C_cacheline_b		=3D 0,=0A=
+	PCFG0C_cacheline_m		=3D 0x000000ff,=0A=
+	PCFG0C_masterLatency_b		=3D 8,=0A=
+	PCFG0C_masterLatency_m		=3D 0x0000ff00,=0A=
+	PCFG0C_headerType_b		=3D 16,=0A=
+	PCFG0C_headerType_m		=3D 0x00ff0000,=0A=
+	PCFG0C_bist_b			=3D 24,=0A=
+	PCFG0C_bist_m			=3D 0xff000000,=0A=
+=0A=
+	PCIPBA_msi_b			=3D 0,=0A=
+	PCIPBA_msi_m			=3D 0x00000001,=0A=
+	PCIPBA_p_b			=3D 3,=0A=
+	PCIPBA_p_m			=3D 0x00000004,=0A=
+	PCIPBA_baddr_b			=3D 8,=0A=
+	PCIPBA_baddr_m			=3D 0xffffff00,=0A=
+=0A=
+	PCFGSS_vendorId_b		=3D 0,=0A=
+	PCFGSS_vendorId_m		=3D 0x0000ffff,=0A=
+	PCFGSS_id_b			=3D 16,=0A=
+	PCFGSS_id_m			=3D 0xffff0000,=0A=
+=0A=
+	PCFG3C_interruptLine_b		=3D 0,=0A=
+	PCFG3C_interruptLine_m		=3D 0x000000ff,=0A=
+	PCFG3C_interruptPin_b		=3D 8,=0A=
+	PCFG3C_interruptPin_m		=3D 0x0000ff00,=0A=
+	PCFG3C_minGrant_b		=3D 16,=0A=
+	PCFG3C_minGrant_m		=3D 0x00ff0000,=0A=
+	PCFG3C_maxLat_b 		=3D 24,=0A=
+	PCFG3C_maxLat_m 		=3D 0xff000000,=0A=
+=0A=
+	PCIPBAC_msi_b			=3D 0,=0A=
+	PCIPBAC_msi_m			=3D 0x00000001,=0A=
+	PCIPBAC_p_b			=3D 1,=0A=
+	PCIPBAC_p_m			=3D 0x00000002,=0A=
+	PCIPBAC_size_b			=3D 2,=0A=
+	PCIPBAC_size_m			=3D 0x0000007c,=0A=
+	PCIPBAC_sb_b			=3D 7,=0A=
+	PCIPBAC_sb_m			=3D 0x00000080,=0A=
+	PCIPBAC_pp_b			=3D 8,=0A=
+	PCIPBAC_pp_m			=3D 0x00000100,=0A=
+	PCIPBAC_mr_b			=3D 9,=0A=
+	PCIPBAC_mr_m			=3D 0x00000600,=0A=
+		PCIPBAC_mr_read_v	=3D0,	//no prefetching=0A=
+		PCIPBAC_mr_readLine_v	=3D1,=0A=
+		PCIPBAC_mr_readMult_v	=3D2,=0A=
+	PCIPBAC_mrl_b			=3D 11,=0A=
+	PCIPBAC_mrl_m			=3D 0x00000800,=0A=
+	PCIPBAC_mrm_b			=3D 12,=0A=
+	PCIPBAC_mrm_m			=3D 0x00001000,=0A=
+	PCIPBAC_trp_b			=3D 13,=0A=
+	PCIPBAC_trp_m			=3D 0x00002000,=0A=
+=0A=
+	PCFG40_trdyTimeout_b		=3D 0,=0A=
+	PCFG40_trdyTimeout_m		=3D 0x000000ff,=0A=
+	PCFG40_retryLim_b		=3D 8,=0A=
+	PCFG40_retryLim_m		=3D 0x0000ff00,=0A=
+};=0A=
+=0A=
+/**********************************************************************=
*********=0A=
+ *=0A=
+ * PCI Local Base Address [0|1|2|3] Register=0A=
+ *=0A=
+ =
************************************************************************=
******/=0A=
+enum {=0A=
+	PCILBA_baddr_b		=3D 0,		// In PCI_t -> pcilba [] .a=0A=
+	PCILBA_baddr_m		=3D 0xffffff00,=0A=
+} ;=0A=
+/**********************************************************************=
*********=0A=
+ *=0A=
+ * PCI Local Base Address Control Register=0A=
+ *=0A=
+ =
************************************************************************=
******/=0A=
+enum {=0A=
+	PCILBAC_msi_b		=3D 0,		// In pPci->pcilba[i].c=0A=
+	PCILBAC_msi_m		=3D 0x00000001,=0A=
+		PCILBAC_msi_mem_v	=3D 0,=0A=
+		PCILBAC_msi_io_v	=3D 1,=0A=
+	PCILBAC_size_b		=3D 2,	// In pPci->pcilba[i].c=0A=
+	PCILBAC_size_m		=3D 0x0000007c,=0A=
+	PCILBAC_sb_b		=3D 7,	// In pPci->pcilba[i].c=0A=
+	PCILBAC_sb_m		=3D 0x00000080,=0A=
+	PCILBAC_rt_b		=3D 8,	// In pPci->pcilba[i].c=0A=
+	PCILBAC_rt_m		=3D 0x00000100,=0A=
+		PCILBAC_rt_noprefetch_v =3D 0, // mem read=0A=
+		PCILBAC_rt_prefetch_v	=3D 1, // mem readline=0A=
+} ;=0A=
+=0A=
+/**********************************************************************=
*********=0A=
+ *=0A=
+ * PCI Local Base Address [0|1|2|3] Mapping Register=0A=
+ *=0A=
+ =
************************************************************************=
******/=0A=
+enum {=0A=
+	PCILBAM_maddr_b 	=3D 8,=0A=
+	PCILBAM_maddr_m 	=3D 0xffffff00,=0A=
+} ;=0A=
+=0A=
+/**********************************************************************=
*********=0A=
+ *=0A=
+ * PCI Decoupled Access Control Register=0A=
+ *=0A=
+ =
************************************************************************=
******/=0A=
+enum {=0A=
+	PCIDAC_den_b		=3D 0,=0A=
+	PCIDAC_den_m		=3D 0x00000001,=0A=
+} ;=0A=
+=0A=
+/**********************************************************************=
*********=0A=
+ *=0A=
+ * PCI Decoupled Access Status Register=0A=
+ *=0A=
+ =
************************************************************************=
******/=0A=
+enum {=0A=
+	PCIDAS_d_b	=3D 0,=0A=
+	PCIDAS_d_m	=3D 0x00000001,=0A=
+	PCIDAS_b_b	=3D 1,=0A=
+	PCIDAS_b_m	=3D 0x00000002,=0A=
+	PCIDAS_e_b	=3D 2,=0A=
+	PCIDAS_e_m	=3D 0x00000004,=0A=
+	PCIDAS_ofe_b	=3D 3,=0A=
+	PCIDAS_ofe_m	=3D 0x00000008,=0A=
+	PCIDAS_off_b	=3D 4,=0A=
+	PCIDAS_off_m	=3D 0x00000010,=0A=
+	PCIDAS_ife_b	=3D 5,=0A=
+	PCIDAS_ife_m	=3D 0x00000020,=0A=
+	PCIDAS_iff_b	=3D 6,=0A=
+	PCIDAS_iff_m	=3D 0x00000040,=0A=
+} ;=0A=
+=0A=
+/**********************************************************************=
*********=0A=
+ *=0A=
+ * PCI DMA Channel 8 Configuration Register=0A=
+ *=0A=
+ =
************************************************************************=
******/=0A=
+enum=0A=
+{=0A=
+	PCIDMA8C_mbs_b	=3D 0,		// Maximum Burst Size.=0A=
+	PCIDMA8C_mbs_m	=3D 0x00000fff,	// { pcidma8c }=0A=
+	PCIDMA8C_our_b	=3D 12,		// Optimize Unaligned Burst Reads.=0A=
+	PCIDMA8C_our_m	=3D 0x00001000,	// { pcidma8c }=0A=
+} ;=0A=
+=0A=
+/**********************************************************************=
*********=0A=
+ *=0A=
+ * PCI DMA Channel 9 Configuration Register=0A=
+ *=0A=
+ =
************************************************************************=
******/=0A=
+enum=0A=
+{=0A=
+	PCIDMA9C_mbs_b	=3D 0,		// Maximum Burst Size.=0A=
+	PCIDMA9C_mbs_m	=3D 0x00000fff, // { pcidma9c }=0A=
+} ;=0A=
+=0A=
+/**********************************************************************=
*********=0A=
+ *=0A=
+ * PCI to Memory(DMA Channel 8) AND Memory to PCI DMA(DMA Channel =
9)Descriptors=0A=
+ *=0A=
+ =
************************************************************************=
******/=0A=
+enum {=0A=
+	PCIDMAD_pt_b		=3D 22,		// in DEVCMD field (descriptor)=0A=
+	PCIDMAD_pt_m		=3D 0x00c00000,	// preferred transaction field=0A=
+		// These are for reads (DMA channel 8)=0A=
+		PCIDMAD_devcmd_mr_v	=3D 0,	//memory read=0A=
+		PCIDMAD_devcmd_mrl_v	=3D 1,	//memory read line=0A=
+		PCIDMAD_devcmd_mrm_v	=3D 2,	//memory read multiple=0A=
+		PCIDMAD_devcmd_ior_v	=3D 3,	//I/O read=0A=
+		// These are for writes (DMA channel 9)=0A=
+		PCIDMAD_devcmd_mw_v	=3D 0,	//memory write=0A=
+		PCIDMAD_devcmd_mwi_v	=3D 1,	//memory write invalidate=0A=
+		PCIDMAD_devcmd_iow_v	=3D 3,	//I/O write=0A=
+=0A=
+	// Swap byte field applies to both DMA channel 8 and 9=0A=
+	PCIDMAD_sb_b		=3D 24,		// in DEVCMD field (descriptor)=0A=
+	PCIDMAD_sb_m		=3D 0x01000000,	// swap byte field=0A=
+} ;=0A=
+=0A=
+=0A=
+/**********************************************************************=
*********=0A=
+ *=0A=
+ * PCI Target Control Register=0A=
+ *=0A=
+ =
************************************************************************=
******/=0A=
+enum=0A=
+{=0A=
+	PCITC_rtimer_b		=3D 0,		// In PCITC_t -> pcitc=0A=
+	PCITC_rtimer_m		=3D 0x000000ff,=0A=
+	PCITC_dtimer_b		=3D 8,		// In PCITC_t -> pcitc=0A=
+	PCITC_dtimer_m		=3D 0x0000ff00,=0A=
+	PCITC_rdr_b		=3D 18,		// In PCITC_t -> pcitc=0A=
+	PCITC_rdr_m		=3D 0x00040000,=0A=
+	PCITC_ddt_b		=3D 19,		// In PCITC_t -> pcitc=0A=
+	PCITC_ddt_m		=3D 0x00080000,=0A=
+} ;=0A=
+/**********************************************************************=
*********=0A=
+ *=0A=
+ * PCI messaging unit [applies to both inbound and outbound registers =
]=0A=
+ *=0A=
+ =
************************************************************************=
******/=0A=
+enum=0A=
+{=0A=
+	PCIM_m0_b	=3D 0,		// In PCIM_t -> {pci{iic,iim,ioic,ioim}}=0A=
+	PCIM_m0_m	=3D 0x00000001,	// inbound or outbound message 0=0A=
+	PCIM_m1_b	=3D 1,		// In PCIM_t -> {pci{iic,iim,ioic,ioim}}=0A=
+	PCIM_m1_m	=3D 0x00000002,	// inbound or outbound message 1=0A=
+	PCIM_db_b	=3D 2,		// In PCIM_t -> {pci{iic,iim,ioic,ioim}}=0A=
+	PCIM_db_m	=3D 0x00000004,	// inbound or outbound doorbell=0A=
+};=0A=
+=0A=
diff -uNr =
linux-2.6.16-rc5/include/asm-mips/idt-boards/rc32438/rc32438_pci_v.h =
acacia/include/asm-mips/idt-boards/rc32438/rc32438_pci_v.h=0A=
--- =
linux-2.6.16-rc5/include/asm-mips/idt-boards/rc32438/rc32438_pci_v.h	=
1969-12-31 16:00:00.000000000 -0800=0A=
+++ acacia/include/asm-mips/idt-boards/rc32438/rc32438_pci_v.h	=
2006-03-14 10:47:28.000000000 -0800=0A=
@@ -0,0 +1,183 @@=0A=
+/**********************************************************************=
****=0A=
+ *=0A=
+ *  BRIEF MODULE DESCRIPTION=0A=
+ *   Definitions for IDT RC32438 PCI setup.=0A=
+ *=0A=
+ *  Copyright 2006 IDT Inc. (rischelp@idt.com)=0A=
+ *         =0A=
+ *  This program is free software; you can redistribute  it and/or =
modify it=0A=
+ *  under  the terms of  the GNU General  Public License as published =
by the=0A=
+ *  Free Software Foundation;  either version 2 of the  License, or =
(at your=0A=
+ *  option) any later version.=0A=
+ *=0A=
+ *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR =
IMPLIED=0A=
+ *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED =
WARRANTIES OF=0A=
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE =
DISCLAIMED.  IN=0A=
+ *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, =
INDIRECT,=0A=
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES =
(INCLUDING, BUT=0A=
+ *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; =
LOSS OF=0A=
+ *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED =
AND ON=0A=
+ *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, =
OR TORT=0A=
+ *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE =
USE OF=0A=
+ *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH =
DAMAGE.=0A=
+ *=0A=
+ *  You should have received a copy of the  GNU General Public License =
along=0A=
+ *  with this program; if not, write  to the Free Software Foundation, =
Inc.,=0A=
+ *  675 Mass Ave, Cambridge, MA 02139, USA.=0A=
+ *=0A=
+ *=0A=
+ =
************************************************************************=
**=0A=
+ */=0A=
+=0A=
+#define PCI_MSG_VirtualAddress	     0xB8088010=0A=
+#define rc32438_pci ((volatile PCI_t) PCI0_VirtualAddress)=0A=
+#define rc32438_pci_msg ((volatile PCIM_t) PCI_MSG_VirtualAddress)=0A=
+=0A=
+#define PCIM_SHFT		0x6=0A=
+#define PCIM_BIT_LEN		0x7=0A=
+#define PCIM_H_EA		0x3=0A=
+#define PCIM_H_IA_FIX		0x4=0A=
+#define PCIM_H_IA_RR		0x5=0A=
+=0A=
+#define PCI_ADDR_START		0x50000000=0A=
+=0A=
+#define CPUTOPCI_MEM_WIN	0x02000000=0A=
+#define CPUTOPCI_IO_WIN		0x00100000=0A=
+#define PCILBA_SIZE_SHFT	2=0A=
+#define PCILBA_SIZE_MASK	0x1F=0A=
+#define SIZE_256MB		0x1C=0A=
+#define SIZE_128MB		0x1B=0A=
+#define SIZE_64MB               0x1A=0A=
+#define SIZE_32MB		0x19=0A=
+#define SIZE_16MB               0x18=0A=
+#define SIZE_4MB		0x16=0A=
+#define SIZE_2MB		0x15=0A=
+#define SIZE_1MB		0x14=0A=
+#define ACACIA_CONFIG0_ADDR	0x80000000=0A=
+#define ACACIA_CONFIG1_ADDR	0x80000004=0A=
+#define ACACIA_CONFIG2_ADDR	0x80000008=0A=
+#define ACACIA_CONFIG3_ADDR	0x8000000C=0A=
+#define ACACIA_CONFIG4_ADDR	0x80000010=0A=
+#define ACACIA_CONFIG5_ADDR	0x80000014=0A=
+#define ACACIA_CONFIG6_ADDR	0x80000018=0A=
+#define ACACIA_CONFIG7_ADDR	0x8000001C=0A=
+#define ACACIA_CONFIG8_ADDR	0x80000020=0A=
+#define ACACIA_CONFIG9_ADDR	0x80000024=0A=
+#define ACACIA_CONFIG10_ADDR	0x80000028=0A=
+#define ACACIA_CONFIG11_ADDR	0x8000002C=0A=
+#define ACACIA_CONFIG12_ADDR	0x80000030=0A=
+#define ACACIA_CONFIG13_ADDR	0x80000034=0A=
+#define ACACIA_CONFIG14_ADDR	0x80000038=0A=
+#define ACACIA_CONFIG15_ADDR	0x8000003C=0A=
+#define ACACIA_CONFIG16_ADDR	0x80000040=0A=
+#define ACACIA_CONFIG17_ADDR	0x80000044=0A=
+#define ACACIA_CONFIG18_ADDR	0x80000048=0A=
+#define ACACIA_CONFIG19_ADDR	0x8000004C=0A=
+#define ACACIA_CONFIG20_ADDR	0x80000050=0A=
+#define ACACIA_CONFIG21_ADDR	0x80000054=0A=
+#define ACACIA_CONFIG22_ADDR	0x80000058=0A=
+#define ACACIA_CONFIG23_ADDR	0x8000005C=0A=
+#define ACACIA_CONFIG24_ADDR	0x80000060=0A=
+#define ACACIA_CONFIG25_ADDR	0x80000064=0A=
+#define ACACIA_CMD 		(PCFG04_command_ioena_m | \=0A=
+				 PCFG04_command_memena_m | \=0A=
+				 PCFG04_command_bmena_m | \=0A=
+				 PCFG04_command_mwinv_m | \=0A=
+				 PCFG04_command_parena_m | \=0A=
+				 PCFG04_command_serrena_m )=0A=
+=0A=
+#define ACACIA_STAT		(PCFG04_status_mdpe_m | \=0A=
+				 PCFG04_status_sta_m  | \=0A=
+				 PCFG04_status_rta_m  | \=0A=
+				 PCFG04_status_rma_m  | \=0A=
+				 PCFG04_status_sse_m  | \=0A=
+				 PCFG04_status_pe_m)=0A=
+=0A=
+#define ACACIA_CNFG1		((ACACIA_STAT<<16)|ACACIA_CMD)=0A=
+=0A=
+#define ACACIA_REVID		0=0A=
+#define ACACIA_CLASS_CODE	0=0A=
+#define ACACIA_CNFG2		((ACACIA_CLASS_CODE<<8) | \=0A=
+				  ACACIA_REVID)=0A=
+=0A=
+#define ACACIA_CACHE_LINE_SIZE	4=0A=
+#define ACACIA_MASTER_LAT	0x3c=0A=
+#define ACACIA_HEADER_TYPE	0=0A=
+#define ACACIA_BIST		0=0A=
+=0A=
+#define ACACIA_CNFG3 ((ACACIA_BIST << 24) | \=0A=
+		      (ACACIA_HEADER_TYPE<<16) | \=0A=
+		      (ACACIA_MASTER_LAT<<8) | \=0A=
+		      ACACIA_CACHE_LINE_SIZE )=0A=
+=0A=
+#define ACACIA_BAR0	0x00000008 /* 128 MB Memory */=0A=
+#define ACACIA_BAR1	0x18800001 /* 1 MB IO */=0A=
+#define ACACIA_BAR2	0x18000001 /* 2 MB IO window for Acacia=0A=
+					internal Registers */=0A=
+#define ACACIA_BAR3	0x48000008 /* Spare 128 MB Memory */=0A=
+=0A=
+#define ACACIA_CNFG4	ACACIA_BAR0=0A=
+#define ACACIA_CNFG5    ACACIA_BAR1=0A=
+#define ACACIA_CNFG6 	ACACIA_BAR2=0A=
+#define ACACIA_CNFG7	ACACIA_BAR3=0A=
+=0A=
+#define ACACIA_SUBSYS_VENDOR_ID 0=0A=
+#define ACACIA_SUBSYSTEM_ID	0=0A=
+#define ACACIA_CNFG8		0=0A=
+#define ACACIA_CNFG9		0=0A=
+#define ACACIA_CNFG10		0=0A=
+#define ACACIA_CNFG11 	((ACACIA_SUBSYS_VENDOR_ID<<16) | \=0A=
+			  ACACIA_SUBSYSTEM_ID)=0A=
+#define ACACIA_INT_LINE		1=0A=
+#define ACACIA_INT_PIN		1=0A=
+#define ACACIA_MIN_GNT		8=0A=
+#define ACACIA_MAX_LAT		0x38=0A=
+#define ACACIA_CNFG12		0=0A=
+#define ACACIA_CNFG13 		0=0A=
+#define ACACIA_CNFG14		0=0A=
+#define ACACIA_CNFG15	((ACACIA_MAX_LAT<<24) | \=0A=
+			 (ACACIA_MIN_GNT<<16) | \=0A=
+			 (ACACIA_INT_PIN<<8)  | \=0A=
+			  ACACIA_INT_LINE)=0A=
+#define	ACACIA_RETRY_LIMIT	0x80=0A=
+#define ACACIA_TRDY_LIMIT	0x80=0A=
+#define ACACIA_CNFG16 ((ACACIA_RETRY_LIMIT<<8) | \=0A=
+			ACACIA_TRDY_LIMIT)=0A=
+#define PCI_PBAxC_R		0x0=0A=
+#define PCI_PBAxC_RL		0x1=0A=
+#define PCI_PBAxC_RM		0x2=0A=
+#define SIZE_SHFT		2=0A=
+=0A=
+#define ACACIA_PBA0C	( PCIPBAC_mrl_m | PCIPBAC_sb_m | \=0A=
+			  ((PCI_PBAxC_RM &0x3) << PCIPBAC_mr_b) | \=0A=
+			  PCIPBAC_pp_m | \=0A=
+			  (SIZE_128MB<<SIZE_SHFT) | \=0A=
+			   PCIPBAC_p_m)=0A=
+=0A=
+#define ACACIA_CNFG17	ACACIA_PBA0C=0A=
+#define ACACIA_PBA0M	0x0=0A=
+#define ACACIA_CNFG18	ACACIA_PBA0M=0A=
+=0A=
+#define ACACIA_PBA1C	((SIZE_1MB<<SIZE_SHFT) | PCIPBAC_sb_m | \=0A=
+			  PCIPBAC_msi_m)=0A=
+=0A=
+#define ACACIA_CNFG19	ACACIA_PBA1C=0A=
+#define ACACIA_PBA1M	0x0=0A=
+#define ACACIA_CNFG20	ACACIA_PBA1M=0A=
+=0A=
+#define ACACIA_PBA2C	((SIZE_2MB<<SIZE_SHFT) | PCIPBAC_sb_m | \=0A=
+			  PCIPBAC_msi_m)=0A=
+=0A=
+#define ACACIA_CNFG21	ACACIA_PBA2C=0A=
+#define ACACIA_PBA2M	0x18000000=0A=
+#define ACACIA_CNFG22	ACACIA_PBA2M=0A=
+#define ACACIA_PBA3C	0=0A=
+#define ACACIA_CNFG23	ACACIA_PBA3C=0A=
+#define ACACIA_PBA3M	0=0A=
+#define ACACIA_CNFG24	ACACIA_PBA3M=0A=
+=0A=
+=0A=
+=0A=
+#define	PCITC_DTIMER_VAL	8=0A=
+#define PCITC_RTIMER_VAL	0x10=0A=
+=0A=
diff -uNr =
linux-2.6.16-rc5/include/asm-mips/idt-boards/rc32438/rc32438_timer.h =
acacia/include/asm-mips/idt-boards/rc32438/rc32438_timer.h=0A=
--- =
linux-2.6.16-rc5/include/asm-mips/idt-boards/rc32438/rc32438_timer.h	=
1969-12-31 16:00:00.000000000 -0800=0A=
+++ acacia/include/asm-mips/idt-boards/rc32438/rc32438_timer.h	=
2006-03-14 10:47:28.000000000 -0800=0A=
@@ -0,0 +1,83 @@=0A=
+/**********************************************************************=
****=0A=
+ *=0A=
+ *  BRIEF MODULE DESCRIPTION=0A=
+ *    Timer register definition IDT RC32438 CPU.=0A=
+ *=0A=
+ *  Copyright 2006 IDT Inc. (rischelp@idt.com)=0A=
+ *         =0A=
+ *  This program is free software; you can redistribute  it and/or =
modify it=0A=
+ *  under  the terms of  the GNU General  Public License as published =
by the=0A=
+ *  Free Software Foundation;  either version 2 of the  License, or =
(at your=0A=
+ *  option) any later version.=0A=
+ *=0A=
+ *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR =
IMPLIED=0A=
+ *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED =
WARRANTIES OF=0A=
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE =
DISCLAIMED.  IN=0A=
+ *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, =
INDIRECT,=0A=
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES =
(INCLUDING, BUT=0A=
+ *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; =
LOSS OF=0A=
+ *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED =
AND ON=0A=
+ *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, =
OR TORT=0A=
+ *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE =
USE OF=0A=
+ *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH =
DAMAGE.=0A=
+ *=0A=
+ *  You should have received a copy of the  GNU General Public License =
along=0A=
+ *  with this program; if not, write  to the Free Software Foundation, =
Inc.,=0A=
+ *  675 Mass Ave, Cambridge, MA 02139, USA.=0A=
+ *=0A=
+ =
************************************************************************=
**=0A=
+ */=0A=
+ =0A=
+#ifndef __IDT_RC32438_TIM_H__=0A=
+#define __IDT_RC32438_TIM_H__=0A=
+=0A=
+enum=0A=
+{=0A=
+	TIM0_PhysicalAddress	=3D 0x18028000,=0A=
+	TIM_PhysicalAddress	=3D TIM0_PhysicalAddress,		// Default=0A=
+=0A=
+	TIM0_VirtualAddress	=3D 0xb8028000,=0A=
+	TIM_VirtualAddress	=3D TIM0_VirtualAddress,		// Default=0A=
+} ;=0A=
+=0A=
+enum=0A=
+{=0A=
+	TIM_Count =3D 3,=0A=
+} ;=0A=
+=0A=
+struct TIM_CNTR_s=0A=
+{=0A=
+	u32 count ;=0A=
+	u32 compare ;=0A=
+	u32 ctc ;	//use CTC_=0A=
+} ;=0A=
+=0A=
+typedef struct TIM_s=0A=
+{=0A=
+	struct TIM_CNTR_s	tim [TIM_Count] ;=0A=
+	u32			rcount ;	//use RCOUNT_=0A=
+	u32			rcompare ;	//use RCOMPARE_=0A=
+	u32			rtc ;		//use RTC_=0A=
+} volatile * TIM_t ;=0A=
+=0A=
+enum=0A=
+{=0A=
+	CTC_en_b	=3D 0,		=0A=
+	CTC_en_m	=3D 0x00000001,=0A=
+	CTC_to_b	=3D 1,		 =0A=
+	CTC_to_m	=3D 0x00000002,=0A=
+=0A=
+	RCOUNT_count_b		=3D 0,	     =0A=
+	RCOUNT_count_m		=3D 0x0000ffff,=0A=
+	RCOMPARE_compare_b	=3D 0,	   =0A=
+	RCOMPARE_compare_m	=3D 0x0000ffff,=0A=
+	RTC_ce_b		=3D 0,		=0A=
+	RTC_ce_m		=3D 0x00000001,=0A=
+	RTC_to_b		=3D 1,		=0A=
+	RTC_to_m		=3D 0x00000002,=0A=
+	RTC_rqe_b		=3D 2,		=0A=
+	RTC_rqe_m		=3D 0x00000004,=0A=
+				 =0A=
+} ;=0A=
+#endif	//__IDT_RC32438_TIM_H__=0A=
+=0A=
diff -uNr linux-2.6.16-rc5/include/asm-mips/mach-idt/irq.h =
acacia/include/asm-mips/mach-idt/irq.h=0A=
--- linux-2.6.16-rc5/include/asm-mips/mach-idt/irq.h	1969-12-31 =
16:00:00.000000000 -0800=0A=
+++ acacia/include/asm-mips/mach-idt/irq.h	2006-03-14 =
13:56:37.000000000 -0800=0A=
@@ -0,0 +1,40 @@=0A=
+/**********************************************************************=
****=0A=
+ *=0A=
+ *  BRIEF MODULE DESCRIPTION=0A=
+ *   NR_IRQS for IDT boards=0A=
+ *=0A=
+ *  Copyright 2006 IDT Inc. (rischelp@idt.com)=0A=
+ *         =0A=
+ *  This program is free software; you can redistribute  it and/or =
modify it=0A=
+ *  under  the terms of  the GNU General  Public License as published =
by the=0A=
+ *  Free Software Foundation;  either version 2 of the  License, or =
(at your=0A=
+ *  option) any later version.=0A=
+ *=0A=
+ *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR =
IMPLIED=0A=
+ *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED =
WARRANTIES OF=0A=
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE =
DISCLAIMED.  IN=0A=
+ *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, =
INDIRECT,=0A=
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES =
(INCLUDING, BUT=0A=
+ *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; =
LOSS OF=0A=
+ *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED =
AND ON=0A=
+ *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, =
OR TORT=0A=
+ *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE =
USE OF=0A=
+ *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH =
DAMAGE.=0A=
+ *=0A=
+ *  You should have received a copy of the  GNU General Public License =
along=0A=
+ *  with this program; if not, write  to the Free Software Foundation, =
Inc.,=0A=
+ *  675 Mass Ave, Cambridge, MA 02139, USA.=0A=
+ *=0A=
+ =
************************************************************************=
**=0A=
+ */=0A=
+=0A=
+#ifndef __ASM_MACH_IDT_IRQ_H__=0A=
+#define __ASM_MACH_IDT_IRQ_H__=0A=
+#include <linux/config.h>=0A=
+=0A=
+#ifdef CONFIG_IDT_EB438=0A=
+#include <asm/idt-boards/rc32438/rc32438.h>=0A=
+#define NR_IRQS RC32438_NR_IRQS=0A=
+#endif=0A=
+=0A=
+#endif //__ASM_MACH_IDT_IRQ_H__=0A=
diff -uNr linux-2.6.16-rc5/include/asm-mips/mach-idt/param.h =
acacia/include/asm-mips/mach-idt/param.h=0A=
--- linux-2.6.16-rc5/include/asm-mips/mach-idt/param.h	1969-12-31 =
16:00:00.000000000 -0800=0A=
+++ acacia/include/asm-mips/mach-idt/param.h	2006-03-14 =
10:47:28.000000000 -0800=0A=
@@ -0,0 +1,41 @@=0A=
+/**********************************************************************=
****=0A=
+ *=0A=
+ *  BRIEF MODULE DESCRIPTION=0A=
+ *   HZ for IDT boards=0A=
+ *=0A=
+ *  Copyright 2006 IDT Inc. (rischelp@idt.com)=0A=
+ *         =0A=
+ *  This program is free software; you can redistribute  it and/or =
modify it=0A=
+ *  under  the terms of  the GNU General  Public License as published =
by the=0A=
+ *  Free Software Foundation;  either version 2 of the  License, or =
(at your=0A=
+ *  option) any later version.=0A=
+ *=0A=
+ *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR =
IMPLIED=0A=
+ *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED =
WARRANTIES OF=0A=
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE =
DISCLAIMED.  IN=0A=
+ *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, =
INDIRECT,=0A=
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES =
(INCLUDING, BUT=0A=
+ *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; =
LOSS OF=0A=
+ *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED =
AND ON=0A=
+ *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, =
OR TORT=0A=
+ *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE =
USE OF=0A=
+ *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH =
DAMAGE.=0A=
+ *=0A=
+ *  You should have received a copy of the  GNU General Public License =
along=0A=
+ *  with this program; if not, write  to the Free Software Foundation, =
Inc.,=0A=
+ *  675 Mass Ave, Cambridge, MA 02139, USA.=0A=
+ *=0A=
+ *=0A=
+ =
************************************************************************=
**=0A=
+ */=0A=
+=0A=
+#ifndef __ASM_MACH_IDT_PARAM_H=0A=
+#define __ASM_MACH_IDT_PARAM_H=0A=
+#include <linux/config.h>=0A=
+#ifdef CONFIG_IDT_EB438=0A=
+#define HZ		1000=0A=
+#else=0A=
+#define HZ		100=0A=
+#endif=0A=
+=0A=
+#endif /* __ASM_MACH_IDT_PARAM_H */=0A=
diff -uNr linux-2.6.16-rc5/include/asm-mips/serial.h =
acacia/include/asm-mips/serial.h=0A=
--- linux-2.6.16-rc5/include/asm-mips/serial.h	2006-02-27 =
02:56:56.000000000 -0800=0A=
+++ acacia/include/asm-mips/serial.h	2006-03-14 13:55:30.000000000 =
-0800=0A=
@@ -238,6 +238,14 @@=0A=
 #define IP32_SERIAL_PORT_DEFNS=0A=
 #endif /* CONFIG_SGI_IP32 */=0A=
 =0A=
+#if defined(CONFIG_IDT_EB438)=0A=
+#define IDT_SERIAL_PORT_DEFNS \=0A=
+        {},{},=0A=
+#else=0A=
+#define IDT_SERIAL_PORT_DEFNS=0A=
+#endif=0A=
+=0A=
+=0A=
 #define SERIAL_PORT_DFNS				\=0A=
 	DDB5477_SERIAL_PORT_DEFNS			\=0A=
 	EV96100_SERIAL_PORT_DEFNS			\=0A=
diff -uNr linux-2.6.16-rc5/MAINTAINERS acacia/MAINTAINERS=0A=
--- linux-2.6.16-rc5/MAINTAINERS	2006-02-27 02:56:56.000000000 -0800=0A=
+++ acacia/MAINTAINERS	2006-03-14 10:47:37.000000000 -0800=0A=
@@ -1232,6 +1232,13 @@=0A=
 L:	linux-kernel@vger.kernel.org=0A=
 S:	Maintained=0A=
 =0A=
+IDT INTERPRISE INTEGRATED COMMUNICATION PROCESSOR SUPPORT=0A=
+P:      Rakesh Tiwari=0A=
+M:      rischelp@idt.com=0A=
+L:	rischelp@idt.com=0A=
+W:	http://www.idt.com/?catID=3D58532=0A=
+S:	Supported=0A=
+=0A=
 IDE/ATAPI TAPE DRIVERS=0A=
 P:	Gadi Oxman=0A=
 M:	Gadi Oxman <gadio@netvision.net.il>=0A=

------_=_NextPart_000_01C647C6.BBD27F73--
