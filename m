Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Nov 2004 21:30:48 +0000 (GMT)
Received: from mailout06.sul.t-online.com ([IPv6:::ffff:194.25.134.19]:6800
	"EHLO mailout06.sul.t-online.com") by linux-mips.org with ESMTP
	id <S8225255AbUKDVan>; Thu, 4 Nov 2004 21:30:43 +0000
Received: from fwd00.aul.t-online.de 
	by mailout06.sul.t-online.com with smtp 
	id 1CPpBd-0007VH-01; Thu, 04 Nov 2004 22:30:29 +0100
Received: from denx.de (EAryJGZAYeAvsJWot7oAZW7VX8Urf0q64TvN7GPROYq-TLRSHM0grC@[217.235.243.140]) by fmrl00.sul.t-online.com
	with esmtp id 1CPpBb-20RSF60; Thu, 4 Nov 2004 22:30:27 +0100
Received: from atlas.denx.de (atlas.denx.de [10.0.0.14])
	by denx.de (Postfix) with ESMTP
	id 574D942B91; Thu,  4 Nov 2004 22:30:24 +0100 (MET)
Received: by atlas.denx.de (Postfix, from userid 15)
	id DA9CCC1430; Thu,  4 Nov 2004 22:30:20 +0100 (MET)
Received: from atlas.denx.de (localhost [127.0.0.1])
	by atlas.denx.de (Postfix) with ESMTP
	id D7EED13D6DB; Thu,  4 Nov 2004 22:30:20 +0100 (MET)
To: "Hannes Bischof" <vergiss-es@gmx.de>
Cc: linux-mips@linux-mips.org
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Compile Mips-Architecture on an i386? 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8bit
In-reply-to: Your message of "Thu, 04 Nov 2004 12:20:05 +0100."
             <20244.1099567205@www38.gmx.net> 
Date: Thu, 04 Nov 2004 22:30:15 +0100
Message-Id: <20041104213020.DA9CCC1430@atlas.denx.de>
X-ID: EAryJGZAYeAvsJWot7oAZW7VX8Urf0q64TvN7GPROYq-TLRSHM0grC@t-dialin.net
X-TOI-MSGID: be656206-994f-4012-bbcd-863bf7110eb7
Return-Path: <wd@denx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6264
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wd@denx.de
Precedence: bulk
X-list: linux-mips

In message <20244.1099567205@www38.gmx.net> you wrote:
> 
> programm for the router. Now my question, is it possible to compile a
> programm for the router by example on an normal PC(i386)???

Yes, of course this is possible. This is what everybody does every day.

> What do I need to compile the software so that it runs under the linux
> system of the router??

You need a set of cross development tools.  I'd  recommend  our  ELDK
(Embedded  Linux  Development  Kit, see http://www.denx.de/ELDK.html)
which is available for free, but I'm obviously biased.

[Note: ELDK 3.1 will be released in a couple of days.]

Viele Grüße,

Wolfgang Denk

-- 
See us @ Embedded/Electronica Munich, Nov 09 - 12, Hall A.6 Booth 513
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
The biggest difference between time and space is that you can't reuse
time.                                                 - Merrick Furst
