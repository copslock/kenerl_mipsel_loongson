Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 28 Sep 2008 22:58:42 +0100 (BST)
Received: from ditditdahdahdah-dahditditditdit.dl5rb.org.uk ([217.169.26.26]:6889
	"EHLO ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S28642681AbYI1V6A (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 28 Sep 2008 22:58:00 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m8SLvv6j013066;
	Sun, 28 Sep 2008 22:57:57 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m8SLvu5g013064;
	Sun, 28 Sep 2008 22:57:56 +0100
Date:	Sun, 28 Sep 2008 22:57:56 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	linux-ide@vger.kernel.org,
	"Maciej W. Rozycki" <macro@linux-mips.org>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH v2] IDE: Fix platform device registration in Swarm IDE
	driver
Message-ID: <20080928215756.GA12949@linux-mips.org>
References: <20080922122853.GA15210@linux-mips.org> <48DA1F9D.6000501@ru.mvista.com> <200809271859.55304.bzolnier@gmail.com> <20080928113931.GA9207@linux-mips.org> <20080928175450.GA8478@linux-mips.org> <48DFFC62.9050300@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48DFFC62.9050300@ru.mvista.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20662
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Sep 29, 2008 at 01:51:30AM +0400, Sergei Shtylyov wrote:

>> +	{
>> +		.name	= "Swarm GenBus IDE",
>> +		.flags	= IORESOURCE_MEM,
>> +	}, {
>> +		.name	= "Swarm GenBus IDE",
>> +		.flags	= IORESOURCE_MEM,
>> +	}, {
>> +		.name	= "Swarm GenBus IDE",
>> +		.flags	= IORESOURCE_IRQ,
>> +		.start	= K_INT_GB_IDE,
>> +		.end	= K_INT_GB_IDE,
>>   
>
>   Giving the resources similar names is pointless. You can just leave  
> the 'name' field uninitialized.

I could - but I prefer things to have reasonable names in /proc/iomem or
wherever.  Unfortunately the IRQ resources name isn't yet being used to
for the interrupt but there's always something left to do :)

  Ralf
