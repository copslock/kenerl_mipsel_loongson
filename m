Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Feb 2004 14:20:30 +0000 (GMT)
Received: from mailout01.sul.t-online.com ([IPv6:::ffff:194.25.134.80]:37046
	"EHLO mailout01.sul.t-online.com") by linux-mips.org with ESMTP
	id <S8225248AbUBLOUa>; Thu, 12 Feb 2004 14:20:30 +0000
Received: from fwd08.aul.t-online.de 
	by mailout01.sul.t-online.com with smtp 
	id 1ArHhY-00084V-00; Thu, 12 Feb 2004 15:20:24 +0100
Received: from denx.de (GiZ2x+ZUreEESq8kJlOhTf8lLCS2qYGw+rJQSuZm5HAOeUdWqGC1w0@[217.235.251.238]) by fmrl08.sul.t-online.com
	with esmtp id 1ArHhK-10lY8W0; Thu, 12 Feb 2004 15:20:10 +0100
Received: from atlas.denx.de (atlas.denx.de [10.0.0.14])
	by denx.de (Postfix) with ESMTP
	id 8384242B98; Thu, 12 Feb 2004 15:20:08 +0100 (MET)
Received: by atlas.denx.de (Postfix, from userid 15)
	id B7FDBC108D; Thu, 12 Feb 2004 15:20:07 +0100 (MET)
Received: from atlas.denx.de (localhost [127.0.0.1])
	by atlas.denx.de (Postfix) with ESMTP
	id B4DA713D425; Thu, 12 Feb 2004 15:20:07 +0100 (MET)
To: "Ren, Manling" <Manling.Ren@gbr.xerox.com>
Cc: linux-mips@linux-mips.org
From: Wolfgang Denk <wd@denx.de>
Subject: Re: questions about making a script file for YAMON command 
X-Mailer: exmh version 1.6.4 10/10/1995
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8bit
In-reply-to: Your message of "Thu, 12 Feb 2004 13:45:25 GMT."
             <8EAC52A94CD8D411A01000805FBB377606563AE8@gbrwgcms02.wgc.gbr.xerox.com> 
Date: Thu, 12 Feb 2004 15:20:02 +0100
Message-Id: <20040212142007.B7FDBC108D@atlas.denx.de>
X-Seen: false
X-ID: GiZ2x+ZUreEESq8kJlOhTf8lLCS2qYGw+rJQSuZm5HAOeUdWqGC1w0@t-dialin.net
Return-Path: <wd@denx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4338
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wd@denx.de
Precedence: bulk
X-list: linux-mips

In message <8EAC52A94CD8D411A01000805FBB377606563AE8@gbrwgcms02.wgc.gbr.xerox.com> you wrote:
> 
> Dear the technical support team,

Did you pay a support contract? ;-)

> I am running YAMON on pb1100 board in Linux.  At the YAMON prompt, I need to
> change some registers by using the command "edit -32 0x########"  several
> times.  I wonder if I can put all these "edit" commands into a script file
> then run this file without typing any more commands?  How can I achieve this

Use the standard tools you can find in your Unix environment. In this
case, use expect.

Best regards,

Wolfgang Denk

-- 
See us @ Embedded World, Nuremberg, Feb 17 - 19,  Hall 12.0 Booth 440
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"No matter where you go, there you are..."          - Buckaroo Banzai
