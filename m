Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Dec 2005 20:14:27 +0000 (GMT)
Received: from eth13.com-link.com ([208.242.241.164]:24514 "EHLO
	real.realitydiluted.com") by ftp.linux-mips.org with ESMTP
	id S8133868AbVLUUOJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 21 Dec 2005 20:14:09 +0000
Received: from localhost ([127.0.0.1])
	by real.realitydiluted.com with esmtp (Exim 4.52 #1 (Debian))
	id 1Ep9R6-0003Fd-Bm; Wed, 21 Dec 2005 13:15:40 -0600
Message-ID: <43A9B7D6.9070405@realitydiluted.com>
Date:	Wed, 21 Dec 2005 14:15:18 -0600
From:	"Steven J. Hill" <sjhill@realitydiluted.com>
User-Agent: Debian Thunderbird 1.0.6 (X11/20050802)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Srinivas Kommu <kommu@hotmail.com>
CC:	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject: Re: Preempted interrupt handler
References: <43A6F155.7080402@avilinks.com> <20051220131829.GB3376@linux-mips.org> <20051221193906.GB1456@sjc-xdm-007.cisco.com>
In-Reply-To: <20051221193906.GB1456@sjc-xdm-007.cisco.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sjhill@realitydiluted.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9715
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@realitydiluted.com
Precedence: bulk
X-list: linux-mips

Srinivas Kommu wrote:
> 
> Is it normal for the modules to be loaded at 0xc0000000 (this is
> highmem, isn't it)? I see the same on my bcm1250 box. I've been wondering
> why they can't be loaded in kseg0. Or is it because of bad
> modutils/compiler flags?
>
Yes, it is normal to load them at 0xc0000000. No it is not because of bad
modutils/compiler flags.

-Steve
