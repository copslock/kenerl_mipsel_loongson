Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Oct 2004 23:20:40 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:22780 "EHLO
	hermes.mvista.com") by linux-mips.org with ESMTP
	id <S8225335AbUJNWUe>; Thu, 14 Oct 2004 23:20:34 +0100
Received: from mvista.com (prometheus.mvista.com [10.0.0.139])
	by hermes.mvista.com (Postfix) with ESMTP
	id 35CB9185AC; Thu, 14 Oct 2004 15:20:28 -0700 (PDT)
Message-ID: <416EFBAB.8050600@mvista.com>
Date: Thu, 14 Oct 2004 15:20:27 -0700
From: Manish Lachwani <mlachwani@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH]PCI on SWARM
References: <416DE31E.90509@mvista.com> <20041014191754.GB30516@linux-mips.org> <Pine.LNX.4.58L.0410142305380.25607@blysk.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.58L.0410142305380.25607@blysk.ds.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <mlachwani@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6050
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlachwani@mvista.com
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:

>On Thu, 14 Oct 2004, Ralf Baechle wrote:
>
>  
>
>>>This small patch is required to get PCI working on the Broadcom SWARM 
>>>board in 2.6. Without this patch, the PCI bus scan is skipped due to 
>>>resource conflict. Tested using the E100 network card
>>>      
>>>
>>>-       ioport_resource.end = 0x0000ffff;       /* 32MB reserved by 
>>>sb1250 */
>>>+       ioport_resource.end = 0xffffffff;       /* 32MB reserved by 
>>>sb1250 */
>>>      
>>>
>>I'm too lazy to dig up the actual numbers from the BCM1250 manuals but
>>it definately does not have 4GB of port address space.
>>    
>>
>
> The doc states low 25 bits are used for I/O addressing, matching the
>comment above (surprise!, surprise!), so I guess the constant sought for
>the bit mask above is 0x01ffffff.  If that turns out to work, I can apply
>an update (can I, Ralf?).
>
>  Maciej
>

Hello !

Honestly, I dont have the manual to determine the port address space 
bits. Hence, I set it to this value to MAX (i.e. 0xffffffff). Probably, 
should have mentioned that when sending the patch. Do you want me to try 
with this value (0x01ffffff) ?

Thanks
Manish Lachwani
