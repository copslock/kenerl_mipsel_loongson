Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Jul 2003 03:13:11 +0100 (BST)
Received: from mx1.teralogic.tv ([IPv6:::ffff:207.16.148.27]:62915 "EHLO
	mail.teralogic.tv") by linux-mips.org with ESMTP
	id <S8225239AbTGWCNJ>; Wed, 23 Jul 2003 03:13:09 +0100
Received: from tlexmail.teralogic.tv (uugate-2.oaktech.com [207.16.148.1])
	by mail.teralogic.tv (8.11.6/8.11.6) with ESMTP id h6N28fG04239;
	Tue, 22 Jul 2003 19:08:41 -0700 (PDT)
Received: by tlexposeidon.teralogic-inc.com with Internet Mail Service (5.5.2653.19)
	id <L92RZBD4>; Tue, 22 Jul 2003 19:03:42 -0700
Message-ID: <56BEF0DBC8B9D611BFDB00508B5E263410301F@tlexposeidon.teralogic-inc.com>
From: Dennis Castleman <DennisCastleman@oaktech.com>
To: "'Wolfgang Denk'" <wd@denx.de>,
	Dennis Castleman <DennisCastleman@oaktech.com>
Cc: linux-mips@linux-mips.org
Subject: RE: Profiling tools 
Date: Tue, 22 Jul 2003 19:03:38 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C350BE.A1BAFB60"
Return-Path: <DennisCastleman@oaktech.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2879
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: DennisCastleman@oaktech.com
Precedence: bulk
X-list: linux-mips

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C350BE.A1BAFB60
Content-Type: text/plain

I'm looking for something like 
http://sourceforge.net/projects/oprofile/
Running on mips.

-----Original Message-----
From: Wolfgang Denk [mailto:wd@denx.de] 
Sent: Tuesday, July 22, 2003 5:04 PM
To: Dennis Castleman
Cc: linux-mips@linux-mips.org
Subject: Re: Profiling tools 


Dear Dennis,

in message
<56BEF0DBC8B9D611BFDB00508B5E263410301E@tlexposeidon.teralogic-inc.com> you
wrote:
>
> Any body have any experience will finding
> Profile tool for mips-linux?

What exactly are you looking for? There can be several intentions  to
"profile" software.

> I'm running MontaVista 2.4.17 on a mips 5kc core.
> I'm running linux on top of RTAI 2.24.1.8
> If I can find a profiler that work with the 5kc, then I'll add
> RTAI support, if necessary.

Did you have a look at the LTT? See http://www.opersys.com/LTT/index.html

> ------_=_NextPart_001_01C350AB.506AC4B0
> Content-Type: text/html
> 
> <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">

Please: don't post HTML to mailing lists.


Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de I am
not now, nor have I ever been, a member of the demigodic party.
                                                   -- Dennis Ritchie

------_=_NextPart_001_01C350BE.A1BAFB60
Content-Type: text/html
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3DUS-ASCII">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
5.5.2653.12">
<TITLE>RE: Profiling tools </TITLE>
</HEAD>
<BODY>

<P><FONT SIZE=3D2>I'm looking for something like </FONT>
<BR><FONT SIZE=3D2><A =
HREF=3D"http://sourceforge.net/projects/oprofile/" =
TARGET=3D"_blank">http://sourceforge.net/projects/oprofile/</A></FONT>
<BR><FONT SIZE=3D2>Running on mips.</FONT>
</P>

<P><FONT SIZE=3D2>-----Original Message-----</FONT>
<BR><FONT SIZE=3D2>From: Wolfgang Denk [<A =
HREF=3D"mailto:wd@denx.de">mailto:wd@denx.de</A>] </FONT>
<BR><FONT SIZE=3D2>Sent: Tuesday, July 22, 2003 5:04 PM</FONT>
<BR><FONT SIZE=3D2>To: Dennis Castleman</FONT>
<BR><FONT SIZE=3D2>Cc: linux-mips@linux-mips.org</FONT>
<BR><FONT SIZE=3D2>Subject: Re: Profiling tools </FONT>
</P>
<BR>

<P><FONT SIZE=3D2>Dear Dennis,</FONT>
</P>

<P><FONT SIZE=3D2>in message =
&lt;56BEF0DBC8B9D611BFDB00508B5E263410301E@tlexposeidon.teralogic-inc.co=
m&gt; you wrote:</FONT>
<BR><FONT SIZE=3D2>&gt;</FONT>
<BR><FONT SIZE=3D2>&gt; Any body have any experience will =
finding</FONT>
<BR><FONT SIZE=3D2>&gt; Profile tool for mips-linux?</FONT>
</P>

<P><FONT SIZE=3D2>What exactly are you looking for? There can be =
several intentions&nbsp; to &quot;profile&quot; software.</FONT>
</P>

<P><FONT SIZE=3D2>&gt; I'm running MontaVista 2.4.17 on a mips 5kc =
core.</FONT>
<BR><FONT SIZE=3D2>&gt; I'm running linux on top of RTAI =
2.24.1.8</FONT>
<BR><FONT SIZE=3D2>&gt; If I can find a profiler that work with the =
5kc, then I'll add</FONT>
<BR><FONT SIZE=3D2>&gt; RTAI support, if necessary.</FONT>
</P>

<P><FONT SIZE=3D2>Did you have a look at the LTT? See <A =
HREF=3D"http://www.opersys.com/LTT/index.html" =
TARGET=3D"_blank">http://www.opersys.com/LTT/index.html</A></FONT>
</P>

<P><FONT SIZE=3D2>&gt; ------_=3D_NextPart_001_01C350AB.506AC4B0</FONT>
<BR><FONT SIZE=3D2>&gt; Content-Type: text/html</FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; &lt;!DOCTYPE HTML PUBLIC &quot;-//W3C//DTD HTML =
3.2//EN&quot;&gt;</FONT>
</P>

<P><FONT SIZE=3D2>Please: don't post HTML to mailing lists.</FONT>
</P>
<BR>

<P><FONT SIZE=3D2>Best regards,</FONT>
</P>

<P><FONT SIZE=3D2>Wolfgang Denk</FONT>
</P>

<P><FONT SIZE=3D2>-- </FONT>
<BR><FONT SIZE=3D2>Software Engineering:&nbsp; Embedded and Realtime =
Systems,&nbsp; Embedded Linux</FONT>
<BR><FONT SIZE=3D2>Phone: (+49)-8142-4596-87&nbsp; Fax: =
(+49)-8142-4596-88&nbsp; Email: wd@denx.de I am not now, nor have I =
ever been, a member of the demigodic party.</FONT></P>

<P><FONT =
SIZE=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; -- Dennis Ritchie</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C350BE.A1BAFB60--
