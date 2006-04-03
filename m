Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Apr 2006 15:25:19 +0100 (BST)
Received: from njbrsmtp1.vzwmail.net ([66.174.76.155]:61169 "EHLO
	njbrsmtp1.vzwmail.net") by ftp.linux-mips.org with ESMTP
	id S8133659AbWDCOZJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 3 Apr 2006 15:25:09 +0100
Received: from squidward (smtp.vzwmail.net [66.174.76.25])
	(authenticated bits=0)
	by njbrsmtp1.vzwmail.net (8.12.9/8.12.9) with ESMTP id k33Ea2Lv019502;
	Mon, 3 Apr 2006 14:36:04 GMT
From:	"Chuck Meade" <chuckmeade@mindspring.com>
To:	<linux-mips@linux-mips.org>
Cc:	"Chuck Meade \(mindspring\)" <chuckmeade@mindspring.com>
Subject: RE: corruption of load instruction offset
Date:	Mon, 3 Apr 2006 10:37:40 -0400
Message-ID: <IIEEICKJLNEPBBDJICNGKEDJKIAA.chuckmeade@mindspring.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
x-mimeole: Produced By Microsoft MimeOLE V6.00.2800.1106
In-Reply-To: <000f01c656ef$d2963670$10eca8c0@grendel>
Importance: Normal
Return-Path: <chuckmeade@mindspring.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11015
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chuckmeade@mindspring.com
Precedence: bulk
X-list: linux-mips

Hi,

> That's pretty twisted - one could almost believe that the fetch from
> 0x8021e28c got corrupted to pick up the most significant 16 bits
> of the instruction at 0x8021e22c or 0x8021e26c - but given that
> instructions are fetched and issued word-by-word, it's hard to see
> where that could happen, in either CPU hardware or software. 
> What is the I-cache line size? If it  were me, I'd check my clocks, 
> voltages, and above all my RAM timing, and I'd re-seat my CPU 
> and RAM in their sockets...

I agree that it is twisted.  The I-cache line size is 32 bytes by the way.

I left it running overnight and got a different error.  Slightly harder to
pinpoint the exact instruction that caused the actual bad load, because the
failing instruction is loading indirect thru a register that is set to 0000fac4.
So the bad load was done previously, and resulted in this register (a1) being
set to 0000fac4.

The common theme here seems to be that I am getting a bad 16-bits of RAM when
loading...  First error that I mentioned last night was an instruction load,
and this new error looks more to me like a data load, since a1 was previously
loaded with a bogus value 0000fac4.  Another bad 16-bit load in the most
significant 16-bits.

So if my analysis is correct, the most significant 16 bits is loading flaky,
both for instructions and for data loads.  This points to some of the lower
level issues you mention -- physical RAM interface, clocking, voltages, and
RAM timing setup.  If anyone can think of something else I should check, let
me know.

Thanks again for the feedback.

Also Ralf, I got your message about the 2.6.14-rc1 version loud and clear.
Thanks to you too for the feedback.

Chuck
