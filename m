Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 26 Feb 2005 18:07:23 +0000 (GMT)
Received: from msr35.hinet.net ([IPv6:::ffff:168.95.4.135]:6110 "EHLO
	msr35.hinet.net") by linux-mips.org with ESMTP id <S8225200AbVBZSHI>;
	Sat, 26 Feb 2005 18:07:08 +0000
Received: from [192.168.186.100] (218-160-39-172.dynamic.hinet.net [218.160.39.172])
	by msr35.hinet.net (8.9.3/8.9.3) with ESMTP id CAA20702
	for <linux-mips@linux-mips.org>; Sun, 27 Feb 2005 02:07:02 +0800 (CST)
Message-ID: <4220BA87.8070101@s90.tku.edu.tw>
Date:	Sun, 27 Feb 2005 02:05:59 +0800
From:	Tsang-Ren Chang <690190029@s90.tku.edu.tw>
User-Agent: Mozilla Thunderbird 0.9 (Windows/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Re: ADM5120: Data bus error
References: <421DF870.30708@s90.tku.edu.tw> <20050225100247.GA10193@linux-mips.org>
In-Reply-To: <20050225100247.GA10193@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <690190029@s90.tku.edu.tw>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7345
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: 690190029@s90.tku.edu.tw
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:

>On Thu, Feb 24, 2005 at 11:53:20PM +0800, Tsang-Ren Chang wrote:
>
>  
>
>>Hi,
>>I'm porting linux-2.4.27 on adm5120 (MIPS 4Kc core).
>>But when I copied /sbin/pppd , It crashed.
>>    
>>
>
>In addition to what Maciej said I'd like to add that bus errors are often
>signalled asynchronously, so the machine state in a register dump very
>often has no relation to the actual problem.
>
>  Ralf
>
>.
>
>  
>
Hi,
I rebuilt the kernel with uncached option and the error disappeared.
What does that mean?

Thanks,
T.R. Chang
