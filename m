Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Mar 2007 06:13:18 +0000 (GMT)
Received: from rrcs-64-183-102-11.west.biz.rr.com ([64.183.102.11]:41411 "EHLO
	jg555.com") by ftp.linux-mips.org with ESMTP id S20021535AbXCHGNQ
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 8 Mar 2007 06:13:16 +0000
Received: from [192.168.55.157] ([::ffff:192.168.55.157])
  (AUTH: PLAIN root, TLS: TLSv1/SSLv3,256bits,AES256-SHA)
  by jg555.com with esmtp; Wed, 07 Mar 2007 22:12:14 -0800
  id 004600EC.45EFA93E.00000872
Message-ID: <45EFA92C.3070203@jg555.com>
Date:	Wed, 07 Mar 2007 22:11:56 -0800
From:	Jim Gifford <maillist@jg555.com>
User-Agent: Thunderbird 1.5.0.10 (Windows/20070221)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: Building 64 bit kernel on Cobalt
References: <45EB53D5.8060007@jg555.com> <20070304232731.GA25039@linux-mips.org>
In-Reply-To: <20070304232731.GA25039@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <maillist@jg555.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14390
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: maillist@jg555.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Sun, Mar 04, 2007 at 03:18:45PM -0800, Jim Gifford wrote:
>
>   
>> Last working Kernel was 2.6.19 series.
>>
>> Some changes from 2.6.19 and the 2.6.20 make it impossible to build a 64 
>> bit kernel to boot on the cobalt. Ya, I know why, building a N32 
>> actually but need a 64 bit kernel in order to do that. Anyone got any 
>> suggestions. Looking through the difference between the kernels to 
>> figure this out, but it's like looking for a needle in a haystack. Any 
>> suggestions as to a starting point?
>>     
>
> Try git-bisect to track down the changeset that broke things.
>
>   Ralf
>
>   
We got it nailed down to arch/mips/kernel /setup.c. But we have not 
isolated which change is actually causing it.

We do know that reverting back to the 2.6.19.x arch/mips/kernel /setup.c 
will fix the issue. We will continue to dwindle it down until we come up 
with the offender.
