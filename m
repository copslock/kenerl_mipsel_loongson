Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Jan 2008 16:35:47 +0000 (GMT)
Received: from wa-out-1112.google.com ([209.85.146.182]:15128 "EHLO
	wa-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S20032276AbYAHQfi (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 8 Jan 2008 16:35:38 +0000
Received: by wa-out-1112.google.com with SMTP id m16so12130548waf.20
        for <linux-mips@linux-mips.org>; Tue, 08 Jan 2008 08:35:37 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:mime-version:content-type:x-mailer:thread-index:x-mimeole:message-id;
        bh=PELyFxm5PzJ8bpyBey4ewQLTaqF2L2dyzKngfH4i5zU=;
        b=oVwHwUOqHnHvqilEYPPCFAJp8Gwy60Ll+Im5Q7jDJoFrfXIRl9tgV1rEqUwUWygglYrTKdR0NBQ/CutRLXR5oE1BTn636XbRDKtww+iT12I9LZDmoWrdWCup6juqEvuvVaYk83IVTSkn0oU8KPwg/9h80Gg+xVxi+JBfHTjFurc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:mime-version:content-type:x-mailer:thread-index:x-mimeole:message-id;
        b=Zzi7Mhr9JczG7ahWmPXq13c/C0Zjzg91sCcSg9RW2RHenNBdAUsBG8ohyLRpf/IaF6Me4abT0VkNGYWU5n2R2kmKDbjgLxTEzatv5WhimpWBAKhfbMPph2fGhrj0Cv8Zllszpfsvfsh/fGsdz4DspRHt/w1VHXKkvVrZZbnOa3k=
Received: by 10.115.74.1 with SMTP id b1mr455677wal.93.1199810131289;
        Tue, 08 Jan 2008 08:35:31 -0800 (PST)
Received: from WWW8E1E968C4DF ( [124.78.172.63])
        by mx.google.com with ESMTPS id m28sm33925040poh.7.2008.01.08.08.35.29
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 08 Jan 2008 08:35:30 -0800 (PST)
From:	"lovecentry" <lovecentry@gmail.com>
To:	<linux-mips@linux-mips.org>
Subject: kseg1 uncache access issue
Date:	Wed, 9 Jan 2008 00:35:06 +0800
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0004_01C85257.7C6BA180"
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AchSFGznFIKi14IwSXqLn9eejUkhaA==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.3198
Message-ID: <4783a652.1cef600a.2530.fffffe31@mx.google.com>
Return-Path: <lovecentry@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17954
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lovecentry@gmail.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

------=_NextPart_000_0004_01C85257.7C6BA180
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi

As we know in mips achitecture if current pc falls into kseg1 segment, any
memory reference will bypass cache and fetch directly from dram. But for
some prcoessor such like mips R10K it has off chip L2 cache. I haven't found
any available path which can access dram directly. All memory reference need
pass through L2 cache. Does it mean any memory reference in kseg1 will be
fetch from L2 cache rather than dram for such system? How does such system
design when system software need access kseg1 region? Further more, Kseg2 is
used to do memory map for those peripheral so Is there has a particular
circuit that routes those access to the appropriate destination.

Any suggestion is highly appreciate!!!

 

Tony


------=_NextPart_000_0004_01C85257.7C6BA180
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	text-justify:inter-ideograph;
	font-size:10.5pt;
	font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:Arial;
	color:windowtext;}
 /* Page Definitions */
 @page Section1
	{size:595.3pt 841.9pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;
	layout-grid:15.6pt;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DZH-CN link=3Dblue vlink=3Dpurple =
style=3D'text-justify-trim:punctuation'>

<div class=3DSection1 style=3D'layout-grid:15.6pt'>

<p class=3DMsoNormal><font size=3D1 color=3D"#333333" =
face=3DTahoma><span lang=3DEN-US
style=3D'font-size:9.0pt;font-family:Tahoma;color:#333333'>Hi<o:p></o:p><=
/span></font></p>

<p class=3DMsoNormal><font size=3D1 color=3D"#333333" =
face=3DTahoma><span lang=3DEN-US
style=3D'font-size:9.0pt;font-family:Tahoma;color:#333333'>As we know in =
mips
achitecture if current pc falls into kseg1 segment, any memory reference =
will
bypass cache and fetch directly from dram. But for some prcoessor such =
like
mips R10K it has off chip L2 cache. I haven't found any available path =
which
can access dram directly. All memory reference need pass through L2 =
cache. Does
it mean any memory reference in kseg1 will be fetch from L2 cache rather =
than
dram for such system? How does such system design when system software =
need
access kseg1 region? Further more, Kseg2 is used to do memory map for =
those peripheral
so Is there has a particular circuit that routes those access to the =
appropriate
destination.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 color=3D"#333333" =
face=3DTahoma><span lang=3DEN-US
style=3D'font-size:9.0pt;font-family:Tahoma;color:#333333'>Any =
suggestion is
highly appreciate!!!<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 color=3D"#333333" =
face=3DTahoma><span lang=3DEN-US
style=3D'font-size:9.0pt;font-family:Tahoma;color:#333333'><o:p>&nbsp;</o=
:p></span></font></p>

<p class=3DMsoNormal><font size=3D1 color=3D"#333333" =
face=3DTahoma><span lang=3DEN-US
style=3D'font-size:9.0pt;font-family:Tahoma;color:#333333'>Tony</span></f=
ont><font
size=3D1 face=3DArial><span lang=3DEN-US =
style=3D'font-size:9.0pt;font-family:Arial'><o:p></o:p></span></font></p>=


</div>

</body>

</html>

------=_NextPart_000_0004_01C85257.7C6BA180--
