Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 18 Oct 2008 12:05:56 +0100 (BST)
Received: from h4.dl5rb.org.uk ([81.2.74.4]:53941 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S21781249AbYJRLFy (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 18 Oct 2008 12:05:54 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m9IB5paB021069;
	Sat, 18 Oct 2008 12:05:52 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m9IB5owT021068;
	Sat, 18 Oct 2008 12:05:50 +0100
Date:	Sat, 18 Oct 2008 12:05:50 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org,
	linux-ide@vger.kernel.org, sshtylyov@ru.mvista.com
Subject: Re: [PATCH] ide: Add tx4939ide driver (v4)
Message-ID: <20081018110550.GB17322@linux-mips.org>
References: <20081017.230825.95059872.anemo@mba.ocn.ne.jp> <20081017141310.GA14999@linux-mips.org> <200810171846.35109.bzolnier@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200810171846.35109.bzolnier@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20794
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Oct 17, 2008 at 06:46:34PM +0200, Bartlomiej Zolnierkiewicz wrote:

> I was going to remove arch/bus specific subdirs in .29 but since the change
> should be really straightforward and we're ahead of the merge schedule for
> .28 I think we may as well do it now...
> 
> I'll prepare corresponding IDE git pull request next week.

Good, feel free to throw in my ACK for the MIPS bits.

Acked-by: Ralf Baechle <ralf@linux-mips.org>

  Ralf
