Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Oct 2005 20:26:37 +0100 (BST)
Received: from lennier.cc.vt.edu ([198.82.162.213]:1766 "EHLO
	lennier.cc.vt.edu") by ftp.linux-mips.org with ESMTP
	id S8133588AbVJQT0V (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 17 Oct 2005 20:26:21 +0100
Received: from vivi.cc.vt.edu (IDENT:mirapoint@evil-vivi.cc.vt.edu [10.1.1.12])
	by lennier.cc.vt.edu (8.12.11/8.12.11) with ESMTP id j9HJQFMQ001520;
	Mon, 17 Oct 2005 15:26:15 -0400
Received: from [128.173.184.73] (gs4073.geos.vt.edu [128.173.184.73])
	by vivi.cc.vt.edu (MOS 3.6.4-CR)
	with ESMTP id EIQ95102;
	Mon, 17 Oct 2005 15:26:13 -0400 (EDT)
Message-ID: <4353FAD2.2030901@gentoo.org>
Date:	Mon, 17 Oct 2005 15:26:10 -0400
From:	"Stephen P. Becker" <geoman@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051004)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	pf@net.alphadv.de
CC:	linux-mips@linux-mips.org
Subject: Re: IP28 patches
References: <Pine.LNX.4.21.0510172008340.2374-100000@Opal.Peter>
In-Reply-To: <Pine.LNX.4.21.0510172008340.2374-100000@Opal.Peter>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <geoman@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9246
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geoman@gentoo.org
Precedence: bulk
X-list: linux-mips

> There are also sources for the Impact driver for the IP28-Xserver, now
> with DMA.

I'm curious, is your Impact driver for ip28 still different from Stan's 
driver for ip30?  In terms of distro support and merging things 
upstream, they either need to be merged, or they need to be completely 
separate drivers with different names (e.g. impact vs. impactsr or 
something like that).

-Steve
