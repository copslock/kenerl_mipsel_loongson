Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Feb 2004 05:13:15 +0000 (GMT)
Received: from [IPv6:::ffff:202.96.215.33] ([IPv6:::ffff:202.96.215.33]:48143
	"EHLO tmtms.trident.com.cn") by linux-mips.org with ESMTP
	id <S8224939AbUBXFNM>; Tue, 24 Feb 2004 05:13:12 +0000
Received: by TMTMS with Internet Mail Service (5.5.2653.19)
	id <FH8P4DFF>; Tue, 24 Feb 2004 13:09:48 +0800
Message-ID: <15F9E1AE3207D6119CEA00D0B7DD5F680219C648@TMTMS>
From:	"Liu Hongming (Alan)" <alanliu@trident.com.cn>
To:	linux-mips@linux-mips.org
Subject: IDE driver problem
Date:	Tue, 24 Feb 2004 13:09:48 +0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C3FA94.6CC96E70"
Return-Path: <alanliu@trident.com.cn>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4421
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alanliu@trident.com.cn
Precedence: bulk
X-list: linux-mips

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C3FA94.6CC96E70
Content-Type: text/plain;
	charset="ISO-8859-1"

Hi All,

I am porting IDE drivers(Since my hardware has endian issue),
and now it could work,however it has some abnormal problems:

I could 'fdisk'  /dev/hda,and partition it into several partitions.
After this,I reboot my board and see all the partitions is there.
Then I 'mke2fs' on /dev/hda1,after this, when using 'fdisk' again,
I found all partitions gone! At this time,I could not access /dev/hda1
any more.However, I could 'mount /dev/hda /opt', it really worked,and
I could create/read/write/erase files in it.

I dumped the first sector of Hard disk and found that it has been
zeroed.Now I dont know what the problem is,since I am not familiar 
with fs parts of linux kernel,and I dont know what 'mke2fs' has done.

Any advice?

Alan

-----Original Message-----
From: Kevin D. Kissell [mailto:kevink@mips.com]
Sent: Tuesday, February 24, 2004 6:47 AM
To: Mark and Janice Juszczec; linux-mips@linux-mips.org
Cc: uhler@mips.com; dom@mips.com; echristo@redhat.com
Subject: Re: r3000 instruction set


Kaffe's makefiles won't pick up on configuration changes, so any time
you re-configure for a different engine or debug level, you need to do
a make clean.  At least, that's the way it was the last time I worked on it.
If you had a partial build with JIT, then changed to intrp, then you could
get all kinds of strange behavior.  The address range of your error us a
dead giveaway.  It's too high to be the kaffe code segment, but too low
to be a shared library.  It's where I'd expect the heap to be, and where
I remember the JIT buffers being allocated when I was trying to debug
that stuff.

> Its been a few weeks since I built this version of kaffe.  The configure 
> output says I did specify --with-engine=intrp.  I'll delete the compiled 
> stuff, reconfigure (double checking that I give it --with-engine=intrp), 
> recompile and retest.
> 
> I'll post my results.
> 
> Mark
> 
> 
> 
> >From: "Kevin D. Kissell" <kevink@mips.com>
> >To: "Mark and Janice Juszczec" <juszczec@hotmail.com>,        
> ><linux-mips@linux-mips.org>
> >CC: <uhler@mips.com>, <dom@mips.com>, <echristo@redhat.com>
> >Subject: Re: r3000 instruction set
> >Date: Mon, 23 Feb 2004 18:21:19 +0100
> >
> > > Someone suggested posting the message I get.  Here it is:
> > >
> > > >./kaffe-bin FirstClass
> > > [kaffe-bin:6] Illgal instruction 674696a at 2abb034, ra=2adbffd0,
> > > P0_STATUS=0000500
> > > pid 6: killed (signal 4)
> > > >Reading command line: Try again
> > > Kernel panic: Attmpted to kill int!
> >
> >Let me guess.  You are running little-endian.  The instruction word
> >in memory would be 0x6a697406.  Do you think it's a coincidence
> >that 0x6a6974 spells "jit" in ASCII?  ;o)
> >
> >The reported address range looks like that where kaffe builds its
> >JITted instruciton buffers in MIPS/Linux.  And, like I say, JIT is
> >somewhat broken for MIPS in Kaffe.  Which version of the kaffe sources
> >are you building, and have you tried configuring with --with-engine=intrp
> >as I suggested?
> >
> >             Regards,
> >
> >             Kevin K.
> 
> _________________________________________________________________
> Click, drag and drop. My MSN is the simple way to design your homepage. 
> http://click.atdmt.com/AVE/go/onm00200364ave/direct/01/
> 
> 

