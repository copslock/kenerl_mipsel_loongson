Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Sep 2008 16:42:49 +0100 (BST)
Received: from ditditdahdahdah-dahditditditdit.dl5rb.org.uk ([217.169.26.26]:46769
	"EHLO ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S62089831AbYIZPmp (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 26 Sep 2008 16:42:45 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m8QFgZ7P003291;
	Fri, 26 Sep 2008 16:42:35 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m8QFgYqF003289;
	Fri, 26 Sep 2008 16:42:34 +0100
Date:	Fri, 26 Sep 2008 16:42:34 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	Aurelien Jarno <aurelien@aurel32.net>, linux-mips@linux-mips.org,
	Michael Buesch <mb@bu3sch.de>
Subject: Re: [PATCH 1/6] [MIPS] BCM47xx: Add platform specific PCI code
Message-ID: <20080926154233.GA3086@linux-mips.org>
References: <20080924191840.GA18700@volta.aurel32.net> <20080924191955.GB18700@volta.aurel32.net> <48DABBBE.7060201@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48DABBBE.7060201@ru.mvista.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20643
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Sep 25, 2008 at 02:14:22AM +0400, Sergei Shtylyov wrote:

>> +	res = ssb_pcibios_map_irq(dev, slot, pin);
>> +	if (res < 0) {
>> +		printk(KERN_ALERT "PCI: Failed to map IRQ of device %s\n",
>> +		       dev->dev.bus_id);
>> +		return 0;
>> +	}
>> +	/* IRQ-0 and IRQ-1 are software interrupts. */
>> +	WARN_ON((res == 0) || (res == 1));
>>   
>
>   Unneeded ()...

My rule of thumb for the use of parenthesis is that the reader of a piece
of code should not have to know much about operator precendence, so the
occasional avoidable parenthesis if it serves readability.

  Ralf
