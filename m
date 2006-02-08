Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Feb 2006 21:31:15 +0000 (GMT)
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:8973 "EHLO
	caramon.arm.linux.org.uk") by ftp.linux-mips.org with ESMTP
	id S8133359AbWBHVbG (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 8 Feb 2006 21:31:06 +0000
Received: from flint.arm.linux.org.uk ([2002:d412:e8ba:1:201:2ff:fe14:8fad])
	by caramon.arm.linux.org.uk with esmtpsa (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.52)
	id 1F6wzL-0006My-Es; Wed, 08 Feb 2006 21:36:36 +0000
Received: from rmk by flint.arm.linux.org.uk with local (Exim 4.52)
	id 1F6wzX-0002jV-U2; Wed, 08 Feb 2006 21:36:47 +0000
Date:	Wed, 8 Feb 2006 21:36:47 +0000
From:	Russell King <rmk@arm.linux.org.uk>
To:	Jordan Crouse <jordan.crouse@amd.com>
Cc:	linux-serial@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] Fix compile error in 8250_au1x00.c
Message-ID: <20060208213647.GB8587@flint.arm.linux.org.uk>
References: <20060207211500.GC5227@cosmic.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060207211500.GC5227@cosmic.amd.com>
User-Agent: Mutt/1.4.1i
Return-Path: <rmk+linux-mips=linux-mips.org@arm.linux.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10373
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rmk@arm.linux.org.uk
Precedence: bulk
X-list: linux-mips

On Tue, Feb 07, 2006 at 02:15:00PM -0700, Jordan Crouse wrote:
> The DB1550 actually doesn't have a UART2.  Remove it from the list.

Applied, thanks.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
