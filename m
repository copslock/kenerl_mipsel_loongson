Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Dec 2003 04:55:41 +0000 (GMT)
Received: from dallas.texasconnect.net ([IPv6:::ffff:208.232.232.3]:26643 "EHLO
	dallas.texasconnect.net") by linux-mips.org with ESMTP
	id <S8225323AbTLREzk>; Thu, 18 Dec 2003 04:55:40 +0000
Received: from dallas.texasconnect.net (dallas.texasconnect.net [208.232.232.3])
	by dallas.texasconnect.net (8.12.9/8.12.9) with ESMTP id hBI4tbcq009747;
	Wed, 17 Dec 2003 22:55:37 -0600
Date: Wed, 17 Dec 2003 22:55:37 -0600 (CST)
From: Ed Okerson <eokerson@texasconnect.net>
To: He Jin <thesistarball@yahoo.com.cn>
cc: linux-mips <linux-mips@linux-mips.org>
Subject: Re: AutoNegotiation could not complete in PB1500 platform
In-Reply-To: <20031218033717Z8225373-16706+1429@linux-mips.org>
Message-ID: <Pine.LNX.4.44.0312172253330.1654-100000@dallas.texasconnect.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <eokerson@texasconnect.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3790
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: eokerson@texasconnect.net
Precedence: bulk
X-list: linux-mips

Did you set the EM bit in the mac_control register to match the endian
mode you are running the CPU in?

Ed Okerson

On Thu, 18 Dec 2003, He Jin wrote:

> Hi, Dear all,
>
> I'm porting my own firmware code to PB1500, however some troubles ocurred with the Au1x NIC and LSI PHY. The dump of PHY register (the NIC initialization code is borrowed from the driver inside YAMON) is as follow:
>
> ////////////////////////////////////
>  MII status: Link is up
>  1th 0x3000
>  2th 0x7809			=> should be 0x7829
> 		^^^^^^^^^^
>  3th 0x16
>  4th 0xf840
>  5th 0x1e1
>  6th 0x 0 			=> should be 0x45e1
> 		^^^^^^^^^^
> 17th 0x22
> 18th 0xffc0
> ////////////////////////////////////
>
> It shows the MII interface couldn't finish the AutoNegotiation process. The values I think right is the output of some small probe programs using YAMON to boot the board and running those small probe programs . Besides, the LED in NIC interface could flash normally and we observed the LSI PHY chips should have been reset sucessfully in our firmware code using oscillograph device to probe the 'reset' pin in the PHY chips.
>
> If I use YAMON, everything OK. Could somebody tell me why ?
>
> Thanks a lot !
>
>
>
>
>
>
>
>
