Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 27 Jun 2009 17:52:58 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:50722 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1492431AbZF0Pwu (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 27 Jun 2009 17:52:50 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n5RFmDlG023744;
	Sat, 27 Jun 2009 16:48:13 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n5RFmB5D023741;
	Sat, 27 Jun 2009 16:48:11 +0100
Date:	Sat, 27 Jun 2009 16:48:11 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	KKylheku@zeugmasystems.com, aurelien@aurel32.net,
	linux-mips@linux-mips.org
Subject: Re: Broadcom Swarm support
Message-ID: <20090627154811.GA22264@linux-mips.org>
References: <20090624063453.GA16846@volta.aurel32.net> <DDFD17CC94A9BD49A82147DDF7D545C501C3539B@exchange.ZeugmaSystems.local> <20090626232432.GB3235@linux-mips.org> <20090627.225933.208964286.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090627.225933.208964286.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23517
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Jun 27, 2009 at 10:59:33PM +0900, Atsushi Nemoto wrote:

> A bit off-topic question.  The update_mmu_cache (or __update_cache)
> itself does not flush icache.  When icache is invalidated (especially
> VIPT case) ?

Not off-topic at all in this thread.

The I-cache for page just being loaded is clean so no flushing needed.  It
is clean because when the page has been unmapped it was flushed or because
the CPU switched to a fresh ASID.

The reason for this bug is that when data is being shoveled around by the
processor (as opposed to DMA) as on PIO block devices it'll end up sitting
in the D-cache so I-cache refills will grab stale data from S-cache or
memory.

  Ralf
