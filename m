Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Jan 2005 18:15:51 +0000 (GMT)
Received: from mail.chipsandsystems.com ([IPv6:::ffff:64.164.196.27]:23214
	"EHLO mail.chipsag.com") by linux-mips.org with ESMTP
	id <S8225429AbVA1SPg>; Fri, 28 Jan 2005 18:15:36 +0000
Received: from [10.1.100.35] ([10.1.100.35]) by mail.chipsag.com with Microsoft SMTPSVC(6.0.3790.0);
	 Fri, 28 Jan 2005 10:18:07 -0800
Message-ID: <41FA8146.20803@embeddedalley.com>
Date:	Fri, 28 Jan 2005 10:15:34 -0800
From:	Pete Popov <ppopov@embeddedalley.com>
Reply-To:  ppopov@embeddedalley.com
Organization: Embedded Alley Solutions, Inc
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Matt Porter <mporter@kernel.crashing.org>
CC:	Ulrich Eckhardt <eckhardt@satorlaser.com>,
	linux-mips@linux-mips.org
Subject: Re: bitrot in drivers/net/au1000_eth.c
References: <200501281501.19162.eckhardt@satorlaser.com> <41FA6FF0.4060302@embeddedalley.com> <20050128102056.A9216@cox.net>
In-Reply-To: <20050128102056.A9216@cox.net>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Jan 2005 18:18:07.0994 (UTC) FILETIME=[B797C5A0:01C50565]
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7064
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips


> I suggest everyone take a look at the effort posted to netdev:
> 
> http://oss.sgi.com/archives/netdev/2004-12/msg00643.html

That's the work Dan told me about. Now we just have to update the 
au1x driver :)

Pete


> It's an attempt at a phy abstraction layer that goes the next
> logical step after the minimal support provided in mii.h.
> 
> It's evolved out of the in-driver abstraction that is currently
> used in the sungem, ibm_emac, and gianfar drivers in 2.6. It
> was just a matter of time before somebody got tired of copying
> the same PHY mgmt bits into every driver. :)
> 
> -Matt
> 
> 
