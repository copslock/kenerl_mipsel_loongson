Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 May 2006 19:45:45 +0100 (BST)
Received: from mail-out.m-online.net ([212.18.0.9]:15009 "HELO
	mail-out.m-online.net") by ftp.linux-mips.org with SMTP
	id S8133813AbWEESpR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 5 May 2006 19:45:17 +0100
Received: from mail01.m-online.net (svr21.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id 2C43772EE4;
	Fri,  5 May 2006 20:45:11 +0200 (CEST)
X-Auth-Info: o2OpLf2+X028E3W086dSuk21T1L8H+iHadiZAilxY+o=
X-Auth-Info: o2OpLf2+X028E3W086dSuk21T1L8H+iHadiZAilxY+o=
X-Auth-Info: o2OpLf2+X028E3W086dSuk21T1L8H+iHadiZAilxY+o=
X-Auth-Info: o2OpLf2+X028E3W086dSuk21T1L8H+iHadiZAilxY+o=
X-Auth-Info: o2OpLf2+X028E3W086dSuk21T1L8H+iHadiZAilxY+o=
X-Auth-Info: o2OpLf2+X028E3W086dSuk21T1L8H+iHadiZAilxY+o=
Received: from mail.denx.de (p549675E3.dip.t-dialin.net [84.150.117.227])
	by smtp-auth.mnet-online.de (Postfix) with ESMTP id 0D6E79194F;
	Fri,  5 May 2006 20:45:11 +0200 (CEST)
Received: from atlas.denx.de (atlas.denx.de [10.0.0.14])
	by mail.denx.de (Postfix) with ESMTP id 9790D6D00A8;
	Fri,  5 May 2006 20:45:10 +0200 (CEST)
Received: from atlas.denx.de (localhost.localdomain [127.0.0.1])
	by atlas.denx.de (Postfix) with ESMTP id 86790353BE7;
	Fri,  5 May 2006 20:45:10 +0200 (MEST)
To:	Geert Uytterhoeven <geert@linux-m68k.org>
cc:	Tom Rini <trini@kernel.crashing.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Thiemo Seufer <ths@networkno.de>,
	Tim Bird <tim.bird@am.sony.com>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
From:	Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH] fix mips/Makefile to support CROSS_COMPILE from environment var 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 05 May 2006 09:45:38 +0200."
             <Pine.LNX.4.62.0605050940410.649@pademelon.sonytel.be> 
Date:	Fri, 05 May 2006 20:45:10 +0200
Message-Id: <20060505184510.86790353BE7@atlas.denx.de>
Content-Transfer-Encoding: 8BIT
Return-Path: <wd@denx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11345
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wd@denx.de
Precedence: bulk
X-list: linux-mips

In message <Pine.LNX.4.62.0605050940410.649@pademelon.sonytel.be> you wrote:
>
> But on second thought: config options are part of the target configuration,
> while CROSS_COMPILE= is part of the host configuration, so IMHO it doesn't
> belong in Kconfig. I.e. do you want to have CONFIG_CROSS_COMPILE set in your
> defconfig? Yes or no, depending on whether you do cross-compilations or not. So
> you cannot simply take a defconfig, you'll have to modify it for your host
> setup.

CONFIG_CROSS_COMPILE is a terrible idea. Don't do it. We may want  to
try  different  tool  chains  which  require  different CROSS_COMPILE
settings with exact the same default config file. Don't break this!

> So I'd prefer to keep the CROSS_COMPILE, like other arches do.

Me too!

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
If A equals success, then the formula is A = X + Y + Z. X is work.  Y
is play. Z is keep your mouth shut.                 - Albert Einstein
