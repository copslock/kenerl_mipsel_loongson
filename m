Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Sep 2008 09:01:06 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:40802 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S30614347AbYI2IAY (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 29 Sep 2008 09:00:24 +0100
Received: from [127.0.0.1] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 91C5A3ECB; Mon, 29 Sep 2008 01:00:18 -0700 (PDT)
Message-ID: <48E08B0E.9010504@ru.mvista.com>
Date:	Mon, 29 Sep 2008 12:00:14 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	linux-ide@vger.kernel.org,
	"Maciej W. Rozycki" <macro@linux-mips.org>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH v2] IDE: Fix platform device registration in Swarm IDE
 driver
References: <20080922122853.GA15210@linux-mips.org> <48DA1F9D.6000501@ru.mvista.com> <200809271859.55304.bzolnier@gmail.com> <20080928113931.GA9207@linux-mips.org> <20080928175450.GA8478@linux-mips.org> <48DFFC62.9050300@ru.mvista.com>
In-Reply-To: <48DFFC62.9050300@ru.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20663
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello, I wrote:

>> The Swarm IDE driver uses a release method which is defined in the 
>> driver
>> itself thus potentially oopsable.  The simple fix would be to just leak
>> the device but this patch goes the full length and moves the entire
>> handling of the platform device in the platform code and retains only
>> the platform driver code in drivers/ide/mips/swarm.c.
>>
>> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
>>   
>
> Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

   Perhaps worth splitting into arch/mips/ and the follow-up 
drivers/ide/ patches though...

MBR, Sergei
