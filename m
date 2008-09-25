Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Sep 2008 01:13:49 +0100 (BST)
Received: from charlotte.tuxdriver.com ([70.61.120.58]:19919 "EHLO
	smtp.tuxdriver.com") by ftp.linux-mips.org with ESMTP
	id S28797044AbYIYANo (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 25 Sep 2008 01:13:44 +0100
Received: from sapphire.tuxdriver.com ([70.61.120.61] helo=localhost)
	by smtp.tuxdriver.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.63)
	(envelope-from <linville@tuxdriver.com>)
	id 1KieU1-0007rI-JY; Wed, 24 Sep 2008 20:13:25 -0400
Date:	Wed, 24 Sep 2008 20:14:33 -0400
From:	"John W. Linville" <linville@tuxdriver.com>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	Aurelien Jarno <aurelien@aurel32.net>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	Michael Buesch <mb@bu3sch.de>
Subject: Re: [PATCH 1/6] [MIPS] BCM47xx: Add platform specific PCI code
Message-ID: <20080925001433.GA3496@tuxdriver.com>
References: <20080924191840.GA18700@volta.aurel32.net> <20080924191955.GB18700@volta.aurel32.net> <48DABBBE.7060201@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48DABBBE.7060201@ru.mvista.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <linville@tuxdriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20625
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linville@tuxdriver.com
Precedence: bulk
X-list: linux-mips

On Thu, Sep 25, 2008 at 02:14:22AM +0400, Sergei Shtylyov wrote:
> Aurelien Jarno wrote:
>
>> This patch, ported from OpenWRT SVN, defines pcibios_map_irq() and
>> pcibios_plat_dev_init() for the BCM47xx platform.
>>
>> It fixes the regression introduced by commit
>> aab547ce0d1493d400b6468c521a0137cd8c1edf.

Did you read this part?

>> +	/* IRQ-0 and IRQ-1 are software interrupts. */
>> +	WARN_ON((res == 0) || (res == 1));
>>   
>
>   Unneeded ()...

Pffttt...

>> +	if (err) {
>> +		printk(KERN_ALERT "PCI: Failed to init device %s\n",
>> +		       pci_name(dev));
>> +	}
>>   
>
>   Unneeded {}...

This is petty bullshit...

Is there a real reason why this hasn't been merged?

John
-- 
John W. Linville		Linux should be at the core
linville@tuxdriver.com			of your literate lifestyle.
