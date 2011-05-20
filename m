Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 May 2011 10:09:59 +0200 (CEST)
Received: from mail161.messagelabs.com ([216.82.253.115]:19069 "EHLO
        mail161.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491095Ab1ETIJ4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 20 May 2011 10:09:56 +0200
X-VirusChecked: Checked
X-Env-Sender: chandanmohanty@motorolasolutions.com
X-Msg-Ref: server-2.tower-161.messagelabs.com!1305878991!35986812!1
X-StarScan-Version: 6.2.9; banners=-,-,-
X-Originating-IP: [129.188.136.8]
Received: (qmail 11418 invoked from network); 20 May 2011 08:09:52 -0000
Received: from motgate8.mot-solutions.com (HELO motgate8.mot-solutions.com) (129.188.136.8)
  by server-2.tower-161.messagelabs.com with DHE-RSA-AES256-SHA encrypted SMTP; 20 May 2011 08:09:52 -0000
Received: from il06exr01.mot.com (il06exr01.mot.com [129.188.137.131])
        by motgate8.mot-solutions.com (8.14.3/8.14.3) with ESMTP id p4K89kH3020530;
        Fri, 20 May 2011 01:09:51 -0700 (MST)
Received: from il06vts02.mot.com (il06vts02.mot.com [129.188.137.142])
        by il06exr01.mot.com (8.13.5/Vontu) with SMTP id p4K89kQq028415;
        Fri, 20 May 2011 03:09:46 -0500 (CDT)
Received: from zuk35exm65.ds.mot.com (zuk35exm65.ea.mot.com [10.178.4.21])
        by il06exr01.mot.com (8.13.5/8.13.0) with ESMTP id p4K89jjF028405;
        Fri, 20 May 2011 03:09:45 -0500 (CDT)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
        boundary="----_=_NextPart_001_01CC16C5.3A957AB0"
Subject: Need your help on setting of  INITIAL_JIFFIES
Date:   Fri, 20 May 2011 09:09:23 +0100
Message-ID: <CF80A1E11D28944EA2838FF532D25C3E03324CCB@zuk35exm65.ds.mot.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Need your help on setting of  INITIAL_JIFFIES
Thread-Index: AcwWxThn48Xgik5gR02qz1dlNwbj2Q==
From:   "MOHANTY CHANDAN-WJKD64" <chandanmohanty@motorolasolutions.com>
To:     <sshtylyov@ru.mvista.com>, <hvr@gnu.org>,
        <linux-mips@linux-mips.org>, <clem.taylor@gmail.com>,
        <linux-mips-bounce@linux-mips.org>, <4468F40F.80902@ru.mvista.com>,
        <4468EE9B.4000009@ru.mvista.com>
Cc:     "MOHANTY CHANDAN-WJKD64" <chandanmohanty@motorolasolutions.com>
X-CFilter-Loop: Reflected
Return-Path: <chandanmohanty@motorolasolutions.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 30101
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chandanmohanty@motorolasolutions.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

------_=_NextPart_001_01CC16C5.3A957AB0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

Hi,
My greetings to all the enlightened Linux Souls.
=20
 I got all the mail ids from one of Linux based mail chain/URL
http://www.linux-mips.org/archives/linux-mips/2006-05/msg00193.html
=20
Pls guide me on the usage of  INITIAL_JIFFIES.
=20
=20
=20
=20
In the source of linux kernel \include\linux\jiffies.h there is code
like this
=20
/*
 * Have the 32 bit jiffies value wrap 5 minutes after boot
 * so jiffies wrap bugs show up earlier.
 */
#define INITIAL_JIFFIES ((unsigned long)(unsigned int) (-300*HZ))
=20
=20
 This sets the initial jiffies value to 0x00000000fffb6c20, which can
trigger 32-bit wraparound bugs .It is an offset to the jiffies
counter,so that it begins from a large value instead of zero. So the
wrap-around happens earlier,making it possible to detect any counter
wrap-around bugs much quicker regardless of the HZ setting.
=20
=20
=20
=20
1.Suppose I want to simulate the jiffies wraparound after 30
mins(1800sec) of reboot.Can I change code as below in kernel?
=20
#define INITIAL_JIFFIES ((unsigned long)(unsigned int) (-1800*HZ))
u64 jiffies_64 =3D INITIAL_JIFFIES;
=20
=20
2.How to verify/test that wraparound has happened?
=20
=20
Regards
Chandan

------_=_NextPart_001_01CC16C5.3A957AB0
Content-Type: text/html;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META content=3D"text/html; charset=3Dus-ascii" =
http-equiv=3DContent-Type>
<META name=3DGENERATOR content=3D"MSHTML 8.00.6001.19046"></HEAD>
<BODY>
<DIV><SPAN class=3D198195407-20052011><FONT color=3D#0000ff=20
face=3DArial>Hi,</FONT></SPAN></DIV>
<DIV><SPAN class=3D198195407-20052011><FONT color=3D#0000ff =
face=3DArial>My greetings=20
to all the enlightened Linux Souls.</FONT></SPAN></DIV>
<DIV><SPAN class=3D198195407-20052011><FONT color=3D#0000ff=20
face=3DArial></FONT></SPAN>&nbsp;</DIV>
<DIV><FONT face=3DArial><FONT color=3D#0000ff><SPAN =
class=3D198195407-20052011>&nbsp;I=20
got all the mail ids from one of Linux based mail chain/URL </SPAN><SPAN =

class=3D198195407-20052011>&nbsp;<A=20
href=3D"http://www.linux-mips.org/archives/linux-mips/2006-05/msg00193.ht=
ml">http://www.linux-mips.org/archives/linux-mips/2006-05/msg00193.html</=
A></SPAN></FONT></FONT></DIV>
<DIV><SPAN class=3D198195407-20052011><FONT color=3D#0000ff=20
face=3DArial></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D198195407-20052011><FONT face=3DArial><FONT =
color=3D#0000ff>Pls=20
guide me on the usage of&nbsp;=20
<EM>INITIAL_JIFFIES.</EM></FONT></FONT></SPAN></DIV>
<DIV><SPAN class=3D198195407-20052011><EM><FONT color=3D#0000ff=20
face=3DArial></FONT></EM></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D198195407-20052011><EM><FONT color=3D#0000ff=20
face=3DArial></FONT></EM></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D198195407-20052011><EM><FONT color=3D#0000ff=20
face=3DArial></FONT></EM></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D198195407-20052011></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D198195407-20052011><FONT color=3D#0000ff =
face=3DArial>In the source=20
of linux kernel \include\linux\jiffies.h there is code like=20
this</FONT></SPAN></DIV>
<DIV><SPAN class=3D198195407-20052011></SPAN><SPAN=20
class=3D198195407-20052011></SPAN><FONT color=3D#0000ff=20
face=3DArial></FONT>&nbsp;</DIV>
<DIV><SPAN class=3D198195407-20052011><FONT color=3D#0000ff =
face=3DArial>/*<BR>&nbsp;*=20
Have the 32 bit jiffies value wrap 5 minutes after boot<BR>&nbsp;* so =
jiffies=20
wrap bugs show up earlier.<BR>&nbsp;*/<BR>#define INITIAL_JIFFIES =
((unsigned=20
long)(unsigned int) (-300*HZ))</FONT></SPAN></DIV>
<DIV><FONT color=3D#0000ff face=3DArial></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial><FONT color=3D#0000ff><SPAN=20
class=3D198195407-20052011>&nbsp;<BR>&nbsp;This sets the initial jiffies =
value to=20
0x00000000fffb6c20, which can trigger 32-bit wraparound bugs&nbsp;.It is =
an=20
offset to the jiffies counter,so that it begins from a large value =
instead of=20
zero. So the wrap-around happens </SPAN><SPAN=20
class=3D198195407-20052011>earlier,making it possible to detect any =
counter=20
wrap-around bugs much quicker regardless of the HZ=20
setting.</SPAN></FONT></FONT></DIV>
<DIV><SPAN class=3D198195407-20052011><FONT color=3D#0000ff=20
face=3DArial></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D198195407-20052011><FONT =
face=3DArial></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D198195407-20052011><FONT =
face=3DArial></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D198195407-20052011><FONT =
face=3DArial></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D198195407-20052011><FONT color=3D#008080 =
face=3DArial>1.Suppose I=20
want to simulate the jiffies wraparound after 30 mins(1800sec) of =
reboot.Can I=20
change code as below in kernel?</FONT></SPAN></DIV>
<DIV><SPAN class=3D198195407-20052011><FONT color=3D#008080=20
face=3DArial></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D198195407-20052011><FONT color=3D#008080 =
face=3DArial>#define=20
INITIAL_JIFFIES ((unsigned long)(unsigned int) =
(-1800*HZ))</FONT></SPAN></DIV>
<DIV><SPAN class=3D198195407-20052011><FONT color=3D#008080 =
face=3DArial>u64=20
jiffies_64 =3D INITIAL_JIFFIES;</FONT></SPAN></DIV>
<DIV><SPAN class=3D198195407-20052011><FONT color=3D#0000ff=20
face=3DArial></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D198195407-20052011><FONT color=3D#0000ff=20
face=3DArial></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D198195407-20052011><FONT color=3D#008080 =
face=3DArial>2.How=20
to&nbsp;verify/test that wraparound has happened?</FONT></SPAN></DIV>
<DIV><SPAN class=3D198195407-20052011><FONT color=3D#008080=20
face=3DArial></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D198195407-20052011><FONT color=3D#008080=20
face=3DArial></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D198195407-20052011><FONT color=3D#0000ff=20
face=3DArial>Regards</FONT></SPAN></DIV>
<DIV><SPAN class=3D198195407-20052011><FONT color=3D#0000ff=20
face=3DArial>Chandan</FONT></SPAN></DIV></BODY></HTML>

------_=_NextPart_001_01CC16C5.3A957AB0--
