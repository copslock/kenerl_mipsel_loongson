Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Feb 2004 12:13:26 +0000 (GMT)
Received: from [IPv6:::ffff:202.96.215.33] ([IPv6:::ffff:202.96.215.33]:19469
	"EHLO tmtms.trident.com.cn") by linux-mips.org with ESMTP
	id <S8225073AbUBXMNX>; Tue, 24 Feb 2004 12:13:23 +0000
Received: by TMTMS with Internet Mail Service (5.5.2653.19)
	id <FH8P41SN>; Tue, 24 Feb 2004 20:09:51 +0800
Message-ID: <15F9E1AE3207D6119CEA00D0B7DD5F680219C6D8@TMTMS>
From:	"Liu Hongming (Alan)" <alanliu@trident.com.cn>
To:	Thomas Lange <thomas@corelatus.se>,
	"Liu Hongming (Alan)" <alanliu@trident.com.cn>
Cc:	linux-mips@linux-mips.org
Subject: RE: IDE driver problem
Date:	Tue, 24 Feb 2004 20:09:50 +0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C3FACF.1A5E2E60"
Return-Path: <alanliu@trident.com.cn>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4424
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alanliu@trident.com.cn
Precedence: bulk
X-list: linux-mips

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C3FACF.1A5E2E60
Content-Type: text/plain;
	charset="ISO-8859-1"

Hi Thomas,

I agree what you said,however,my problem is that
when I use 'mke2fs /dev/hda2', it will report following errors:
"Device size reported to be zero.  Invalid partition specified, or
 partition table wasn't reread after running fdisk, due to
 a modified partition being busy and in use.  You may need to reboot
 to re-read your partition table".
The fact is that I have created four partitions: hda1,hda2,hda3,hda4.
And their cylinder is:1-1000,1001-2000,2001-3000,3001-4000.However,
when kernel boots up,it only could find hda1.
After rebooting,I use fdisk to find the status of the four partitions.They
are
all still there.I dont know why kernel could not find them. I have used
tools
to dump the first sector,the four partition table is:
0x00000000:  00000000 00000000 00000000 00000000
0x00000010:  00000000 00000000 00000000 00000000
0x00000020:  00000000 00000000 00000000 00000000
0x00000030:  00000000 00000000 00000000 00000000
0x00000040:  00000000 00000000 00000000 00000000
0x00000050:  00000000 00000000 00000000 00000000
0x00000060:  00000000 00000000 00000000 00000000
0x00000070:  00000000 00000000 00000000 00000000
0x00000080:  00000000 00000000 00000000 00000000
0x00000090:  00000000 00000000 00000000 00000000
0x000000a0:  00000000 00000000 00000000 00000000
0x000000b0:  00000000 00000000 00000000 00000000
0x000000c0:  00000000 00000000 00000000 00000000
0x000000d0:  00000000 00000000 00000000 00000000
0x000000e0:  00000000 00000000 00000000 00000000
0x000000f0:  00000000 00000000 00000000 00000000
0x00000100:  00000000 00000000 00000000 00000000
0x00000110:  00000000 00000000 00000000 00000000
0x00000120:  00000000 00000000 00000000 00000000
0x00000130:  00000000 00000000 00000000 00000000
0x00000140:  00000000 00000000 00000000 00000000
0x00000150:  00000000 00000000 00000000 00000000
0x00000160:  00000000 00000000 00000000 00000000
0x00000170:  00000000 00000000 00000000 00000000
0x00000180:  00000000 00000000 00000000 00000000
0x00000190:  00000000 00000000 00000000 00000000
0x000001a0:  00000000 00000000 00000000 00000000
0x000001b0:  00000000 00000000 00000000 00008001
0x000001c0:  0100830f  ffe73f00 00004161 0f000000
0x000001d0:  c1e8830f ffff8061 0f008061 0f00000f
0x000001e0:  ffff830f ffff00c3 1e008061 0f00000f
0x000001f0:  ffff830f ffff8024 2e008061 0f0055aa

I think they are all right.But why kernel could not find these partitions?

Best Regards,
Alan

-----Original Message-----
From: Thomas Lange [mailto:thomas@corelatus.se]
Sent: Tuesday, February 24, 2004 7:56 PM
To: Liu Hongming (Alan)
Cc: linux-mips@linux-mips.org
Subject: Re: IDE driver problem


