Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Nov 2004 17:12:31 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:5874 "EHLO
	hermes.mvista.com") by linux-mips.org with ESMTP
	id <S8225205AbUKBRM1>; Tue, 2 Nov 2004 17:12:27 +0000
Received: from mvista.com (prometheus.mvista.com [10.0.0.139])
	by hermes.mvista.com (Postfix) with ESMTP
	id C584E1845C; Tue,  2 Nov 2004 09:12:24 -0800 (PST)
Message-ID: <4187BFF8.6000905@mvista.com>
Date: Tue, 02 Nov 2004 09:12:24 -0800
From: Manish Lachwani <mlachwani@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Thomas Petazzoni <thomas.petazzoni@enix.org>
Cc: linux-mips@linux-mips.org
Subject: Re: Custom kernel crashes
References: <4187AF03.5030606@enix.org> <4187BB44.4030508@mvista.com> <4187BED1.2060208@enix.org>
In-Reply-To: <4187BED1.2060208@enix.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <mlachwani@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6247
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlachwani@mvista.com
Precedence: bulk
X-list: linux-mips

Hello !

What are these values: NPP_BOARD_INTERNAL_SRAM_BASE, 
NPP_BOARD_INTERNAL_SRAM_END and NPP_BOARD_INTERNAL_SRAM_BASE.

Also, what is ENTRYLO() defined as?

Thanks
Manish Lachwani



Thomas Petazzoni wrote:
> Hello,
> 
> Manish Lachwani a écrit :
> 
>> This may or may not apply to your case. Is this board still the one 
>> that has the Marvell Discovery ethernet device? If yes, Marvell 
>> Discovery has its SRAM located at 0xfe000000. So, make a check in the 
>> ethernet driver or other board specific sources and see if there is 
>> any access to this SRAM location.
> 
> 
> The DMA buffers and DMA buffer descriptors used for the serial driver 
> are all located in the SRAM of the Marvell, which is mapped using a 
> wired uncached TLB entry.
> 
> Here's the code that wires the entry :
> 
>   add_wired_entry(ENTRYLO(NPP_BOARD_INTERNAL_SRAM_BASE),
>                   ENTRYLO(NPP_BOARD_INTERNAL_SRAM_END),
>                   NPP_BOARD_INTERNAL_SRAM_BASE,
>                   PM_256K);
> 
> I would like to use ioremap() instead of wired TLB entries, but for the 
> moment, I'm focusing on this crash.
> 
> Thanks,
> 
> Thomas
