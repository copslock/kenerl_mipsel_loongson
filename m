Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Sep 2006 03:17:40 +0100 (BST)
Received: from mms3.broadcom.com ([216.31.210.19]:36366 "EHLO
	MMS3.broadcom.com") by ftp.linux-mips.org with ESMTP
	id S20039064AbWI1CRi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 28 Sep 2006 03:17:38 +0100
Received: from 10.10.64.154 by MMS3.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.2.2)); Wed, 27 Sep 2006 19:17:18 -0700
X-Server-Uuid: 450F6D01-B290-425C-84F8-E170B39A25C9
Received: by mail-irva-10.broadcom.com (Postfix, from userid 47) id
 854072AF; Wed, 27 Sep 2006 19:17:18 -0700 (PDT)
Received: from mail-irva-8.broadcom.com (mail-irva-8 [10.10.64.221]) by
 mail-irva-10.broadcom.com (Postfix) with ESMTP id 60BE92AE; Wed, 27 Sep
 2006 19:17:18 -0700 (PDT)
Received: from mail-sj1-12.sj.broadcom.com (mail-sj1-12.sj.broadcom.com
 [10.16.128.215]) by mail-irva-8.broadcom.com (MOS 3.7.5a-GA) with ESMTP
 id EGA70623; Wed, 27 Sep 2006 19:17:18 -0700 (PDT)
Received: from NT-SJCA-0751.brcm.ad.broadcom.com (nt-sjca-0751
 [10.16.192.221]) by mail-sj1-12.sj.broadcom.com (Postfix) with ESMTP id
 E3E0F20501; Wed, 27 Sep 2006 19:17:17 -0700 (PDT)
Received: from NT-SJCA-0752.brcm.ad.broadcom.com ([10.16.192.222]) by
 NT-SJCA-0751.brcm.ad.broadcom.com with Microsoft
 SMTPSVC(6.0.3790.1830); Wed, 27 Sep 2006 19:17:17 -0700
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: [MIPS] SB1: Build fix: delete initialization of
 flush_icache_page pointer.
Date:	Wed, 27 Sep 2006 19:17:16 -0700
Message-ID: <710F16C36810444CA2F5821E5EAB7F230A0E91@NT-SJCA-0752.brcm.ad.broadcom.com>
In-Reply-To: <20060927.235804.95064004.anemo@mba.ocn.ne.jp>
Thread-Topic: [MIPS] SB1: Build fix: delete initialization of
 flush_icache_page pointer.
Thread-Index: AcbiRRCpHPchlMG/QlKjBOnyukB+eAAXBrhw
From:	"Manoj Ekbote" <manoje@broadcom.com>
To:	"Atsushi Nemoto" <anemo@mba.ocn.ne.jp>
cc:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	"Mark E Mason" <mark.e.mason@broadcom.com>
X-OriginalArrivalTime: 28 Sep 2006 02:17:17.0729 (UTC)
 FILETIME=[38837110:01C6E2A4]
X-TMWD-Spam-Summary: TS=20060928021719; SEV=2.0.2; DFV=A2006092711;
 IFV=2.0.4,4.0-8; RPD=4.00.0004; ENG=IBF;
 RPDID=303030312E30413031303230332E34353142324538462E303033342D412D;
 CAT=NONE; CON=NONE
X-MMS-Spam-Filter-ID: A2006092711_4.00.0004_4.0-8
X-WSS-ID: 6905EF242304646491-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-Path: <manoje@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12704
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manoje@broadcom.com
Precedence: bulk
X-list: linux-mips


>On Tue, 26 Sep 2006 18:54:40 -0700, "Manoj Ekbote" 
><manoje@broadcom.com> wrote:
>> I tried the patch that you pointed to and UP kernel boots 
>fine. Looks 
>> like that was a icache and dcache coherency problem now that 
>there is 
>> no flush_icache_page implementation.
>
>Hmm ... so it might be a SMP kernel problem?
>
>> Oh, inserting flush_icache_page caused the kernel to panic. 
>I also see 
>> that __flush_icache_page is not used anywhere. Any future use?
>
>I think __flush_icache_page should go away.  Here is a patch.
>http://www.linux-mips.org/archives/linux-mips/2006-09/msg00003.html
>
>BTW, what you tried is something like this ?

I added a line that initializes the flush_icache_page pointer in
sb1_cache_init.
The below method worked. The SMP kernel boots fine now. Removing parts
of local_sb1_flush_icache_page doesn't help. It looks like
flush_icache_page in mm/memory.c:do_no_page is needed. Removing it will
fail the boot process.

I am wondering if people have booted the latest tree on non-Broadcom
boards...curious to know if the removal of flush_icache_page has
affected them.

Thanks.

>include/asm-mips/cacheflush.h:
>static inline void flush_icache_page(struct vm_area_struct *vma,
>	struct page *page)
>{
>	__flush_icache_page(vma, page);
>}
>
>If this caused panic, what is the message?
>
>---
>Atsushi Nemoto
>
>
