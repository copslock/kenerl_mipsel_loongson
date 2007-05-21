Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 May 2007 15:56:31 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:7127 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022753AbXEUO4a (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 21 May 2007 15:56:30 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l4LEuGun005957;
	Mon, 21 May 2007 16:56:16 +0200
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l4LEuFiS005956;
	Mon, 21 May 2007 16:56:15 +0200
Date:	Mon, 21 May 2007 16:56:15 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Move do_default_vi inside of CONFIG_CPU_MIPSR2_SRS
Message-ID: <20070521145615.GA5943@linux-mips.org>
References: <20070521.234538.15687337.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070521.234538.15687337.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15109
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, May 21, 2007 at 11:45:38PM +0900, Atsushi Nemoto wrote:

> This fixes the warning:
> 
> arch/mips/kernel/traps.c:931: warning: 'do_default_vi' defined but not used

Applied.

  Ralf
