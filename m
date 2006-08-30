Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Aug 2006 13:15:43 +0100 (BST)
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:37904 "EHLO
	caramon.arm.linux.org.uk") by ftp.linux-mips.org with ESMTP
	id S20037642AbWH3MPl (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 30 Aug 2006 13:15:41 +0100
Received: from flint.arm.linux.org.uk ([2002:d993:5cf9:1:201:2ff:fe14:8fad])
	by caramon.arm.linux.org.uk with esmtpsa (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.52)
	id 1GIOyh-00031y-30; Wed, 30 Aug 2006 13:15:31 +0100
Received: from rmk by flint.arm.linux.org.uk with local (Exim 4.52)
	id 1GIOye-0006ny-Uy; Wed, 30 Aug 2006 13:15:29 +0100
Date:	Wed, 30 Aug 2006 13:15:28 +0100
From:	Russell King <rmk@arm.linux.org.uk>
To:	Thomas Koeller <thomas.koeller@baslerweb.com>
Cc:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>,
	sshtylyov@ru.mvista.com, linux-serial@vger.kernel.org,
	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] RM9000 serial driver
Message-ID: <20060830121528.GB25699@flint.arm.linux.org.uk>
References: <200608102318.52143.thomas.koeller@baslerweb.com> <200608220057.52213.thomas.koeller@baslerweb.com> <20060822095942.4663a4cd.yoichi_yuasa@tripeaks.co.jp> <200608260038.13662.thomas.koeller@baslerweb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608260038.13662.thomas.koeller@baslerweb.com>
User-Agent: Mutt/1.4.1i
Return-Path: <rmk+linux-mips=linux-mips.org@arm.linux.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12479
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rmk@arm.linux.org.uk
Precedence: bulk
X-list: linux-mips

On Sat, Aug 26, 2006 at 12:38:13AM +0200, Thomas Koeller wrote:
> so far nobody commented on my recent mail, in which I explained why I
> think that the AU1X00 code in 8250.c is not entirely correct, so I assume
> nobody cares.

Or maybe your assumption is wrong.  You were referring to the port type
not being setup at autodetect time, and assuming that is used to define
the register mapping.  It isn't, so your premise for it being broken is
incorrect.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
