Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Nov 2004 17:58:01 +0000 (GMT)
Received: from smtp804.mail.sc5.yahoo.com ([IPv6:::ffff:66.163.168.183]:64591
	"HELO smtp804.mail.sc5.yahoo.com") by linux-mips.org with SMTP
	id <S8225005AbUKXR5y>; Wed, 24 Nov 2004 17:57:54 +0000
Received: from unknown (HELO ?10.2.2.68?) (pvpopov@pacbell.net@63.194.214.47 with plain)
  by smtp804.mail.sc5.yahoo.com with SMTP; 24 Nov 2004 17:57:49 -0000
Message-ID: <41A4CB92.7070403@embeddedalley.com>
Date: Wed, 24 Nov 2004 09:57:38 -0800
From: Pete Popov <ppopov@embeddedalley.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.3) Gecko/20040910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Gilad Rom <gilad@romat.com>
CC: linux-mips@linux-mips.org
Subject: Re: Au1500 Chip Select
References: <20041124143229.ADF81EB2E4@mail.romat.com>
In-Reply-To: <20041124143229.ADF81EB2E4@mail.romat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6437
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips

Gilad Rom wrote:

> Hello,
> 
> I am trying to implement a simple program which
> Will be used to communicate with an I/O peripheral 
> Over CS1 (Chip select 1) of the au1500.

I'm not sure I understand what you're trying to do. The chip select is setup by 
the boot loader or kernel, and you don't touch it anymore. The CS will get 
asserted/deasserted based on the addresses you're trying to access.

> Has anyone ever attempted this? Could someone 
> Point me to some sample code, perhaps? I am grepping
> Through the kernel, yet having trouble locating
> Chip-select specific code for reference.

Again, what sort of an example are you looking for?  Setting up a chip select on 
the Au1x is nothing more than writing the appropriate values to the 3 chip 
select registers. Then you're done.

Pete
