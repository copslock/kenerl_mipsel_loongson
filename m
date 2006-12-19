Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Dec 2006 08:17:34 +0000 (GMT)
Received: from www.nabble.com ([72.21.53.35]:8904 "EHLO talk.nabble.com")
	by ftp.linux-mips.org with ESMTP id S28574753AbWLSIR3 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 19 Dec 2006 08:17:29 +0000
Received: from [72.21.53.38] (helo=jubjub.nabble.com)
	by talk.nabble.com with esmtp (Exim 4.50)
	id 1GwaA8-0000l8-Nl
	for linux-mips@linux-mips.org; Tue, 19 Dec 2006 00:17:24 -0800
Message-ID: <7943218.post@talk.nabble.com>
Date:	Tue, 19 Dec 2006 00:17:24 -0800 (PST)
From:	Daniel Laird <danieljlaird@hotmail.com>
To:	linux-mips@linux-mips.org
Subject: 2.6.19 timer API changes
In-Reply-To: <7925588.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Nabble-From: danieljlaird@hotmail.com
References: <7925588.post@talk.nabble.com>
Return-Path: <lists@nabble.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13464
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: danieljlaird@hotmail.com
Precedence: bulk
X-list: linux-mips


Hi All, 

I am porting the Philips/PNX8550 kernel from 2.6.17.13 to 2.6.19.  I am
having some issues: 
One issue I am having is with the new Timer API that replaced the board
specific API. 

I have made all of the important changes 
board_timer_setup -> plat_timer_setup 

When I run the kernel it hangs in the calibrate_delay function. 
Eventually the complete kernel does run but it runs very slow. 
This is usually an issue with the Timer Interuppt setup etc.  But I have
looked at the other MIPS ports and seem to have made the same changes. 

On the PNX8550 it does not use the CP0 timer but use a different timer (the
Custom MIPS core has 3 extra timers) 

I replaced the arch/mips/kernel/time.c with a merge between 2.6.17.13 and
2.6.19 and I can get the kernel to boot at the correct speed straight
through the calibrate_delay function and the entire system seems to be
working correctly. 

I was wondering if anyone might have any ideas on how to debug this problem
as I would like a clean port to 2.6.19. 
Maybe the new timer code will not work properly on the PNX8550 in which case
maybe some patches are required. 

I am continuing to debug at my end and once I have a working system with the
smallest set of changes to the time.c file I will post them in the hope that
someone will point out a silly error I have made in the CPU/board setup. 

In the mean time any helpful ideas on debugging, tracing, even solving this
issue would be really appreciated 

Daniel 
  




-- 
View this message in context: http://www.nabble.com/2.6.19-timer-API-changes-tf2838715.html#a7943218
Sent from the linux-mips main mailing list archive at Nabble.com.
