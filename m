Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Jul 2009 21:48:29 +0200 (CEST)
Received: from h155.mvista.com ([63.81.120.155]:65405 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1493732AbZG3TsW (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 30 Jul 2009 21:48:22 +0200
Received: from [127.0.0.1] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 4B9323EC9; Thu, 30 Jul 2009 12:48:18 -0700 (PDT)
Message-ID: <4A71F8FD.3060002@ru.mvista.com>
Date:	Thu, 30 Jul 2009 23:48:13 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
User-Agent: Thunderbird 2.0.0.22 (Windows/20090605)
MIME-Version: 1.0
To:	David Miller <davem@davemloft.net>
Cc:	florian@openwrt.org, ralf@linux-mips.org,
	manuel.lauss@googlemail.com, linux-mips@linux-mips.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH 0/4] au1000_eth platform device/driver conversion
References: <200907282300.07144.florian@openwrt.org> <20090730.123450.224830320.davem@davemloft.net>
In-Reply-To: <20090730.123450.224830320.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23801
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

David Miller wrote:

> From: Florian Fainelli <florian@openwrt.org>
> Date: Tue, 28 Jul 2009 23:00:04 +0200
>   
>> Hi Ralf, David, Manuel,
>>
>> The following patches convert the AMD Alchemy au1000_eth driver
>> to become a platform device/driver. The patches are splitted that way:
>>     
>
> I was only able to see patch #2 and #4 in this series and
> checking the netdev patch postings that made it to:
>
> 	http://patchwork.ozlabs.org/project/netdev/list/
>
> confirms that patches #1 and #3 didn't make it to the list
> either.

   Because they were only posted to linux-mips. And we didn't see #2 and 
#4 in linux-mips either.

WBR, Sergei
