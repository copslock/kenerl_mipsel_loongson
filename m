Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Jan 2005 17:00:26 +0000 (GMT)
Received: from eth13.com-link.com ([IPv6:::ffff:208.242.241.164]:59015 "EHLO
	real.realitydiluted.com") by linux-mips.org with ESMTP
	id <S8225439AbVAGRAV>; Fri, 7 Jan 2005 17:00:21 +0000
Received: from sjhill by real.realitydiluted.com with local (Exim 4.34 #1 (Debian))
	id 1CmxTF-0002Vm-OA; Fri, 07 Jan 2005 11:00:17 -0600
Subject: Re: Problem with MV64340 serial driver
In-Reply-To: <41DEBB63.6060400@enix.org>
To: Thomas Petazzoni <thomas.petazzoni@enix.org>
Date: Fri, 7 Jan 2005 11:00:17 -0600 (CST)
CC: linux-mips@linux-mips.org
X-Mailer: ELM [version 2.4ME+ PL100 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <E1CmxTF-0002Vm-OA@real.realitydiluted.com>
From: sjhill@realitydiluted.com
Return-Path: <sjhill@realitydiluted.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6837
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@realitydiluted.com
Precedence: bulk
X-list: linux-mips

> > That driver is for the 64360, but my point is that it should work with
> > minor modifications on the 64340. I apologize if I was not clear.
> 
> Ok, but I couldn't find the directory 'drivers/serial/mpsc' you 
> mentionned. I'm sure I'm doing something wrong, but what ?
> 
I meant to say 64360 at the end of the first sentence. Regardless, I
just did a fresh BK update from that repository and I see a that
directory just fine. Did you try checking out that entire BK repository?

-Steve
