Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Jan 2007 07:25:40 +0000 (GMT)
Received: from mx.mips.com ([63.167.95.198]:19421 "EHLO dns0.mips.com")
	by ftp.linux-mips.org with ESMTP id S28580041AbXAKHZg (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 11 Jan 2007 07:25:36 +0000
Received: from mercury.mips.com (mercury [192.168.64.101])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id l0B7QX41025216;
	Wed, 10 Jan 2007 23:26:34 -0800 (PST)
Received: from Ulysses ([192.168.3.143])
	by mercury.mips.com (8.13.5/8.13.5) with SMTP id l0B7PQ81005986;
	Wed, 10 Jan 2007 23:25:26 -0800 (PST)
Message-ID: <000d01c73551$dc5883c0$8f03a8c0@Ulysses>
From:	"Kevin D. Kissell" <KevinK@mips.com>
To:	"sathesh babu" <sathesh_edara2003@yahoo.co.in>,
	"mlachwani" <mlachwani@mvista.com>, <macro@ds2.pg.gda.pl>,
	<jsun@mvista.com>
Cc:	<linux-mips@linux-mips.org>
References: <793966.31860.qm@web7914.mail.in.yahoo.com>
Subject: Re: Running linux-2.6.18 kernel in uncache area
Date:	Thu, 11 Jan 2007 07:26:48 -0000
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_000A_01C73551.DB03A220"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1807
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1807
Return-Path: <KevinK@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13581
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: KevinK@mips.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

------=_NextPart_000_000A_01C73551.DB03A220
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

The way an uncached kernel boot works is by setting the cache attribute
of kseg0 (0x80000000-0x9fffffff) to be non-cacheable. It doesn't change =
a
lot of other code, so there's nothing necessarily strange about cache =
initialization
being done anyway, and it's perfectly normal and expected that the same
memory be seen at 0x80800000 as at 0xa0800000.
  ----- Original Message -----=20
  From: sathesh babu=20
  To: sathesh babu ; mlachwani ; macro@ds2.pg.gda.pl ; jsun@mvista.com=20
  Cc: linux-mips@linux-mips.org=20
  Sent: Thursday, January 11, 2007 1:02 AM
  Subject: Re: Running linux-2.6.18 kernel in uncache area


  Hi,=20
    Could you please respond on this.

  Regards,
  Sathesh

  sathesh babu <sathesh_edara2003@yahoo.co.in> wrote:



      Hi,
        I would like to runlinux-2.6.18 kernel in uncached area.I tried =
it by enabling CONFIG_UNCACHE.But still i am doubting it is running in =
cache area.

      Is there a way to know the kernel is running in cache or uncache =
area?

      While going thru mailing list i read that there is a patch to run =
the kernel in uncache area.

      If you have could you please pass to me.

      Regards,
      Sathesh



      sathesh babu <sathesh_edara2003@yahoo.co.in> wrote:
        Hi Mlachwani,
         I tried by enabling Uncache option.
        But how do i know kernel runs from the uncache area.

        During the boot process , i checked the boot up message and =
observed that kernel  still calling cache initilization routines.

        I did quick test :
          - Read the  10 words of uncached area start from 0xa0800000

          - Read the 10 word of cached area start ftom 0x80800000

        I checked the contents in the both areas and are same.

        That means  cache is not disabled properly.

        Is there anyway i can check the kernel is running from cache or =
uncached area?

        Any other options should i enable/disable to run kernel from =
uncached area.

         Regards,
        Sathesh

        BOOTUP MESSAGES:
        =
--------------------------------------------------------------------
        Determined physical RAM map:
         memory: 02000000 @ 00000000 (usable)
        Initial ramdisk at: 0x80000000 (0 bytes)
        Built 1 zonelists.  Total pages: 8192
        Kernel command line: root=3D/dev/mtdblock2 rw rootfstype=3Djffs2 =
myfs_start=3D0xbfA800
        00 rootfstype=3Djffs2
        Primary instruction cache 16kB, linesize 32 bytes.
        Primary data cache 8kB, linesize 32 bytes.
        Fusiv LX4189 CACHES
        Synthesized TLB refill handler (17 instructions).
        Synthesized TLB load handler fastpath (31 instructions).
        Synthesized TLB store handler fastpath (31 instructions).
        th (25 instructions).
        PID hash table entries: 256 (order: 8, 1024 bytes)
        Dentry cache hash table entries: 4096 (order: 2, 16384 bytes)
        Inode-cache hash table entries: 2048 (order: 1, 8192 bytes)
        Memory: 28864k/32768k available (2367k kernel code, 3888k =
reserved, 401k data, 1
        56k init, 0k highmem)
        Mount-cache hash table entries: 512
        =
---------------------------------------------------------------------
        mlachwani <mlachwani@mvista.com> wrote:
          sathesh babu wrote:
          > Hi,
          > I would like to know is there any configuration option ( =
using make=20
          > menuconfig) to turn off cache in linux-2.6.18 kernel.
          >=20
          > Basically i would like to run kernel in uncache area.
          >=20
          > I see there is an option in the in the menuconfig under=20
          > Kernel hacking
          > [ ] Run uncached (NEW)
          > Sould i need to enable this option to run in the uncahe =
area?
          >=20
          > Could you please tell me how to disable cache and run the =
kernel in=20
          > uncache area.
          >=20
          >=20
          >=20
          > Regards,
          > Sathesh
          >
          > Send free SMS to your Friends on Mobile from your Yahoo! =
Messenger.=20
          > Download Now! http://messenger.yahoo.com/download.php
          >
          That should be it. Did you try with that option MIPS_UNCACHED =
enabled?

          thanks,
          Manish Lachwani




        Send free SMS to your Friends on Mobile from your Yahoo! =
Messenger. Download Now! http://messenger.yahoo.com/download.php



-------------------------------------------------------------------------=
-
      Here's a new way to find what you're looking for - Yahoo! Answers=20



-------------------------------------------------------------------------=
---
    Here's a new way to find what you're looking for - Yahoo! Answers=20




-------------------------------------------------------------------------=
-----
  Here's a new way to find what you're looking for - Yahoo! Answers 
------=_NextPart_000_000A_01C73551.DB03A220
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2800.1561" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>The way an uncached kernel boot works =
is by setting=20
the cache attribute</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>of kseg0 (0x80000000-0x9fffffff) to be=20
non-cacheable. It doesn't change a</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>lot of other code, so there's nothing =
necessarily=20
strange about cache initialization</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>being done anyway, and it's perfectly =
normal and=20
expected that the same</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>memory be seen at 0x80800000 as at=20
0xa0800000.</FONT></DIV>
<BLOCKQUOTE=20
style=3D"PADDING-RIGHT: 0px; PADDING-LEFT: 5px; MARGIN-LEFT: 5px; =
BORDER-LEFT: #000000 2px solid; MARGIN-RIGHT: 0px">
  <DIV style=3D"FONT: 10pt arial">----- Original Message ----- </DIV>
  <DIV=20
  style=3D"BACKGROUND: #e4e4e4; FONT: 10pt arial; font-color: =
black"><B>From:</B>=20
  <A title=3Dsathesh_edara2003@yahoo.co.in=20
  href=3D"mailto:sathesh_edara2003@yahoo.co.in">sathesh babu</A> </DIV>
  <DIV style=3D"FONT: 10pt arial"><B>To:</B> <A=20
  title=3Dsathesh_edara2003@yahoo.co.in=20
  href=3D"mailto:sathesh_edara2003@yahoo.co.in">sathesh babu</A> ; <A=20
  title=3Dmlachwani@mvista.com =
href=3D"mailto:mlachwani@mvista.com">mlachwani</A> ;=20
  <A title=3Dmacro@ds2.pg.gda.pl=20
  href=3D"mailto:macro@ds2.pg.gda.pl">macro@ds2.pg.gda.pl</A> ; <A=20
  title=3Djsun@mvista.com =
href=3D"mailto:jsun@mvista.com">jsun@mvista.com</A> </DIV>
  <DIV style=3D"FONT: 10pt arial"><B>Cc:</B> <A =
title=3Dlinux-mips@linux-mips.org=20
  =
href=3D"mailto:linux-mips@linux-mips.org">linux-mips@linux-mips.org</A> =
</DIV>
  <DIV style=3D"FONT: 10pt arial"><B>Sent:</B> Thursday, January 11, =
2007 1:02=20
  AM</DIV>
  <DIV style=3D"FONT: 10pt arial"><B>Subject:</B> Re: Running =
linux-2.6.18 kernel=20
  in uncache area</DIV>
  <DIV><BR></DIV>
  <DIV>Hi, </DIV>
  <DIV>&nbsp; Could you please respond on this.</DIV>
  <DIV>&nbsp;</DIV>
  <DIV>Regards,</DIV>
  <DIV>Sathesh<BR><BR><B><I>sathesh babu &lt;<A=20
  =
href=3D"mailto:sathesh_edara2003@yahoo.co.in">sathesh_edara2003@yahoo.co.=
in</A>&gt;</I></B>=20
  wrote:</DIV>
  <BLOCKQUOTE class=3Dreplbq=20
  style=3D"PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #1010ff 2px =
solid"><BR><BR>
    <BLOCKQUOTE class=3Dreplbq=20
    style=3D"PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #1010ff =
2px solid">
      <DIV>Hi,</DIV>
      <DIV>&nbsp; I would like to runlinux-2.6.18 kernel in uncached =
area.I=20
      tried it by enabling CONFIG_UNCACHE.But still i am doubting it is =
running=20
      in cache area.</DIV>
      <DIV>&nbsp;</DIV>
      <DIV>Is there a way to know the kernel is running in cache or =
uncache=20
      area?</DIV>
      <DIV>&nbsp;</DIV>
      <DIV>While going thru mailing list i read that there is a patch to =
run the=20
      kernel in uncache area.</DIV>
      <DIV>&nbsp;</DIV>
      <DIV>If you have could you please pass to me.</DIV>
      <DIV>&nbsp;</DIV>
      <DIV>Regards,</DIV>
      <DIV>Sathesh</DIV>
      <DIV>&nbsp;</DIV>
      <DIV><BR><BR><B><I>sathesh babu &lt;<A=20
      =
href=3D"mailto:sathesh_edara2003@yahoo.co.in">sathesh_edara2003@yahoo.co.=
in</A>&gt;</I></B>=20
      wrote:</DIV>
      <BLOCKQUOTE class=3Dreplbq=20
      style=3D"PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #1010ff =
2px solid">
        <DIV>Hi Mlachwani,</DIV>
        <DIV>&nbsp;I tried by enabling Uncache option.</DIV>
        <DIV>But how do i know&nbsp;kernel runs from the uncache =
area.</DIV>
        <DIV>&nbsp;</DIV>
        <DIV>During the boot process , i checked the boot up =
message&nbsp;and=20
        observed that&nbsp;kernel &nbsp;still calling cache =
initilization=20
        routines.</DIV>
        <DIV>&nbsp;</DIV>
        <DIV>I did quick test :</DIV>
        <DIV>&nbsp;&nbsp;- Read the &nbsp;10 words of uncached area=20
        start&nbsp;from 0xa0800000</DIV>
        <DIV>&nbsp;</DIV>
        <DIV>&nbsp; - Read the 10 word of cached area start ftom=20
0x80800000</DIV>
        <DIV>&nbsp;</DIV>
        <DIV>I checked the contents in the both areas and are =
same.</DIV>
        <DIV>&nbsp;</DIV>
        <DIV>That means&nbsp; cache is not disabled properly.</DIV>
        <DIV>&nbsp;</DIV>
        <DIV>Is there anyway i can check the kernel is running from =
cache or=20
        uncached area?</DIV>
        <DIV>&nbsp;</DIV>
        <DIV>Any other options should i enable/disable to run kernel =
from=20
        uncached area.</DIV>
        <DIV>&nbsp;</DIV>
        <DIV>&nbsp;Regards,</DIV>
        <DIV>Sathesh</DIV>
        <DIV>&nbsp;</DIV>
        <DIV>BOOTUP MESSAGES:</DIV>
        =
<DIV>--------------------------------------------------------------------=
<BR>Determined=20
        physical RAM map:<BR>&nbsp;memory: 02000000 @ 00000000=20
        (usable)<BR>Initial ramdisk at: 0x80000000 (0 bytes)<BR>Built 1=20
        zonelists.&nbsp; Total pages: 8192<BR>Kernel command line:=20
        root=3D/dev/mtdblock2 rw rootfstype=3Djffs2 =
myfs_start=3D0xbfA800<BR>00=20
        rootfstype=3Djffs2<BR>Primary instruction cache 16kB, linesize =
32=20
        bytes.<BR>Primary data cache 8kB, linesize 32 bytes.<BR>Fusiv =
LX4189=20
        CACHES<BR>Synthesized TLB refill handler (17=20
        instructions).<BR>Synthesized TLB load handler fastpath (31=20
        instructions).<BR>Synthesized TLB store handler fastpath (31=20
        instructions).<BR>th (25 instructions).<BR>PID hash table =
entries: 256=20
        (order: 8, 1024 bytes)<BR>Dentry cache hash table entries: 4096 =
(order:=20
        2, 16384 bytes)<BR>Inode-cache hash table entries: 2048 (order: =
1, 8192=20
        bytes)<BR>Memory: 28864k/32768k available (2367k kernel code, =
3888k=20
        reserved, 401k data, 1<BR>56k init, 0k highmem)<BR>Mount-cache =
hash=20
        table entries: 512</DIV>
        =
<DIV>--------------------------------------------------------------------=
-<BR><B><I>mlachwani=20
        &lt;mlachwani@mvista.com&gt;</I></B> wrote:</DIV>
        <BLOCKQUOTE class=3Dreplbq=20
        style=3D"PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: =
#1010ff 2px solid">sathesh=20
          babu wrote:<BR>&gt; Hi,<BR>&gt; I would like to know is there =
any=20
          configuration option ( using make <BR>&gt; menuconfig) to turn =
off=20
          cache in linux-2.6.18 kernel.<BR>&gt; <BR>&gt; Basically i =
would like=20
          to run kernel in uncache area.<BR>&gt; <BR>&gt; I see there is =
an=20
          option in the in the menuconfig under <BR>&gt; Kernel =
hacking<BR>&gt;=20
          [ ] Run uncached (NEW)<BR>&gt; Sould i need to enable this =
option to=20
          run in the uncahe area?<BR>&gt; <BR>&gt; Could you please tell =
me how=20
          to disable cache and run the kernel in <BR>&gt; uncache =
area.<BR>&gt;=20
          <BR>&gt; <BR>&gt; <BR>&gt; Regards,<BR>&gt; =
Sathesh<BR>&gt;<BR>&gt;=20
          Send free SMS to your Friends on Mobile from your Yahoo! =
Messenger.=20
          <BR>&gt; Download Now!=20
          http://messenger.yahoo.com/download.php<BR>&gt;<BR>That should =
be it.=20
          Did you try with that option MIPS_UNCACHED=20
          enabled?<BR><BR>thanks,<BR>Manish =
Lachwani<BR><BR></BLOCKQUOTE><BR>
        <DIV>Send free SMS to your Friends on Mobile from your Yahoo! =
Messenger.=20
        Download Now!=20
      http://messenger.yahoo.com/download.php</DIV></BLOCKQUOTE><BR>
      <DIV>
      <HR SIZE=3D1>
      </HR>Here=92s a new way to find what you're looking for - <A=20
      =
href=3D"http://us.rd.yahoo.com/mail/in/yanswers/*http://in.answers.yahoo.=
com/">Yahoo!=20
      Answers</A> </DIV></BLOCKQUOTE><BR>
    <DIV>
    <HR SIZE=3D1>
    </HR>Here=92s a new way to find what you're looking for - <A=20
    =
href=3D"http://us.rd.yahoo.com/mail/in/yanswers/*http://in.answers.yahoo.=
com/">Yahoo!=20
    Answers</A> </DIV></BLOCKQUOTE><BR>
  <P>
  <HR SIZE=3D1>
  </HR>Here=92s a new way to find what you're looking for - <A=20
  =
href=3D"http://us.rd.yahoo.com/mail/in/yanswers/*http://in.answers.yahoo.=
com/">Yahoo!=20
  Answers</A> </BLOCKQUOTE></BODY></HTML>

------=_NextPart_000_000A_01C73551.DB03A220--
