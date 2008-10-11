Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 11 Oct 2008 16:20:01 +0100 (BST)
Received: from h4.dl5rb.org.uk ([81.2.74.4]:38059 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S21223195AbYJKPT7 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 11 Oct 2008 16:19:59 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m9BFJlIw019221;
	Sat, 11 Oct 2008 16:19:47 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m9BFJldU019220;
	Sat, 11 Oct 2008 16:19:47 +0100
Date:	Sat, 11 Oct 2008 16:19:46 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Report all watch register masks in /proc/cpuinfo
	(version 2).
Message-ID: <20081011151945.GC6570@linux-mips.org>
References: <48EF97C9.7080101@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48EF97C9.7080101@caviumnetworks.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20718
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Oct 10, 2008 at 10:58:33AM -0700, David Daney wrote:

> Report all watch register masks in /proc/cpuinfo.
>
> This version actually passes checkpatch.pl!
>
> Some CPUs have heterogeneous watch register properties.  Let's show
> them all.
>
> Signed-off-by: David Daney <ddaney@caviumnetworks.com>

Thanks, applied / folded into the original patch for Linus.

  Ralf
