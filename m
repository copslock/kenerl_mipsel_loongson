Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 25 Mar 2006 17:40:52 +0000 (GMT)
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:42001 "EHLO
	caramon.arm.linux.org.uk") by ftp.linux-mips.org with ESMTP
	id S8133787AbWCYRkm (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 25 Mar 2006 17:40:42 +0000
Received: from flint.arm.linux.org.uk ([2002:d412:e8ba:1:201:2ff:fe14:8fad])
	by caramon.arm.linux.org.uk with esmtpsa (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.52)
	id 1FNCuU-0001sO-BK; Sat, 25 Mar 2006 17:50:46 +0000
Received: from rmk by flint.arm.linux.org.uk with local (Exim 4.52)
	id 1FNCuS-0006Un-ND; Sat, 25 Mar 2006 17:50:44 +0000
Date:	Sat, 25 Mar 2006 17:50:43 +0000
From:	Russell King <rmk@arm.linux.org.uk>
To:	Jon Anders Haugum <jonah@omegav.ntnu.no>
Cc:	linux-serial@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] serial8250: set divisor register correctly for AMD Alchemy SoC uart
Message-ID: <20060325175042.GH6100@flint.arm.linux.org.uk>
References: <20060303140428.T96056@invalid.ed.ntnu.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060303140428.T96056@invalid.ed.ntnu.no>
User-Agent: Mutt/1.4.1i
Return-Path: <rmk+linux-mips=linux-mips.org@arm.linux.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10939
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rmk@arm.linux.org.uk
Precedence: bulk
X-list: linux-mips

On Fri, Mar 03, 2006 at 02:56:38PM +0100, Jon Anders Haugum wrote:
> Alchemy SoC uart have got a non-standard divisor register that needs some 
> special handling.
> 
> This patch adds divisor read/write functions with test and special 
> handling for Alchemy internal uart.

This doesn't apply to mainline anymore.

patching file drivers/serial/8250.c
Hunk #1 succeeded at 362 with fuzz 2.
Hunk #2 FAILED at 528.
Hunk #3 FAILED at 540.
Hunk #4 FAILED at 552.
Hunk #5 FAILED at 565.
Hunk #6 FAILED at 780.
Hunk #7 FAILED at 788.
Hunk #8 succeeded at 1890 with fuzz 2.
6 out of 8 hunks FAILED -- saving rejects to file drivers/serial/8250.c.rej

Please resend.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
