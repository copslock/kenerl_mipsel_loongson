Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Oct 2008 17:45:11 +0100 (BST)
Received: from h4.dl5rb.org.uk ([81.2.74.4]:7661 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S21493847AbYJNQpJ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 14 Oct 2008 17:45:09 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m9EGivMW010887;
	Tue, 14 Oct 2008 17:44:57 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m9EGivsu010885;
	Tue, 14 Oct 2008 17:44:57 +0100
Date:	Tue, 14 Oct 2008 17:44:57 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Aurelien Jarno <aurelien@aurel32.net>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH 0/5] BCM47xx patches for 2.6.28
Message-ID: <20081014164457.GB10310@linux-mips.org>
References: <20081014094043.GA26560@volta.aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20081014094043.GA26560@volta.aurel32.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20756
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Oct 14, 2008 at 11:40:43AM +0200, Aurelien Jarno wrote:

>       [MIPS] WGT634U: Add machine detection message
>       [MIPS] Remove references to BCM947XX
>       [MIPS] BCM47xx: Use the new SSB GPIO API
>       [MIPS] Add WGT634U reset button support
>       [MIPS] Scan PCI busses when they are registered
> 
> Compared to the previous version, one patch has been merged, and the
> second patch has been updated to reflect the new location of this file.

Whole series applied with the changed of <asm/gpio.h> to <linux/gpio.h> as
discussed on IRC.

Thanks,

  Ralf
