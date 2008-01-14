Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Jan 2008 14:01:03 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:19891 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20029955AbYANOBB (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 14 Jan 2008 14:01:01 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m0EDxx25030742;
	Mon, 14 Jan 2008 14:00:24 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m0EDxx7H030741;
	Mon, 14 Jan 2008 13:59:59 GMT
Date:	Mon, 14 Jan 2008 13:59:59 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] prom_free_prom_memory for QEMU
Message-ID: <20080114135959.GA22344@linux-mips.org>
References: <20080114.212253.126142719.anemo@mba.ocn.ne.jp> <20080114133701.GA16555@linux-mips.org> <20080114.225318.63132741.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080114.225318.63132741.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18023
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jan 14, 2008 at 10:53:18PM +0900, Atsushi Nemoto wrote:

> On Mon, 14 Jan 2008 13:37:01 +0000, Ralf Baechle <ralf@linux-mips.org> wrote:
> > I was actually planning to remove the Qemu platform for 2.6.25.  The
> > Malta emulation has become so good that there is no more point in having
> > the underfeatured synthetic platform that CONFIG_QEMU is.
> > 
> > Objections?
> 
> The Qemu platform is one of officially supported platforms by Debian.
> If Debian did not support the Malta yet, I hope qemu alive.

A few days ago Thiemo told me Debian dropped the Qemu kernel image.  Malta
otoh is alive and well.

  Ralf
