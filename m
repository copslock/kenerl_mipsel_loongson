Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Mar 2007 10:00:03 +0000 (GMT)
Received: from srv5.dvmed.net ([207.36.208.214]:15256 "EHLO mail.dvmed.net")
	by ftp.linux-mips.org with ESMTP id S20022413AbXCNJ76 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 14 Mar 2007 09:59:58 +0000
Received: from cpe-065-190-194-075.nc.res.rr.com ([65.190.194.75] helo=[10.10.10.10])
	by mail.dvmed.net with esmtpsa (Exim 4.63 #1 (Red Hat Linux))
	id 1HRQGt-0003Ra-Vg; Wed, 14 Mar 2007 09:59:52 +0000
Message-ID: <45F7C797.4030509@garzik.org>
Date:	Wed, 14 Mar 2007 05:59:51 -0400
From:	Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.10 (X11/20070302)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	shemminger@linux-foundation.org, linux-mips@linux-mips.org,
	ralf@linux-mips.org, netdev@vger.kernel.org,
	sshtylyov@ru.mvista.com, akpm@linux-foundation.org
Subject: Re: [PATCH] tc35815: Fix an usage of streaming DMA API.
References: <20070303.235459.25478204.anemo@mba.ocn.ne.jp>	<20070314.010220.65192616.anemo@mba.ocn.ne.jp>	<20070313120418.554a3a43@freekitty> <20070314.100557.33857330.nemoto@toshiba-tops.co.jp>
In-Reply-To: <20070314.100557.33857330.nemoto@toshiba-tops.co.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <jeff@garzik.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14464
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jeff@garzik.org
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> On Tue, 13 Mar 2007 12:04:18 -0700, Stephen Hemminger <shemminger@linux-foundation.org> wrote:
>>> + *	1.35	Fix an usage of streaming DMA API.
>>>   */
>> Please don't use comments as changelog anymore. It gets out of date.
>> The use of change control systems has made this practice obsolete.
> 
> OK, Jeff, should I send a revised patch dropping this line?

Nah, there's no need to reject the patch on that basis.

You should send an additional patch, on top of all others you sent 
recently, that completely removes the entire changelog from the driver 
source code :)

	Jeff
