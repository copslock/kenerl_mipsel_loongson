Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Nov 2002 15:52:51 +0100 (CET)
Received: from ip-161-71-171-238.corp-eur.3com.com ([161.71.171.238]:2038 "EHLO
	columba.www.eur.3com.com") by linux-mips.org with ESMTP
	id <S1122165AbSKHOwu>; Fri, 8 Nov 2002 15:52:50 +0100
Received: from toucana.eur.3com.com (toucana.EUR.3Com.COM [140.204.220.50])
	by columba.www.eur.3com.com  with ESMTP id gA8EsJRc025778;
	Fri, 8 Nov 2002 14:54:22 GMT
Received: from notesmta.eur.3com.com (eurmta1.EUR.3Com.COM [140.204.220.206])
	by toucana.eur.3com.com  with SMTP id gA8Ermk08021;
	Fri, 8 Nov 2002 14:53:48 GMT
Received: by notesmta.eur.3com.com(Lotus SMTP MTA v4.6.3  (733.2 10-16-1998))  id 80256C6B.0051C789 ; Fri, 8 Nov 2002 14:53:14 +0000
X-Lotus-FromDomain: 3COM
From: "Jon Burgess" <Jon_Burgess@eur.3com.com>
To: Ralf Baechle <ralf@linux-mips.org>
cc: linux-mips@linux-mips.org
Message-ID: <80256C6B.0051C5D4.00@notesmta.eur.3com.com>
Date: Fri, 8 Nov 2002 14:52:25 +0000
Subject: Re: EV64120 anybody?
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Return-Path: <Jon_Burgess@eur.3com.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 612
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Jon_Burgess@eur.3com.com
Precedence: bulk
X-list: linux-mips



Ralf wrote:
> Does anybody still care about support for the EV64120?
> It's significant time since I last received a report about
> this board.  As it is at least the code in
> arch/mips/galileo-boards/ev64120/compressed is in a shape
> such that I cannot merge it with Linus, so that means
> either somebody who cares about this board is going
> to clean the code or I'm considering to do the rm -rf
> thing ...

I copied the approach in ev64120/compressed to implement a
compressed kernel in a product based on a different chip. Having
a compressed kernel image is fairly crucial for use in an
embedded system.

I think this is the only example of support for a compressed
kernel image in the linux-mips.org code. There was the start of
some more generic support in the SF tree but I haven't
looked at it recently.

Is the problem that the code is not generic, or are there some
other issues?

I cleaned up the code a bit to get it compile with the latest
tools when I copied it, but it is still not generic enough.

The misc.c #include "../../../../../lib/inflate.c' is a nasty
piece of coding.

     Jon
