Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Mar 2006 11:52:48 +0000 (GMT)
Received: from fri.itea.ntnu.no ([129.241.7.60]:8386 "EHLO fri.itea.ntnu.no")
	by ftp.linux-mips.org with ESMTP id S8133394AbWCBLwj (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 2 Mar 2006 11:52:39 +0000
Received: from localhost (localhost [127.0.0.1])
	by fri.itea.ntnu.no (Postfix) with ESMTP id EECEC8330;
	Thu,  2 Mar 2006 13:00:29 +0100 (CET)
Received: from invalid.ed.ntnu.no (invalid.ed.ntnu.no [129.241.205.150])
	by fri.itea.ntnu.no (Postfix) with ESMTP;
	Thu,  2 Mar 2006 13:00:28 +0100 (CET)
Received: from invalid.ed.ntnu.no (jonah@localhost.ed.ntnu.no [127.0.0.1])
	by invalid.ed.ntnu.no (8.13.3/8.13.3) with ESMTP id k22C0SM2081339
	(version=TLSv1/SSLv3 cipher=DHE-DSS-AES256-SHA bits=256 verify=NO);
	Thu, 2 Mar 2006 13:00:28 +0100 (CET)
	(envelope-from jonah@omegav.ntnu.no)
Received: from localhost (jonah@localhost)
	by invalid.ed.ntnu.no (8.13.3/8.13.3/Submit) with ESMTP id k22C0RpS081336;
	Thu, 2 Mar 2006 13:00:28 +0100 (CET)
	(envelope-from jonah@omegav.ntnu.no)
X-Authentication-Warning: invalid.ed.ntnu.no: jonah owned process doing -bs
Date:	Thu, 2 Mar 2006 13:00:27 +0100 (CET)
From:	Jon Anders Haugum <jonah@omegav.ntnu.no>
X-X-Sender: jonah@invalid.ed.ntnu.no
To:	Jordan Crouse <jordan.crouse@amd.com>
Cc:	linux-serial@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] Fix compile error in 8250_au1x00.c
In-Reply-To: <20060207211500.GC5227@cosmic.amd.com>
Message-ID: <20060302124634.T81066@invalid.ed.ntnu.no>
References: <20060207211500.GC5227@cosmic.amd.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-Content-Scanned: with sophos and spamassassin at mailgw.ntnu.no.
Return-Path: <jonah@omegav.ntnu.no>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10718
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonah@omegav.ntnu.no
Precedence: bulk
X-list: linux-mips

On Tue, 7 Feb 2006, Jordan Crouse wrote:

> There are additional rumors of strangeness on the DB1550, but those
> are unsubstantiated at this point.  At least with this patch, it will
> compile.

I can confirm strangeness on Au1550, and I've pinned it down to wrong 
way of setting the divisor register. The alchemy uart have got a spearate 
register for divisor, while the driver tries to set the divisor latch 
just like on any 16550 uart.

How would be a good way of solving this? I can imagine a couple of ways:

1. Make divisor latch read/write a bit more abstract, so that a 
alternative function can be used for alchemy.

2. Add divisor latch to the alchemy uart register map. But since the 
divisor register is located in a single 32-bit register and the driver 
will try to access it one byte at a time; byte access would be needed. And 
this would add some endian handling...


-- 
Jon Anders Haugum
