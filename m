Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Oct 2008 10:08:02 +0100 (BST)
Received: from h4.dl5rb.org.uk ([81.2.74.4]:59350 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S21454423AbYJNJIA (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 14 Oct 2008 10:08:00 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m9E97vKh001149;
	Tue, 14 Oct 2008 10:07:57 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m9E97vJx001147;
	Tue, 14 Oct 2008 10:07:57 +0100
Date:	Tue, 14 Oct 2008 10:07:57 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Align .data.cacheline_aligned based on
	MIPS_L1_CACHE_SHIFT
Message-ID: <20081014090757.GC30880@linux-mips.org>
References: <48F3DB6D.9020108@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48F3DB6D.9020108@caviumnetworks.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20740
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Oct 13, 2008 at 04:36:13PM -0700, David Daney wrote:

> Align .data.cacheline_aligned based on the MIPS_L1_CACHE_SHIFT
> configuration variable.
>
> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
> Signed-off-by: Tomaso Paoletti <tpaoletti@caviumnetworks.com>

Thanks, applied already yesterday as you may have noticed,

  Ralf
