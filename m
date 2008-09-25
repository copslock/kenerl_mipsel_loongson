Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Sep 2008 10:54:25 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:36932 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S30611410AbYIYJyS (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 25 Sep 2008 10:54:18 +0100
Received: from [127.0.0.1] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id DDF7A3ED0; Thu, 25 Sep 2008 02:54:11 -0700 (PDT)
Message-ID: <48DB5FC0.2060908@ru.mvista.com>
Date:	Thu, 25 Sep 2008 13:54:08 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
MIME-Version: 1.0
To:	"John W. Linville" <linville@tuxdriver.com>
Cc:	Aurelien Jarno <aurelien@aurel32.net>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	Michael Buesch <mb@bu3sch.de>
Subject: Re: [PATCH 1/6] [MIPS] BCM47xx: Add platform specific PCI code
References: <20080924191840.GA18700@volta.aurel32.net> <20080924191955.GB18700@volta.aurel32.net> <48DABBBE.7060201@ru.mvista.com> <20080925001433.GA3496@tuxdriver.com>
In-Reply-To: <20080925001433.GA3496@tuxdriver.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20627
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

John W. Linville wrote:

>>> This patch, ported from OpenWRT SVN, defines pcibios_map_irq() and
>>> pcibios_plat_dev_init() for the BCM47xx platform.
>>>
>>> It fixes the regression introduced by commit
>>> aab547ce0d1493d400b6468c521a0137cd8c1edf.
>>>       
>
> Did you read this part?
>   

   I usually comment on the patches regardless of such stuff. Maybe I 
shoudn't have this time in order to not take the blame for the patch bot 
being merged...

>>> +	if (err) {
>>> +		printk(KERN_ALERT "PCI: Failed to init device %s\n",
>>> +		       pci_name(dev));
>>> +	}
>>>   
>>>       
>>   Unneeded {}...
>>     
>
> This is petty bullshit...
>   

   No, just style nitpicking. :-)

> Is there a real reason why this hasn't been merged?
>   

   This question is not to me.

> John
>   

WBR, Sergei
