Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4VMLsnC025909
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 31 May 2002 15:21:54 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4VMLsuk025908
	for linux-mips-outgoing; Fri, 31 May 2002 15:21:54 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from broadon.com (gw2.routefree.net [209.21.47.227])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4VMLnnC025881
	for <linux-mips@oss.sgi.com>; Fri, 31 May 2002 15:21:49 -0700
Received: from osprey.routefree.com ([10.0.0.30] helo=broadon.com)
	by broadon.com with esmtp (BroadOn)
	id 17DunC-0002Nf-00; Fri, 31 May 2002 22:22:42 +0000
Message-ID: <3CF7F7B1.50300@broadon.com>
Date: Fri, 31 May 2002 15:22:41 -0700
From: Raymond Lo <lo@broadon.com>
Organization: BroadOn Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: virtual coherency issues with 4Kc ? 
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I'm evaluting the MIPS 4Kc core.   One thing I'm trying to find out is 
how does linux deal with virtual aliasing in the cache for 4Kc.  

The cache of 4Kc is virtually-indexed and it has no hardware support to 
suppress virtual aliasing.   The cachetlb.txt under linux/Documentation 
indicates that two things need to be done in software to handle virtual 
aliasing in D-cache.

The first is to handle virtual aliasing in user address spaces.  Shared 
pages are mmaped at virtual addresses that are multiples of the cache 
size.   That has already been taked care of in  include/asm-mips/shmparam.h.

The second is to handle virtual aliasing between kernel virtual address 
space and user virtual address space by providing a number of functions 
to flush the cache at various points in the kernel.   The old interface 
is flush_page_to_ram.   The new ones are
  copy_user_page,
  clear_user_page,
  flush_dcache_page.

I'm surprised to find out that flush_dcache_page is a macro defined to 
be  do {} while (0) in linux/asm-mips/pgtable.h.  The source code I 
looked is the web CVS on oss.sgi.com and 2.4.18.

Apparently the necessary flushing hasn't been done from the mm and fs 
code for any MIPS port.  I know this is not necessary for R4000 with 
virtual coherency execptions.     I don't understand why it can be 
skipped for 4Kc.   Can anybody shine some light on the subject?

 -Raymond

 
P.S.   The link http://oss.sgi.com/mips/archive/ is stale.  