The partition table is written to the first partition
on the device, in your example hda1.
Use mke2fs on hda2 and I am sure it work just great.

Cheers,
/Thomas

Liu Hongming (Alan) wrote:
> Hi All,
> 
> I am porting IDE drivers(Since my hardware has endian issue),
> and now it could work,however it has some abnormal problems:
> 
> I could 'fdisk'  /dev/hda,and partition it into several partitions.
> After this,I reboot my board and see all the partitions is there.
> Then I 'mke2fs' on /dev/hda1,after this, when using 'fdisk' again,
> I found all partitions gone! At this time,I could not access /dev/hda1
> any more.However, I could 'mount /dev/hda /opt', it really worked,and
> I could create/read/write/erase files in it.
> 
> I dumped the first sector of Hard disk and found that it has been
> zeroed.Now I dont know what the problem is,since I am not familiar
> with fs parts of linux kernel,and I dont know what 'mke2fs' has done.
> 
> Any advice?
> 
> Alan
> 
> -----Original Message-----
> From: Kevin D. Kissell [mailto:kevink@mips.com]
> Sent: Tuesday, February 24, 2004 6:47 AM
> To: Mark and Janice Juszczec; linux-mips@linux-mips.org
> Cc: uhler@mips.com; dom@mips.com; echristo@redhat.com
> Subject: Re: r3000 instruction set
> 
> 
> Kaffe's makefiles won't pick up on configuration changes, so any time
> you re-configure for a different engine or debug level, you need to do
> a make clean.  At least, that's the way it was the last time I worked on 
> it.
> If you had a partial build with JIT, then changed to intrp, then you could
> get all kinds of strange behavior.  The address range of your error us a
> dead giveaway.  It's too high to be the kaffe code segment, but too low
> to be a shared library.  It's where I'd expect the heap to be, and where
> I remember the JIT buffers being allocated when I was trying to debug
> that stuff.
> 
>  > Its been a few weeks since I built this version of kaffe.  The
configure
>  > output says I did specify --with-engine=intrp.  I'll delete the
compiled
>  > stuff, reconfigure (double checking that I give it
--with-engine=intrp),
>  > recompile and retest.
>  >
>  > I'll post my results.
>  >
>  > Mark
>  >
>  >
>  >
>  > >From: "Kevin D. Kissell" <kevink@mips.com>
>  > >To: "Mark and Janice Juszczec" <juszczec@hotmail.com>,       
>  > ><linux-mips@linux-mips.org>
>  > >CC: <uhler@mips.com>, <dom@mips.com>, <echristo@redhat.com>
>  > >Subject: Re: r3000 instruction set
>  > >Date: Mon, 23 Feb 2004 18:21:19 +0100
>  > >
>  > > > Someone suggested posting the message I get.  Here it is:
>  > > >
>  > > > >./kaffe-bin FirstClass
>  > > > [kaffe-bin:6] Illgal instruction 674696a at 2abb034, ra=2adbffd0,
>  > > > P0_STATUS=0000500
>  > > > pid 6: killed (signal 4)
>  > > > >Reading command line: Try again
>  > > > Kernel panic: Attmpted to kill int!
>  > >
>  > >Let me guess.  You are running little-endian.  The instruction word
>  > >in memory would be 0x6a697406.  Do you think it's a coincidence
>  > >that 0x6a6974 spells "jit" in ASCII?  ;o)
>  > >
>  > >The reported address range looks like that where kaffe builds its
>  > >JITted instruciton buffers in MIPS/Linux.  And, like I say, JIT is
>  > >somewhat broken for MIPS in Kaffe.  Which version of the kaffe sources
>  > >are you building, and have you tried configuring with 
> --with-engine=intrp
>  > >as I suggested?
>  > >
>  > >             Regards,
>  > >
>  > >             Kevin K.
>  >
>  > _________________________________________________________________
>  > Click, drag and drop. My MSN is the simple way to design your homepage.
>  > http://click.atdmt.com/AVE/go/onm00200364ave/direct/01/
>  >
>  >
> 


------_=_NextPart_001_01C3FACF.1A5E2E60
Content-Type: text/html;
	charset="ISO-8859-1"

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=ISO-8859-1">
<META NAME="Generator" CONTENT="MS Exchange Server version 5.5.2653.12">
<TITLE>RE: IDE driver problem</TITLE>
</HEAD>
<BODY>

