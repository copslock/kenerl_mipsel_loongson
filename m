Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Feb 2004 02:46:17 +0000 (GMT)
Received: from [IPv6:::ffff:202.96.215.33] ([IPv6:::ffff:202.96.215.33]:21513
	"EHLO tmtms.trident.com.cn") by linux-mips.org with ESMTP
	id <S8225482AbUBZCqQ>; Thu, 26 Feb 2004 02:46:16 +0000
Received: by TMTMS with Internet Mail Service (5.5.2653.19)
	id <FH8P4LQ1>; Thu, 26 Feb 2004 10:42:48 +0800
Message-ID: <15F9E1AE3207D6119CEA00D0B7DD5F680219C8F0@TMTMS>
From: "Liu Hongming (Alan)" <alanliu@trident.com.cn>
To: Ralf Baechle <ralf@linux-mips.org>,
	"Liu Hongming (Alan)" <alanliu@trident.com.cn>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-mips@linux-mips.org
Subject: RE: IDE driver problem
Date: Thu, 26 Feb 2004 10:42:42 +0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C3FC12.35155FF0"
Return-Path: <alanliu@trident.com.cn>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4449
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alanliu@trident.com.cn
Precedence: bulk
X-list: linux-mips

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C3FC12.35155FF0
Content-Type: text/plain;
	charset="ISO-8859-1"


Hi,

Very glad to see you here.

Alan Cox,many friends of mine ADMIRE you very much!
Ralf Baechle,I learn a lot from your codes when porting my mips!

The ENDIAN issue in my board is:
My mips is little endian(not pure,dont care it here),and my memory 
is little endian(it should be same as cpu,however,it is not always in my
SOC,that's why ENDIAN issue comes out).When reading/writing words 
from/to memory,it is always OK,little endian. However,the wierd situation is
that
when writing string such as "ABCDEFGH" into memory,such as address
0,in memory it will be stored as:
addr 0:1:2:3:4:5:6:7
        DC B A HG F E
that means,when using byte access to memory,it will byteswap.You want
to access address 0,however,it will access address 3,vice versa.
You want to access address 1,it will access address 2,vice versa.
This is byte access situation.
When using half word accessing,it will swap too:
if I want to write 0x1234 into memory at address 0,it will write into memory
address 2;
if I want to write 0x1234 into memory at address 2,it will write into memory
address 0;

So,in my board, we could not use type-casting to access data in memory.
I dont know if I have clarified the situation.


-----Original Message-----
From: Ralf Baechle [mailto:ralf@linux-mips.org]
Sent: Thursday, February 26, 2004 1:13 AM
To: Liu Hongming (Alan)
Cc: Alan Cox; linux-mips@linux-mips.org
Subject: Re: IDE driver problem


On Wed, Feb 25, 2004 at 08:11:54PM +0800, Liu Hongming (Alan) wrote:

> I have found out where the problem is. Since my hardware has
> endian issue, fs/partition/msdos.c could not handle partition table
> correctly. I have changed a little(still having much to change),and it 
> really works now.

I'm not sure what you call endian issue here.  The PC style partition
table code we've used for years on big endian systems without problems.

  Ralf

------_=_NextPart_001_01C3FC12.35155FF0
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
<BR>

<P><FONT SIZE=2>Hi,</FONT>
</P>

<P><FONT SIZE=2>Very glad to see you here.</FONT>
</P>

<P><FONT SIZE=2>Alan Cox,many friends of mine ADMIRE you very much!</FONT>
<BR><FONT SIZE=2>Ralf Baechle,I learn a lot from your codes when porting my mips!</FONT>
</P>

<P><FONT SIZE=2>The ENDIAN issue in my board is:</FONT>
<BR><FONT SIZE=2>My mips is little endian(not pure,dont care it here),and my memory </FONT>
<BR><FONT SIZE=2>is little endian(it should be same as cpu,however,it is not always in my</FONT>
<BR><FONT SIZE=2>SOC,that's why ENDIAN issue comes out).When reading/writing words </FONT>
<BR><FONT SIZE=2>from/to memory,it is always OK,little endian. However,the wierd situation is that</FONT>
<BR><FONT SIZE=2>when writing string such as &quot;ABCDEFGH&quot; into memory,such as address</FONT>
<BR><FONT SIZE=2>0,in memory it will be stored as:</FONT>
<BR><FONT SIZE=2>addr 0:1:2:3:4:5:6:7</FONT>
<BR><FONT SIZE=2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC B A HG F E</FONT>
<BR><FONT SIZE=2>that means,when using byte access to memory,it will byteswap.You want</FONT>
<BR><FONT SIZE=2>to access address 0,however,it will access address 3,vice versa.</FONT>
<BR><FONT SIZE=2>You want to access address 1,it will access address 2,vice versa.</FONT>
<BR><FONT SIZE=2>This is byte access situation.</FONT>
<BR><FONT SIZE=2>When using half word accessing,it will swap too:</FONT>
<BR><FONT SIZE=2>if I want to write 0x1234 into memory at address 0,it will write into memory address 2;</FONT>
<BR><FONT SIZE=2>if I want to write 0x1234 into memory at address 2,it will write into memory address 0;</FONT>
</P>

<P><FONT SIZE=2>So,in my board, we could not use type-casting to access data in memory.</FONT>
<BR><FONT SIZE=2>I dont know if I have clarified the situation.</FONT>
</P>
<BR>

<P><FONT SIZE=2>-----Original Message-----</FONT>
<BR><FONT SIZE=2>From: Ralf Baechle [<A HREF="mailto:ralf@linux-mips.org">mailto:ralf@linux-mips.org</A>]</FONT>
<BR><FONT SIZE=2>Sent: Thursday, February 26, 2004 1:13 AM</FONT>
<BR><FONT SIZE=2>To: Liu Hongming (Alan)</FONT>
<BR><FONT SIZE=2>Cc: Alan Cox; linux-mips@linux-mips.org</FONT>
<BR><FONT SIZE=2>Subject: Re: IDE driver problem</FONT>
</P>
<BR>

<P><FONT SIZE=2>On Wed, Feb 25, 2004 at 08:11:54PM +0800, Liu Hongming (Alan) wrote:</FONT>
</P>

<P><FONT SIZE=2>&gt; I have found out where the problem is. Since my hardware has</FONT>
<BR><FONT SIZE=2>&gt; endian issue, fs/partition/msdos.c could not handle partition table</FONT>
<BR><FONT SIZE=2>&gt; correctly. I have changed a little(still having much to change),and it </FONT>
<BR><FONT SIZE=2>&gt; really works now.</FONT>
</P>

<P><FONT SIZE=2>I'm not sure what you call endian issue here.&nbsp; The PC style partition</FONT>
<BR><FONT SIZE=2>table code we've used for years on big endian systems without problems.</FONT>
</P>

<P><FONT SIZE=2>&nbsp; Ralf</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C3FC12.35155FF0--
