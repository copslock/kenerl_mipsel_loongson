Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Dec 2010 09:29:39 +0100 (CET)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:48146 "EHLO
        phoenix3.szarvasnet.hu" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491012Ab0LWI3g (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 Dec 2010 09:29:36 +0100
Received: from mail.szarvas.hu (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with SMTP id 06FEF80E0;
        Thu, 23 Dec 2010 09:29:29 +0100 (CET)
Received: from [192.168.254.10] (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPA id A7C3C1F0002;
        Thu, 23 Dec 2010 09:29:28 +0100 (CET)
Message-ID: <4D13085E.5060001@openwrt.org>
Date:   Thu, 23 Dec 2010 09:29:18 +0100
From:   Gabor Juhos <juhosg@openwrt.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; hu-HU; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
MIME-Version: 1.0
To:     Greg KH <gregkh@suse.de>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Imre Kaloz <kaloz@openwrt.org>,
        "Luis R. Rodriguez" <lrodriguez@atheros.com>,
        Cliff Holden <Cliff.Holden@Atheros.com>,
        Kathy Giori <Kathy.Giori@Atheros.com>,
        David Brownell <dbrownell@users.sourceforge.net>,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 11/16] USB: ehci: add workaround for Synopsys HC bug
References: <1293049861-28913-1-git-send-email-juhosg@openwrt.org> <1293049861-28913-12-git-send-email-juhosg@openwrt.org> <20101223003048.GB9811@suse.de>
In-Reply-To: <20101223003048.GB9811@suse.de>
X-Enigmail-Version: 1.1.1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-VBMS: A1474DD8D18 | phoenix3 | 127.0.0.1 |  | <juhosg@openwrt.org> | 
Return-Path: <juhosg@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28702
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips

Hi Greg,

<...>
>> diff --git a/drivers/usb/host/ehci-q.c b/drivers/usb/host/ehci-q.c
>> index 233c288..343b8de 100644
>> --- a/drivers/usb/host/ehci-q.c
>> +++ b/drivers/usb/host/ehci-q.c
>> @@ -1193,6 +1193,9 @@ static void end_unlink_async (struct ehci_hcd *ehci)
>>  		ehci->reclaim = NULL;
>>  		start_unlink_async (ehci, next);
>>  	}
>> +
>> +	if (ehci->has_synopsys_hc_bug)
>> +		writel((u32)ehci->async->qh_dma, &ehci->regs->async_next);
>>  }
>>  
>>  /* makes sure the async qh will become idle */
>> diff --git a/drivers/usb/host/ehci.h b/drivers/usb/host/ehci.h
>> index ba8eab3..6da85b2 100644
>> --- a/drivers/usb/host/ehci.h
>> +++ b/drivers/usb/host/ehci.h
>> @@ -133,6 +133,7 @@ struct ehci_hcd {			/* one per controller */
>>  	unsigned		broken_periodic:1;
>>  	unsigned		fs_i_thresh:1;	/* Intel iso scheduling */
>>  	unsigned		use_dummy_qh:1;	/* AMD Frame List table quirk*/
>> +	unsigned		has_synopsys_hc_bug:1; /* Synopsys HC */
> 
> That's fine, but who sets this value to 1?  I don't see any code that
> does that, so why add this at all?  :)

It will be set to 1 by ehci_ath79_init which is in the next patch [1] of this
series.

-Gabor

1. http://marc.info/?l=linux-usb&m=129304988827418&w=2
