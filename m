Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Aug 2008 15:42:08 +0100 (BST)
Received: from mms1.broadcom.com ([216.31.210.17]:265 "EHLO mms1.broadcom.com")
	by ftp.linux-mips.org with ESMTP id S28579059AbYHHOl7 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 8 Aug 2008 15:41:59 +0100
Received: from [10.11.16.99] by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.3.2)); Fri, 08 Aug 2008 07:41:43 -0700
X-Server-Uuid: 02CED230-5797-4B57-9875-D5D2FEE4708A
Received: by mail-irva-10.broadcom.com (Postfix, from userid 47) id
 0C49A2B1; Fri, 8 Aug 2008 07:41:43 -0700 (PDT)
Received: from mail-irva-8.broadcom.com (mail-irva-8 [10.11.18.52]) by
 mail-irva-10.broadcom.com (Postfix) with ESMTP id EBA1F2B0; Fri, 8 Aug
 2008 07:41:42 -0700 (PDT)
Received: from mail-irva-13.broadcom.com (mail-irva-13.broadcom.com
 [10.11.16.103]) by mail-irva-8.broadcom.com (MOS 3.7.5a-GA) with ESMTP
 id HBH95486; Fri, 8 Aug 2008 07:41:42 -0700 (PDT)
Received: from [10.28.6.13] (lab-mhtb-013.ne.broadcom.com [10.28.6.13])
 by mail-irva-13.broadcom.com (Postfix) with ESMTP id 47DD274D00; Fri, 8
 Aug 2008 07:41:41 -0700 (PDT)
Subject: Re: Anyone noticed that there are a lot of cache flushes after
 kunmap/kunmap_atomic is called?
From:	"Jon Fraser" <jfraser@broadcom.com>
Reply-to: jfraser@broadcom.com
To:	"Ralf Baechle" <ralf@linux-mips.org>
cc:	"David VomLehn" <dvomlehn@cisco.com>,
	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
In-Reply-To: <20080808082404.GA27519@linux-mips.org>
References: <489A5975.1000401@cisco.com>
 <20080808082404.GA27519@linux-mips.org>
Organization: Broadcom
Date:	Fri, 08 Aug 2008 10:41:39 -0400
Message-ID: <1218206499.20791.152.camel@chaos.ne.broadcom.com>
MIME-Version: 1.0
X-Mailer: Evolution 2.12.3 (2.12.3-3.fc8)
X-WSS-ID: 648284AD4E0109962554-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-Path: <jfraser@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20157
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jfraser@broadcom.com
Precedence: bulk
X-list: linux-mips

David,

  I'm battling this now.  Our mips 24k has a virtually indexed cache.
We're definitely seeing issues where the cache hasn't been flushed
for highmem pages.  I thought I had this fixed, but I'm still seeing
some problems.

Jon


On Fri, 2008-08-08 at 09:24 +0100, Ralf Baechle wrote:
> On Wed, Aug 06, 2008 at 07:09:57PM -0700, David VomLehn wrote:
> 
> > On the MIPS processor, cache flushing is done based on virtual addresses. 
> > However, in the Linux kernel, there are a lot of places where memory is 
> > mapped with kmap or kmap_atomic, then unmapped with the corresponding 
> > kunmap or kunmap_atomic and only *then* is the cache flushed. In other 
> > words, we only flush the cache after we have dropped the mapping of 
> > memory into a virtual address. I think this is generally wrong.
> >
> > This may really only affect those of us who have enabled high memory, but 
> > it's pretty prevalent in kernel code. We noted this before, but have 
> > apparently just been bitten by it. Is it just me or is there a fairly 
> > widespread problem for processors that flush the cache using virtual 
> > addresses?
> 
> Not all MIPS processors have virtually indexed caches; some have physically
> indexed caches or caches which behave effectivly like physically indexed
> and MIPS highmem only tries to support the latter kinds of caches.  Which
> means most of the cache flushes turn into nops anyway.
> 
>   Ralf
> 
> 
