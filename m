Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Sep 2007 15:06:11 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:50069 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20023120AbXIYOGI (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 25 Sep 2007 15:06:08 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l8PE67pB022363;
	Tue, 25 Sep 2007 15:06:08 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l8PE67Cv022362;
	Tue, 25 Sep 2007 15:06:07 +0100
Date:	Tue, 25 Sep 2007 15:06:07 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Aurelien Jarno <aurelien@aurel32.net>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH 1/4][MIPS] Add support for BCM47XX CPUs.
Message-ID: <20070925140607.GB19803@linux-mips.org>
References: <20070925133847.GA14227@hall.aurel32.net> <20070925134012.GB14227@hall.aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070925134012.GB14227@hall.aurel32.net>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16659
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Sep 25, 2007 at 03:40:12PM +0200, Aurelien Jarno wrote:

> 
> This patch replaces commit ceb550f7d4b24ee5d5de1a8f7ac07f8a2fe3bf1d in
> order to replace BCM947XX into BCM47XX.
> 
> 
>     [MIPS] Add support for BCM47XX CPUs.
>     
>     Note that the BCM4710 does not support the wait instruction, this
>     is not a mistake in the code.
>     
>     It originally comes from the OpenWrt patches.
>     
>     Cc: Michael Buesch <mb@bu3sch.de>
>     Cc: Felix Fietkau <nbd@openwrt.org>
>     Cc: Florian Schirmer <jolt@tuxbox.org>
>     Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
>     Cc: Ralf Baechle <ralf@linux-mips.org>
>     Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>     Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

All four updated.  But please

  o don't indent the log message.  I have to undo that formatting damage.
  o commit IDs are very useless as reference in the queue branch where they
    change each time I respin the tree.  Which could be three times a minute.

  Ralf
