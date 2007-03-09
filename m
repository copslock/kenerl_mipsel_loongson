Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Mar 2007 13:24:26 +0000 (GMT)
Received: from mail1.pearl-online.net ([62.159.194.147]:28441 "EHLO
	mail1.pearl-online.net") by ftp.linux-mips.org with ESMTP
	id S20021459AbXCINYU (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 9 Mar 2007 13:24:20 +0000
Received: from SNaIlmail.Peter (unknown [77.47.7.186])
	by mail1.pearl-online.net (Postfix) with ESMTP id 4A8A4B196;
	Fri,  9 Mar 2007 14:24:03 +0100 (CET)
Received: from Indigo2.Peter (Indigo2.Peter [192.168.1.28])
	by SNaIlmail.Peter (8.12.6/8.12.6/Sendmail/Linux 2.0.32) with ESMTP id l29DIhRY000729;
	Fri, 9 Mar 2007 14:18:43 +0100
Received: from Indigo2.Peter (localhost [127.0.0.1])
	by Indigo2.Peter (8.12.6/8.12.6/Sendmail/Linux 2.6.14-rc2-ip28) with ESMTP id l29DIeup014338;
	Fri, 9 Mar 2007 14:18:40 +0100
Received: from localhost (pf@localhost)
	by Indigo2.Peter (8.12.6/8.12.6/Submit) with ESMTP id l29DIeZU014335;
	Fri, 9 Mar 2007 14:18:40 +0100
X-Authentication-Warning: Indigo2.Peter: pf owned process doing -bs
Date:	Fri, 9 Mar 2007 14:18:40 +0100 (CET)
From:	peter fuerst <post@pfrst.de>
X-X-Sender: pf@Indigo2.Peter
Reply-To: post@pfrst.de
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH 0/2] FLATMEM: allow memory to start at pfn != 0 [take
 #2]
In-Reply-To: <cda58cb80703061339l2f8cfc09m5823b090b69a7aa7@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0703091415250.604@Indigo2.Peter>
References: <116841864595-git-send-email-fbuihuu@gmail.com> 
 <1172879147.964.65.camel@sakura.staff.proxad.net> 
 <cda58cb80703050615r4e559ca1u78517634ac23a27@mail.gmail.com> 
 <1173112433.7093.36.camel@sakura.staff.proxad.net>
 <cda58cb80703061339l2f8cfc09m5823b090b69a7aa7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <post@pfrst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14401
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: post@pfrst.de
Precedence: bulk
X-list: linux-mips



to detail Thomas' note...

On Tue, 6 Mar 2007, Franck Bui-Huu wrote:

> Date: Tue, 6 Mar 2007 22:39:59 +0100
> From: Franck Bui-Huu <vagabon.xyz@gmail.com>
> To: mbizon@freebox.fr
> Cc: linux-mips <linux-mips@linux-mips.org>
> Subject: Re: [PATCH 0/2] FLATMEM: allow memory to start at pfn != 0 [take
>     #2]
> ...
> In your case, you said:
>
>         PAGE_OFFSET = 0x80000000
>         PHYS_OFFSET = 0x10000000
>
> this means that the first kernel virtual address is 0x80000000 and the
> corresponding physical address is 0x10000000. If you load your kernel
> at 0x9000xxxx, it will be loaded in physical memory located at
> 0x2000xxxx which is obviously not what you want.
>

Never. If the kernel virtual address is 0x80000000+off with 0 <= off <=
0x1fffffff (aka kseg0, defined by bits 31..29), the corresponding physical
address is always 0+off, no matter what PHYS_OFFSET you invent. Physical
memory at 0x20000000 is not reachable from kesg0/1.

> ...

regards

peter
