Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Feb 2004 12:15:31 +0000 (GMT)
Received: from [IPv6:::ffff:202.96.215.33] ([IPv6:::ffff:202.96.215.33]:49926
	"EHLO tmtms.trident.com.cn") by linux-mips.org with ESMTP
	id <S8225204AbUBYMPa>; Wed, 25 Feb 2004 12:15:30 +0000
Received: by TMTMS with Internet Mail Service (5.5.2653.19)
	id <FH8P4JF1>; Wed, 25 Feb 2004 20:11:58 +0800
Message-ID: <15F9E1AE3207D6119CEA00D0B7DD5F680219C882@TMTMS>
From: "Liu Hongming (Alan)" <alanliu@trident.com.cn>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	"Liu Hongming (Alan)" <alanliu@trident.com.cn>
Cc: linux-mips@linux-mips.org
Subject: RE: IDE driver problem
Date: Wed, 25 Feb 2004 20:11:54 +0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C3FB98.8EBCBB40"
Return-Path: <alanliu@trident.com.cn>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4437
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alanliu@trident.com.cn
Precedence: bulk
X-list: linux-mips

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C3FB98.8EBCBB40
Content-Type: text/plain;
	charset="ISO-8859-1"


Thanks for your tips.

I have found out where the problem is. Since my hardware has
endian issue, fs/partition/msdos.c could not handle partition table
correctly. I have changed a little(still having much to change),and it 
really works now.


-----Original Message-----
From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk]
Sent: Wednesday, February 25, 2004 6:10 AM
To: Liu Hongming (Alan)
Cc: linux-mips@linux-mips.org
Subject: Re: IDE driver problem


On Maw, 2004-02-24 at 05:09, Liu Hongming (Alan) wrote:
> Hi All,
> 
> I am porting IDE drivers(Since my hardware has endian issue),
> and now it could work,however it has some abnormal problems:

Sounds like your partition data reading is wrong. Print out the
partition table bases and see if they are all zero

------_=_NextPart_001_01C3FB98.8EBCBB40
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

<P><FONT SIZE=2>Thanks for your tips.</FONT>
</P>

<P><FONT SIZE=2>I have found out where the problem is. Since my hardware has</FONT>
<BR><FONT SIZE=2>endian issue, fs/partition/msdos.c could not handle partition table</FONT>
<BR><FONT SIZE=2>correctly. I have changed a little(still having much to change),and it </FONT>
<BR><FONT SIZE=2>really works now.</FONT>
</P>
<BR>

<P><FONT SIZE=2>-----Original Message-----</FONT>
<BR><FONT SIZE=2>From: Alan Cox [<A HREF="mailto:alan@lxorguk.ukuu.org.uk">mailto:alan@lxorguk.ukuu.org.uk</A>]</FONT>
<BR><FONT SIZE=2>Sent: Wednesday, February 25, 2004 6:10 AM</FONT>
<BR><FONT SIZE=2>To: Liu Hongming (Alan)</FONT>
<BR><FONT SIZE=2>Cc: linux-mips@linux-mips.org</FONT>
<BR><FONT SIZE=2>Subject: Re: IDE driver problem</FONT>
</P>
<BR>

<P><FONT SIZE=2>On Maw, 2004-02-24 at 05:09, Liu Hongming (Alan) wrote:</FONT>
<BR><FONT SIZE=2>&gt; Hi All,</FONT>
<BR><FONT SIZE=2>&gt; </FONT>
<BR><FONT SIZE=2>&gt; I am porting IDE drivers(Since my hardware has endian issue),</FONT>
<BR><FONT SIZE=2>&gt; and now it could work,however it has some abnormal problems:</FONT>
</P>

<P><FONT SIZE=2>Sounds like your partition data reading is wrong. Print out the</FONT>
<BR><FONT SIZE=2>partition table bases and see if they are all zero</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C3FB98.8EBCBB40--
