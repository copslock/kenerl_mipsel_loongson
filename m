Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Feb 2004 12:14:33 +0000 (GMT)
Received: from ftp.mips.com ([IPv6:::ffff:206.31.31.227]:24768 "EHLO
	mx2.mips.com") by linux-mips.org with ESMTP id <S8224991AbUBLPRF>;
	Thu, 12 Feb 2004 15:17:05 +0000
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.11/8.12.11) with ESMTP id i1CEcxhd023647;
	Thu, 12 Feb 2004 06:38:59 -0800 (PST)
Received: from xchange.mips.com (xchange [192.168.20.31])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id GAA04359;
	Thu, 12 Feb 2004 06:46:44 -0800 (PST)
Received: by xchange.mips.com with Internet Mail Service (5.5.2653.19)
	id <D6LS36JQ>; Thu, 12 Feb 2004 06:41:02 -0800
Message-ID: <0C5F4C7A1E3ED51194E200508B2CE32A03B84D84@xchange.mips.com>
From: "Berg, Christian" <chrisb@mips.com>
To: "Ren, Manling" <Manling.Ren@gbr.xerox.com>
Cc: linux-mips@linux-mips.org
Subject: RE: questions about making a script file for YAMON command
Date: Thu, 12 Feb 2004 06:40:53 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C3F176.378C1C70"
Return-Path: <chrisb@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4349
X-Approved-By: ralf@linux-mips.org
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chrisb@mips.com
Precedence: bulk
X-list: linux-mips

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C3F176.378C1C70
Content-Type: text/plain

Hi Manling,
 
there is a variable called START in the YAMON environment. The contents of
which is executed at YAMON start-up. So if you can fit your 'edit' commands
in the space provided you're good to go. See page 22 of the YAMON user
manual
(http://www.mips.com/content/Documentation/MIPSDocumentation/Software/doclib
rary
<http://www.mips.com/content/Documentation/MIPSDocumentation/Software/doclib
rary> ). But this is getting off topic now...
 
Chris

-----Original Message-----
From: Ren, Manling [mailto:Manling.Ren@gbr.xerox.com] 
Sent: Thursday, February 12, 2004 2:45 PM
To: linux-mips@linux-mips.org
Subject: RE: questions about making a script file for YAMON command



 

Dear the technical support team,
 
I am running YAMON on pb1100 board in Linux.  At the YAMON prompt, I need to
change some registers by using the command "edit -32 0x########"  several
times.  I wonder if I can put all these "edit" commands into a script file
then run this file without typing any more commands?  How can I achieve this
if it is possible.  It seems that the "load" command in YAMON is only
supported srec file.  Could you give me some clues please.  Thanks a lot.
 
Regards,
Manling
 
____________________________ 
Manling Ren  :-)* ******* *****                

Welwyn OPDU Software Architecture Team 
OPDU                    
Xerox Limited Technical Centre 
DP2         
Bessemer Road               
Welwyn Garden City  AL7 1HE         
Hertfordshire               
UK                          
%    +44 (0)1707 35 2704                  
*     8 668 2704 (xerox intranet)         
*     +44 (0)1707 35 3947         
*    Manling.Ren@gbr.xerox.com  
_________________________________           


 



 


------_=_NextPart_001_01C3F176.378C1C70
Content-Type: text/html
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3DUS-ASCII">
<TITLE>Message</TITLE>

<META content=3D"MSHTML 6.00.2800.1400" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN =
class=3D322463914-12022004>Hi=20
Manling,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN=20
class=3D322463914-12022004></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN =
class=3D322463914-12022004>there=20
is a variable called START in the YAMON environment. The contents of=20
which&nbsp;is executed at YAMON start-up. So if you can fit your 'edit' =
commands=20
in&nbsp;the space provided you're good to go. See page 22 of the YAMON =
user=20
manual (<A=20
href=3D"http://www.mips.com/content/Documentation/MIPSDocumentation/Soft=
ware/doclibrary">http://www.mips.com/content/Documentation/MIPSDocumenta=
tion/Software/doclibrary</A>).=20
But this is getting off topic now...</SPAN></FONT></DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN=20
class=3D322463914-12022004></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN=20
class=3D322463914-12022004>Chris</SPAN></FONT></DIV>
<BLOCKQUOTE dir=3Dltr=20
style=3D"PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #0000ff 2px =
solid; MARGIN-RIGHT: 0px">
  <DIV></DIV>
  <DIV class=3DOutlookMessageHeader lang=3Den-us dir=3Dltr =
align=3Dleft><FONT=20
  face=3DTahoma size=3D2>-----Original Message-----<BR><B>From:</B> =
Ren, Manling=20
  [mailto:Manling.Ren@gbr.xerox.com] <BR><B>Sent:</B> Thursday, =
February 12,=20
  2004 2:45 PM<BR><B>To:</B> =
linux-mips@linux-mips.org<BR><B>Subject:</B> RE:=20
  questions about making a script file for YAMON =
command<BR><BR></FONT></DIV>
  <DIV><FONT face=3DTahoma size=3D2><BR></FONT>&nbsp;</DIV>
  <BLOCKQUOTE dir=3Dltr style=3D"MARGIN-RIGHT: 0px">
    <DIV><FONT face=3D"Comic Sans MS" color=3D#0000ff size=3D2><SPAN=20
    class=3D555301313-12022004>Dear the technical support=20
team,</SPAN></FONT></DIV>
    <DIV><FONT face=3D"Comic Sans MS" color=3D#0000ff size=3D2><SPAN=20
    class=3D555301313-12022004></SPAN></FONT>&nbsp;</DIV>
    <DIV><FONT face=3D"Comic Sans MS" color=3D#0000ff size=3D2><SPAN=20
    class=3D555301313-12022004>I am running YAMON on pb1100 board in=20
    Linux.&nbsp;&nbsp;At the YAMON&nbsp;prompt, I need to change some =