<P><FONT SIZE=2>Hi Thomas,</FONT>
</P>

<P><FONT SIZE=2>I agree what you said,however,my problem is that</FONT>
<BR><FONT SIZE=2>when I use 'mke2fs /dev/hda2', it will report following errors:</FONT>
<BR><FONT SIZE=2>&quot;Device size reported to be zero.&nbsp; Invalid partition specified, or</FONT>
<BR><FONT SIZE=2>&nbsp;partition table wasn't reread after running fdisk, due to</FONT>
<BR><FONT SIZE=2>&nbsp;a modified partition being busy and in use.&nbsp; You may need to reboot</FONT>
<BR><FONT SIZE=2>&nbsp;to re-read your partition table&quot;.</FONT>
<BR><FONT SIZE=2>The fact is that I have created four partitions: hda1,hda2,hda3,hda4.</FONT>
<BR><FONT SIZE=2>And their cylinder is:1-1000,1001-2000,2001-3000,3001-4000.However,</FONT>
<BR><FONT SIZE=2>when kernel boots up,it only could find hda1.</FONT>
<BR><FONT SIZE=2>After rebooting,I use fdisk to find the status of the four partitions.They are</FONT>
<BR><FONT SIZE=2>all still there.I dont know why kernel could not find them. I have used tools</FONT>
<BR><FONT SIZE=2>to dump the first sector,the four partition table is:</FONT>
<BR><FONT SIZE=2>0x00000000:&nbsp; 00000000 00000000 00000000 00000000</FONT>
<BR><FONT SIZE=2>0x00000010:&nbsp; 00000000 00000000 00000000 00000000</FONT>
<BR><FONT SIZE=2>0x00000020:&nbsp; 00000000 00000000 00000000 00000000</FONT>
<BR><FONT SIZE=2>0x00000030:&nbsp; 00000000 00000000 00000000 00000000</FONT>
<BR><FONT SIZE=2>0x00000040:&nbsp; 00000000 00000000 00000000 00000000</FONT>
<BR><FONT SIZE=2>0x00000050:&nbsp; 00000000 00000000 00000000 00000000</FONT>
<BR><FONT SIZE=2>0x00000060:&nbsp; 00000000 00000000 00000000 00000000</FONT>
<BR><FONT SIZE=2>0x00000070:&nbsp; 00000000 00000000 00000000 00000000</FONT>
<BR><FONT SIZE=2>0x00000080:&nbsp; 00000000 00000000 00000000 00000000</FONT>
<BR><FONT SIZE=2>0x00000090:&nbsp; 00000000 00000000 00000000 00000000</FONT>
<BR><FONT SIZE=2>0x000000a0:&nbsp; 00000000 00000000 00000000 00000000</FONT>
<BR><FONT SIZE=2>0x000000b0:&nbsp; 00000000 00000000 00000000 00000000</FONT>
<BR><FONT SIZE=2>0x000000c0:&nbsp; 00000000 00000000 00000000 00000000</FONT>
<BR><FONT SIZE=2>0x000000d0:&nbsp; 00000000 00000000 00000000 00000000</FONT>
<BR><FONT SIZE=2>0x000000e0:&nbsp; 00000000 00000000 00000000 00000000</FONT>
<BR><FONT SIZE=2>0x000000f0:&nbsp; 00000000 00000000 00000000 00000000</FONT>
<BR><FONT SIZE=2>0x00000100:&nbsp; 00000000 00000000 00000000 00000000</FONT>
<BR><FONT SIZE=2>0x00000110:&nbsp; 00000000 00000000 00000000 00000000</FONT>
<BR><FONT SIZE=2>0x00000120:&nbsp; 00000000 00000000 00000000 00000000</FONT>
<BR><FONT SIZE=2>0x00000130:&nbsp; 00000000 00000000 00000000 00000000</FONT>
<BR><FONT SIZE=2>0x00000140:&nbsp; 00000000 00000000 00000000 00000000</FONT>
<BR><FONT SIZE=2>0x00000150:&nbsp; 00000000 00000000 00000000 00000000</FONT>
<BR><FONT SIZE=2>0x00000160:&nbsp; 00000000 00000000 00000000 00000000</FONT>
<BR><FONT SIZE=2>0x00000170:&nbsp; 00000000 00000000 00000000 00000000</FONT>
<BR><FONT SIZE=2>0x00000180:&nbsp; 00000000 00000000 00000000 00000000</FONT>
<BR><FONT SIZE=2>0x00000190:&nbsp; 00000000 00000000 00000000 00000000</FONT>
<BR><FONT SIZE=2>0x000001a0:&nbsp; 00000000 00000000 00000000 00000000</FONT>
<BR><FONT SIZE=2>0x000001b0:&nbsp; 00000000 00000000 00000000 00008001</FONT>
<BR><FONT SIZE=2>0x000001c0:&nbsp; 0100830f&nbsp; ffe73f00 00004161 0f000000</FONT>
<BR><FONT SIZE=2>0x000001d0:&nbsp; c1e8830f ffff8061 0f008061 0f00000f</FONT>
<BR><FONT SIZE=2>0x000001e0:&nbsp; ffff830f ffff00c3 1e008061 0f00000f</FONT>
<BR><FONT SIZE=2>0x000001f0:&nbsp; ffff830f ffff8024 2e008061 0f0055aa</FONT>
</P>

