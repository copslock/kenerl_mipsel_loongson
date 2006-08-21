Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Aug 2006 20:28:11 +0100 (BST)
Received: from mms2.broadcom.com ([216.31.210.18]:19463 "EHLO
	mms2.broadcom.com") by ftp.linux-mips.org with ESMTP
	id S20038592AbWHUT2J convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 21 Aug 2006 20:28:09 +0100
Received: from 10.10.64.154 by mms2.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.2.0)); Mon, 21 Aug 2006 12:27:50 -0700
X-Server-Uuid: D9EB6F12-1469-4C1C-87A2-5E4C0D6F9D06
Received: by mail-irva-10.broadcom.com (Postfix, from userid 47) id
 A82282AF; Mon, 21 Aug 2006 12:27:50 -0700 (PDT)
Received: from mail-irva-8.broadcom.com (mail-irva-8 [10.10.64.221]) by
 mail-irva-10.broadcom.com (Postfix) with ESMTP id 6C4252AF; Mon, 21 Aug
 2006 12:27:50 -0700 (PDT)
Received: from mail-sj1-12.sj.broadcom.com (mail-sj1-12.sj.broadcom.com
 [10.16.128.215]) by mail-irva-8.broadcom.com (MOS 3.7.5a-GA) with ESMTP
 id EDH07840; Mon, 21 Aug 2006 12:27:49 -0700 (PDT)
Received: from NT-SJCA-0751.brcm.ad.broadcom.com (nt-sjca-0751
 [10.16.192.221]) by mail-sj1-12.sj.broadcom.com (Postfix) with ESMTP id
 4426F20503; Mon, 21 Aug 2006 12:27:49 -0700 (PDT)
Received: from NT-SJCA-0752.brcm.ad.broadcom.com ([10.16.192.222]) by
 NT-SJCA-0751.brcm.ad.broadcom.com with Microsoft
 SMTPSVC(6.0.3790.1830); Mon, 21 Aug 2006 12:27:49 -0700
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: [MIPS] SB1: Build fix: delete initialization of
 flush_icache_page pointer.
Date:	Mon, 21 Aug 2006 12:27:47 -0700
Message-ID: <710F16C36810444CA2F5821E5EAB7F230A0465@NT-SJCA-0752.brcm.ad.broadcom.com>
In-Reply-To: <20060818.105105.41197512.nemoto@toshiba-tops.co.jp>
Thread-Topic: [MIPS] SB1: Build fix: delete initialization of
 flush_icache_page pointer.
Thread-Index: AcbCaOFEsOE5SkNVRZCUOrZgnvH0agC7oF4Q
From:	"Manoj Ekbote" <manoje@broadcom.com>
To:	"Atsushi Nemoto" <anemo@mba.ocn.ne.jp>,
	"Mark E Mason" <mark.e.mason@broadcom.com>
cc:	linux-mips@linux-mips.org, ralf@linux-mips.org, ths@networkno.de
X-OriginalArrivalTime: 21 Aug 2006 19:27:49.0188 (UTC)
 FILETIME=[E33CD840:01C6C557]
X-TMWD-Spam-Summary: SEV=1.1; DFV=A2006082110; IFV=2.0.6,4.0-7;
 RPD=4.00.0004;
 RPDID=303030312E30413031303230312E34344541303833352E303034352D412D;
 ENG=IBF; TS=20060821192753; CAT=NONE; CON=NONE;
X-MMS-Spam-Filter-ID: A2006082110_4.00.0004_2.0.6,4.0-7
X-WSS-ID: 68F4D6BC3881003089-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-Path: <manoje@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12390
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manoje@broadcom.com
Precedence: bulk
X-list: linux-mips

The patch doesn't help. The kernel hangs in the same fashion. 



>-----Original Message-----
>From: linux-mips-bounce@linux-mips.org 
>[mailto:linux-mips-bounce@linux-mips.org] On Behalf Of Atsushi Nemoto
>Sent: Thursday, August 17, 2006 6:51 PM
>To: Mark E Mason
>Cc: linux-mips@linux-mips.org; ralf@linux-mips.org; ths@networkno.de
>Subject: Re: [MIPS] SB1: Build fix: delete initialization of 
>flush_icache_page pointer.
>
>On Thu, 17 Aug 2006 14:20:07 -0700, "Mark E Mason" 
><mark.e.mason@broadcom.com> wrote:
>> The sb1_flash_icache_page change below breaks causes 1480 kernels to 
>> hang after freeing memory:
>
>Does this (untested) patch work for you?
>
>diff --git a/arch/mips/mm/c-sb1.c b/arch/mips/mm/c-sb1.c index 
>4bd9ad8..0f5691a 100644
>--- a/arch/mips/mm/c-sb1.c
>+++ b/arch/mips/mm/c-sb1.c
>@@ -253,6 +253,17 @@ void sb1___flush_cache_all(void)
> 	__attribute__((alias("local_sb1___flush_cache_all")));
> #endif
> 
>+static inline void local_sb1_flush_data_cache_page(void * addr) {
>+	__sb1_writeback_inv_dcache_range((unsigned long)addr,
>+					 (unsigned long)addr + 
>PAGE_SIZE); }
>+
>+static void sb1_flush_data_cache_page(unsigned long addr) {
>+	on_each_cpu(local_sb1_flush_data_cache_page, (void *) 
>addr, 1, 1); }
>+
> /*
>  * When flushing a range in the icache, we have to first writeback
>  * the dcache for the same range, so new ifetches will see 
>any @@ -527,8 +538,8 @@ #endif
> 	flush_cache_page = sb1_flush_cache_page;
> 
> 	flush_cache_sigtramp = sb1_flush_cache_sigtramp;
>-	local_flush_data_cache_page = (void *) sb1_nop;
>-	flush_data_cache_page = (void *) sb1_nop;
>+	local_flush_data_cache_page = local_sb1_flush_data_cache_page;
>+	flush_data_cache_page = sb1_flush_data_cache_page;
> 
> 	/* Full flush */
> 	__flush_cache_all = sb1___flush_cache_all;
>
>
>
