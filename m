Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Sep 2006 04:06:26 +0100 (BST)
Received: from mms2.broadcom.com ([216.31.210.18]:21513 "EHLO
	mms2.broadcom.com") by ftp.linux-mips.org with ESMTP
	id S20038965AbWIZDGY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 26 Sep 2006 04:06:24 +0100
Received: from 10.10.64.154 by mms2.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.2.0)); Mon, 25 Sep 2006 20:06:03 -0700
X-Server-Uuid: D9EB6F12-1469-4C1C-87A2-5E4C0D6F9D06
Received: by mail-irva-10.broadcom.com (Postfix, from userid 47) id
 E31B22AF; Mon, 25 Sep 2006 20:06:02 -0700 (PDT)
Received: from mail-irva-8.broadcom.com (mail-irva-8 [10.10.64.221]) by
 mail-irva-10.broadcom.com (Postfix) with ESMTP id BD2402AE; Mon, 25 Sep
 2006 20:06:02 -0700 (PDT)
Received: from mail-sj1-12.sj.broadcom.com (mail-sj1-12.sj.broadcom.com
 [10.16.128.215]) by mail-irva-8.broadcom.com (MOS 3.7.5a-GA) with ESMTP
 id EFW39411; Mon, 25 Sep 2006 20:06:02 -0700 (PDT)
Received: from NT-SJCA-0750.brcm.ad.broadcom.com (nt-sjca-0750
 [10.16.192.220]) by mail-sj1-12.sj.broadcom.com (Postfix) with ESMTP id
 3856B20501; Mon, 25 Sep 2006 20:06:02 -0700 (PDT)
Received: from NT-SJCA-0752.brcm.ad.broadcom.com ([10.16.192.222]) by
 NT-SJCA-0750.brcm.ad.broadcom.com with Microsoft
 SMTPSVC(6.0.3790.1830); Mon, 25 Sep 2006 20:06:02 -0700
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: [MIPS] SB1: Build fix: delete initialization of
 flush_icache_page pointer.
Date:	Mon, 25 Sep 2006 20:05:59 -0700
Message-ID: <710F16C36810444CA2F5821E5EAB7F230A0DFA@NT-SJCA-0752.brcm.ad.broadcom.com>
In-Reply-To: <20060823.131627.75185523.nemoto@toshiba-tops.co.jp>
Thread-Topic: [MIPS] SB1: Build fix: delete initialization of
 flush_icache_page pointer.
Thread-Index: AcbGavG27legh5bGTYOZAKxXvmDrJgapYngA
From:	"Manoj Ekbote" <manoje@broadcom.com>
To:	"Atsushi Nemoto" <anemo@mba.ocn.ne.jp>
cc:	"Mark E Mason" <mark.e.mason@broadcom.com>,
	linux-mips@linux-mips.org, ralf@linux-mips.org, ths@networkno.de
X-OriginalArrivalTime: 26 Sep 2006 03:06:02.0001 (UTC)
 FILETIME=[B2B07010:01C6E118]
X-TMWD-Spam-Summary: SEV=1.1; DFV=A2006092510; IFV=2.0.6,4.0-7;
 RPD=4.00.0004;
 RPDID=303030312E30413031303230322E34353138393730422E303030432D412D;
 ENG=IBF; TS=20060926030604; CAT=NONE; CON=NONE;
X-MMS-Spam-Filter-ID: A2006092510_4.00.0004_2.0.6,4.0-7
X-WSS-ID: 690646913889709828-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-Path: <manoje@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12664
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manoje@broadcom.com
Precedence: bulk
X-list: linux-mips

Hello,

The latest tip still has problems with booting on Broadcom boards.
I turned on a couple of printk's in the page fault handler and I see the
following messages:

[4294669.578000] VFS: Mounted root (nfs filesystem).
[4294669.579000] Freeing unused kernel memory: 116k freed
[4294669.585000] Cpu0[init:1:0000000010000540:1:ffffffff80214a1c]
[4294669.589000] Cpu0[init:1:000000002ab01a30:1:ffffffff80214a1c]
[4294669.594000] Cpu0[init:1:000000002aaa8b00:0:000000002aaa8b00]
[4294669.595000] Cpu0[init:1:000000002aaa9364:0:000000002aaa9364]
[4294669.596000] Cpu0[init:1:000000002aab3200:0:000000002aab3200]
[4294669.600000] Cpu0[init:1:0000000000000004:0:000000002aab32f4]
[4294669.601000] do_page_fault() #2: sending SIGSEGV to init for invalid
read access from
[4294669.601000] 0000000000000004 (epc == 000000002aab32f4, ra ==
000000002aaa8cbc)
[4294669.602000] Cpu0[init:1:0000000000000004:0:000000002aab32f4]
[4294669.603000] do_page_fault() #2: sending SIGSEGV to init for invalid
read access from
[4294669.603000] 0000000000000004 (epc == 000000002aab32f4, ra ==
000000002aaa8cbc)
[4294669.604000] Cpu0[init:1:0000000000000004:0:000000002aab32f4]
[4294669.605000] do_page_fault() #2: sending SIGSEGV to init for invalid
read access from
[4294669.605000] 0000000000000004 (epc == 000000002aab32f4, ra ==
000000002aaa8cbc)

It looks like a cache corruption issue.  Did the removal of
flush_icache_page
cause this? 

Any thoughts appreciated.

Thx,
/manoj


>-----Original Message-----
>From: Atsushi Nemoto [mailto:anemo@mba.ocn.ne.jp] 
>Sent: Tuesday, August 22, 2006 9:16 PM
>To: Manoj Ekbote
>Cc: Mark E Mason; linux-mips@linux-mips.org; 
>ralf@linux-mips.org; ths@networkno.de
>Subject: Re: [MIPS] SB1: Build fix: delete initialization of 
>flush_icache_page pointer.
>
>On Mon, 21 Aug 2006 12:27:47 -0700, "Manoj Ekbote" 
><manoje@broadcom.com> wrote:
>> The patch doesn't help. The kernel hangs in the same fashion. 
>
>Thank you for testing.
>
>Then I have no idea why the kernel hangs...
>
>
>Random thoughts:
>
>Does it still hang on init=/bin/sh?
>
>Does enabling second and third "#if 0" blocks in 
>arch/mips/mm/fault.c show some useful information?
>
>Finally, I think there is no serious reason separating c-sb1.c 
>from c-r4k.c.  The c-r4k.c support both vtagged-icache and 
>pindexed-dcache, therefore SB1 can use it too.
>
>mm/c-r4k.c:probe_pcache()
>	switch (c->cputype) {
>	case CPU_20KC:
>	case CPU_25KF:
>	case CPU_SB1:
>	case CPU_SB1A:
>		c->dcache.flags |= MIPS_CACHE_PINDEX;
>	case CPU_R10000:
>	case CPU_R12000:
>	case CPU_R14000:
>		break;
>
>kernel/cpu-probe.c:cpu_probe_sibyte()
>#if 0
>	c->options &= ~MIPS_CPU_4K_CACHE;
>	c->options |= MIPS_CPU_SB1_CACHE;
>#endif
>
>---
>Atsushi Nemoto
>
>
