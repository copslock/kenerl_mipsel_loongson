Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Jul 2003 10:54:14 +0100 (BST)
Received: from alg145.algor.co.uk ([IPv6:::ffff:62.254.210.145]:12561 "EHLO
	dmz.algor.co.uk") by linux-mips.org with ESMTP id <S8225213AbTGaJyM>;
	Thu, 31 Jul 2003 10:54:12 +0100
Received: from alg158.algor.co.uk ([62.254.210.158] helo=olympia.mips.com)
	by dmz.algor.co.uk with esmtp (Exim 3.35 #1 (Debian))
	id 19iA9h-0007c9-00; Thu, 31 Jul 2003 10:55:29 +0100
Received: from holborn.algor.co.uk ([192.168.192.237] helo=mips.com)
	by olympia.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 19iA7O-00010r-00; Thu, 31 Jul 2003 10:53:06 +0100
Message-ID: <3F28E702.70401@mips.com>
Date: Thu, 31 Jul 2003 10:53:06 +0100
From: Chris Dearman <chris@mips.com>
Organization: MIPS Technologies (UK) Ltd
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
MIME-Version: 1.0
To: Jun Sun <jsun@mvista.com>
CC: linux-mips@linux-mips.org
Subject: Re: Malta + USB on 2.4, anyone?
References: <20030730191219.A14914@mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-MTUK-Scanner: Found to be clean
X-MTUK-SpamCheck: not spam, SpamAssassin ()
Return-Path: <chris@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2935
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chris@mips.com
Precedence: bulk
X-list: linux-mips

Jun Sun wrote:
> Has anybody tried USB on malta with 2.4 kernel?  I just found that
> I got 0xff IRQ number and kernel panics.

> Also, the kgdb seems to be flaky.  Targets can send chars too fast
> so that chars get lost.  It appears that the linux status register
> might be lying about "transmitter buffer empty".  

   I regularly use gdb @ 115200 on Malta and haven't noticed any problems.

	Chris


-- 
Chris Dearman          The Fruit Farm, Ely Road    voice +44 1223 706206
MIPS Technologies (UK) Chittering, Cambs, CB5 9PH  fax   +44 1223 706250
