Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Nov 2005 11:19:13 +0000 (GMT)
Received: from alg145.algor.co.uk ([62.254.210.145]:48134 "EHLO
	dmz.algor.co.uk") by ftp.linux-mips.org with ESMTP id S3466282AbVKVLS4
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 22 Nov 2005 11:18:56 +0000
Received: from alg158.algor.co.uk ([62.254.210.158] helo=olympia.mips.com)
	by dmz.algor.co.uk with esmtp (Exim 3.35 #1 (Debian))
	id 1EeW9T-0007k7-00; Tue, 22 Nov 2005 11:17:31 +0000
Received: from highbury.mips.com ([192.168.192.236])
	by olympia.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1EeWD3-0000yF-00; Tue, 22 Nov 2005 11:21:13 +0000
Message-ID: <4382FF29.2020605@mips.com>
Date:	Tue, 22 Nov 2005 11:21:13 +0000
From:	Nigel Stephens <nigel@mips.com>
Organization: MIPS Technologies
User-Agent: Debian Thunderbird 1.0.2 (X11/20050817)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	"Kevin D. Kissell" <kevink@mips.com>
CC:	"Knittel, Brian" <Brian.Knittel@powertv.com>,
	linux-mips@linux-mips.org
Subject: Re: Saving arguments on the stack
References: <762C0A863A7674478671627FEAF5848105AF92D2@hqmail01.powertv.com> <4382DC76.60506@mips.com>
In-Reply-To: <4382DC76.60506@mips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MTUK-Scanner:	Found to be clean
X-MTUK-SpamCheck: not spam (whitelisted), SpamAssassin (score=-4.712,
	required 4, AWL, BAYES_00)
Return-Path: <nigel@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9529
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nigel@mips.com
Precedence: bulk
X-list: linux-mips



Kevin D. Kissell wrote:

> Knittel, Brian wrote:
>
>> Hi,
>>
>> I'd like to force the compiler to store arguments on the stack with 
>> otherwise optimized code.
>>
>> I found a refernce in the archives (form 2001) for using -0 (no 
>> optimization). Has anyone found another way to do this?
>
>
> If I recall correctly, if you specify -g to enable debugger support,
> the subroutine prologues store the arguments into their stack slots,
> even if a higher level of optimization is otherwise specified.


'Fraid not: the -g option only adds debug info to the object file, it 
shouldn't alter the generated code. Using -O0 will certainly store 
everything on the stack, but it also won't be "with otherwise optimized 
code".


Nigel
