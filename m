Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Feb 2005 18:21:14 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:26105 "EHLO
	hermes.mvista.com") by linux-mips.org with ESMTP
	id <S8225463AbVBCSU6>; Thu, 3 Feb 2005 18:20:58 +0000
Received: from mvista.com (prometheus.mvista.com [10.0.0.139])
	by hermes.mvista.com (Postfix) with ESMTP
	id DE985189C8; Thu,  3 Feb 2005 10:20:56 -0800 (PST)
Message-ID: <42026B88.6050908@mvista.com>
Date:	Thu, 03 Feb 2005 10:20:56 -0800
From:	Manish Lachwani <mlachwani@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Rojhalat Ibrahim <ibrahim@schenk.isar.de>,
	linux-mips@linux-mips.org
Subject: Re: More than 512MB of memory
References: <41ED20E3.60309@schenk.isar.de> <20050203153520.GF13804@linux-mips.org>
In-Reply-To: <20050203153520.GF13804@linux-mips.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <mlachwani@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7137
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlachwani@mvista.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:

>On Tue, Jan 18, 2005 at 03:44:51PM +0100, Rojhalat Ibrahim wrote:
>
>  
>
>>is there anything special I have to do
>>when I want to use more than 512MB of memory?
>>My Yosemite board works fine with 512MB
>>but when I try 1GB it crashes in 32bit mode
>>with highmem and also in 64bit mode.
>>The boot monitor (PMON) maps the 1024MB
>>to physical addresses 0x0000.0000 - 0x4000.0000.
>>    
>>
>
>Interesting.  It's supposed to work but I don't have enough memory for
>testing this.
>
>  Ralf
>
>  
>
IIRC, you had posted the kernel boot log in a message as well. Can you 
post it again? For both the HIGHMEM case and the 64-bit case.

Thanks
Manish Lachwani
