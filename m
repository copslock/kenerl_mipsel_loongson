Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 May 2005 19:23:37 +0100 (BST)
Received: from ms-smtp-01-smtplb.ohiordc.rr.com ([IPv6:::ffff:65.24.5.135]:17837
	"EHLO ms-smtp-01-eri0.ohiordc.rr.com") by linux-mips.org with ESMTP
	id <S8224784AbVE0SXV>; Fri, 27 May 2005 19:23:21 +0100
Received: from [192.168.0.3] (cpe-65-24-168-255.columbus.res.rr.com [65.24.168.255])
	by ms-smtp-01-eri0.ohiordc.rr.com (8.12.10/8.12.7) with ESMTP id j4RIMoWY022115;
	Fri, 27 May 2005 14:23:08 -0400 (EDT)
Subject: Re: Porting To New System
From:	Cameron Cooper <developer@phatlinux.com>
To:	Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc:	Stanislaw Skowronek <sskowron@ET.PUT.Poznan.PL>,
	linux-mips@linux-mips.org
In-Reply-To: <1117217584.5743.229.camel@localhost.localdomain>
References: <Pine.GSO.4.10.10505271929510.25076-100000@helios.et.put.poznan.pl>
	 <1117217584.5743.229.camel@localhost.localdomain>
Content-Type: text/plain
Date:	Fri, 27 May 2005 14:21:15 -0400
Message-Id: <1117218075.2921.2.camel@phatbox>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Symantec AntiVirus Scan Engine
Return-Path: <developer@phatlinux.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8002
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: developer@phatlinux.com
Precedence: bulk
X-list: linux-mips

> For ucLinux you essentially need a console, an input device (keyboard
> etc), a storage device, the ability to allocate memory and a timer
> interrupt/callback. Absolutely everything else is optional. So you can
> probably run ucLinux as a 'game' which allocates lots of memory,
> requests a timer callback and drives the entire world through the
> firmware. Whether you can do non-ucLinux depends on MMU access and
> control. If you've got some kind of MMU interface then you've probably
> got sufficient to do a full Linux but ucLinux would still be a natural
> stepping stone in exploration.

Thank you, that is a very useful bit of information. I will start with
ucLinux. Once (if?) a MMU interface is discovered then I will do a full
Linux kernel.

Cameron
