Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Feb 2007 21:04:02 +0000 (GMT)
Received: from smtp1.dnsmadeeasy.com ([205.234.170.134]:59548 "EHLO
	smtp1.dnsmadeeasy.com") by ftp.linux-mips.org with ESMTP
	id S20039039AbXBWVDh (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 23 Feb 2007 21:03:37 +0000
Received: from smtp1.dnsmadeeasy.com (localhost [127.0.0.1])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP id 2FB73299BFD;
	Fri, 23 Feb 2007 16:02:59 -0500 (EST)
X-Authenticated-Name: js.dnsmadeeasy
X-Transit-System: In case of SPAM please contact abuse@dnsmadeeasy.com
Received: from avtrex.com (unknown [67.116.42.147])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP;
	Fri, 23 Feb 2007 16:02:59 -0500 (EST)
Received: from [192.168.7.26] ([192.168.7.26]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 23 Feb 2007 13:02:56 -0800
Message-ID: <45DF567F.9060200@avtrex.com>
Date:	Fri, 23 Feb 2007 13:02:55 -0800
From:	David Daney <ddaney@avtrex.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20070212)
MIME-Version: 1.0
To:	Marc St-Jean <Marc_St-Jean@pmc-sierra.com>
Cc:	Sergei Shtylyov <sshtylyov@ru.mvista.com>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH 2/5] mips: PMC MSP71xx mips common
References: <45DF5438.1040706@pmc-sierra.com>
In-Reply-To: <45DF5438.1040706@pmc-sierra.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Feb 2007 21:02:56.0383 (UTC) FILETIME=[FDD330F0:01C7578D]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14231
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

Marc St-Jean wrote:
> 
> Sergei Shtylyov wrote:
>> Hello.
>>
>> Marc St-Jean wrote:
>>
>>  > [PATCH 2/5] mips: PMC MSP71xx mips common
>>
>>  > Patch to add mips common support for the PMC-Sierra
>>  > MSP71xx devices.
>>
>>  > These 5 patches along with the previously posted serial patch
>>  > will boot the PMC-Sierra MSP7120 Residential Gateway board.
>>
>>  > Signed-off-by: Marc St-Jean <Marc_St-Jean@pmc-sierra.com>
>>
>>  > diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
>>  > index 5da6b0d..d512389 100644
>>  > --- a/arch/mips/Kconfig
>>  > +++ b/arch/mips/Kconfig
>> [...]
>>
>>  > +menu "Options for PMC-Sierra MSP chipsets"
>>  > +     depends on PMC_MSP
>>  > +
>>  > +config PMC_MSP_EMBEDDED_ROOTFS
>>  > +     bool "Root filesystem embedded in kernel image"
>>  > +     select MTD
>>  > +     select MTD_BLOCK
>>  > +     select MTD_PMC_MSP_RAMROOT
>>  > +     select MTD_RAM
>>  > +
>>
>>     Hm, why not just use initramfs?
> 
> I investigated this as part of an earlier thread.  Initramfs
> is not a read-only "ROM" fs but a compressed writable fs.
> Once expanded it will take more memory.
> 
> To lower memory usage for embedded usage of our devices we've
> added a method to embedded cramfs/squashfs file systems into
> the kernel image.
> 

Why not just run the cramfs/squashfs on a standard mdtblock device?

> I've made sure it was unobtrusive and that no linker script
> changes, etc. were required.
> 
> 
