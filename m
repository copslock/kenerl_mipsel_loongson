Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Sep 2008 18:19:17 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:41381 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S28643180AbYIWRTL (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 23 Sep 2008 18:19:11 +0100
Received: from [192.168.1.234] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id F35613ECC; Tue, 23 Sep 2008 10:19:05 -0700 (PDT)
Message-ID: <48D92545.7050307@ru.mvista.com>
Date:	Tue, 23 Sep 2008 21:20:05 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	bzolnier@gmail.com, linux-mips@linux-mips.org,
	linux-ide@vger.kernel.org, ralf@linux-mips.org
Subject: Re: [PATCH 1/2] ide: Add tx4939ide driver (v2)
References: <20080918.001342.52129176.anemo@mba.ocn.ne.jp>	<48D57245.8060606@ru.mvista.com> <20080924.020459.128619366.anemo@mba.ocn.ne.jp>
In-Reply-To: <20080924.020459.128619366.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20604
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Atsushi Nemoto wrote:

>>>+static int tx4939ide_dma_test_irq(ide_drive_t *drive)
>>>+{
>>>+	ide_hwif_t *hwif = HWIF(drive);
>>>+	void __iomem *base = TX4939IDE_BASE(hwif);
>>>+	u16 ctl = tx4939ide_readw(base, TX4939IDE_int_ctl);
>>>+	u8 dma_stat, stat;
>>>+	u16 ide_int;
>>>+	int found = 0;
>>>+
>>>+	tx4939ide_check_error_ints(hwif, ctl);
>>>+	ide_int = ctl & (TX4939IDE_INT_XFEREND | TX4939IDE_INT_HOST);

>>   Well, since you're effectively ignoring the BUSERR interrupt, there's 
>>no point in enabling it...

> The BUSERR is not ignored.  tx4939ide_check_error_ints() will print a
> message.  It would be better than just ignoring.

     I mean you're not accounting it as an interrupt.  It will be reported 
anyway when the dma_timeout() method will call this method on timeout... ah, 
it wouldn't be called in this case since dma_time_expiry() will most probably 
return -1 seeing bit 1 of DMA status register set.  You're right then...

> ---
> Atsushi Nemoto

MBR, Sergei
