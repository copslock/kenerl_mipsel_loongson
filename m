Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Feb 2004 17:51:41 +0000 (GMT)
Received: from eth13.com-link.com ([IPv6:::ffff:208.242.241.164]:36269 "EHLO
	real.realitydiluted.com") by linux-mips.org with ESMTP
	id <S8225458AbUBERvj>; Thu, 5 Feb 2004 17:51:39 +0000
Received: from localhost ([127.0.0.1] helo=realitydiluted.com)
	by real.realitydiluted.com with esmtp (Exim 3.36 #1 (Debian))
	id 1AoneB-0000TU-00; Thu, 05 Feb 2004 11:50:39 -0600
Message-ID: <40228235.6050403@realitydiluted.com>
Date: Thu, 05 Feb 2004 12:49:41 -0500
From: "Steven J. Hill" <sjhill@realitydiluted.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Markus Dahms <dahms@fh-brandenburg.de>
CC: linux-mips@linux-mips.org
Subject: Re: Indy R4000PC problems
References: <20040202160729.GA5966@fh-brandenburg.de>
In-Reply-To: <20040202160729.GA5966@fh-brandenburg.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sjhill@realitydiluted.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4291
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@realitydiluted.com
Precedence: bulk
X-list: linux-mips

Markus Dahms wrote:
> 
> I had problems getting the 2.4 kernel to work on an Indy with
> a R4000PC (100MHz) processor (very old PROM, too).
> The solution I found yesterday is to change an entry in
> arch/mips/kernel/cpu-probe.c from CPU_R4000SC to CPU_R4000PC.
> Is there a reason why only the SC version is thought to be
> there, or is it believed to be compatible?
>
The SC stands for secondary cache. So one would expect that if
your Indy only has a primary cache (PC) and you are detecting
as an Indy with SC, you will crash since there is no secondary
cache.

-Steve
