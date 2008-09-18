Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Sep 2008 12:39:56 +0100 (BST)
Received: from outbound-dub.frontbridge.com ([213.199.154.16]:28447 "EHLO
	IE1EHSOBE006.bigfish.com") by ftp.linux-mips.org with ESMTP
	id S20050127AbYIRLjw (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 18 Sep 2008 12:39:52 +0100
Received: from mail52-dub-R.bigfish.com (10.5.252.3) by
 IE1EHSOBE006.bigfish.com (10.5.252.26) with Microsoft SMTP Server id
 8.1.240.5; Thu, 18 Sep 2008 11:39:45 +0000
Received: from mail52-dub (localhost.localdomain [127.0.0.1])	by
 mail52-dub-R.bigfish.com (Postfix) with ESMTP id EB9A714101B7	for
 <linux-mips@linux-mips.org>; Thu, 18 Sep 2008 11:39:44 +0000 (UTC)
X-BigFish: VPS-44(zzfadRa0dJ14ffO4015M19c2k1127izzzz6619IPz2dh6bh61h)
Received: by mail52-dub (MessageSwitch) id 1221737982952013_23810; Thu, 18 Sep
 2008 11:39:42 +0000 (UCT)
Received: from sggdcex1ns01.sony.com.sg (sggdcex1ns01.sony.com.sg
 [121.100.32.134])	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168
 bits))	(No client certificate requested)	by mail52-dub.bigfish.com (Postfix)
 with ESMTP id 251DC808071	for <linux-mips@linux-mips.org>; Thu, 18 Sep 2008
 11:39:41 +0000 (UTC)
Received: from sggdcwn1vs01.sony.com.sg (sggdcwn1vs01 [43.68.8.23])	by
 sggdcex1ns01.sony.com.sg (8.13.7+Sun/8.13.7) with SMTP id m8IBdcVI000410	for
 <linux-mips@linux-mips.org>; Thu, 18 Sep 2008 19:39:39 +0800 (SGT)
Received: from (sgsesgdcid02.sony.com.sg [43.68.8.2]) by
 sggdcwn1vs01.sony.com.sg with smtp	 id
 7401_797db7bc_8576_11dd_9a2f_001372631f16;	Thu, 18 Sep 2008 19:39:38 +0800
Received: from sgapxbh05.ap.sony.com (sgapxbh05.ap.sony.com [43.68.17.37])	by
 sgsesgdcid02.sony.com.sg (8.13.7+Sun/8.13.7) with ESMTP id m8IBdcLx028460	for
 <linux-mips@linux-mips.org>; Thu, 18 Sep 2008 19:39:38 +0800 (SGT)
Received: from insardxms01.ap.sony.com ([43.88.102.10]) by
 sgapxbh05.ap.sony.com with Microsoft SMTPSVC(6.0.3790.3959); Thu, 18 Sep 2008
 19:39:37 +0800
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.4325
Content-Class: urn:content-classes:message
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C91983.39F24AAB"
Subject: execve errno setting on MIPS
Importance: normal
Priority: normal
Date:	Thu, 18 Sep 2008 17:09:35 +0530
Message-ID: <7B7EF7F090B9804A830ACC82F2CDE95D53F553@insardxms01.ap.sony.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: execve errno setting on MIPS
Thread-Index: AckZgzm/T9gNDGOUS1OLOnTq63CX4w==
From:	"Sadashiiv, Halesh" <halesh.sadashiv@ap.sony.com>
To:	<linux-mips@linux-mips.org>
X-OriginalArrivalTime: 18 Sep 2008 11:39:37.0412 (UTC) FILETIME=[3AC44040:01C91983]
Return-Path: <halesh.sadashiv@ap.sony.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20530
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: halesh.sadashiv@ap.sony.com
Precedence: bulk
X-list: linux-mips

------_=_NextPart_001_01C91983.39F24AAB
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi all,
=20
Please find the below testcase..
=20
#include <stdio.h>
#include <limits.h>
#include <errno.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <sys/stat.h>
=20
#define EXE_NAME "./exe"
=20
char e2BIG[ARG_MAX+1][10];
char *envList[]=3D{NULL};
=20
int main(void)
{
  int ret,ind;
=20
  for(ind =3D 0; ind < ARG_MAX+1; ind++)
    strcpy(e2BIG[ind], "helloword");
=20
  if ((ret =3D chmod(EXE_NAME,0744)) !=3D 0){
    printf("chmod failed\n");
    exit(1);
  }
=20
  /* whne arg list is too long */
  if ((ret =3D execve(EXE_NAME,e2BIG,envList)) =3D=3D -1) {
    if ( errno =3D=3D E2BIG)
      printf("Test Pass\n");
    else
      printf("Test Fail : Got Errno %d\n", errno);
    exit(0);
  }
  else
    printf("execve worked out of limit\n");
  exit(1);
}
=20
On MIPS E2BIG is not getting set as errno instead EFAULT is set, while
on=20
other archs like ARM, PowerPC and i686 I am able to get E2BIG.
=20
Please let me know about the issue...
=20
Let EXE_NAME be any executable....
=20
Thanks,
Halesh

