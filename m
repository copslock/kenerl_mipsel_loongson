Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Oct 2004 19:13:46 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:8433 "EHLO
	hermes.mvista.com") by linux-mips.org with ESMTP
	id <S8225254AbUJTSNl>; Wed, 20 Oct 2004 19:13:41 +0100
Received: from mvista.com (prometheus.mvista.com [10.0.0.139])
	by hermes.mvista.com (Postfix) with ESMTP
	id C663E18360; Wed, 20 Oct 2004 11:13:30 -0700 (PDT)
Message-ID: <4176AACA.3000206@mvista.com>
Date: Wed, 20 Oct 2004 11:13:30 -0700
From: Manish Lachwani <mlachwani@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Manish Lachwani <mlachwani@mvista.com>
Cc: Thomas Koeller <thomas.koeller@baslerweb.com>,
	linux-mips@linux-mips.org
Subject: Re: yosemite interrupt setup
References: <200410201952.29205.thomas.koeller@baslerweb.com> <4176A855.1000907@mvista.com>
In-Reply-To: <4176A855.1000907@mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <mlachwani@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6135
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlachwani@mvista.com
Precedence: bulk
X-list: linux-mips

Manish Lachwani wrote:

> Thomas Koeller wrote:
>
>> Hi Manish,
>>
>> may I ask you to help me with this:
>>
>> I am currently analyzing the yosemite interrupt handling
>> code. So far I have not been able to find the point
>> where the association between a particular external or
>> message interrupt and its vector is established. It seems
>> that the corresponding OCD address definitions from
>> asm-mips/titan_dep.h, such as RM9000x2_OCD_INTPIN0, are
>> not used anywhere in the code. I guess the kernel does
>> not rely on PMON having set up this before, or does it?
>>
>> thanks,
>> Thomas
>>
>>  
>>
> Hi Thomas
>
> As far as I remember, the message interrupts can be invoked by writing 
> to the INTMSG register. Are you referring to the Hypertransport 
> section or the ethernet section? No, PMON does not do any interrupt 
> related setup. All that is done in Linux.
>
> For example, if you look at the titan ge driver, there is a section:
>
>     /*
>      * Enable the Interrupts for Tx and Rx
>      */
>     reg_data1 = TITAN_GE_READ(TITAN_GE_INTR_XDMA_IE);
>
>     if (port_num == 0) {
>         reg_data1 |= 0x3;
> #ifdef CONFIG_SMP
>         TITAN_GE_WRITE(0x0038, 0x003);
> #else
>         TITAN_GE_WRITE(0x0038, 0x303);
> #endif
>     }
>
>     if (port_num == 1) {
>         reg_data1 |= 0x300;
>     }
>
>     TITAN_GE_WRITE(TITAN_GE_INTR_XDMA_IE, reg_data1);
>     TITAN_GE_WRITE(0x003c, 0x300);
>
>     if (config_done == 0) {
>         TITAN_GE_WRITE(0x0024, 0x04000024);    /* IRQ vector */
>         TITAN_GE_WRITE(0x0020, 0x000fb000);    /* INTMSG base */
>     }
>
>
> Here, 0xfb000020 is the INTMSG register. And 0xfb000024 is the 
> Interrupt Vector register.
> AFAIK, the IRQ vector is 8 bits with the top three bits signifying the 
> interrupt number and the bottom three bits indicates the 32 interrupt 
> status bits. So, essentially there are 256 message
> interrupts.
>
> Let me know if this helps or if there is something specific ...
>
> Thanks
> Manish Lachwani
>
>
>
>
>
Hi Thomas

Let me correct myself: 0xfe000020 is the INTMSG base register and 
0xfe000024 is the Interrupt Vector register (for the ethernet block). 
The actual INTMSG register resides in 0xfb000a00. Another example is 
arch/mips/pmc-sierra/yosemite/smp.c where an interrupt is generated by 
writing a vector to the INTMSG register:

 *(volatile uint32_t *)(0xfb000a00) = 0x00610002;

Thanks
Manish Lachwani
