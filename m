Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Feb 2009 08:33:31 +0000 (GMT)
Received: from qmta04.emeryville.ca.mail.comcast.net ([76.96.30.40]:48275 "EHLO
	QMTA04.emeryville.ca.mail.comcast.net") by ftp.linux-mips.org
	with ESMTP id S21200955AbZBTId1 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 20 Feb 2009 08:33:27 +0000
Received: from OMTA01.emeryville.ca.mail.comcast.net ([76.96.30.11])
	by QMTA04.emeryville.ca.mail.comcast.net with comcast
	id J8Wz1b0080EPchoA48ZLbF; Fri, 20 Feb 2009 08:33:20 +0000
Received: from [10.0.0.109] ([24.6.28.106])
	by OMTA01.emeryville.ca.mail.comcast.net with comcast
	id J8ZK1b0012HMlxk8M8ZKof; Fri, 20 Feb 2009 08:33:20 +0000
Message-ID: <499E6AC5.5070404@notav8.com>
Date:	Fri, 20 Feb 2009 00:33:09 -0800
From:	Chris Rhodin <chris@notav8.com>
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: plat_irq_dispatch
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <chris@notav8.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21947
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chris@notav8.com
Precedence: bulk
X-list: linux-mips

Hi,

I've been digging through the interrupt code trying to figure out what 
would be required to make it "generic irq" clean.  I have a couple of 
questions that I haven't been able to answer myself.

1) I count 24 different versions of plat_irq_dispatch, many of them only 
seem to vary in the use and priority of the 8 sources in the cause 
register.  Is this really the case or am I missing something subtle?

2) Why isn't plat_irq_dispatch looping until all active interrupts are 
serviced?

I already have what I believe is a generic plat_irq_dispatch that finds 
the highest priority irq in (almost) constant time.  It needs one block 
of defines to identify the 8 sources and another block to set the 
priorities.

Thanks,

Chris Rhodin
