Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Aug 2007 02:04:45 +0100 (BST)
Received: from smtp1.dnsmadeeasy.com ([205.234.170.144]:62699 "EHLO
	smtp1.dnsmadeeasy.com") by ftp.linux-mips.org with ESMTP
	id S20021921AbXH2BEg (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 29 Aug 2007 02:04:36 +0100
Received: from smtp1.dnsmadeeasy.com (localhost [127.0.0.1])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP id 55C6E30AAF7
	for <linux-mips@linux-mips.org>; Wed, 29 Aug 2007 01:04:48 +0000 (UTC)
X-Authenticated-Name: js.dnsmadeeasy
X-Transit-System: In case of SPAM please contact abuse@dnsmadeeasy.com
Received: from avtrex.com (unknown [67.116.42.147])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP
	for <linux-mips@linux-mips.org>; Wed, 29 Aug 2007 01:04:48 +0000 (UTC)
Received: from [192.168.7.26] ([192.168.7.26]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 28 Aug 2007 18:04:28 -0700
Message-ID: <46D4C61C.6010008@avtrex.com>
Date:	Tue, 28 Aug 2007 18:04:28 -0700
From:	David Daney <ddaney@avtrex.com>
User-Agent: Thunderbird 1.5.0.12 (X11/20070719)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Cc:	Johannes Schmidt <jschmidt@avtrex.com>,
	Steve Francis <sfrancis@avtrex.com>
Subject: O_DIRECT file access and cache aliasing...
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Aug 2007 01:04:28.0904 (UTC) FILETIME=[8CDFE680:01C7E9D8]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16304
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

We have a system based on a Sigam Designs SMP8634 processor (MIPS 4Kec). 
  The caches are reported as:

Primary instruction cache 16kB, physically tagged, 2-way, linesize 16 bytes.
Primary data cache 16kB, 2-way, linesize 16 bytes.

Configured with CONFIG_DMA_NONCOHERENT.

When we write files that were opened with O_DIRECT set, we observe that 
there are many 16 byte chunks of data in the files that contain all 
zeros instead of the correct data.

My understanding is that the cache is virtually indexed.  So I think 
what is happening is that when data is written to memory by a user 
application that does an O_DIRECT write, the IDE driver is given a list 
of pages to transfer to the disk.  The driver then does a 
dma_cache_wback() on the KSEG0 address of the pages before initiating 
the DMA operation.  Since the KSEG0 address and the USEG address of the 
physical memory are different, the data is never flushed to memory 
resulting in incorrect data being written to disk.

Two questions:

1) Does this analysis seem plausible?

2) How do I fix it given that I cannot change the hardware?

Several possibilities come to mind:

A) Don't use O_DIRECT mode.

B) Hack up sys_read and sys_write to flush the USEG addresses when 
CONFIG_DMA_NONCOHERENT *and* O_DIRECT are in effect.

Any helpful advice would be welcome,
David Daney
