Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 16 Jan 2005 09:35:25 +0000 (GMT)
Received: from imfep06.dion.ne.jp ([IPv6:::ffff:210.174.120.157]:16041 "EHLO
	imfep06.dion.ne.jp") by linux-mips.org with ESMTP
	id <S8224986AbVAPJfU>; Sun, 16 Jan 2005 09:35:20 +0000
Received: from [192.168.0.2] ([218.222.93.90]) by imfep06.dion.ne.jp
          (InterMail vM.4.01.03.31 201-229-121-131-20020322) with ESMTP
          id <20050116093517.KNMK23095.imfep06.dion.ne.jp@[192.168.0.2]>;
          Sun, 16 Jan 2005 18:35:17 +0900
Message-ID: <41EA3554.10407@mb.neweb.ne.jp>
Date: Sun, 16 Jan 2005 18:35:16 +0900
From: Nyauyama <ichinoh@mb.neweb.ne.jp>
User-Agent: Mozilla Thunderbird 1.0 (Macintosh/20041206)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Pete Popov <ppopov@embeddedalley.com>
CC: linux-mips@linux-mips.org
Subject: Re: QUESTION YAMON's uart3 of au1100
References: <41E9D047.4010603@mb.neweb.ne.jp> <41E9D91A.3050201@embeddedalley.com>
In-Reply-To: <41E9D91A.3050201@embeddedalley.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ichinoh@mb.neweb.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6932
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ichinoh@mb.neweb.ne.jp
Precedence: bulk
X-list: linux-mips

Pete Popov wrote:

>Nyauyama wrote:
>  
>
>>Hello!
>>
>>I have a question about initialization of YAMON's uart3 of au1100.
>>BFC00000(BOOTLOC) is read by processing delay3.
>>Why BFC00000?
>>    
>>
>
>Looks like just an arbitrary ad-hoc delay routine (delay3) that
>reads from uncached space and throws away the value (just a delay).
>
>What's the problem you're having?
>
>  Pete
>
>  
>
The problem occurs by UART3 after using uboot and starting Linux kernel.
Linux kernel has initialized UART3.
When the noise is received when uboot processes it,
anything cannot be received from uart3.
When having seen referring to the initialization of YAMON,
I have not understood the reason to read BFC00000.

Thank you for the reply.

Nyauyama
