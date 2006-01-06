Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Jan 2006 16:57:11 +0000 (GMT)
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:22285 "EHLO
	caramon.arm.linux.org.uk") by ftp.linux-mips.org with ESMTP
	id S8133583AbWAFQ4x (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 6 Jan 2006 16:56:53 +0000
Received: from flint.arm.linux.org.uk ([2002:d412:e8ba:1:201:2ff:fe14:8fad])
	by caramon.arm.linux.org.uk with esmtpsa (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.52)
	id 1Euuw8-0001Qt-UD; Fri, 06 Jan 2006 16:59:33 +0000
Received: from rmk by flint.arm.linux.org.uk with local (Exim 4.52)
	id 1Euuw6-0007xQ-Me; Fri, 06 Jan 2006 16:59:31 +0000
Date:	Fri, 6 Jan 2006 16:59:30 +0000
From:	Russell King <rmk@arm.linux.org.uk>
To:	Jordan Crouse <jordan.crouse@amd.com>
Cc:	linux-mips@linux-mips.org, drzeus@drzeus.cx
Subject: Re: [PATCH]  Force MMC/SD to 512 byte block sizes
Message-ID: <20060106165930.GC16093@flint.arm.linux.org.uk>
References: <20060106164406.GA15617@cosmic.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060106164406.GA15617@cosmic.amd.com>
User-Agent: Mutt/1.4.1i
Return-Path: <rmk+linux-mips=linux-mips.org@arm.linux.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9792
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rmk@arm.linux.org.uk
Precedence: bulk
X-list: linux-mips

On Fri, Jan 06, 2006 at 09:44:06AM -0700, Jordan Crouse wrote:
> This patch is not specific to the AU1200 SD driver, but thats what
> we used to debug and verify this, so thats why it is applied against
> the linux-mips tree.   Pierre, I'm sending this to you too, because I thought
> you may be interested.

NACK.  Please wait until the next round of patches get merged and then
revalidate this.

It's obviously wrong in the case of cards which do not support partial
block writes, and it does nothing to detect this (apart from violating
their advertised capabilities.)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
