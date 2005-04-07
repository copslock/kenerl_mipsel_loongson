Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Apr 2005 12:37:48 +0100 (BST)
Received: from mail.timesys.com ([IPv6:::ffff:65.117.135.102]:12695 "EHLO
	exchange.timesys.com") by linux-mips.org with ESMTP
	id <S8224935AbVDGLhd>; Thu, 7 Apr 2005 12:37:33 +0100
Received: from [192.168.2.27] ([192.168.2.27]) by exchange.timesys.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Thu, 7 Apr 2005 07:33:21 -0400
Message-ID: <42551B79.6080803@timesys.com>
Date:	Thu, 07 Apr 2005 07:37:29 -0400
From:	Greg Weeks <greg.weeks@timesys.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	linux-mips@linux-mips.org
Subject: Re: 4kc machine check
References: <4254181A.9000301@timesys.com> <20050406200255.GA4978@linux-mips.org>
In-Reply-To: <20050406200255.GA4978@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Apr 2005 11:33:21.0218 (UTC) FILETIME=[9A0C9A20:01C53B65]
Return-Path: <greg.weeks@timesys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7621
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: greg.weeks@timesys.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:

>On Wed, Apr 06, 2005 at 01:10:50PM -0400, Greg Weeks wrote:
>
>  
>
>>I noticed there was a recent checkin for 4000 series tlb code. It still 
>>seems to be a problem on the 4kc malta.
>>    
>>
>
>4K is not R4000 series ...   Anyway, the 4K code you were sent aren't yet
>in because they've only empirically proven to be correct; we'd like to
>look into the case a little further before comitting the patches into CVS.
>  
>
Touched code got built so I figured it was worth a build and run. I 
still see occasional machine checks with the patch you gave me that 
moves the tlb_probe around.

Greg Weeks