registers=20
    by using the command "edit -32 0x########"&nbsp; several =
times.&nbsp; I=20
    wonder if I can&nbsp;put all these "edit" commands into a script =
file then=20
    run this file without typing any more commands?&nbsp; How can I =
achieve this=20
    if it is possible.&nbsp; It seems that the "load" command in YAMON =
is only=20
    supported srec file.&nbsp; Could you give me some clues =
please.&nbsp; Thanks=20
    a lot.</SPAN></FONT></DIV>
    <DIV><FONT face=3D"Comic Sans MS" color=3D#0000ff size=3D2><SPAN=20
    class=3D555301313-12022004></SPAN></FONT>&nbsp;</DIV>
    <DIV><FONT face=3D"Comic Sans MS" color=3D#0000ff size=3D2><SPAN=20
    class=3D555301313-12022004>Regards,</SPAN></FONT></DIV>
    <DIV><FONT face=3D"Comic Sans MS" color=3D#0000ff size=3D2><SPAN=20
    class=3D555301313-12022004>Manling</SPAN></FONT></DIV>
    <DIV><FONT face=3D"Comic Sans MS" color=3D#0000ff size=3D2><SPAN=20
    class=3D555301313-12022004></SPAN></FONT>&nbsp;</DIV>
    <DIV><FONT face=3D"Comic Sans MS" color=3D#0000ff size=3D2><SPAN=20
    class=3D555301313-12022004>
    <P><I><FONT face=3D"Times New Roman" color=3D#000080=20
    size=3D2>____________________________</FONT></I> <BR><I><FONT=20
    face=3D"Times New Roman" color=3D#000080 size=3D2>Manling =
Ren&nbsp;</FONT></I>=20
    <FONT face=3DWingdings color=3D#000000 size=3D4>J&nbsp;<FONT=20
    face=3D"Courier New"></FONT><FONT FACE=3D"Courier New"></FONT> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<FONT=20
    face=3D"Courier New"></FONT><FONT FACE=3D"Courier New"></FONT> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</FONT>=20
    &nbsp;&nbsp;&nbsp; &nbsp;=20
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<FONT face=3DArial=20
    color=3D#000000 size=3D2> </FONT></P>
    <P><FONT face=3DArial color=3D#000000 size=3D2>Welwyn</FONT> <FONT =
face=3DArial=20
    color=3D#000000 size=3D2>OPDU Software Architecture</FONT><FONT =
face=3DArial=20
    color=3D#000000 size=3D2> Team</FONT> <BR><FONT face=3DArial =
color=3D#000000=20
    size=3D2>OPDU&nbsp;&nbsp;&nbsp; &nbsp;=20
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
    </FONT><BR><FONT face=3DArial color=3D#000000 size=3D2>Xerox =
Limited Technical=20
    Centre</FONT> <BR><FONT face=3DArial color=3D#000000=20
    size=3D2>DP2&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; =
</FONT><BR><FONT=20
    face=3DArial color=3D#000000 size=3D2>Bessemer Road&nbsp;&nbsp;=20
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp; =
</FONT><BR><FONT=20
    face=3DArial color=3D#000000 size=3D2>Welwyn Garden City&nbsp; AL7=20
    1HE&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; </FONT><BR><FONT =
face=3DArial=20
    color=3D#000000 size=3D2>Hertfordshire&nbsp;&nbsp;=20
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp; =
</FONT><BR><FONT=20
    face=3DArial color=3D#000000 =
size=3D2>UK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
    &nbsp;&nbsp;&nbsp; &nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </FONT><BR><FONT face=3D"Monotype =
Sorts"=20
    color=3D#000080 size=3D5>%<B></B></FONT><B></B><B><FONT =
face=3DArial color=3D#000080=20
    size=3D1>&nbsp;</FONT></B> <FONT face=3D"MS Sans Serif" =
color=3D#000080=20
    size=3D1>&nbsp; +44 (0)1707 35 =
2704&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</FONT> &nbsp;&nbsp;&nbsp; <BR><FONT=20
    face=3DWingdings color=3D#000000>(</FONT><FONT face=3D"MS Sans =
Serif"=20
    color=3D#000080 size=3D1>&nbsp;&nbsp;&nbsp;&nbsp; 8 668 2704 (xerox =

    intranet)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</FONT> &nbsp; =
<BR><FONT=20
    face=3DWingdings color=3D#ff0000>4</FONT><FONT face=3D"Times New =
Roman"=20
    color=3D#000080 size=3D1></FONT> <FONT face=3D"MS Sans Serif" =
color=3D#000080=20
    size=3D1>&nbsp;&nbsp;&nbsp; +44 (0)1707 35=20
    3947&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;</FONT> <BR><FONT=20
    face=3DWingdings color=3D#000080 size=3D2>*</FONT><FONT =
face=3DTahoma color=3D#000080=20
    size=3D2></FONT> <FONT face=3D"MS Sans Serif" color=3D#000080 =
size=3D1>&nbsp;&nbsp;=20
    Manling.Ren@gbr.xerox.com&nbsp; </FONT><BR><FONT face=3D"MS Sans =
Serif"=20
    color=3D#000080 size=3D1>_________________________________=20
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</FONT> &nbsp;&nbsp;&nbsp;=20
    </P><BR></SPAN></FONT></DIV>
    <DIV>&nbsp;</DIV><FONT face=3D"Comic Sans MS" color=3D#0000ff=20
    size=3D2></FONT><BR><BR>
    <DIV>&nbsp;</DIV></BLOCKQUOTE></BLOCKQUOTE></BODY></HTML>

------_=_NextPart_001_01C3F176.378C1C70--
