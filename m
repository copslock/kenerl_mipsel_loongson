Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Apr 2003 21:00:56 +0100 (BST)
Received: from mailout10.sul.t-online.com ([IPv6:::ffff:194.25.134.21]:55522
	"EHLO mailout10.sul.t-online.com") by linux-mips.org with ESMTP
	id <S8225203AbTD2UAv>; Tue, 29 Apr 2003 21:00:51 +0100
Received: from fwd04.sul.t-online.de 
	by mailout10.sul.t-online.com with smtp 
	id 19AbHR-0006ov-02; Tue, 29 Apr 2003 22:00:45 +0200
Received: from denx.de (320026445996-0001@[217.235.235.5]) by fmrl04.sul.t-online.com
	with esmtp id 19AbHJ-0qrEsSC; Tue, 29 Apr 2003 22:00:37 +0200
Received: from atlas.denx.de (atlas.denx.de [10.0.0.14])
	by denx.de (Postfix) with ESMTP
	id 1F9B742FD1; Tue, 29 Apr 2003 22:00:35 +0200 (MEST)
Received: by atlas.denx.de (Postfix, from userid 15)
	id 5E744C5F48; Tue, 29 Apr 2003 22:00:34 +0200 (MEST)
Received: from atlas.denx.de (localhost [127.0.0.1])
	by atlas.denx.de (Postfix) with ESMTP
	id 562A8C5F47; Tue, 29 Apr 2003 22:00:34 +0200 (MEST)
To: "Michael Anburaj" <michaelanburaj@hotmail.com>
Cc: geert@linux-m68k.org, linux-mips@linux-mips.org
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Linux for MIPS Atlas 4Kc board 
X-Mailer: exmh version 1.6.4 10/10/1995
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8bit
In-reply-to: Your message of "Tue, 29 Apr 2003 12:40:18 PDT."
             <BAY1-F39ahdtT8esYrJ0000a53e@hotmail.com> 
Date: Tue, 29 Apr 2003 22:00:29 +0200
Message-Id: <20030429200034.5E744C5F48@atlas.denx.de>
X-Sender: 320026445996-0001@t-dialin.net
Return-Path: <wd@denx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-Spam-Checker-Version: SpamAssassin 2.50 (1.173-2003-02-20-exp)
X-archive-position: 2229
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wd@denx.de
Precedence: bulk
X-list: linux-mips

In message <BAY1-F39ahdtT8esYrJ0000a53e@hotmail.com> you wrote:
> 
> Now I have all the tools (mips32el-linux) on Redhat Linux 9 & its source. I 

Did you have a look at the ELDK? See http://www.denx.de/re/ELDK.html
resp. ftp://ftp.leo.org/pub/eldk/2.1.0/eldk-mips-linux-x86/

> $ make xconfig
> 
> It displayed a window with lot of options. But under processor I could only 
> find flavors of x86 core.

I bet you missed to set "ARCH := mips" in the TLD Makefile;
alternatively try "make ARCH=mips xconfig"


Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"The number  of  Unix  installations  has  grown  to  10,  with  more
expected."    - The Unix Programmer's Manual, 2nd Edition, June, 1972
