Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Nov 2007 16:10:21 +0000 (GMT)
Received: from smtp1.dnsmadeeasy.com ([205.234.170.144]:4825 "EHLO
	smtp1.dnsmadeeasy.com") by ftp.linux-mips.org with ESMTP
	id S20029619AbXKNQKM (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 14 Nov 2007 16:10:12 +0000
Received: from smtp1.dnsmadeeasy.com (localhost [127.0.0.1])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP id EC17130FF5A;
	Wed, 14 Nov 2007 16:10:08 +0000 (UTC)
X-Authenticated-Name: js.dnsmadeeasy
X-Transit-System: In case of SPAM please contact abuse@dnsmadeeasy.com
Received: from avtrex.com (unknown [67.116.42.147])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP;
	Wed, 14 Nov 2007 16:10:08 +0000 (UTC)
Received: from jennifer.localdomain ([192.168.7.223]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 14 Nov 2007 08:09:54 -0800
Message-ID: <473B1DD0.2090903@avtrex.com>
Date:	Wed, 14 Nov 2007 08:09:52 -0800
From:	David Daney <ddaney@avtrex.com>
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
MIME-Version: 1.0
To:	David Kuk <david.kuk@entone.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: smp8634 add memory at dram1
References: <473AB56B.2070107@entone.com>
In-Reply-To: <473AB56B.2070107@entone.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Nov 2007 16:09:55.0013 (UTC) FILETIME=[CB910750:01C826D8]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17502
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

David Kuk wrote:
> After study about the memory configuration of sigma smp8634, i found 
> some difficult to accomplish the task.
>
> so my question is if have two 128MB ram separately under dram0 and 
> dram1 controller, where dram0 for linux and dram1 for video decoding. 
> Now the situation is the memory for linux is not enough and video 
> decoding can not use all of it's 128MB at dram1, what we plan to do is 
> to share 64MB at dram1 to the linux kernel as high memory, and only 
> reserved 64MB at dram1 for the video decoding.
>
> first, in MIPS architecture, we found that the kseg0 and kseg1 are 
> mapped to 0x00000000-0x20000000, which include only dram0 controller, 
> so we wish to add the dram1 memory manually to the kernel using 
> function add_memory_region at setup.c , after booting up result the 
> warning that the memory larger than 512 need to configured the kernel 
> support high memory.
>
> then when we configure the kernel to support high memory at menu 
> configure, the kernel when booting up will remind us our CPU do not 
> support high memory due to cache aliases.
>
> Both way will lead the linux can not boot up normally, so what should 
> we do, is there any mis-understanding about the hardware 
> implementation or MIPS design?

I think your understanding of the 8634 is at least close to correct.

It may be possible (but I have not tried it yet) to use the remapping
registers to move dram1 into the first 512MB of the memory space.  If it
is possible, you would then have to modify the gbus access functions
accordingly.  Also the 8634 media drivers would probably have to be
changed as well.  I am not sure about the microcode for the media DSPs,
but if it is dependent on the mapping of the DRAM, then you would
probably have to get the vendor's help.

Let me know if you are successful.

Thanks,
David Daney
