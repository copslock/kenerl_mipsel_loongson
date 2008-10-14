Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Oct 2008 17:32:09 +0100 (BST)
Received: from h4.dl5rb.org.uk ([81.2.74.4]:26027 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S21493483AbYJNQcG (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 14 Oct 2008 17:32:06 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m9EGVxw5010346;
	Tue, 14 Oct 2008 17:31:59 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m9EGVwZP010344;
	Tue, 14 Oct 2008 17:31:58 +0100
Date:	Tue, 14 Oct 2008 17:31:58 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Align .data.cacheline_aligned based on
	MIPS_L1_CACHE_SHIFT
Message-ID: <20081014163158.GA10310@linux-mips.org>
References: <48F3DB6D.9020108@caviumnetworks.com> <20081014090757.GC30880@linux-mips.org> <48F4C6D5.3000100@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48F4C6D5.3000100@caviumnetworks.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20755
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Oct 14, 2008 at 09:20:37AM -0700, David Daney wrote:

> Actually I didn't.  When I look at:
>
> http://www.linux-mips.org/git?p=linux.git;a=summary
>
> I don't see it.  Am I looking in the wrong place?

Commit edc05575a87f02e85417d2ccb1b1ad1df582658e.  I just forgot to git push.

  Ralf
