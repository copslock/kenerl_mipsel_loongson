Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 07 Aug 2005 18:09:59 +0100 (BST)
Received: from mailout05.sul.t-online.com ([IPv6:::ffff:194.25.134.82]:17347
	"EHLO mailout05.sul.t-online.com") by linux-mips.org with ESMTP
	id <S8224983AbVHGRJo>; Sun, 7 Aug 2005 18:09:44 +0100
Received: from fwd28.aul.t-online.de 
	by mailout05.sul.t-online.com with smtp 
	id 1E1oiF-00073j-03; Sun, 07 Aug 2005 19:13:27 +0200
Received: from denx.de (S+QIpEZ1Zei9WXFka6c1DcE7YtrnAp1lXqMepafn5HkSC55aahdi8M@[84.150.87.222]) by fwd28.sul.t-online.de
	with esmtp id 1E1oiB-1SBDQu0; Sun, 7 Aug 2005 19:13:23 +0200
Received: from atlas.denx.de (atlas.denx.de [10.0.0.14])
	by denx.de (Postfix) with ESMTP
	id 789DA42A8A; Sun,  7 Aug 2005 19:13:22 +0200 (MEST)
Received: from atlas.denx.de (localhost.localdomain [127.0.0.1])
	by atlas.denx.de (Postfix) with ESMTP id 2AC0C353BF9;
	Sun,  7 Aug 2005 19:13:22 +0200 (MEST)
To:	Stuart Longland <redhatter@gentoo.org>
Cc:	linux-mips@linux-mips.org, cobalt@colonel-panic.org
From:	Wolfgang Denk <wd@denx.de>
Subject: Re: netconsole support on Cobalt systems... Anyone tried it? 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8bit
In-reply-to: Your message of "Sat, 06 Aug 2005 22:51:39 +1000."
             <42F4B25B.6040708@gentoo.org> 
Date:	Sun, 07 Aug 2005 19:13:22 +0200
Message-Id: <20050807171322.2AC0C353BF9@atlas.denx.de>
X-ID:	S+QIpEZ1Zei9WXFka6c1DcE7YtrnAp1lXqMepafn5HkSC55aahdi8M@t-dialin.net
X-TOI-MSGID: a9f11f48-fe08-41c9-9ab4-c75fd7f66770
Return-Path: <wd@denx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8710
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wd@denx.de
Precedence: bulk
X-list: linux-mips

In message <42F4B25B.6040708@gentoo.org> you wrote:
>
> I've been tinkering with my Qube2 tonight, seeing if I can get
> netconsole running.  I'd like to get this running for two reasons:
...
> I've looked around on the web, but haven't found a great deal of
> material that explains how one uses it.  The best resource thus far has

See "doc/README.NetConsole" in the U-Boot source tree  (ok,  this  is
more  about  U-Boot's implementation but it also contains a few hints
about the Linux part).

> Has anyone here, tried using netconsole on Cobalt hardware?  Has anybody
> played with netconsole on _any_ hardware?

We use netconsole  for  Linux  in  several  projects  (all  PowerPC),
usually in combination with netconsole in U-Boot.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
The rule on staying alive as a program manager is to give 'em a  num-
ber or give 'em a date, but never give 'em both at once.
