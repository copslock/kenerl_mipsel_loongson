Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Sep 2002 18:25:57 +0200 (CEST)
Received: from ip-161-71-171-238.corp-eur.3com.com ([161.71.171.238]:27367
	"EHLO columba.www.eur.3com.com") by linux-mips.org with ESMTP
	id <S1122958AbSIEQZ4>; Thu, 5 Sep 2002 18:25:56 +0200
Received: from toucana.eur.3com.com (toucana.EUR.3Com.COM [140.204.220.50])
	by columba.www.eur.3com.com  with ESMTP id g85GRDRG007964;
	Thu, 5 Sep 2002 17:27:23 +0100 (BST)
Received: from notesmta.eur.3com.com (eurmta1.EUR.3Com.COM [140.204.220.206])
	by toucana.eur.3com.com  with SMTP id g85GQIR06446;
	Thu, 5 Sep 2002 17:26:18 +0100 (BST)
Received: by notesmta.eur.3com.com(Lotus SMTP MTA v4.6.3  (733.2 10-16-1998))  id 80256C2B.005ABDF4 ; Thu, 5 Sep 2002 17:31:08 +0100
X-Lotus-FromDomain: 3COM
From: "Jon Burgess" <Jon_Burgess@eur.3com.com>
To: "Matthew Dharm" <mdharm@momenco.com>
cc: "Linux-MIPS" <linux-mips@linux-mips.org>
Message-ID: <80256C2B.005ABC29.00@notesmta.eur.3com.com>
Date: Thu, 5 Sep 2002 17:25:00 +0100
Subject: RE: Interrupt handling....
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Return-Path: <Jon_Burgess@eur.3com.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 120
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Jon_Burgess@eur.3com.com
Precedence: bulk
X-list: linux-mips



>    li   t0, 0xfc000000
>    lb   t1, 0xc(t0)
>
>After all,
>isn't that what ioremap is supposed to do?

I think the problem is that you need to use the pointer which ioremap() returns
to access the region you requested. It looks like you've assumed that ioremap()
will map it 1:1 which I don't think is the case.

i.e.

struct hw_regs *foo;

foo = (struct hw_regs *)ioremap(0xfc000000, <Size>);

foo->command = hw_reset;
...


     Jon
