Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Sep 2006 02:55:46 +0100 (BST)
Received: from mms3.broadcom.com ([216.31.210.19]:8452 "EHLO MMS3.broadcom.com")
	by ftp.linux-mips.org with ESMTP id S20038996AbWI0Bzo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 27 Sep 2006 02:55:44 +0100
Received: from 10.10.64.154 by MMS3.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.2.2)); Tue, 26 Sep 2006 18:55:16 -0700
X-Server-Uuid: 450F6D01-B290-425C-84F8-E170B39A25C9
Received: by mail-irva-10.broadcom.com (Postfix, from userid 47) id
 3BA942B1; Tue, 26 Sep 2006 18:55:16 -0700 (PDT)
Received: from mail-irva-8.broadcom.com (mail-irva-8 [10.10.64.221]) by
 mail-irva-10.broadcom.com (Postfix) with ESMTP id 579ED2B3; Tue, 26 Sep
 2006 18:55:15 -0700 (PDT)
Received: from mail-sj1-12.sj.broadcom.com (mail-sj1-12.sj.broadcom.com
 [10.16.128.215]) by mail-irva-8.broadcom.com (MOS 3.7.5a-GA) with ESMTP
 id EFY52268; Tue, 26 Sep 2006 18:54:42 -0700 (PDT)
Received: from NT-SJCA-0750.brcm.ad.broadcom.com (nt-sjca-0750
 [10.16.192.220]) by mail-sj1-12.sj.broadcom.com (Postfix) with ESMTP id
 509DD20501; Tue, 26 Sep 2006 18:54:42 -0700 (PDT)
Received: from NT-SJCA-0752.brcm.ad.broadcom.com ([10.16.192.222]) by
 NT-SJCA-0750.brcm.ad.broadcom.com with Microsoft
 SMTPSVC(6.0.3790.1830); Tue, 26 Sep 2006 18:54:42 -0700
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: [MIPS] SB1: Build fix: delete initialization of
 flush_icache_page pointer.
Date:	Tue, 26 Sep 2006 18:54:40 -0700
Message-ID: <710F16C36810444CA2F5821E5EAB7F230A0E45@NT-SJCA-0752.brcm.ad.broadcom.com>
In-Reply-To: <20060926.183946.49857108.nemoto@toshiba-tops.co.jp>
Thread-Topic: [MIPS] SB1: Build fix: delete initialization of
 flush_icache_page pointer.
Thread-Index: AcbhT7ypS3Njh6HmQ7+E9jeQQjaFlAAhMObQ
From:	"Manoj Ekbote" <manoje@broadcom.com>
To:	"Atsushi Nemoto" <anemo@mba.ocn.ne.jp>
cc:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	"Mark E Mason" <mark.e.mason@broadcom.com>
X-OriginalArrivalTime: 27 Sep 2006 01:54:42.0152 (UTC)
 FILETIME=[E61D0E80:01C6E1D7]
X-TMWD-Spam-Summary: TS=20060927015519; SEV=2.0.2; DFV=A2006092610;
 IFV=2.0.4,4.0-8; RPD=4.00.0004; ENG=IBF;
 RPDID=303030312E30413031303230352E34353139443745442E303034352D412D;
 CAT=NONE; CON=NONE
X-MMS-Spam-Filter-ID: A2006092610_4.00.0004_4.0-8
X-WSS-ID: 6907058E2304388638-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-Path: <manoje@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12689
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manoje@broadcom.com
Precedence: bulk
X-list: linux-mips

Hi,

I tried the patch that you pointed to and UP kernel boots fine. Looks
like that was a icache and dcache coherency problem now that there is no
flush_icache_page implementation.

The SMP kernel still has trouble.Turning on the first printk in fault.c
makes it work..which is interesting.
I added a __sb1_flush_icache_range call with dcache invalidation..still
no help. I don't see a SIGSEGV message now.The kernel hangs with no
response to keystrokes and the soft lockup detect error shows up after
sometime.

Oh, inserting flush_icache_page caused the kernel to panic. I also see
that __flush_icache_page is not used anywhere. Any future use?

Thx.

>-----Original Message-----
>From: Atsushi Nemoto [mailto:anemo@mba.ocn.ne.jp] 
>Sent: Tuesday, September 26, 2006 2:40 AM
>To: Manoj Ekbote
>Cc: Mark E Mason; linux-mips@linux-mips.org; 
>ralf@linux-mips.org; ths@networkno.de
>Subject: Re: [MIPS] SB1: Build fix: delete initialization of 
>flush_icache_page pointer.
>
>On Mon, 25 Sep 2006 20:05:59 -0700, "Manoj Ekbote" 
><manoje@broadcom.com> wrote:
>> The latest tip still has problems with booting on Broadcom boards.
>> I turned on a couple of printk's in the page fault handler and I see 
>> the following messages:
>...
>> It looks like a cache corruption issue.  Did the removal of 
>> flush_icache_page cause this?
>
>Yes perhaps.  But flush_icache_page() itself is obsolete API 
>and should be gone (see Documentation/cachetlb.txt).  So there 
>should be fault in somewhere else.
>
>I think 
>
>http://www.linux-mips.org/archives/linux-mips/2006-08/msg00184.html
>
>is still needed, but it seems not enough.
>
>If reverting flush_icache_page() worked, then you can debug more.
>
>1. kill part of local_sb1_flush_icache_page().
>
>If killing __sb1_writeback_inv_dcache_phys_range() part was 
>OK, then it would be dcache issue, if killing 
>drop_mmu_context() part was OK, then it would be icache issue.
>
>2. kill calls of flush_icache_page().
>
>If is used in only 3 places.
>
>mm/fremap.c:    flush_icache_page(vma, page);
>mm/memory.c:    flush_icache_page(vma, page);
>mm/memory.c:            flush_icache_page(vma, new_page);
>
>Finding which lines are required might help further investigation.
>
>
>Another possible approach might be trying c-r4k.c instead of c-sb1.c.
>
>If you wanted to debug with latest git tree, note that 
>include/asm-mips/hazard.h in current lmo git tree seems 
>broken.  The fix was already posted to this ML so hopefully we 
>can see in git tree soon...
>
>---
>Atsushi Nemoto
>
>
