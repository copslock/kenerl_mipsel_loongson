Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Nov 2007 11:06:19 +0000 (GMT)
Received: from spamgate.koyote.com ([204.11.24.49]:41602 "EHLO
	spamgate.koyote.com") by ftp.linux-mips.org with ESMTP
	id S20038869AbXKZLGI (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 26 Nov 2007 11:06:08 +0000
Received: from localhost (test [127.0.0.1])
	by spamgate.koyote.com (Postfix) with ESMTP id 5F611CBA28;
	Mon, 26 Nov 2007 05:03:24 -0600 (CST)
Received: from spamgate.koyote.com ([127.0.0.1])
	by localhost (spamgate.koyote.com [127.0.0.1]) (amavisd-new, port 10026)
	with LMTP id mbFQadzg8+nq; Mon, 26 Nov 2007 05:03:21 -0600 (CST)
Received: from mail.localdomain (mail.enetonline.net [204.11.24.29])
	by spamgate.koyote.com (Postfix) with ESMTP id E77C5CB9BC;
	Mon, 26 Nov 2007 05:03:21 -0600 (CST)
Received: from mythtv.ewol.com (unknown [66.209.47.173])
	by mail.localdomain (Postfix) with ESMTP id C3726792DE7;
	Mon, 26 Nov 2007 05:05:30 -0600 (CST)
Message-ID: <474AA87D.7000509@cortland.com>
Date:	Mon, 26 Nov 2007 06:05:33 -0500
From:	Steve Brown <sbrown@cortland.com>
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
MIME-Version: 1.0
To:	Michael Buesch <mb@bu3sch.de>
CC:	"John W. Linville" <linville@tuxdriver.com>,
	linux-mips@linux-mips.org
Subject: Re: ohci-ssb driver on a Broadcom BCM5354
References: <47408305.5090804@cortland.com> <20071118224752.GB12263@tuxdriver.com> <200711191923.56471.mb@bu3sch.de>
In-Reply-To: <200711191923.56471.mb@bu3sch.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sbrown@cortland.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17585
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sbrown@cortland.com
Precedence: bulk
X-list: linux-mips

Michael Buesch wrote:
> On Sunday 18 November 2007 23:47:52 John W. Linville wrote:
>   
>> You probably want to make Michael Buesch aware of this issue.
>>     
>
> I'm not sure anyone really tested this beyond some insmod tests.
> I did not test this, as I don't have such a device.
> So if you have any patches to fix this, please send them. I'm
> certainly the wrong person who can fix this. ;)
>
>   
Adding the following at the end of ssb_ohci_attach seems to fix the problem.

 if (ssb_dma_set_mask(dev, DMA_32BIT_MASK))
   return -EOPNOTSUPP;

I guessed at the dma mask. Would the code in the b43 driver that selects 
a dma mask be appropriate here?

Steve
