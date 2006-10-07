Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 07 Oct 2006 11:54:24 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:49071 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20038709AbWJGKyW (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 7 Oct 2006 11:54:22 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.7/8.13.7) with ESMTP id k97ArxDM000764;
	Sat, 7 Oct 2006 11:54:01 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.7/8.13.7/Submit) id k97ArcL9000763;
	Sat, 7 Oct 2006 11:53:38 +0100
Date:	Sat, 7 Oct 2006 11:53:38 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Jonathan Day <imipak@yahoo.com>
Cc:	Kaz Kylheku <kaz@zeugmasystems.com>, linux-mips@linux-mips.org
Subject: Re: CFE problem: starting secondary CPU.
Message-ID: <20061007105338.GA571@linux-mips.org>
References: <66910A579C9312469A7DF9ADB54A8B7D3E7324@exchange.ZeugmaSystems.local> <20061007021523.38254.qmail@web31512.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061007021523.38254.qmail@web31512.mail.mud.yahoo.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12826
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Oct 06, 2006 at 07:15:23PM -0700, Jonathan Day wrote:

> I've seen the case where the second CPU did not start
> on a Broadcom 1250 running a 64-bit kernel, but I
> don't know if anyone has a good solution. I just
> rigged the values in the Linux kernel so that it knows
> about the second CPU. It's a godawful hack, but I
> needed something quick at the time.
> 
> Personally, I am not a fan of CFE and would love to
> know if there's a better way to bootstrap.

Firmware is a stepchild and all implementations have in common that they're
hated by they're users.  And my grief is there are way to many different
firmwares for MIPS systems.

  Ralf
