Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 May 2005 19:15:20 +0100 (BST)
Received: from [IPv6:::ffff:81.2.110.250] ([IPv6:::ffff:81.2.110.250]:36283
	"EHLO lxorguk.ukuu.org.uk") by linux-mips.org with ESMTP
	id <S8224769AbVE0SO5>; Fri, 27 May 2005 19:14:57 +0100
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by lxorguk.ukuu.org.uk (8.12.11/8.12.11) with ESMTP id j4RID8T6030889;
	Fri, 27 May 2005 19:13:08 +0100
Received: (from alan@localhost)
	by localhost.localdomain (8.12.11/8.12.11/Submit) id j4RID7JI030888;
	Fri, 27 May 2005 19:13:07 +0100
X-Authentication-Warning: localhost.localdomain: alan set sender to alan@lxorguk.ukuu.org.uk using -f
Subject: Re: Porting To New System
From:	Alan Cox <alan@lxorguk.ukuu.org.uk>
To:	Stanislaw Skowronek <sskowron@ET.PUT.Poznan.PL>
Cc:	Cameron Cooper <developer@phatlinux.com>, linux-mips@linux-mips.org
In-Reply-To: <Pine.GSO.4.10.10505271929510.25076-100000@helios.et.put.poznan.pl>
References: <Pine.GSO.4.10.10505271929510.25076-100000@helios.et.put.poznan.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1117217584.5743.229.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date:	Fri, 27 May 2005 19:13:07 +0100
Return-Path: <alan@lxorguk.ukuu.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8001
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

On Gwe, 2005-05-27 at 18:30, Stanislaw Skowronek wrote:
> >  Does the firmware give you the ability to control MMU mappings ?
> 
> I think we won't - this would be a serious security bug.

That depends who the device is defending against and how. MMU control
cuts both ways in game consoles (if present) - it makes it harder to
defend the console from a hostile writer, but it also makes it easier
for the game authors to debug and to trap/recover from errors when the
game is deployed.

For ucLinux you essentially need a console, an input device (keyboard
etc), a storage device, the ability to allocate memory and a timer
interrupt/callback. Absolutely everything else is optional. So you can
probably run ucLinux as a 'game' which allocates lots of memory,
requests a timer callback and drives the entire world through the
firmware. Whether you can do non-ucLinux depends on MMU access and
control. If you've got some kind of MMU interface then you've probably
got sufficient to do a full Linux but ucLinux would still be a natural
stepping stone in exploration.

Alan
