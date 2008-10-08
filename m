Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Oct 2008 17:39:48 +0100 (BST)
Received: from sj-iport-6.cisco.com ([171.71.176.117]:22149 "EHLO
	sj-iport-6.cisco.com") by ftp.linux-mips.org with ESMTP
	id S20953984AbYJHQjm (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 8 Oct 2008 17:39:42 +0100
X-IronPort-AV: E=Sophos;i="4.33,379,1220227200"; 
   d="scan'208";a="171221113"
Received: from sj-dkim-1.cisco.com ([171.71.179.21])
  by sj-iport-6.cisco.com with ESMTP; 08 Oct 2008 16:39:34 +0000
Received: from sj-core-2.cisco.com (sj-core-2.cisco.com [171.71.177.254])
	by sj-dkim-1.cisco.com (8.12.11/8.12.11) with ESMTP id m98GdWW4001218
	for <linux-mips@linux-mips.org>; Wed, 8 Oct 2008 09:39:32 -0700
Received: from sausatlsmtp2.sciatl.com ([192.133.217.159])
	by sj-core-2.cisco.com (8.13.8/8.13.8) with ESMTP id m98GdWQq012746
	for <linux-mips@linux-mips.org>; Wed, 8 Oct 2008 16:39:32 GMT
Received: from default.com ([192.133.217.159]) by sausatlsmtp2.sciatl.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 8 Oct 2008 12:39:31 -0400
Received: from sausatlbhs02.corp.sa.net ([192.133.216.42]) by sausatlsmtp2.sciatl.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 8 Oct 2008 12:39:30 -0400
Received: from CUPLXSUNDISM01.corp.sa.net ([64.101.21.60]) by sausatlbhs02.corp.sa.net with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 8 Oct 2008 12:39:29 -0400
Message-ID: <48ECE240.5050306@sciatl.com>
Date:	Wed, 08 Oct 2008 09:39:28 -0700
From:	C Michael Sundius <Michael.sundius@sciatl.com>
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org, luigi.mantellini.ml@gmail.com,
	msundius@sundius.com
Subject: Re: Huge buffer allocation: best place
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Oct 2008 16:39:29.0845 (UTC) FILETIME=[6F5AA650:01C92964]
X-ST-MF-Message-Resent:	10/8/2008 12:39
Authentication-Results:	sj-dkim-1; header.From=Michael.sundius@sciatl.com; dkim=neutral
Return-Path: <michael.sundius@sciatl.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20707
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Michael.sundius@sciatl.com
Precedence: bulk
X-list: linux-mips

Luigi 'Comio' Mantellini Wrote:

 > I need to allocate a huge contiguous buffer (~6MByte) shared with a 
secondary cpu
 > (a packet processor).  Which is the best place and the best way to do 
this?

 >
 > The main problem is that using a simple kmalloc at module init time 
there isn't sufficient
 > contiguous memory to cover the request. I should use (I suppose) the 
alloc_bootmem_*
 > macros but I'm not sure where is the best place to reserve my memory. 
For now I defined
 > a global bad huge vector... but I'm not happy for this solution...


I have seen a similar need and allocate driver buffers from the bootmem 
allocator, however
if you use Highmem you might prefer to use memory in high memory since 
the low memory
is limited. This presents a problem since the bootmem allocator does not 
manage memory
in the high memory zone.

I am currently working on a extremely simple allocation method for 
allocating large driver buffers
early (say after paging_init() and sparse_init() but before mem_init() ) 
for exactly this
purpose.

I'm wondering if anyone else out there has run into these problems and 
how they solved them.
up to now, we have blindly carved off a huge chunk of the highmemory and 
required each
driver to allocate the driver memory resource at compile time. (via a 
big ugly struct with lots of
magic numbers the drivers map (kmap) these memory areas in separately). 
This error prone a best and
is problematic since each version of our box has different resource 
needs (and we want just one
 kernel). Thus the need for runtime allocation of such resources.

Luigi, are you running w/ highmem enabled? if not I suggest just using 
the bootmem allocator.
we call a function called platform_alloc_bootmem() which is in our 
platform specific code, it is
called just after (or at the end of) the bootmem_init() function in the 
setup.c (after they reserve
space for the initrd and kernel).

there is another function called resource_init() which I think could be 
a good place for you to
make a call to some platform_specific resource allocation function.
(one other question: is any of that resource --from resrouce.c-- used in 
the mips code?)

Mike



     - - - - -                              Cisco                            - - - - -         
This e-mail and any attachments may contain information which is confidential, 
proprietary, privileged or otherwise protected by law. The information is solely 
intended for the named addressee (or a person responsible for delivering it to 
the addressee). If you are not the intended recipient of this message, you are 
not authorized to read, print, retain, copy or disseminate this message or any 
part of it. If you have received this e-mail in error, please notify the sender 
immediately by return e-mail and delete it from your computer.
