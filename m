Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Dec 2005 11:35:13 +0000 (GMT)
Received: from rtsoft2.corbina.net ([85.21.88.2]:25239 "HELO
	mail.dev.rtsoft.ru") by ftp.linux-mips.org with SMTP
	id S8133648AbVLELeS (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 5 Dec 2005 11:34:18 +0000
Received: (qmail 16327 invoked from network); 5 Dec 2005 11:33:45 -0000
Received: from wasted.dev.rtsoft.ru (HELO ?192.168.1.248?) (192.168.1.248)
  by mail.dev.rtsoft.ru with SMTP; 5 Dec 2005 11:33:45 -0000
Message-ID: <43942625.2070609@ru.mvista.com>
Date:	Mon, 05 Dec 2005 14:36:05 +0300
From:	Sergei Shtylylov <sshtylyov@ru.mvista.com>
Organization: MostaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	David Sanchez <david.sanchez@lexbox.fr>,
	Linux MIPS Development <linux-mips@linux-mips.org>
Subject: Re: Au1550 system bus masters issue
References: <17AB476A04B7C842887E0EB1F268111E0271B7@xpserver.intra.lexbox.org>
In-Reply-To: <17AB476A04B7C842887E0EB1F268111E0271B7@xpserver.intra.lexbox.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9593
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

David Sanchez wrote:

> I notice the following issue in the specification update (v31420) of the
> au1550:
> 
> "System bus masters (USB host, PCI, MAC0, MAC1, DDMA) may receive stale
> data.
> 
> Description
> -----------
> System bus masters (USB host controller, PCI controller, MAC0, MAC1,
> DDMA controller), when performing
> coherent reads, may incorrectly receive stale data from memory instead
> of valid modified data from the Au1
> data cache. If the request for data arrives within a 3-clock window
> prior to the cache line castout to memory,
> the cache snoop response is incorrect and stale data is retrieved from
> memory instead of the correct data from
> the cache. The cache line castout then completes, and memory is updated.
> Cache/memory data is not corrupted, but the specific bus read in not
> valid.
> 
> Affected Step
> -------------
> AA
> 
> Workaround
> ----------
> Do not enable cacheable master reads if the core modifies data in cache.
> 
> Status
> ------
> Not Fixed"
> 
> Does somebody known if the linux kernel 2.6.10 integrates this
> workaround ?

    Mainly as CONFIG_DMA_NONCOHERENT defined. USB OHCI and PCI still have
coherency enabled but as the cache hits prone to errata shouldn't happen due 
to the CONFIG_DMA_NONCOHERENT, it's probably not a problem (enabling coherency 
in Ethernet driver however makes the kernel non-bootable. USB host controller 
(and probably not only it, I'm too lazy to re-check ;-) is still prone to 
other errata on stepping AB though, see this thread:

http://www.linux-mips.org/archives/linux-mips/2005-11/msg00137.html

I'm gonna rework the patch and resubmit.

> Thanks

WBR, Sergei
