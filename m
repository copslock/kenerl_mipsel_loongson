Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Apr 2011 21:42:33 +0200 (CEST)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:36503 "EHLO
        phoenix3.szarvasnet.hu" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491143Ab1DKTma convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 11 Apr 2011 21:42:30 +0200
Received: from mail.szarvas.hu (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with SMTP id F0DFE14014A;
        Mon, 11 Apr 2011 21:42:22 +0200 (CEST)
Received: from [127.0.0.1] (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPA id 7A3AB14013D;
        Mon, 11 Apr 2011 21:42:22 +0200 (CEST)
Message-ID: <4DA359A0.5020503@openwrt.org>
Date:   Mon, 11 Apr 2011 21:42:24 +0200
From:   Gabor Juhos <juhosg@openwrt.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; hu-HU; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
MIME-Version: 1.0
To:     Alan Stern <stern@rowland.harvard.edu>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Greg Kroah-Hartman <gregkh@suse.de>, linux-usb@vger.kernel.org
Subject: Re: [PATCH 2/3] USB: ehci: add workaround for Synopsys HC bug
References: <Pine.LNX.4.44L0.1104111452040.1975-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1104111452040.1975-100000@iolanthe.rowland.org>
X-Enigmail-Version: 1.1.1
Content-Type: text/plain; charset=ISO-8859-1
X-Antivirus: avast! (VPS 110411-0, 2011.04.11), Outbound message
X-Antivirus-Status: Clean
Content-Transfer-Encoding: 8BIT
X-VBMS: A166A1A67D0 | phoenix3 | 127.0.0.1 |  | <juhosg@openwrt.org> | 
Return-Path: <juhosg@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29734
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips

2011.04.11. 20:53 keltezéssel, Alan Stern írta:
> On Sun, 10 Apr 2011, Gabor Juhos wrote:
> 
>> A Synopsys USB core used in various SoCs has a bug which might cause
>> that the host controller not issuing ping.
>>
>> When software uses the Doorbell mechanism to remove queue heads, the
>> host controller still has references to the removed queue head even
>> after indicating an Interrupt on Async Advance. This happens if the last
>> executed queue head's Next Link queue head is removed.
>>
>> Consequences of the defect:
>> The Host controller fetches the removed queue head, using memory that
>> would otherwise be deallocated.This results in incorrect transactions on
>> both the USB and system memory. This may result in undefined behavior.
> 
>> --- a/drivers/usb/host/ehci-q.c
>> +++ b/drivers/usb/host/ehci-q.c
>> @@ -1183,6 +1183,9 @@ static void end_unlink_async (struct ehci_hcd *ehci)
>>  		ehci->reclaim = NULL;
>>  		start_unlink_async (ehci, next);
>>  	}
>> +
>> +	if (ehci->has_synopsys_hc_bug)
>> +		writel((u32)ehci->async->qh_dma, &ehci->regs->async_next);
>>  }
> 
> This should be ehci_writel(ehci, ...).

You are right, I will change that.

Thanks,
Gabor
