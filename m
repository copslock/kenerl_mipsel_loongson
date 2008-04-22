Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Apr 2008 17:23:51 +0100 (BST)
Received: from NaN.false.org ([208.75.86.248]:42962 "EHLO nan.false.org")
	by ftp.linux-mips.org with ESMTP id S28578959AbYDVQXt (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 22 Apr 2008 17:23:49 +0100
Received: from nan.false.org (localhost [127.0.0.1])
	by nan.false.org (Postfix) with ESMTP id 744D4983DB;
	Tue, 22 Apr 2008 16:23:44 +0000 (GMT)
Received: from caradoc.them.org (22.svnf5.xdsl.nauticom.net [209.195.183.55])
	by nan.false.org (Postfix) with ESMTP id 39E9398060;
	Tue, 22 Apr 2008 16:23:44 +0000 (GMT)
Received: from drow by caradoc.them.org with local (Exim 4.69)
	(envelope-from <drow@caradoc.them.org>)
	id 1JoLHT-00040t-EI; Tue, 22 Apr 2008 12:23:43 -0400
Date:	Tue, 22 Apr 2008 12:23:43 -0400
From:	Daniel Jacobowitz <dan@debian.org>
To:	David Daney <ddaney@avtrex.com>
Cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch 6/6] Ptrace support for HARDWARE_WATCHPOINTS.
Message-ID: <20080422162343.GA14790@caradoc.them.org>
Mail-Followup-To: David Daney <ddaney@avtrex.com>,
	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
References: <480D2151.2020701@avtrex.com> <480D33EB.30808@avtrex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <480D33EB.30808@avtrex.com>
User-Agent: Mutt/1.5.17 (2007-12-11)
Return-Path: <drow@false.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18993
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Mon, Apr 21, 2008 at 05:40:11PM -0700, David Daney wrote:
> +struct mips32_watch_regs {
> +	unsigned int num_valid;
> +	unsigned int reg_mask;
> +	unsigned int irw_mask;
> +	unsigned long watchlo[8];
> +	unsigned int watchhi[8];
> +};

Please do not use long in new ptrace interfaces.  Use either
uint32_t or uint64_t as appropriate so that it doesn't depend
on how the kernel or debugger was built.

-- 
Daniel Jacobowitz
CodeSourcery
