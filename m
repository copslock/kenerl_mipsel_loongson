Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Jan 2007 15:26:25 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:57560 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20048699AbXAXP0V (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 24 Jan 2007 15:26:21 +0000
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id A89993EC9; Wed, 24 Jan 2007 07:25:47 -0800 (PST)
Message-ID: <45B77A7B.2040504@ru.mvista.com>
Date:	Wed, 24 Jan 2007 18:25:47 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	Marc St-Jean <Marc_St-Jean@pmc-sierra.com>,
	linux-mips@linux-mips.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial driver PMC MSP71xx, kernel linux-mips.git mast
 er
References: <5C1FD43E5F1B824E83985A74F396286E03AD7632@bby1exm08.pmc_nt.nt.pmc-sierra.bc.ca> <45B51D5C.207@ru.mvista.com>
In-Reply-To: <45B51D5C.207@ru.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13803
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello, I wrote:

>>>> Here is a serial driver patch for the PMC-Sierra MSP71xx device.

>>>> There are three different fixes:
>>>> 1. Fix for THRE errata
>>>> 2. Fix for Busy Detect on LCR write
>>>> 3. Workaround for interrupt/data concurrency issue

>>>> The first fix is handled cleanly using a UART_BUG_* flag.

>>>    Hm, I wouldn't call it clean...

>> Relative to the other two. Any recommended improvements on this one?

>    I already told: runtime check.

    BTW, I've just came accross 2 patches in the -mm tree related to the 
transmitter bug:

http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.20-rc4/2.6.20-rc4-mm1/broken-out/8250-make-probing-for-txen-bug-a-config-option.patch
http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.20-rc4/2.6.20-rc4-mm1/broken-out/8250-uart-backup-timer.patch

>>>> Thanks,
>>>> Marc

WBR, Sergei
