Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Jul 2004 16:01:32 +0100 (BST)
Received: from mail.elvees.com ([IPv6:::ffff:80.92.98.198]:11459 "EHLO
	narwhal.elvees.dmz") by linux-mips.org with ESMTP
	id <S8225219AbUGTPB2>; Tue, 20 Jul 2004 16:01:28 +0100
Received: from (IP:192.168.2.1)
	=?ISO-8859-1?Q?=9C(authenticated?= with LOGIN user mail-deepfire)
	=?ISO-8859-1?Q?=9Cby?= mail.elvees.com with ESMTP id i6KF0vvp006317;
	Tue, 20 Jul 2004 19:01:00 +0400 (MSD)
	(envelope-from deepfire@elvees.com)
From: Samium Gromoff <deepfire@elvees.com>
To: maksik@gmx.co.uk
Subject: Re: is there *any* way to boot IP32 from hard drive ?
Date: Tue, 20 Jul 2004 18:01:54 +0400
User-Agent: KMail/1.6.2
Cc: linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200407201801.55096.deepfire@elvees.com>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-Path: <deepfire@elvees.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5522
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: deepfire@elvees.com
Precedence: bulk
X-list: linux-mips

> Hi List,
>
> I've asked the very same question here before, but got no answer. Probably, 
> the experts, who might have known the answer just overlooked it... (sorry 
> guys for addressing some of you directly, but I'm really in trouble). The 
> thing is that I desperately need to get the O2 to boot from its HDD, it'sall 
> installed and supposed to be used as a standalone box.

First -- you`re right to use the arcboot image from debian -- that`s how i got
it working.

Second -- not all kernels will run successfully, indeed -- the one i used was
the glaurung 2.6.1 kernel from:

	http://www.linux-mips.org/~glaurung/

This is the only kernel which worked for me so far, and it is not without it`s
share of flaws, namely -- RTC, framebuffer, the AD-based sound chip and mouse
all having issues. Also it hangs (at times) =)

Hope this helps.

regards, Samium Gromoff
