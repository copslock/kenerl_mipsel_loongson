Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Feb 2005 22:38:44 +0000 (GMT)
Received: from mail.chipsandsystems.com ([IPv6:::ffff:64.164.196.27]:17384
	"EHLO mail.chipsag.com") by linux-mips.org with ESMTP
	id <S8225439AbVBBWi3>; Wed, 2 Feb 2005 22:38:29 +0000
Received: from [10.1.100.35] ([10.1.100.35]) by mail.chipsag.com with Microsoft SMTPSVC(6.0.3790.0);
	 Wed, 2 Feb 2005 14:41:07 -0800
Message-ID: <42015662.2090605@embeddedalley.com>
Date:	Wed, 02 Feb 2005 14:38:26 -0800
From:	Pete Popov <ppopov@embeddedalley.com>
Reply-To:  ppopov@embeddedalley.com
Organization: Embedded Alley Solutions, Inc
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Josh Green <jgreen@users.sourceforge.net>
CC:	linux-mips@linux-mips.org
Subject: Re: Problems with PCMCIA on AMD Alchemy DB1100
References: <1107304567.2912.34.camel@SillyPuddy.localdomain>	 <4200230A.6020002@embeddedalley.com> <1107383597.21173.6.camel@SillyPuddy.localdomain>
In-Reply-To: <1107383597.21173.6.camel@SillyPuddy.localdomain>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Feb 2005 22:41:07.0639 (UTC) FILETIME=[490F4470:01C50978]
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7121
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips


> I tried ejecting a card and it seemed to work fine.  The oops could have
> been related to the ds.c bug.  At any rate, everything seems to be
> running great at this point and I have yet to see any other problems.

Phew. I hadn't seen these problems and wasn't looking forward more 
pcmcia debug. I'll apply the other patches later. I can't apply the 
ds.c patch though -- that's out of my control. It should go to the 
pcmcia maintainer.

Pete
