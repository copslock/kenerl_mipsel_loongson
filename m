Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Sep 2004 17:48:42 +0100 (BST)
Received: from 64-60-250-34.cust.telepacific.net ([IPv6:::ffff:64.60.250.34]:56172
	"EHLO panta-1.pantasys.com") by linux-mips.org with ESMTP
	id <S8225210AbUIJQsi>; Fri, 10 Sep 2004 17:48:38 +0100
Received: from [10.1.40.165] ([10.1.40.1]) by panta-1.pantasys.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Fri, 10 Sep 2004 09:41:40 -0700
Message-ID: <4141DAD6.8000802@pantasys.com>
Date: Fri, 10 Sep 2004 09:48:22 -0700
From: Peter Buckingham <peter@pantasys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Hellwig <hch@lst.de>
CC: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH 2.6] make the bcm1250 work
References: <4140C205.7020405@pantasys.com> <20040910075644.GA27574@lst.de>
In-Reply-To: <20040910075644.GA27574@lst.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Sep 2004 16:41:40.0984 (UTC) FILETIME=[0C6F1F80:01C49755]
Return-Path: <peter@pantasys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5815
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: peter@pantasys.com
Precedence: bulk
X-list: linux-mips

Hi Christoph,

Christoph Hellwig wrote:
>> #ifdef CONFIG_EMBEDDED_RAMDISK
>> /* These are symbols defined by the ramdisk linker script */
>>+extern unsigned long initrd_start, initrd_end;
>> extern unsigned char __rd_start;
>> extern unsigned char __rd_end;
> 
> 
> Please use the appropinquate header for these.

I'd love to use the appropriate header for these, but can't find one. 
cscope doesn't seem to show that these are defined usefully in a header 
file.

Can you point me to where these are defined?

thanks,

peter
