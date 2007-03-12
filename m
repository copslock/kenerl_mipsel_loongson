Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Mar 2007 20:05:07 +0000 (GMT)
Received: from mail1.pearl-online.net ([62.159.194.147]:57926 "EHLO
	mail1.pearl-online.net") by ftp.linux-mips.org with ESMTP
	id S20021684AbXCLUFC (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 12 Mar 2007 20:05:02 +0000
Received: from SNaIlmail.Peter (unknown [77.47.7.186])
	by mail1.pearl-online.net (Postfix) with ESMTP id 7348CCA25;
	Mon, 12 Mar 2007 21:04:43 +0100 (CET)
Received: from Indigo2.Peter (Indigo2.Peter [192.168.1.28])
	by SNaIlmail.Peter (8.12.6/8.12.6/Sendmail/Linux 2.0.32) with ESMTP id l2CK2d3C001079;
	Mon, 12 Mar 2007 21:02:39 +0100
Received: from Indigo2.Peter (localhost [127.0.0.1])
	by Indigo2.Peter (8.12.6/8.12.6/Sendmail/Linux 2.6.14-rc2-ip28) with ESMTP id l2CK2PeQ000448;
	Mon, 12 Mar 2007 21:02:26 +0100
Received: from localhost (pf@localhost)
	by Indigo2.Peter (8.12.6/8.12.6/Submit) with ESMTP id l2CK2PZY000445;
	Mon, 12 Mar 2007 21:02:25 +0100
X-Authentication-Warning: Indigo2.Peter: pf owned process doing -bs
Date:	Mon, 12 Mar 2007 21:02:25 +0100 (CET)
From:	peter fuerst <post@pfrst.de>
X-X-Sender: pf@Indigo2.Peter
Reply-To: post@pfrst.de
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH 0/2] FLATMEM: allow memory to start at pfn != 0 [take
 #2]
In-Reply-To: <cda58cb80703121005h53969eb2j7b2290b97b14374d@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0703122016430.438@Indigo2.Peter>
References: <116841864595-git-send-email-fbuihuu@gmail.com> 
 <Pine.LNX.4.58.0703101034500.19007@Indigo2.Peter> 
 <cda58cb80703120247q435b6bb1p8a025d8597aca2a2@mail.gmail.com> 
 <Pine.LNX.4.58.0703121329450.440@Indigo2.Peter>
 <cda58cb80703121005h53969eb2j7b2290b97b14374d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <post@pfrst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14438
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: post@pfrst.de
Precedence: bulk
X-list: linux-mips



Hi!

On Mon, 12 Mar 2007, Franck Bui-Huu wrote:

> Date: Mon, 12 Mar 2007 18:05:10 +0100
> From: Franck Bui-Huu <vagabon.xyz@gmail.com>
> To: post@pfrst.de
> Cc: linux-mips@linux-mips.org
> Subject: Re: [PATCH 0/2] FLATMEM: allow memory to start at pfn != 0 [take
>     #2]
>
> On 3/12/07, peter fuerst <post@pfrst.de> wrote:
> >
> > You see the problem. Any occurrence of PAGE_OFFSET must be checked.
> >
>
> yes and whatever the scheme you propose...
>
> > the kernel-addresses.  Moreover it would be desirable, if this macro
> > really could be used throughout the kernel, e.g. by drivers, handling
> > any reasonable kernel-address, which isn't possible in the page_offset
> > scheme anyway.
> >
>
> Can you explain why the current use of pa() failed to handle all
> kernel address with a real example ?

Simply, when you convert between cached (kseg0, ckseg0, several xkphys-
regions) and uncached (kseg1, ckseg1, several xkphys-regions) addresses
and the other way round, you need the physical address as an intermediate
value and __pa() or virt_to_phys() can support only one direction.

Of course a scheme, that supports all unmapped spaces (kseg0/1, ckseg0/1,
xkphys) simultaneously, or even xkphys alone, can't support TLB-mapped
spaces (kseg3, ckseg3, ..., xkseg) - at which your patch seems to aim -
and vice versa.

>
> A few people reported that they had problem with KPHYS/CKSEG0 address
> mix for 64 bit kernels but as far I can see it was due to a miss
> configuration of their kernels. Of course I canbe wrong but these

Hmm, i don't remember actually mis-configured kernels, but allright,
have to skim the eMail-archive again.

> people haven't given any feedbacks so far...
>
> Thanks
> --
>                Franck

kind regards

peter
