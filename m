Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Oct 2008 09:36:21 +0100 (BST)
Received: from h4.dl5rb.org.uk ([81.2.74.4]:48042 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S21451646AbYJNIgT (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 14 Oct 2008 09:36:19 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m9E8aFtI031041;
	Tue, 14 Oct 2008 09:36:15 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m9E8aEOt031039;
	Tue, 14 Oct 2008 09:36:14 +0100
Date:	Tue, 14 Oct 2008 09:36:14 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	Johannes Dickgreber <tanzy@gmx.de>, linux-mips@linux-mips.org
Subject: Re: [PATCH 2/2] show_cpuinfo prints the name of the calling CPU,
	which i think is wrong.
Message-ID: <20081014083614.GA30880@linux-mips.org>
References: <1223919381-24521-1-git-send-email-tanzy@gmx.de> <20081013222146.GD8145@linux-mips.org> <48F3DAF9.5000603@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48F3DAF9.5000603@caviumnetworks.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20738
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Oct 13, 2008 at 04:34:17PM -0700, David Daney wrote:

> The patch is required on SMP systems as without it you get:
>
> BUG: using smp_processor_id() in preemptible [00000000] code: cat/687
> caller is show_cpuinfo+0xc4/0x500
> Call Trace:
> [<ffffffff8111f4c8>] dump_stack+0x8/0x38
> [<ffffffff812c235c>] debug_smp_processor_id+0xec/0x100
> [<ffffffff8112de64>] show_cpuinfo+0xc4/0x500
> [<ffffffff811d4128>] seq_read+0x2f8/0x420
> [<ffffffff811fb658>] proc_reg_read+0x90/0xd8
> [<ffffffff811b05ec>] vfs_read+0xbc/0x160
> [<ffffffff811b0a88>] sys_read+0x50/0x98
> [<ffffffff81129224>] handle_sysn32+0x44/0x84

Uh indeed, makes sense ...

  Ralf
