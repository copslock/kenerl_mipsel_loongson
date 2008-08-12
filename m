Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Aug 2008 10:56:14 +0100 (BST)
Received: from aux-209-217-49-36.oklahoma.net ([209.217.49.36]:17166 "EHLO
	proteus.paralogos.com") by ftp.linux-mips.org with ESMTP
	id S20030019AbYHLJ4G (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 12 Aug 2008 10:56:06 +0100
Received: from [127.0.0.1] ([217.109.65.213])
	by proteus.paralogos.com (8.9.3/8.9.3) with ESMTP id FAA13209;
	Tue, 12 Aug 2008 05:27:17 -0500
Message-ID: <48A15E97.1070207@paralogos.com>
Date:	Tue, 12 Aug 2008 11:57:43 +0200
From:	"Kevin D. Kissell" <kevink@paralogos.com>
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
MIME-Version: 1.0
To:	David VomLehn <dvomlehn@cisco.com>
CC:	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: Anyone noticed that there are a lot of cache flushes after kunmap/kunmap_atomic
 is called?
References: <489A5975.1000401@cisco.com>
In-Reply-To: <489A5975.1000401@cisco.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kevink@paralogos.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20175
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@paralogos.com
Precedence: bulk
X-list: linux-mips

I remember dealing with analgous situations in System V many many years 
ago.  If the cache flushes are virtual, then either there must be 
bullet-proof protection (hardware or software) against virtual aliasing, 
or they must be flushed on deallocation, before the mapping is 
destroyed.  The good news is that, provided that DMA buffer management 
is done correctly, one should be able to use hit-invalidate instead of 
hit-writeback-invalidate on the deallocated pages.  That won't save that 
many CPU cycles, but it will save some number of memory cycles and 
milliwatts.

          Regards,

          Kevin K.

David VomLehn wrote:
> On the MIPS processor, cache flushing is done based on virtual 
> addresses. However, in the Linux kernel, there are a lot of places 
> where memory is mapped with kmap or kmap_atomic, then unmapped with 
> the corresponding kunmap or kunmap_atomic and only *then* is the cache 
> flushed. In other words, we only flush the cache after we have dropped 
> the mapping of memory into a virtual address. I think this is 
> generally wrong.
>
> This may really only affect those of us who have enabled high memory, 
> but it's pretty prevalent in kernel code. We noted this before, but 
> have apparently just been bitten by it. Is it just me or is there a 
> fairly widespread problem for processors that flush the cache using 
> virtual addresses?
>
>
>
>
>     - - - - -                              
> Cisco                            - - - - -         This e-mail and any 
> attachments may contain information which is confidential, 
> proprietary, privileged or otherwise protected by law. The information 
> is solely intended for the named addressee (or a person responsible 
> for delivering it to the addressee). If you are not the intended 
> recipient of this message, you are not authorized to read, print, 
> retain, copy or disseminate this message or any part of it. If you 
> have received this e-mail in error, please notify the sender 
> immediately by return e-mail and delete it from your computer.
>
>
>
