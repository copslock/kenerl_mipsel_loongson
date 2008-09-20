Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 20 Sep 2008 19:26:22 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:22710 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S32727410AbYITS0S (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 20 Sep 2008 19:26:18 +0100
Received: from [127.0.0.1] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id EE2EF3EC9; Sat, 20 Sep 2008 11:26:09 -0700 (PDT)
Message-ID: <48D5403D.3020100@ru.mvista.com>
Date:	Sat, 20 Sep 2008 22:26:05 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
MIME-Version: 1.0
To:	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org,
	linux-ide@vger.kernel.org, ralf@linux-mips.org
Subject: Re: [PATCH 1/2] ide: Add tx4939ide driver (v2)
References: <20080918.001342.52129176.anemo@mba.ocn.ne.jp> <200809181645.10410.bzolnier@gmail.com> <48D37025.2030501@ru.mvista.com> <200809191010.09457.bzolnier@gmail.com>
In-Reply-To: <200809191010.09457.bzolnier@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20579
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Bartlomiej Zolnierkiewicz wrote:

>>>> This is the driver for the Toshiba TX4939 SoC ATA controller.
>>>>
>>>> This controller has standard ATA taskfile registers and DMA
>>>> command/status registers, but the register layout is swapped on big
>>>> endian.  There are some other endian issue and some special registers
>>>> which requires many custom dma_ops/port_ops routines.
>>>>
>>>> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
>>>> ---
>>>> This patch is against linux-next 20080916.
>>>>
>>>> Changes since v1:
>>>> * rework IO accessors
>>>> * rework pio/dma timing setup
>>>> * use ide_get_pair_dev
>>>> * do not do ATA hard reset
>>>> * and so on  (Many thanks to Sergei)
>>>>     
>>>>         
>>> Sergei, are you OK with this version?
>>>   
>>>       
>>    I didn't have tome to look at it.
>>     
>
> I didn't mean to rush you.  I just prefer to have it in pata tree
>   

   Looking at it now... Unfortunately, it doesn't look compilable. :-/

MBR, Sergei
