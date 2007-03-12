Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Mar 2007 13:08:33 +0000 (GMT)
Received: from mail1.pearl-online.net ([62.159.194.147]:41281 "EHLO
	mail1.pearl-online.net") by ftp.linux-mips.org with ESMTP
	id S20022290AbXCLNIY (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 12 Mar 2007 13:08:24 +0000
Received: from SNaIlmail.Peter (unknown [77.47.7.186])
	by mail1.pearl-online.net (Postfix) with ESMTP id D4258CA21;
	Mon, 12 Mar 2007 14:07:58 +0100 (CET)
Received: from Indigo2.Peter (Indigo2.Peter [192.168.1.28])
	by SNaIlmail.Peter (8.12.6/8.12.6/Sendmail/Linux 2.0.32) with ESMTP id l2CD423C000844;
	Mon, 12 Mar 2007 14:04:02 +0100
Received: from Indigo2.Peter (localhost [127.0.0.1])
	by Indigo2.Peter (8.12.6/8.12.6/Sendmail/Linux 2.6.14-rc2-ip28) with ESMTP id l2CD3wAY000449;
	Mon, 12 Mar 2007 14:03:58 +0100
Received: from localhost (pf@localhost)
	by Indigo2.Peter (8.12.6/8.12.6/Submit) with ESMTP id l2CD3vmm000446;
	Mon, 12 Mar 2007 14:03:57 +0100
X-Authentication-Warning: Indigo2.Peter: pf owned process doing -bs
Date:	Mon, 12 Mar 2007 14:03:57 +0100 (CET)
From:	peter fuerst <post@pfrst.de>
X-X-Sender: pf@Indigo2.Peter
Reply-To: post@pfrst.de
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH 0/2] FLATMEM: allow memory to start at pfn != 0 [take
 #2]
In-Reply-To: <cda58cb80703120247q435b6bb1p8a025d8597aca2a2@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0703121329450.440@Indigo2.Peter>
References: <116841864595-git-send-email-fbuihuu@gmail.com> 
 <Pine.LNX.4.58.0703101034500.19007@Indigo2.Peter>
 <cda58cb80703120247q435b6bb1p8a025d8597aca2a2@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <post@pfrst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14432
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: post@pfrst.de
Precedence: bulk
X-list: linux-mips


Hi!

On Mon, 12 Mar 2007, Franck Bui-Huu wrote:

> Date: Mon, 12 Mar 2007 10:47:01 +0100
> From: Franck Bui-Huu <vagabon.xyz@gmail.com>
> To: post@pfrst.de
> Cc: linux-mips@linux-mips.org
> Subject: Re: [PATCH 0/2] FLATMEM: allow memory to start at pfn != 0 [take
>     #2]
>
> Hi,
>
> On 3/10/07, peter fuerst <post@pfrst.de> wrote:
> > 3) The page_offset adjustment may force fixes in other, not yet blown up,
> >    places (pmd_phys() cried out lately...).
> >
>
> Not really fair. It crashed lately because until now I was the only

May be, so i apologize.

> one to use it. And unfortunately I failed to give back this change to
> Ralf's tree.

You see the problem. Any occurrence of PAGE_OFFSET must be checked.

>
> BUT, note that the root cause of this bug is that we did _plain_
> address translation instead of using dedicated macro.
>
> So I would say that this patch helps to fix these buggy places.

Sure, a dedicated macro or function is the correct way to handle all
the kernel-addresses.  Moreover it would be desirable, if this macro
really could be used throughout the kernel, e.g. by drivers, handling
any reasonable kernel-address, which isn't possible in the page_offset
scheme anyway.

>
> > What can PHYS_OFFSET achieve here - besides obfuscating ?
> > Are there future uses for it, that justify the contortions ?
> >
>
> How do you deal with fancy cases such as physical memory starting at
> 0x20000000 for example ?

With XKPHYS and exactly this offset ;-)
To be serious again:
O.K. i see the future use is to support TLB-mapped 32bit kernels.

In this case, with respect to unmapped kernels, the min_low_pfn stuff
should be decoupled from the PHYS_OFFSET setting, to let the unmapped
kernels keep it zero and benefit from memory savings though.
Otherwise, for each different non-zero PHYS_OFFSET, there must be an
accordingly adjusted PAGE_OFFSET (the CKSEG0 part in __pa_page_offset
is still to be prepared for this).

>
> --
>                Franck
>
>

kind regards

peter
