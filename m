Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jun 2003 04:53:17 +0100 (BST)
Received: from bay8-f73.bay8.hotmail.com ([IPv6:::ffff:64.4.27.73]:65295 "EHLO
	hotmail.com") by linux-mips.org with ESMTP id <S8224861AbTFQDxO>;
	Tue, 17 Jun 2003 04:53:14 +0100
Received: from mail pickup service by hotmail.com with Microsoft SMTPSVC;
	 Mon, 16 Jun 2003 20:28:20 -0700
Received: from 159.226.39.179 by by8fd.bay8.hotmail.msn.com with HTTP;
	Tue, 17 Jun 2003 03:28:20 GMT
X-Originating-IP: [159.226.39.179]
X-Originating-Email: [michael_e_guo@hotmail.com]
From: "Guo Michael" <michael_e_guo@hotmail.com>
To: joseph@omnilux.net
Cc: linux-mips@linux-mips.org
Subject: Re: wired tlb entry?
Date: Tue, 17 Jun 2003 11:28:20 +0800
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312; format=flowed
Message-ID: <BAY8-F73IhTrBoe2U8Q000490cf@hotmail.com>
X-OriginalArrivalTime: 17 Jun 2003 03:28:20.0830 (UTC) FILETIME=[803AC7E0:01C33480]
Return-Path: <michael_e_guo@hotmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2652
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: michael_e_guo@hotmail.com
Precedence: bulk
X-list: linux-mips

Hi! You can use add_wired_entry(unsigned long entrylo0, unsigned long 
entrylo1, unsigned long entryhi, unsigned long pagemask);

for more information you can check include/asm-mips/pgtable.h


-Michael

>From: "Joseph Chiu" <joseph@omnilux.net>
>To: "Linux-MIPS" <linux-mips@linux-mips.org>
>Subject: wired tlb entry?
>Date: Mon, 16 Jun 2003 17:36:58 -0700
>
>Hi,
>Is there a (proper) way to add a page entry in the TLB it's always valid?
>Specifically, accesses to memory-mapped hardware (PCMCIA) causes the 
kernel
>to oops under heavy interrupt loading.
>It seems to me that the page entry in the TLB is getting flushed out under
>the activity; and when the ioremap'd memory region is accesses, the
>exception handling for the missing translation does not run.
>
>I'm afraid my two days of googling hasn't turned up the right information.
>I think I just don't know the right terminology and I hope someone can at
>least point me in the right direction.
>Thanks.
>Joseph
>(I am running 2.4.18-mips)
>
>
>
>--
>Joseph Chiu, Senior Engineer, Omnilux, Inc.
>joseph@omnilux.net  (626) 535-2819
>The sun will come up tomorrow.  Bet your bottom dollar that tomorrow,
>things'll be back.
>
>

_________________________________________________________________
享用世界上最大的电子邮件系统— MSN Hotmail。  http://www.hotmail.com  
