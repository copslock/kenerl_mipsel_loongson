Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Nov 2004 17:35:16 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:63986 "EHLO
	hermes.mvista.com") by linux-mips.org with ESMTP
	id <S8224897AbUKVRfL>; Mon, 22 Nov 2004 17:35:11 +0000
Received: from mvista.com (prometheus.mvista.com [10.0.0.139])
	by hermes.mvista.com (Postfix) with ESMTP
	id 78DEA1861C; Mon, 22 Nov 2004 09:35:08 -0800 (PST)
Message-ID: <41A2234C.8090809@mvista.com>
Date: Mon, 22 Nov 2004 09:35:08 -0800
From: Manish Lachwani <mlachwani@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Thomas Koeller <thomas.koeller@baslerweb.com>
Cc: linux-mips@linux-mips.org
Subject: Re: titan code question
References: <200411191623.14760.thomas.koeller@baslerweb.com>
In-Reply-To: <200411191623.14760.thomas.koeller@baslerweb.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <mlachwani@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6402
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlachwani@mvista.com
Precedence: bulk
X-list: linux-mips

Hi Thomas,

This makes sense. Basically, in Titan 1.0 and 1.1, there was no support 
for IP header alignment. As a results, for every incoming packet, there 
had to be an extra copy in the driver. This had to be somehow fixed in 
the chip. So, the chip designers were basically looking for some unused 
registers that can be used to indicate to the chip that IP header needs 
aligning. And the chip designers wanted to implement this framework by 
using minimal possible changes so that 1.2 can be released asap.

Hence, they used this register. I am not sure if this is even 
documented. However, this code has been written based on the feedback 
from the chip designers. If you dont use this code, the MAC subsystem of 
titan will stop aligning IP headers and you will need to implement the 
code in the driver to do the aligning.

Hope this clears things.

Thanks
Manish Lachwani


Thomas Koeller wrote:
> Hi Manish & Ralf,
> 
> the code below is from tian_ge.c:
> 
> 	/*
> 	 * This is the 1.2 revision of the chip. It has fix for the
> 	 * IP header alignment. Now, the IP header begins at an
> 	 * aligned address and this wont need an extra copy in the
> 	 * driver. This performance drawback existed in the previous
> 	 * versions of the silicon
> 	 */
> 	reg_data_1 = TITAN_GE_READ(0x103c + (port_num << 12));
> 	reg_data_1 |= 0x40000000;
> 	TITAN_GE_WRITE((0x103c + (port_num << 12)), reg_data_1);
> 
> 	reg_data_1 |= 0x04000000;
> 	TITAN_GE_WRITE((0x103c + (port_num << 12)), reg_data_1);
> 
> 	mdelay(5);
> 
> 	reg_data_1 &= ~(0x04000000);
> 	TITAN_GE_WRITE((0x103c + (port_num << 12)), reg_data_1);
> 
> 	mdelay(5);
> 
> 
> According to the RM9000 user manual, register 0x103c (and 0x203c
> and 0x303c), named TTPRI0, contains eight four-bit fields, each
> of which is a packet priority value. This would be used to find
> the priority for incoming packets.
> 
> Given the register description in the cpu manual, I cannot make
> any sense of the code above. Whoever did that, would you care to
> explain?
> 
> thanks,
> Thomas
