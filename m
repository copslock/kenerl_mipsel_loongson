Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jan 2006 17:54:26 +0000 (GMT)
Received: from [195.110.64.125] ([195.110.64.125]:26106 "EHLO smtp.uk.colt.net")
	by ftp.linux-mips.org with ESMTP id S8133532AbWAXRyI (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 24 Jan 2006 17:54:08 +0000
Received: from [10.0.1.55] (117-21-161-212.DSL.ONCOLT.COM [212.161.21.117])
	by smtp.uk.colt.net (Postfix) with ESMTP id AEABFE2BF2
	for <linux-mips@linux-mips.org>; Tue, 24 Jan 2006 17:47:38 +0000 (GMT)
From:	David Goodenough <david.goodenough@btconnect.com>
To:	linux-mips@linux-mips.org
Subject: Re: OT: 802.11b/g mini-PCI card that is known to work with linux-mips (Au1550)
Date:	Tue, 24 Jan 2006 17:56:45 +0000
User-Agent: KMail/1.8.2
References: <ecb4efd10601240845j515c42a1xbfe4dd7ea6857e1e@mail.gmail.com>
In-Reply-To: <ecb4efd10601240845j515c42a1xbfe4dd7ea6857e1e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601241756.46331.david.goodenough@btconnect.com>
Return-Path: <david.goodenough@btconnect.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10106
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.goodenough@btconnect.com
Precedence: bulk
X-list: linux-mips

On Tuesday 24 January 2006 16:45, Clem Taylor wrote:
> Hi,
>
> I realize this is a bit off topic, but I was wondering if anyone has
> any experience using 802.11 mini-PCI cards with linux-mips? It sounds
> like many of the 802.11b/g chipsets only have closed-source drivers
> which means I'm out of luck for linux-mips. I was wondering if anyone
> can recommend a chipset or specific mini-PCI card that is known to
> work with linux-mips. I'm using an AMD Alchemy Au1550.
>
>                                Thanks,
>                                Clem Taylor
If you look at the OpenWrt project you will see that various wireless
cards are found in the hardware that OpenWrt supports.  There are 
Prism, Atheros, Broadcomm, TI and RaLink cards as I recall.  Almost
all of the OpenWrt hardware is Mips based, some is I386 or AR7.

David
