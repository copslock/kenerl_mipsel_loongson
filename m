Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 May 2009 16:44:28 +0100 (BST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:23788 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20024507AbZE1PoU (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 28 May 2009 16:44:20 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4a1eb10d0000>; Thu, 28 May 2009 11:43:11 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 28 May 2009 08:43:19 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 28 May 2009 08:43:18 -0700
Message-ID: <4A1EB116.6080404@caviumnetworks.com>
Date:	Thu, 28 May 2009 08:43:18 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	wuzhangjin@gmail.com, Florian Fainelli <florian@openwrt.org>,
	Richard Sandiford <rdsandiford@googlemail.com>,
	"Maciej W. Rozycki" <macro@linux-mips.org>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Handle removal of 'h' constraint in GCC 4.4
References: <1229567048-19219-1-git-send-email-ddaney@caviumnetworks.com>	 <alpine.LFD.1.10.0812190041080.6463@ftp.linux-mips.org>	 <87wsdl63xv.fsf@firetop.home>  <200905281331.41440.florian@openwrt.org> <1243521105.5183.5.camel@falcon>
In-Reply-To: <1243521105.5183.5.camel@falcon>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 28 May 2009 15:43:18.0901 (UTC) FILETIME=[05F36A50:01C9DFAB]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23031
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Wu Zhangjin wrote:
> Hi, 
> 
> On Thu, 2009-05-28 at 13:31 +0200, Florian Fainelli wrote:
>> Le Saturday 27 December 2008 16:19:40 Richard Sandiford, vous avez écrit :
>>> "Maciej W. Rozycki" <macro@linux-mips.org> writes:
>>>> On Wed, 17 Dec 2008, David Daney wrote:
>>>>> This is an incomplete proof of concept that I applied to be able to
>>>>> build a 64 bit kernel with GCC-4.4.  It doesn't handle the 32 bit case
>>>>> or the R4000_WAR case.
>>>>  The R4000_WAR case can use the same C code -- GCC will adjust code
>>>> generated as necessary according to the -mfix-r4000 flag.  For the 32-bit
>>>> case I think the conclusion was the only way to get it working is to use
>>>> MFHI explicitly in the asm.
>>> No, the same sort of cast, multiply and shift should work for 32-bit
>>> code too.  I.e.:
>>>
>>> 		usecs = ((uint64_t)usecs * lpj) >> 32;
>>>
>>> It should work for both -mfix-r4000 and -mno-fix-r4000.
>> Any updates on this ?
> 
> I have updated it to this PATCH, could you help to review it?
> 
> 
> 

FWIW, Ralf also has a patch, that I have tested, that takes a slightly 
different approach.

In any event, it would be nice if one of the patches were merged to 
2.6.30 before it is released.  GCC-4.4 has been available for quite a 
while now.  Not being able to build the kernel with it will become a 
larger issue as time goes by.

David Daney