------_=_NextPart_001_01C3FA94.6CC96E70
Content-Type: text/html;
	charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3DISO-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
5.5.2653.12">
<TITLE>IDE driver problem</TITLE>
</HEAD>
<BODY>

<P><FONT SIZE=3D2>Hi All,</FONT>
</P>

<P><FONT SIZE=3D2>I am porting IDE drivers(Since my hardware has endian =
issue),</FONT>
<BR><FONT SIZE=3D2>and now it could work,however it has some abnormal =
problems:</FONT>
</P>

<P><FONT SIZE=3D2>I could 'fdisk'&nbsp; /dev/hda,and partition it into =
several partitions.</FONT>
<BR><FONT SIZE=3D2>After this,I reboot my board and see all the =
partitions is there.</FONT>
<BR><FONT SIZE=3D2>Then I 'mke2fs' on /dev/hda1,after this, when using =
'fdisk' again,</FONT>
<BR><FONT SIZE=3D2>I found all partitions gone! At this time,I could =
not access /dev/hda1</FONT>
<BR><FONT SIZE=3D2>any more.However, I could 'mount /dev/hda /opt', it =
really worked,and</FONT>
<BR><FONT SIZE=3D2>I could create/read/write/erase files in it.</FONT>
</P>

<P><FONT SIZE=3D2>I dumped the first sector of Hard disk and found that =
it has been</FONT>
<BR><FONT SIZE=3D2>zeroed.Now I dont know what the problem is,since I =
am not familiar </FONT>
<BR><FONT SIZE=3D2>with fs parts of linux kernel,and I dont know what =
'mke2fs' has done.</FONT>
</P>

<P><FONT SIZE=3D2>Any advice?</FONT>
</P>

<P><FONT SIZE=3D2>Alan</FONT>
</P>

<P><FONT SIZE=3D2>-----Original Message-----</FONT>
<BR><FONT SIZE=3D2>From: Kevin D. Kissell [<A =
HREF=3D"mailto:kevink@mips.com">mailto:kevink@mips.com</A>]</FONT>
<BR><FONT SIZE=3D2>Sent: Tuesday, February 24, 2004 6:47 AM</FONT>
<BR><FONT SIZE=3D2>To: Mark and Janice Juszczec; =
linux-mips@linux-mips.org</FONT>
<BR><FONT SIZE=3D2>Cc: uhler@mips.com; dom@mips.com; =
echristo@redhat.com</FONT>
<BR><FONT SIZE=3D2>Subject: Re: r3000 instruction set</FONT>
</P>
<BR>

<P><FONT SIZE=3D2>Kaffe's makefiles won't pick up on configuration =
changes, so any time</FONT>
<BR><FONT SIZE=3D2>you re-configure for a different engine or debug =
level, you need to do</FONT>
<BR><FONT SIZE=3D2>a make clean.&nbsp; At least, that's the way it was =
the last time I worked on it.</FONT>
<BR><FONT SIZE=3D2>If you had a partial build with JIT, then changed to =
intrp, then you could</FONT>
<BR><FONT SIZE=3D2>get all kinds of strange behavior.&nbsp; The address =
range of your error us a</FONT>
<BR><FONT SIZE=3D2>dead giveaway.&nbsp; It's too high to be the kaffe =
code segment, but too low</FONT>
<BR><FONT SIZE=3D2>to be a shared library.&nbsp; It's where I'd expect =
the heap to be, and where</FONT>
<BR><FONT SIZE=3D2>I remember the JIT buffers being allocated when I =
was trying to debug</FONT>
<BR><FONT SIZE=3D2>that stuff.</FONT>
</P>