<P><FONT SIZE=2>I think they are all right.But why kernel could not find these partitions?</FONT>
</P>

<P><FONT SIZE=2>Best Regards,</FONT>
<BR><FONT SIZE=2>Alan</FONT>
</P>

<P><FONT SIZE=2>-----Original Message-----</FONT>
<BR><FONT SIZE=2>From: Thomas Lange [<A HREF="mailto:thomas@corelatus.se">mailto:thomas@corelatus.se</A>]</FONT>
<BR><FONT SIZE=2>Sent: Tuesday, February 24, 2004 7:56 PM</FONT>
<BR><FONT SIZE=2>To: Liu Hongming (Alan)</FONT>
<BR><FONT SIZE=2>Cc: linux-mips@linux-mips.org</FONT>
<BR><FONT SIZE=2>Subject: Re: IDE driver problem</FONT>
</P>
<BR>

<P><FONT SIZE=2>The partition table is written to the first partition</FONT>
<BR><FONT SIZE=2>on the device, in your example hda1.</FONT>
<BR><FONT SIZE=2>Use mke2fs on hda2 and I am sure it work just great.</FONT>
</P>

<P><FONT SIZE=2>Cheers,</FONT>
<BR><FONT SIZE=2>/Thomas</FONT>
</P>

<P><FONT SIZE=2>Liu Hongming (Alan) wrote:</FONT>
<BR><FONT SIZE=2>&gt; Hi All,</FONT>
<BR><FONT SIZE=2>&gt; </FONT>
<BR><FONT SIZE=2>&gt; I am porting IDE drivers(Since my hardware has endian issue),</FONT>
<BR><FONT SIZE=2>&gt; and now it could work,however it has some abnormal problems:</FONT>
<BR><FONT SIZE=2>&gt; </FONT>
<BR><FONT SIZE=2>&gt; I could 'fdisk'&nbsp; /dev/hda,and partition it into several partitions.</FONT>
<BR><FONT SIZE=2>&gt; After this,I reboot my board and see all the partitions is there.</FONT>
<BR><FONT SIZE=2>&gt; Then I 'mke2fs' on /dev/hda1,after this, when using 'fdisk' again,</FONT>
<BR><FONT SIZE=2>&gt; I found all partitions gone! At this time,I could not access /dev/hda1</FONT>
<BR><FONT SIZE=2>&gt; any more.However, I could 'mount /dev/hda /opt', it really worked,and</FONT>
<BR><FONT SIZE=2>&gt; I could create/read/write/erase files in it.</FONT>
<BR><FONT SIZE=2>&gt; </FONT>
<BR><FONT SIZE=2>&gt; I dumped the first sector of Hard disk and found that it has been</FONT>
<BR><FONT SIZE=2>&gt; zeroed.Now I dont know what the problem is,since I am not familiar</FONT>
<BR><FONT SIZE=2>&gt; with fs parts of linux kernel,and I dont know what 'mke2fs' has done.</FONT>
<BR><FONT SIZE=2>&gt; </FONT>
<BR><FONT SIZE=2>&gt; Any advice?</FONT>
<BR><FONT SIZE=2>&gt; </FONT>
<BR><FONT SIZE=2>&gt; Alan</FONT>
<BR><FONT SIZE=2>&gt; </FONT>
<BR><FONT SIZE=2>&gt; -----Original Message-----</FONT>
<BR><FONT SIZE=2>&gt; From: Kevin D. Kissell [<A HREF="mailto:kevink@mips.com">mailto:kevink@mips.com</A>]</FONT>
<BR><FONT SIZE=2>&gt; Sent: Tuesday, February 24, 2004 6:47 AM</FONT>
<BR><FONT SIZE=2>&gt; To: Mark and Janice Juszczec; linux-mips@linux-mips.org</FONT>
<BR><FONT SIZE=2>&gt; Cc: uhler@mips.com; dom@mips.com; echristo@redhat.com</FONT>
<BR><FONT SIZE=2>&gt; Subject: Re: r3000 instruction set</FONT>
<BR><FONT SIZE=2>&gt; </FONT>
<BR><FONT SIZE=2>&gt; </FONT>
<BR><FONT SIZE=2>&gt; Kaffe's makefiles won't pick up on configuration changes, so any time</FONT>
<BR><FONT SIZE=2>&gt; you re-configure for a different engine or debug level, you need to do</FONT>
<BR><FONT SIZE=2>&gt; a make clean.&nbsp; At least, that's the way it was the last time I worked on </FONT>
<BR><FONT SIZE=2>&gt; it.</FONT>
<BR><FONT SIZE=2>&gt; If you had a partial build with JIT, then changed to intrp, then you could</FONT>
<BR><FONT SIZE=2>&gt; get all kinds of strange behavior.&nbsp; The address range of your error us a</FONT>
<BR><FONT SIZE=2>&gt; dead giveaway.&nbsp; It's too high to be the kaffe code segment, but too low</FONT>
<BR><FONT SIZE=2>&gt; to be a shared library.&nbsp; It's where I'd expect the heap to be, and where</FONT>
<BR><FONT SIZE=2>&gt; I remember the JIT buffers being allocated when I was trying to debug</FONT>
<BR><FONT SIZE=2>&gt; that stuff.</FONT>
<BR><FONT SIZE=2>&gt; </FONT>
<BR><FONT SIZE=2>&gt;&nbsp; &gt; Its been a few weeks since I built this version of kaffe.&nbsp; The configure</FONT>
<BR><FONT SIZE=2>&gt;&nbsp; &gt; output says I did specify --with-engine=intrp.&nbsp; I'll delete the compiled</FONT>
<BR><FONT SIZE=2>&gt;&nbsp; &gt; stuff, reconfigure (double checking that I give it --with-engine=intrp),</FONT>
<BR><FONT SIZE=2>&gt;&nbsp; &gt; recompile and retest.</FONT>
<BR><FONT SIZE=2>&gt;&nbsp; &gt;</FONT>
<BR><FONT SIZE=2>&gt;&nbsp; &gt; I'll post my results.</FONT>
<BR><FONT SIZE=2>&gt;&nbsp; &gt;</FONT>
<BR><FONT SIZE=2>&gt;&nbsp; &gt; Mark</FONT>
<BR><FONT SIZE=2>&gt;&nbsp; &gt;</FONT>
<BR><FONT SIZE=2>&gt;&nbsp; &gt;</FONT>
<BR><FONT SIZE=2>&gt;&nbsp; &gt;</FONT>
<BR><FONT SIZE=2>&gt;&nbsp; &gt; &gt;From: &quot;Kevin D. Kissell&quot; &lt;kevink@mips.com&gt;</FONT>
<BR><FONT SIZE=2>&gt;&nbsp; &gt; &gt;To: &quot;Mark and Janice Juszczec&quot; &lt;juszczec@hotmail.com&gt;,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </FONT>
<BR><FONT SIZE=2>&gt;&nbsp; &gt; &gt;&lt;linux-mips@linux-mips.org&gt;</FONT>
<BR><FONT SIZE=2>&gt;&nbsp; &gt; &gt;CC: &lt;uhler@mips.com&gt;, &lt;dom@mips.com&gt;, &lt;echristo@redhat.com&gt;</FONT>
<BR><FONT SIZE=2>&gt;&nbsp; &gt; &gt;Subject: Re: r3000 instruction set</FONT>
<BR><FONT SIZE=2>&gt;&nbsp; &gt; &gt;Date: Mon, 23 Feb 2004 18:21:19 +0100</FONT>
<BR><FONT SIZE=2>&gt;&nbsp; &gt; &gt;</FONT>
<BR><FONT SIZE=2>&gt;&nbsp; &gt; &gt; &gt; Someone suggested posting the message I get.&nbsp; Here it is:</FONT>
<BR><FONT SIZE=2>&gt;&nbsp; &gt; &gt; &gt;</FONT>
<BR><FONT SIZE=2>&gt;&nbsp; &gt; &gt; &gt; &gt;./kaffe-bin FirstClass</FONT>
<BR><FONT SIZE=2>&gt;&nbsp; &gt; &gt; &gt; [kaffe-bin:6] Illgal instruction 674696a at 2abb034, ra=2adbffd0,</FONT>
<BR><FONT SIZE=2>&gt;&nbsp; &gt; &gt; &gt; P0_STATUS=0000500</FONT>
<BR><FONT SIZE=2>&gt;&nbsp; &gt; &gt; &gt; pid 6: killed (signal 4)</FONT>
<BR><FONT SIZE=2>&gt;&nbsp; &gt; &gt; &gt; &gt;Reading command line: Try again</FONT>
<BR><FONT SIZE=2>&gt;&nbsp; &gt; &gt; &gt; Kernel panic: Attmpted to kill int!</FONT>
<BR><FONT SIZE=2>&gt;&nbsp; &gt; &gt;</FONT>
<BR><FONT SIZE=2>&gt;&nbsp; &gt; &gt;Let me guess.&nbsp; You are running little-endian.&nbsp; The instruction word</FONT>
<BR><FONT SIZE=2>&gt;&nbsp; &gt; &gt;in memory would be 0x6a697406.&nbsp; Do you think it's a coincidence</FONT>
<BR><FONT SIZE=2>&gt;&nbsp; &gt; &gt;that 0x6a6974 spells &quot;jit&quot; in ASCII?&nbsp; ;o)</FONT>
<BR><FONT SIZE=2>&gt;&nbsp; &gt; &gt;</FONT>
<BR><FONT SIZE=2>&gt;&nbsp; &gt; &gt;The reported address range looks like that where kaffe builds its</FONT>
<BR><FONT SIZE=2>&gt;&nbsp; &gt; &gt;JITted instruciton buffers in MIPS/Linux.&nbsp; And, like I say, JIT is</FONT>
<BR><FONT SIZE=2>&gt;&nbsp; &gt; &gt;somewhat broken for MIPS in Kaffe.&nbsp; Which version of the kaffe sources</FONT>
<BR><FONT SIZE=2>&gt;&nbsp; &gt; &gt;are you building, and have you tried configuring with </FONT>
<BR><FONT SIZE=2>&gt; --with-engine=intrp</FONT>
<BR><FONT SIZE=2>&gt;&nbsp; &gt; &gt;as I suggested?</FONT>
<BR><FONT SIZE=2>&gt;&nbsp; &gt; &gt;</FONT>
<BR><FONT SIZE=2>&gt;&nbsp; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Regards,</FONT>
<BR><FONT SIZE=2>&gt;&nbsp; &gt; &gt;</FONT>
<BR><FONT SIZE=2>&gt;&nbsp; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Kevin K.</FONT>
<BR><FONT SIZE=2>&gt;&nbsp; &gt;</FONT>
<BR><FONT SIZE=2>&gt;&nbsp; &gt; _________________________________________________________________</FONT>
<BR><FONT SIZE=2>&gt;&nbsp; &gt; Click, drag and drop. My MSN is the simple way to design your homepage.</FONT>
<BR><FONT SIZE=2>&gt;&nbsp; &gt; <A HREF="http://click.atdmt.com/AVE/go/onm00200364ave/direct/01/" TARGET="_blank">http://click.atdmt.com/AVE/go/onm00200364ave/direct/01/</A></FONT>
<BR><FONT SIZE=2>&gt;&nbsp; &gt;</FONT>
<BR><FONT SIZE=2>&gt;&nbsp; &gt;</FONT>
<BR><FONT SIZE=2>&gt; </FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C3FACF.1A5E2E60--
