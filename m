Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4VNxpnC003799
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 31 May 2002 16:59:51 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4VNxpQC003798
	for linux-mips-outgoing; Fri, 31 May 2002 16:59:51 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mx2.mips.com (mx2.mips.com [206.31.31.227])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4VNxhnC003793
	for <linux-mips@oss.sgi.com>; Fri, 31 May 2002 16:59:44 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.9.3/8.9.0) with ESMTP id RAA24616;
	Fri, 31 May 2002 17:01:12 -0700 (PDT)
Received: from grendel (grendel [192.168.236.16])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id RAA20950;
	Fri, 31 May 2002 17:01:13 -0700 (PDT)
Message-ID: <004101c20900$5a1f35c0$10eca8c0@grendel>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Raymond Lo" <lo@broadon.com>, <linux-mips@oss.sgi.com>
References: <3CF7F7B1.50300@broadon.com>
Subject: Re: virtual coherency issues with 4Kc ? 
Date: Sat, 1 Jun 2002 02:07:32 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Note that the cache organization of the 4Kc is configurable.
Virtual aliasing problems should only be possible if the cache
"way" size exceeds the page size used (4KB for Linux). A
maxed-out 4Kc can create a virtual coherency problem, 
but a 4Kc with e.g. 4-way set associative 16KB caches
should be exempt.  Since the cache configuration of a 4Kc
can be determined at boot time by the kernel, by reading
the config registers, those annoying cache flushes should
only really happen if the cache configuration is "at risk".

            Kevin K.

----- Original Message ----- 
From: "Raymond Lo" <lo@broadon.com>
To: <linux-mips@oss.sgi.com>
Sent: Saturday, June 01, 2002 12:22 AM
Subject: virtual coherency issues with 4Kc ? 


> I'm evaluting the MIPS 4Kc core.   One thing I'm trying to find out is 
> how does linux deal with virtual aliasing in the cache for 4Kc.  
> 
> The cache of 4Kc is virtually-indexed and it has no hardware support to 
> suppress virtual aliasing.   The cachetlb.txt under linux/Documentation 
> indicates that two things need to be done in software to handle virtual 
> aliasing in D-cache.
> 
> The first is to handle virtual aliasing in user address spaces.  Shared 
> pages are mmaped at virtual addresses that are multiples of the cache 
> size.   That has already been taked care of in  include/asm-mips/shmparam.h.
> 
> The second is to handle virtual aliasing between kernel virtual address 
> space and user virtual address space by providing a number of functions 
> to flush the cache at various points in the kernel.   The old interface 
> is flush_page_to_ram.   The new ones are
>   copy_user_page,
>   clear_user_page,
>   flush_dcache_page.
> 
> I'm surprised to find out that flush_dcache_page is a macro defined to 
> be  do {} while (0) in linux/asm-mips/pgtable.h.  The source code I 
> looked is the web CVS on oss.sgi.com and 2.4.18.
> 
> Apparently the necessary flushing hasn't been done from the mm and fs 
> code for any MIPS port.  I know this is not necessary for R4000 with 
> virtual coherency execptions.     I don't understand why it can be 
> skipped for 4Kc.   Can anybody shine some light on the subject?
> 
>  -Raymond
> 
>  
> P.S.   The link http://oss.sgi.com/mips/archive/ is stale.  
> 
> 
> 
> 
