Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Nov 2008 09:34:42 +0000 (GMT)
Received: from qmta07.emeryville.ca.mail.comcast.net ([76.96.30.64]:26847 "EHLO
	QMTA07.emeryville.ca.mail.comcast.net") by ftp.linux-mips.org
	with ESMTP id S23764241AbYKSJef (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 19 Nov 2008 09:34:35 +0000
Received: from OMTA10.emeryville.ca.mail.comcast.net ([76.96.30.28])
	by QMTA07.emeryville.ca.mail.comcast.net with comcast
	id gxZW1a0070cQ2SLA7xaSXy; Wed, 19 Nov 2008 09:34:26 +0000
Received: from [10.0.0.109] ([24.6.28.106])
	by OMTA10.emeryville.ca.mail.comcast.net with comcast
	id gxaQ1a0012HMlxk8WxaRMF; Wed, 19 Nov 2008 09:34:26 +0000
X-Authority-Analysis: v=1.0 c=1 a=Jiin1-7K6OfAIeOXQRQA:9
 a=ju7N_OKAWWLS1qSILEEA:7 a=6NdkLgnzaU1jjMVrZKpJ_v30dbsA:4 a=4t78-hnhQh4A:10
 a=gi0PWCVxevcA:10
Message-ID: <4923DDA1.2090107@notav8.com>
Date:	Wed, 19 Nov 2008 01:34:25 -0800
From:	Chris Rhodin <chris@notav8.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.8) Gecko/20050511
X-Accept-Language: en-us, en, zh, zh-cn, zh-hk, zh-sg, zh-tw
MIME-Version: 1.0
To:	David Daney <ddaney@caviumnetworks.com>
CC:	linux-mips@linux-mips.org
Subject: Re: gdb configuration
References: <49229165.80000@notav8.com> <4922F3C7.8070408@caviumnetworks.com>
In-Reply-To: <4922F3C7.8070408@caviumnetworks.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <chris@notav8.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21336
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chris@notav8.com
Precedence: bulk
X-list: linux-mips

I was using a gdb I built from the Debian sources, it's version 6.4.90.  
I just built 6.8 from GNU and everything seems to work fine now.

Thanks,


Chris Rhodin

David Daney wrote:

> Chris Rhodin wrote:
>
>> Hi,
>>
>> I'm trying to debug 32-bit linux over a serial port with gdb.  I'm 
>> able to connect to the target and everything looks good until I 
>> examine the registers.  What's there is obviously wrong.  I've 
>> examined the stack and found the register data structure.  Each 
>> register in this structure is 32 bits.  When I compare the structure 
>> to the registers that gdb displays I can see that gdb is expecting 
>> each register to occupy 64 bits.  I've tried setting "abi", 
>> "saved-gpreg-size", and "stack-arg-size" to 32 bits without success.  
>> Can someone point out my obvious mistake?
>>
>
> Please report the exact versions of all the tools you are using.  If 
> you are not using gdb 6.8 upgrade to that version and see what happens.
>
> If it still fails, try asking on gdb@sourceware.org
>
> David Daney
>
> .
>
