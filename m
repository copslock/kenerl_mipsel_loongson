Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Mar 2005 17:07:02 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:44530 "EHLO
	hermes.mvista.com") by linux-mips.org with ESMTP
	id <S8225339AbVCKRGr>; Fri, 11 Mar 2005 17:06:47 +0000
Received: from mvista.com (prometheus.mvista.com [10.0.0.139])
	by hermes.mvista.com (Postfix) with ESMTP
	id 894FF18A0B; Fri, 11 Mar 2005 09:06:42 -0800 (PST)
Message-ID: <4231D022.9050604@mvista.com>
Date:	Fri, 11 Mar 2005 09:06:42 -0800
From:	Manish Lachwani <mlachwani@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Alan Cox <alan@lxorguk.ukuu.org.uk>, Rishabh@soc-soft.com,
	linux-mips@linux-mips.org
Subject: Re: Memory Management HAndling
References: <4BF47D56A0DD2346A1B8D622C5C5902C61E22B@soc-mail.soc-soft.com> <1110548190.15943.46.camel@localhost.localdomain> <20050311155924.GD5958@linux-mips.org>
In-Reply-To: <20050311155924.GD5958@linux-mips.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <mlachwani@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7423
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlachwani@mvista.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:

>On Fri, Mar 11, 2005 at 01:36:31PM +0000, Alan Cox wrote:
>
>  
>
>>On Gwe, 2005-03-11 at 05:25, Rishabh@soc-soft.com wrote:
>>    
>>
>>>These macros can handle memory pages in KSEG0. Any suggestions on how
>>>can they be changed for addressing memory present in HIGHMEM. Since VA
>>>will not be in linear relation with mem_map.
>>>      
>>>
>>Take a look at how kmap() works on x86 and how the mappings are used.
>>    
>>
>
>Highmem is supported for MIPS since ~ 2.4.18 or so.
>
>  Ralf
>
>  
>
Right, I had the 2.4.21 HIGHMEM working on PMC-Sierra Yosemite. Also, at 
that time, Sibyte supported HIGHMEM.

Thanks
Manish Lachwani
