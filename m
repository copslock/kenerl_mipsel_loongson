Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 28 Sep 2008 12:47:56 +0100 (BST)
Received: from ditditdahdahdah-dahditditditdit.dl5rb.org.uk ([217.169.26.26]:41172
	"EHLO ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S28582711AbYI1LrO (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 28 Sep 2008 12:47:14 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m8SBlBrI009615;
	Sun, 28 Sep 2008 12:47:11 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m8SBlB0C009613;
	Sun, 28 Sep 2008 12:47:11 +0100
Date:	Sun, 28 Sep 2008 12:47:11 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	bzolnier@gmail.com, linux-ide@vger.kernel.org,
	"Maciej W. Rozycki" <macro@linux-mips.org>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] IDE: Fix platform device registration in Swarm IDE
	driver
Message-ID: <20080928114711.GB9207@linux-mips.org>
References: <20080922122853.GA15210@linux-mips.org> <48DA1F9D.6000501@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48DA1F9D.6000501@ru.mvista.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20656
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Sep 24, 2008 at 03:08:13PM +0400, Sergei Shtylyov wrote:

>> +{
>>   
> [...]
>> +	pdev = platform_device_register_simple(DEV_NAME, -1,
>> +		       swarm_ide_resource, ARRAY_SIZE(swarm_ide_resource));
>>   
>
>   If you have the resources as static array anyway, why not have the  
> device in the static variable too and use platform_device_register()?

It saves a few lines of code.

>> -static struct platform_device *swarm_ide_dev;
>>   
>
>   Platform device in the driver itself? Interesting... :-)

It works and isn't a too bad idea for certain drivers where adding one half
of the code to a platform file, another to the driver file is just too
much fuzz.  It's just that this wasn't done right in case of the Swarm so
I'm gluing that now.

  Ralf
