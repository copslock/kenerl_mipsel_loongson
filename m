Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4V0u3nC010514
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 30 May 2002 17:56:03 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4V0u3ql010513
	for linux-mips-outgoing; Thu, 30 May 2002 17:56:03 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mail.ict.ac.cn ([159.226.39.4])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4V0tunC010509
	for <linux-mips@oss.sgi.com>; Thu, 30 May 2002 17:55:57 -0700
Message-Id: <200205310055.g4V0tunC010509@oss.sgi.com>
Received: (qmail 10240 invoked from network); 31 May 2002 00:48:18 -0000
Received: from unknown (HELO foxsen) (159.226.40.150)
  by 159.226.39.4 with SMTP; 31 May 2002 00:48:18 -0000
Date: Fri, 31 May 2002 8:56:47 +0800
From: "Zhang Fuxin" <fxzhang@ict.ac.cn>
To: William Jhun <wjhun@ayrnetworks.com>
CC: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: Re: Re: pcnet32.c bug?
X-mailer: Foxmail 4.1 [cn]
Mime-Version: 1.0
Content-Type: text/plain;
      charset="GB2312"
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by oss.sgi.com id g4V0tvnC010510
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

hi,
>> 
>> so,the problem is,can we use wback_inv instead of inv in pci_dma_sync_single
>> when the direction is FROMDEVICE? I don't think so,but that would mean many
>> current drivers are broken...
>
>If I understand this correctly, a writeback means only modified
>cachelines (i.e. data cache lines with a dirty bit, like 'W', set) will
>be written back to main memory.  Since the driver never actually writes
>to any of these buffers (and their contents are invalidated on the
>pci_map_single()), nothing should ever be written back to main memory.
>If this were not the case, you would surely see packet corruption as the
>stale cachelines from a re-used buffer would be written back. I tend not
>to think that it's just coincidence and that MIPS caches tend to be
>small...
Oh,yes,thank you.
>
>So, writeback-invalidate is not incorrect, but it's not efficient for
>all platforms. Ralf explained to me that some CPUs cannot do indexed
>invalidates separately from writebacks.
>
>I think all three (dma_cache_wback, dma_cache_wback_inv,
>dma_cache_inv) of these calls should be implemented for all CPUs and
>default to dma_cache_wback_inv() if not available. I can come up with a
>patch if people agree (that wback_inv is a suitable replacement for
>either _inv or _wback; MIPS-specific code than can be written to use
>whatever is most optimal if present on that architecture...
Why not? We have many different c-xxx.c for caches anyway.
>
>Thanks,
>Will

= = = = = = = = = = = = = = = = = = = =
			

Best Regards
---------------------------------------
Zhang Fuxin
System Architecture Lab
Institute of Computing Technology
Chinese Academy of Sciences,China
http://www.ict.ac.cn
 
			　　　　　　　　　2002-05-31
