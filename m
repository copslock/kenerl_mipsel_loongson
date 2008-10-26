Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 26 Oct 2008 12:48:31 +0000 (GMT)
Received: from h4.dl5rb.org.uk ([81.2.74.4]:41700 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S22415549AbYJZMsZ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 26 Oct 2008 12:48:25 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m9QCmMmE016734;
	Sun, 26 Oct 2008 12:48:22 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m9QCmLrV016732;
	Sun, 26 Oct 2008 12:48:21 GMT
Date:	Sun, 26 Oct 2008 12:48:21 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	ddaney@caviumnetworks.com
Cc:	linux-mips@linux-mips.org,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>,
	Paul Gortmaker <Paul.Gortmaker@windriver.com>
Subject: Re: [PATCH 35/37] Set c0 status for ST0_KX on Cavium OCTEON.
Message-ID: <20081026124821.GN25297@linux-mips.org>
References: <1224809821-5532-1-git-send-email-ddaney@caviumnetworks.com> <1224809821-5532-36-git-send-email-ddaney@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1224809821-5532-36-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20975
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Oct 23, 2008 at 05:56:59PM -0700, ddaney@caviumnetworks.com wrote:

> Always set ST0_KX on Octeon since IO addresses are at 64bit addresses.
> Keep in mind this also moves the TLB handler.
> 
> Signed-off-by: Tomaso Paoletti <tpaoletti@caviumnetworks.com>
> Signed-off-by: Paul Gortmaker <Paul.Gortmaker@windriver.com>
> Signed-off-by: David Daney <ddaney@caviumnetworks.com>

> -#ifdef CONFIG_64BIT
> +#if defined(CONFIG_64BIT) || defined(CONFIG_CPU_CAVIUM_OCTEON)
> +	/*
> +	 * Note: We always set ST0_KX on Octeon since IO addresses are at
> +	 * 64bit addresses. Keep in mind this also moves the TLB handler.
> +	 */
>  	setup_c0_status ST0_KX 0

That's a bit odd - on 64-bit kernels KX would be set anyway and on 32-bit
kernels would be corrupted by exceptions or interrupts, so 64-bit
addresses are not safe to use on 32-bit kernels for most part.

32-bit virtual addresses mapped to a non-compat address otoh will work fine
without KX set.

  Ralf