=20



-------------------------------------------------------------------
This email is confidential and intended only for the use of the =
individual or entity named above and may contain information that is =
privileged. If you are not the intended recipient, you are notified that =
any dissemination, distribution or copying of this email is strictly =
prohibited. If you have received this email in error, please notify us =
immediately by return email or telephone and destroy the original =
message. - This mail is sent via Sony Asia Pacific Mail Gateway.
-------------------------------------------------------------------

------_=_NextPart_001_01C91983.39F24AAB
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:st1=3D"urn:schemas-microsoft-com:office:smarttags" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"State"/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"place" downloadurl=3D"http://www.5iantlavalamp.com/"/>
<!--[if !mso]>
<style>
st1\:*{behavior:url(#default#ieooui) }
</style>
<![endif]-->
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:"MS Mincho";
	panose-1:2 2 6 9 4 2 5 8 3 4;}
@font-face
	{font-family:"\@MS Mincho";
	panose-1:0 0 0 0 0 0 0 0 0 0;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;}
pre
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:10.0pt;
	font-family:"Courier New";
	color:black;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:Arial;
	color:windowtext;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1><pre><font size=3D2 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:10.0pt'>Hi =
all,<o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></pre><pre><fon=
t
size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>Please find the below =
testcase..<o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></pre><pre><fon=
t
size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>#include =
&lt;stdio.h&gt;<o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>#include =
&lt;limits.h&gt;<o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>#include =
&lt;errno.h&gt;<o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>#include =
&lt;unistd.h&gt;<o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>#include =
&lt;stdlib.h&gt;<o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>#include =
&lt;string.h&gt;<o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>#include =
&lt;sys/types.h&gt;<o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>#include =
&lt;sys/stat.h&gt;<o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></pre><pre><fon=
t
size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>#define EXE_NAME =
&quot;./exe&quot;<o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></pre><pre><fon=
t
size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>char =
e2BIG[ARG_MAX+1][10];<o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>char =
*envList[]=3D{NULL};<o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></pre><pre><fon=
t
size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>int =
main(void)<o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>{<o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>&nbsp; int ret,<st1:State
w:st=3D"on"><st1:place =
w:st=3D"on">ind</st1:place></st1:State>;<o:p></o:p></span></font></pre><p=
re><font
size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></pre><pre><fon=
t
size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>&nbsp; for(<st1:State
w:st=3D"on">ind</st1:State> =3D 0; <st1:State =
w:st=3D"on">ind</st1:State> &lt; ARG_MAX+1; <st1:State
w:st=3D"on"><st1:place =
w:st=3D"on">ind++</st1:place></st1:State>)<o:p></o:p></span></font></pre>=
<pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp; strcpy(e2BIG[<st1:State
w:st=3D"on"><st1:place w:st=3D"on">ind</st1:place></st1:State>], =
&quot;helloword&quot;);<o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></pre><pre><fon=
t
size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>&nbsp; if ((ret =3D chmod(EXE_NAME,0744)) =
!=3D 0){<o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp; printf(&quot;chmod =
failed\n&quot;);<o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp; =
exit(1);<o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>&nbsp; =
}<o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></pre><pre><fon=
t
size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>&nbsp; /* whne arg list is too long =
*/<o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>&nbsp; if ((ret =3D =
execve(EXE_NAME,e2BIG,envList)) =3D=3D -1) =
{<o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp; if ( errno =3D=3D =
E2BIG)<o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
printf(&quot;Test =
Pass\n&quot;);<o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp; =
else<o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
printf(&quot;Test Fail : Got Errno %d\n&quot;, =
errno);<o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp; =
exit(0);<o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>&nbsp; =
}<o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>&nbsp; =
else<o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp; printf(&quot;execve worked =
out of limit\n&quot;);<o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>&nbsp; =
exit(1);<o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>}<o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></pre><pre><fon=
t
size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>On MIPS E2BIG is not getting set as errno =
instead EFAULT is set, while on =
<o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>other archs like ARM, PowerPC and i686 I am =
able to get E2BIG.<o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></pre><pre><fon=
t
size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>Please let me know about the =
issue...<o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></pre><pre><fon=
t
size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>Let EXE_NAME be any =
executable....<o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></pre><pre><fon=
t
size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>Thanks,<o:p></o:p></span></font></pre><pre><fo=
nt
size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>Halesh<o:p></o:p></span></font></pre>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

</div>

<p></p><hr><br>This email is confidential and intended only for the use =
of the individual or entity named above and may contain information that =
is privileged. If you are not the intended recipient, you are notified =
that any dissemination, distribution or copying of this email is =
strictly prohibited. If you have received this email in error, please =
notify us immediately by return email or telephone and destroy the =
original message. - This mail is sent via Sony Asia Pacific Mail =
Gateway.<hr></body>

</html>

------_=_NextPart_001_01C91983.39F24AAB--
