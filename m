Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 11 Oct 2008 16:07:57 +0100 (BST)
Received: from h4.dl5rb.org.uk ([81.2.74.4]:43990 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S21221987AbYJKPHz (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 11 Oct 2008 16:07:55 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m9BF7mm1010671;
	Sat, 11 Oct 2008 16:07:48 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m9BF7mID010669;
	Sat, 11 Oct 2008 16:07:48 +0100
Date:	Sat, 11 Oct 2008 16:07:48 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Use __cpuinit for mips_probe_watch_registers.
Message-ID: <20081011150748.GB6570@linux-mips.org>
References: <48EF89E8.1090300@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48EF89E8.1090300@caviumnetworks.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20717
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Oct 10, 2008 at 09:59:20AM -0700, David Daney wrote:

> Use __cpuinit for mips_probe_watch_registers.
>
> This function is called whenever a cpu is added, it cannot be __init.
>
> Signed-off-by: David Daney <ddaney@caviumnetworks.com>

Thanks, applied / folded into the original patch for Linus.

  Ralf
