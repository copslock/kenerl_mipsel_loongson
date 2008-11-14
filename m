Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Nov 2008 00:15:33 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:51856 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S23664368AbYKNAPb (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 14 Nov 2008 00:15:31 +0000
Received: from [127.0.0.1] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id C562B3ECC; Thu, 13 Nov 2008 16:15:28 -0800 (PST)
Message-ID: <491CC31C.7090606@ru.mvista.com>
Date:	Fri, 14 Nov 2008 03:15:24 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	linux-kernel@vger.kernel.org,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH] New IDE/block driver for OCTEON SOC Compact Flash interface.
References: <491C7F28.2070507@caviumnetworks.com> <491CC0B6.8020400@ru.mvista.com>
In-Reply-To: <491CC0B6.8020400@ru.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21286
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello, I wrote:

>> As part of our efforts to get the Cavium OCTEON processor support
>> merged (see: http://marc.info/?l=linux-mips&m=122600487218824), we
>> have this CF driver for your consideration.
>>
>> Most OCTEON variants have *no* DMA or interrupt support on the CF
>> interface so a simple bit-banging approach is taken.  Although if DMA is
>> available, we do take advantage of it.
>>
>> The register definitions are part of the chip support patch set
>> mentioned above, and are not included here.
>>
>> At this point I would like to get feedback as to whether this is a
>> good approach for the CF driver, or perhaps generate ideas about other
>> possible approaches.
>
>   It's totally unacceptable for drivers/ide/ as this is 
> self-containeed driver no using IDE core for anything, so this can 
> only fit well to drivers/block/.

   I probably need to clarify that it will hardly be accepted into 
drivers/block/ as well, being a mere CF driver.

MBR, Sergei
