Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 May 2007 16:06:53 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:39639 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20024326AbXEUPGv (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 21 May 2007 16:06:51 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l4LF6bEI006204;
	Mon, 21 May 2007 17:06:37 +0200
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l4LF6an6006203;
	Mon, 21 May 2007 17:06:36 +0200
Date:	Mon, 21 May 2007 17:06:36 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Move do_default_vi inside of CONFIG_CPU_MIPSR2_SRS
Message-ID: <20070521150636.GA6163@linux-mips.org>
References: <20070521.234538.15687337.anemo@mba.ocn.ne.jp> <20070521145615.GA5943@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070521145615.GA5943@linux-mips.org>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15110
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, May 21, 2007 at 04:56:15PM +0200, Ralf Baechle wrote:

> > This fixes the warning:
> > 
> > arch/mips/kernel/traps.c:931: warning: 'do_default_vi' defined but not used
> 
> Applied.

The patch isn't quite right, it may fix the warning but it confuses
vectored interrupts and shadow registers.  Something to sort later ...

  Ralf
