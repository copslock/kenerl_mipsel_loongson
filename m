Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Sep 2002 18:42:23 +0200 (CEST)
Received: from ip-161-71-171-238.corp-eur.3com.com ([161.71.171.238]:39368
	"EHLO columba.www.eur.3com.com") by linux-mips.org with ESMTP
	id <S1122976AbSISQmW>; Thu, 19 Sep 2002 18:42:22 +0200
Received: from toucana.eur.3com.com (toucana.EUR.3Com.COM [140.204.220.50])
	by columba.www.eur.3com.com  with ESMTP id g8JGhOY3022072
	for <linux-mips@linux-mips.org>; Thu, 19 Sep 2002 17:43:56 +0100 (BST)
Received: from notesmta.eur.3com.com (eurmta1.EUR.3Com.COM [140.204.220.206])
	by toucana.eur.3com.com  with SMTP id g8JGgYu25255
	for <linux-mips@linux-mips.org>; Thu, 19 Sep 2002 17:42:34 +0100 (BST)
Received: by notesmta.eur.3com.com(Lotus SMTP MTA v4.6.3  (733.2 10-16-1998))  id 80256C39.005C4540 ; Thu, 19 Sep 2002 17:47:50 +0100
X-Lotus-FromDomain: 3COM
From: "Jon Burgess" <Jon_Burgess@eur.3com.com>
To: linux-mips@linux-mips.org
Message-ID: <80256C39.005C4310.00@notesmta.eur.3com.com>
Date: Thu, 19 Sep 2002 17:41:14 +0100
Subject: Re: Problem running Mips2 user space code
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Return-Path: <Jon_Burgess@eur.3com.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 249
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Jon_Burgess@eur.3com.com
Precedence: bulk
X-list: linux-mips



I just enabled the DEBUG_CACHE in mm/c-mips32.c and the program fails
immeadiately after some cache routines have been called. We have already seen a
cache related problem with this chip so it looks like be caused by a hardware
problem not the kernel. Sorry to trouble you all with this. I'll be in touch
again if it looks like a kernel problem.

Thanks,
     Jon
