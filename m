Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Oct 2008 12:12:39 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:65165 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S22285785AbYJXLM2 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 24 Oct 2008 12:12:28 +0100
Received: from [127.0.0.1] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id F12873ECB; Fri, 24 Oct 2008 04:12:20 -0700 (PDT)
Message-ID: <4901AD8F.4000007@ru.mvista.com>
Date:	Fri, 24 Oct 2008 15:12:15 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To:	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org,
	linux-ide@vger.kernel.org, ralf@linux-mips.org
Subject: Re: [PATCH] ide: Add tx4938ide driver (v2)
References: <20081023.012013.52129771.anemo@mba.ocn.ne.jp> <200810232247.05686.bzolnier@gmail.com>
In-Reply-To: <200810232247.05686.bzolnier@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20922
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Bartlomiej Zolnierkiewicz wrote:

>> This is the driver for the Toshiba TX4938 SoC EBUS controller ATA mode.
>> It has custom set_pio_mode and some hacks for big endian.
>>
>> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
>>     
>
> I applied it so please address issues left (if any) with incremental patches.
>   

   I'm not sure there was really a need to haste it into -rc1 (if you 
could push it to Linus later anyway)...
   I've realized that I have a question to Atsushi on why he chose the 
same way of implemnting the register accesses as on TX4939 despite 
TX4938 IDE is not really a SoC but a board level device (so probable 
should be using the normal, not the "raw" I/O accessors)...

MBR, Sergei
