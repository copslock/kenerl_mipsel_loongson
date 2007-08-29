Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Aug 2007 05:04:16 +0100 (BST)
Received: from smtp1.dnsmadeeasy.com ([205.234.170.144]:18856 "EHLO
	smtp1.dnsmadeeasy.com") by ftp.linux-mips.org with ESMTP
	id S20021437AbXH2EEG (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 29 Aug 2007 05:04:06 +0100
Received: from smtp1.dnsmadeeasy.com (localhost [127.0.0.1])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP id 6941B309D93;
	Wed, 29 Aug 2007 04:04:00 +0000 (UTC)
X-Authenticated-Name: js.dnsmadeeasy
X-Transit-System: In case of SPAM please contact abuse@dnsmadeeasy.com
Received: from avtrex.com (unknown [67.116.42.147])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP;
	Wed, 29 Aug 2007 04:04:00 +0000 (UTC)
Received: from [192.168.7.235] ([192.168.7.235]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 28 Aug 2007 21:03:58 -0700
Message-ID: <46D4F02E.7090800@avtrex.com>
Date:	Tue, 28 Aug 2007 21:03:58 -0700
From:	David Daney <ddaney@avtrex.com>
User-Agent: Thunderbird 1.5.0.12 (X11/20070719)
MIME-Version: 1.0
To:	YH Lin <YH_Lin@sdesigns.com>
Cc:	"Johannes P. Schmidt" <jschmidt@avtrex.com>,
	Steve Francis <sfrancis@avtrex.com>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: O_DIRECT file access and cache aliasing...
References: <5DF100B598199744B111FCEA5222E78A02826C5D@sigma-exch1.sdesigns.com>
In-Reply-To: <5DF100B598199744B111FCEA5222E78A02826C5D@sigma-exch1.sdesigns.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Aug 2007 04:03:58.0799 (UTC) FILETIME=[A03B75F0:01C7E9F1]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16307
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

YH Lin wrote:
> Hi There,
>
> There's system call "cacheflush" which is specific to MIPS Linux for
> flushing cache in the user level.
>
> $ man cacheflush
>
> should be able to give out more information.
>   
Yes, we know of the cacheflush system call, it was one of the tools we 
used to diagnose the cache aliasing defect.

Ideally the kernel we are using (2.6.15 + vendor BSP) would present 
standard Linux semantics.  That way we would not have to conditionally 
sprinkle cacheflush calls throughout out code to achieve the correct 
behavior obtained on other systems.

As Atsushi Nemoto noted in the other message, the problem has probably 
been corrected in the kernel mainline.  Perhaps an upgrade is in order.

Thanks,
David Daney

> Regards,
> YH Lin
>
> -----Original Message-----
> From: linux-mips-bounce@linux-mips.org
> [mailto:linux-mips-bounce@linux-mips.org] On Behalf Of David Daney
> Sent: Tuesday, August 28, 2007 6:04 PM
> To: linux-mips@linux-mips.org
> Cc: Johannes Schmidt; Steve Francis
> Subject: O_DIRECT file access and cache aliasing...
>
> We have a system based on a Sigam Designs SMP8634 processor (MIPS 4Kec).
>
>   The caches are reported as:
>
> Primary instruction cache 16kB, physically tagged, 2-way, linesize 16
> bytes.
> Primary data cache 16kB, 2-way, linesize 16 bytes.
>
> Configured with CONFIG_DMA_NONCOHERENT.
>
> When we write files that were opened with O_DIRECT set, we observe that 
> there are many 16 byte chunks of data in the files that contain all 
> zeros instead of the correct data.
>
> My understanding is that the cache is virtually indexed.  So I think 
> what is happening is that when data is written to memory by a user 
> application that does an O_DIRECT write, the IDE driver is given a list 
> of pages to transfer to the disk.  The driver then does a 
> dma_cache_wback() on the KSEG0 address of the pages before initiating 
> the DMA operation.  Since the KSEG0 address and the USEG address of the 
> physical memory are different, the data is never flushed to memory 
> resulting in incorrect data being written to disk.
>
> Two questions:
>
> 1) Does this analysis seem plausible?
>
> 2) How do I fix it given that I cannot change the hardware?
>
> Several possibilities come to mind:
>
> A) Don't use O_DIRECT mode.
>
> B) Hack up sys_read and sys_write to flush the USEG addresses when 
> CONFIG_DMA_NONCOHERENT *and* O_DIRECT are in effect.
>
> Any helpful advice would be welcome,
> David Daney
>
>
>
>   