<P><FONT SIZE=3D2>&gt; Its been a few weeks since I built this version =
of kaffe.&nbsp; The configure </FONT>
<BR><FONT SIZE=3D2>&gt; output says I did specify =
--with-engine=3Dintrp.&nbsp; I'll delete the compiled </FONT>
<BR><FONT SIZE=3D2>&gt; stuff, reconfigure (double checking that I give =
it --with-engine=3Dintrp), </FONT>
<BR><FONT SIZE=3D2>&gt; recompile and retest.</FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; I'll post my results.</FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; Mark</FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; &gt;From: &quot;Kevin D. Kissell&quot; =
&lt;kevink@mips.com&gt;</FONT>
<BR><FONT SIZE=3D2>&gt; &gt;To: &quot;Mark and Janice Juszczec&quot; =
&lt;juszczec@hotmail.com&gt;,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</FONT>
<BR><FONT SIZE=3D2>&gt; &gt;&lt;linux-mips@linux-mips.org&gt;</FONT>
<BR><FONT SIZE=3D2>&gt; &gt;CC: &lt;uhler@mips.com&gt;, =
&lt;dom@mips.com&gt;, &lt;echristo@redhat.com&gt;</FONT>
<BR><FONT SIZE=3D2>&gt; &gt;Subject: Re: r3000 instruction set</FONT>
<BR><FONT SIZE=3D2>&gt; &gt;Date: Mon, 23 Feb 2004 18:21:19 =
+0100</FONT>
<BR><FONT SIZE=3D2>&gt; &gt;</FONT>
<BR><FONT SIZE=3D2>&gt; &gt; &gt; Someone suggested posting the message =
I get.&nbsp; Here it is:</FONT>
<BR><FONT SIZE=3D2>&gt; &gt; &gt;</FONT>
<BR><FONT SIZE=3D2>&gt; &gt; &gt; &gt;./kaffe-bin FirstClass</FONT>
<BR><FONT SIZE=3D2>&gt; &gt; &gt; [kaffe-bin:6] Illgal instruction =
674696a at 2abb034, ra=3D2adbffd0,</FONT>
<BR><FONT SIZE=3D2>&gt; &gt; &gt; P0_STATUS=3D0000500</FONT>
<BR><FONT SIZE=3D2>&gt; &gt; &gt; pid 6: killed (signal 4)</FONT>
<BR><FONT SIZE=3D2>&gt; &gt; &gt; &gt;Reading command line: Try =
again</FONT>
<BR><FONT SIZE=3D2>&gt; &gt; &gt; Kernel panic: Attmpted to kill =
int!</FONT>
<BR><FONT SIZE=3D2>&gt; &gt;</FONT>
<BR><FONT SIZE=3D2>&gt; &gt;Let me guess.&nbsp; You are running =
little-endian.&nbsp; The instruction word</FONT>
<BR><FONT SIZE=3D2>&gt; &gt;in memory would be 0x6a697406.&nbsp; Do you =
think it's a coincidence</FONT>
<BR><FONT SIZE=3D2>&gt; &gt;that 0x6a6974 spells &quot;jit&quot; in =
ASCII?&nbsp; ;o)</FONT>
<BR><FONT SIZE=3D2>&gt; &gt;</FONT>
<BR><FONT SIZE=3D2>&gt; &gt;The reported address range looks like that =
where kaffe builds its</FONT>
<BR><FONT SIZE=3D2>&gt; &gt;JITted instruciton buffers in =
MIPS/Linux.&nbsp; And, like I say, JIT is</FONT>
<BR><FONT SIZE=3D2>&gt; &gt;somewhat broken for MIPS in Kaffe.&nbsp; =
Which version of the kaffe sources</FONT>
<BR><FONT SIZE=3D2>&gt; &gt;are you building, and have you tried =
configuring with --with-engine=3Dintrp</FONT>
<BR><FONT SIZE=3D2>&gt; &gt;as I suggested?</FONT>
<BR><FONT SIZE=3D2>&gt; &gt;</FONT>
<BR><FONT SIZE=3D2>&gt; =
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; Regards,</FONT>
<BR><FONT SIZE=3D2>&gt; &gt;</FONT>
<BR><FONT SIZE=3D2>&gt; =
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; Kevin K.</FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; =
_________________________________________________________________</FONT>=

<BR><FONT SIZE=3D2>&gt; Click, drag and drop. My MSN is the simple way =
to design your homepage. </FONT>
<BR><FONT SIZE=3D2>&gt; <A =
HREF=3D"http://click.atdmt.com/AVE/go/onm00200364ave/direct/01/" =
TARGET=3D"_blank">http://click.atdmt.com/AVE/go/onm00200364ave/direct/01=
/</A></FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C3FA94.6CC96E70--
